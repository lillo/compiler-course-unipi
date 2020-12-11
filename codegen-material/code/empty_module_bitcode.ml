(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm -package llvm.bitwriter empty_module_bitcode.byte  
 *)
 
 let _ =
  let filename = "output.bc" in 
  let llvm_context = Llvm.global_context () in 
  let my_module = Llvm.create_module llvm_context "my-empty-module" in  
  Llvm_bitwriter.write_bitcode_file my_module filename |> ignore;
  Llvm.dispose_module my_module