(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm call_ext_fun.byte  
 *)
 
let declare_puts llcontext llmodule = 
  let i32t = Llvm.i32_type llcontext in 
  let char_ptr = Llvm.i8_type llcontext |> Llvm.pointer_type in 
  let puts_t = Llvm.function_type i32t [|char_ptr|] in 
  Llvm.declare_function "puts" puts_t llmodule

let define_main llcontext llmodule puts = 
  let void_t = Llvm.void_type llcontext in 
  let main_t = Llvm.function_type void_t [||] in 
  let main_def = Llvm.define_function "main" main_t llmodule in
  let ibuilder = Llvm.builder_at_end llcontext (Llvm.entry_block main_def) in 
  let str = Llvm.build_global_string "Hello World\n" "msg" ibuilder in
  let zero = Llvm.const_int (Llvm.i64_type llcontext) 0 in 
  let pstr = Llvm.build_gep str [|zero; zero|] "gep" ibuilder in 
  let _ = Llvm.build_call puts [|pstr|] "call" ibuilder in
  let _ = Llvm.build_ret_void ibuilder in   
  main_def 

let _ =
  let llvm_context = Llvm.global_context () in 
  let my_module = Llvm.create_module llvm_context "call_ext_fun" in
  let puts = declare_puts llvm_context my_module in 
  define_main llvm_context my_module puts |> ignore; 
  Printf.printf "%s" (Llvm.string_of_llmodule my_module);
  Llvm.dispose_module my_module