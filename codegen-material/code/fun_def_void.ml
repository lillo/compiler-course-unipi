(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm fun_def_void.byte  
 *)
 
 let _ =
  let llvm_context = Llvm.global_context () in 
  let llmodule = Llvm.create_module llvm_context "my-empty-module" in
  (* Create the void type *)
  let voidt = Llvm.void_type llvm_context in 
  (* Create the type of the function void main() *)
  let ttmain = Llvm.function_type voidt [||] in
  (* Define the function void main() with an empty body *)
  let fundef = Llvm.define_function "main" ttmain llmodule in  
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule