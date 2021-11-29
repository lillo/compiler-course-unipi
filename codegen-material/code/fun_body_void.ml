(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm fun_body_void.byte  
 *)
 
 let _ =
  let llvm_context = Llvm.global_context () in 
  let llmodule = Llvm.create_module llvm_context "my-empty-module" in
  (* Create the void type *)
  let voidt = Llvm.void_type llvm_context in 
  (* Create the type of the function void main() *)
  let ttmain = Llvm.function_type voidt [||] in
  (* Define the function void main() with a return statement as body *)
  let fundef = Llvm.define_function "main" ttmain llmodule in
  (* The instruction builder points at the end of the entry block of main *)
  let ibuilder = Llvm.builder_at_end llvm_context (Llvm.entry_block fundef) in
  (* we build the instruction return void, the instruction is added at the end of the entry basic block and it is returned *) 
  let _ = Llvm.build_ret_void ibuilder in   
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule