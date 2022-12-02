open Fun_frontend

(* A shorthand for referring to Llvm module *)
module L = Llvm

(* The LLVM global context *)
let llcontext = L.global_context ()

(* Some useful LLVM IR type to use in the code generation *)
let int_type = L.i32_type llcontext
let bool_type = L.i1_type llcontext
let char_type = L.i8_type llcontext
let void_type = L.void_type llcontext

(* The type and name of the function main we generate *)
let main_type = L.function_type void_type [||]
let main_name = "main"

(* A table mapping a binary operator in the LLVM function that implemets it and its name *)
let primitive_operators = 
  [ "+", (L.build_add, "add") 
  ; "*", (L.build_mul, "mul")
  ; "-", (L.build_sub, "mul")
  ; "/", (L.build_sdiv, "div")
  ; "<", (L.build_icmp L.Icmp.Slt, "less")
  ; "<=", (L.build_icmp L.Icmp.Sle, "less_equal")
  ; ">", (L.build_icmp L.Icmp.Sgt, "greater")
  ; "<", (L.build_icmp L.Icmp.Sge, "greater_equal")
  ; "=", (L.build_icmp L.Icmp.Eq, "equal")
  ]

(* Translate a FUN type into a LLVM IR one*)
let rec lltype_of_type = function 
  | Tint  -> int_type
  | Tbool -> bool_type
  | Tfun(t1, t2) ->    (* Note: we generate only first order function types *)
    let return_type = lltype_of_type t2 in 
    let argument_type = lltype_of_type t1 in 
    L.function_type return_type [|argument_type|] 

(** Generate code for expressions
  @param current_fun is the llvalue of the function the expression belongs to
  @param env is the environment mapping names to llvalues 
  @param ibuilder is the builder used to generate instructions  
*)   
let rec codegen_expr current_fun env ibuilder = function
  | CstI(i) -> 
    L.const_int int_type i 
  | CstB(b) -> 
    L.const_int bool_type (if b then 1 else 0)
  | Var(x) -> 
    lookup env x
  | Let(x, e1, e2) -> 
    let te1 = codegen_expr current_fun env ibuilder e1 in 
    let env' = (x, te1)::env in 
    codegen_expr current_fun env' ibuilder e2
  | Call(fname, e) -> 
    let funref = lookup env fname in 
    let te = codegen_expr current_fun env ibuilder e in 
    L.build_call funref [|te|] ("call_" ^ fname) ibuilder
  | Prim(op, e1, e2) -> 
    let te1 = codegen_expr current_fun env ibuilder e1 in 
    let te2 = codegen_expr current_fun env ibuilder e2 in 
    let (llvm_operator, label) = List.assoc op primitive_operators in 
    llvm_operator te1 te2 label ibuilder
  | If(e1, e2, e3) -> 
    let bthen = Llvm.append_block llcontext "then" current_fun in 
    let belse = Llvm.append_block llcontext "else" current_fun in 
    let bcont = Llvm.append_block llcontext "cont" current_fun in 
    let te1 = codegen_expr current_fun env ibuilder e1 in 
    let _ = Llvm.build_cond_br te1 bthen belse ibuilder in
    Llvm.position_at_end bthen ibuilder;
    let te2 = codegen_expr current_fun env ibuilder e2 in 
    let _ = Llvm.build_br bcont ibuilder in 
    Llvm.position_at_end belse ibuilder;
    let te3 = codegen_expr current_fun env ibuilder e3 in 
    let _ = Llvm.build_br bcont ibuilder in 
    Llvm.position_at_end bcont ibuilder;
    Llvm.build_phi [(te2, bthen) ; (te3, belse)] "phi" ibuilder 

(** 
    Generate the code for a function definition
    @param llmodule represents the LLVM module we are generating
    @param env an environment mapping function names to their translation
    @param fundecl the function we are translating
*)
let codegen_fundecl llmodule env (Fundecl {fname; ftype; fparam; fbody}) =
  let fun_type = lltype_of_type ftype in 
  let fundef = L.define_function fname fun_type llmodule in
  let param = L.param fundef 0 in  
  let env' = (fname,fundef)::env in 
  let ibuilder = L.builder_at_end llcontext (L.entry_block fundef) in
  let last_instr = codegen_expr fundef ((fparam,param)::env') ibuilder fbody in 
  let _ = L.build_ret last_instr ibuilder in 
  env' 

(**
  Generate the code for the main expression e
  @param llmodule represents the LLVM module we are generating
  @param env an environment mapping function names to their translation
  @param e the expression we are translating
*)
let codegen_main llmodule env e = 
  let maindef = L.define_function main_name main_type llmodule in  
  let ibuilder = L.builder_at_end llcontext (L.entry_block maindef) in
  let last_instr = codegen_expr maindef env ibuilder e in
  let str = Llvm.build_global_string "%d\n" "str_constr" ibuilder in
  let printf = L.lookup_function "printf" llmodule |> Option.get in
  let zero = Llvm.const_int (Llvm.i64_type llcontext) 0 in 
  let pstr = Llvm.build_gep str [|zero; zero|] "gep" ibuilder in 
  let _ = Llvm.build_call printf [|pstr; last_instr|] "call_printf" ibuilder in   
  let _ = L.build_ret_void ibuilder in 
  ()

(* Declare in the current module the printf prototype *)  
let printf_declaration llvm_module =
  let printf_t = L.var_arg_function_type int_type [| L.pointer_type char_type |] in
  L.declare_function "printf" printf_t llvm_module

(* Generate code for a program and returns the generated llmodule *)  
let codegen (Prog(fs, e)) = 
  let llmodule = L.create_module llcontext "simple-fun-module" in 
  printf_declaration llmodule |> ignore;
  let env = List.fold_left (codegen_fundecl llmodule) [] fs in 
  codegen_main llmodule env e;
  llmodule  