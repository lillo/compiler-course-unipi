(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm fun_sum.byte  
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
  (* We take a pointer to the first argument of the function *)
  let param0 = Llvm.param fundef 0 in 
  (* We take a pointer to the second argument of the function *)
  let param1 = Llvm.param fundef 1 in 
  (* We build the add instruction *) 
  let sum_param = Llvm.build_add param0 param1 "result" ibuilder in 
  (* we build the instruction return %result, that returns the result of the sum *) 
  let _ = Llvm.build_ret sum_param ibuilder in   
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule