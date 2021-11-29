(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm fun_params.byte  
 *)
 
 let _ =
  let llvm_context = Llvm.global_context () in 
  let llmodule = Llvm.create_module llvm_context "my-empty-module" in
  (* Create the i32 type *)
  let i32t = Llvm.i32_type llvm_context in 
  (* Create the type of the function i32 sum(i32,i32) *)
  let ttsum = Llvm.function_type i32t [|i32t ; i32t|] in
  (* Define the function i32 sum(i32,i32) with a return statement as body *)
  let fundef = Llvm.define_function "sum" ttsum llmodule in
  (* The instruction builder points at the end of the entry block of main *)
  let ibuilder = Llvm.builder_at_end llvm_context (Llvm.entry_block fundef) in
  let zero = Llvm.const_int i32t 0 in 
  (* we build the instruction return 0, the instruction is added at the end of the entry basic block and it is returned *) 
  let _ = Llvm.build_ret zero ibuilder in   
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule