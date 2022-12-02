(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm fun_equals.byte  
 *)
let define_equals llcontext llmodule = 
  let i1t = Llvm.i1_type llcontext in 
  let i32t = Llvm.i32_type llcontext in 
  let ttequal = Llvm.function_type i1t [|i32t ; i32t |] in 
  let defeq = Llvm.define_function "equals" ttequal llmodule in 
  let ibuilder = Llvm.builder_at_end llcontext (Llvm.entry_block defeq) in 
  let param0 = Llvm.param defeq 0 in 
  let param1 = Llvm.param defeq 1 in 
  let icmp = Llvm.build_icmp Llvm.Icmp.Eq param0 param1 "icmp" ibuilder in 
  let _ = Llvm.build_ret icmp ibuilder in 
  defeq

let _ = 
  let llvm_context = Llvm.global_context () in 
  let llmodule = Llvm.create_module llvm_context "fun-equals" in
  let _ = define_equals llvm_context llmodule in         
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule