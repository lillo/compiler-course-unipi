(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm empty_module.byte  
 *)
 
let _ =
  let llvm_context = Llvm.global_context () in 
  let my_module = Llvm.create_module llvm_context "my-empty-module" in  
  Printf.printf "%s" (Llvm.string_of_llmodule my_module);
  Llvm.dispose_module my_module