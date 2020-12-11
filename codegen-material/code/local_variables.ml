(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm local_variables.byte  
 *)
 
let gen_foo llcontext llmodule = 
  (* Create the i32 type *)
  let i32t = Llvm.i32_type llcontext in 
  (* Create the type of the function i32 foo(i32) *)
  let ttfoo = Llvm.function_type i32t [|i32t|] in
  (* Define the function i32 foo(i32) with a return statement as body *)
  let fundef = Llvm.define_function "foo" ttfoo llmodule in
  (* The instruction builder points at the end of the entry block of foo *)
  let ibuilder = Llvm.builder_at_end llcontext (Llvm.entry_block fundef) in
  (* We allocate on the stack the space for our argument *)
  let param_stack = Llvm.build_alloca i32t "param" ibuilder in
  (* We take a pointer to the argument of the function *)
  let param = Llvm.param fundef 0 in 
  (* We store the value of param to the stack *)
  let _ = Llvm.build_store param param_stack ibuilder in 
  (* We get a pointer to the argument on the stack *)
  let load_param = Llvm.build_load param_stack "load" ibuilder in 
  (* We build the add instruction *) 
  let sum_param = Llvm.build_add load_param (Llvm.const_int i32t 2) "result" ibuilder in 
  (* we build the instruction return %result, that returns the result of the sum *) 
  let _ = Llvm.build_ret sum_param ibuilder in
  fundef

let gen_bar llcontext llmodule = 
  (* Create the void type *)
  let voidt = Llvm.void_type llcontext in
  (* Create the i32t type *)
  let i32t = Llvm.i32_type llcontext in 
  (* Create the type of bar: void bar() *)
  let ttbar = Llvm.function_type voidt [||] in 
  (* Define bar *)
  let fundef = Llvm.define_function "bar" ttbar llmodule in 
  (* Get the instruction builder *)
  let ibuilder = Llvm.builder_at_end llcontext (Llvm.entry_block fundef) in 
  (* Allocate the space for a local variable *)
  let local_var = Llvm.build_alloca i32t "local" ibuilder in 
  (* We lookup the global variable 'a': Be careful ¦> Option.get is very ugly *)
  let global_a = Llvm.lookup_global "a" llmodule |> Option.get in 
  (* Load the value of a in a register and perform some simple operations *)
  let load_a = Llvm.build_load global_a "load_a" ibuilder in 
  let sum_10 = Llvm.build_add load_a (Llvm.const_int i32t 10) "sum10" ibuilder in 
  let mul_2  = Llvm.build_mul sum_10 (Llvm.const_int i32t 2)  "mul2" ibuilder in
  (* Store the value in the register mul2 into our local variable *) 
  let _ = Llvm.build_store mul_2 local_var ibuilder in 
  let _ = Llvm.build_ret_void ibuilder in 
  fundef


 let _ =
  let llvm_context = Llvm.global_context () in 
  let llmodule = Llvm.create_module llvm_context "local-variables" in
  let _ = Llvm.define_global "a" (Llvm.const_int (Llvm.i32_type llvm_context) 0) llmodule in 
  let _ = gen_foo llvm_context llmodule in      
  let _ = gen_bar llvm_context llmodule in 
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule