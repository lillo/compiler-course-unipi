(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm array_access.byte  
 *)
let gen_foo llcontext llmodule gname = 
  (* Create the i32 type *)
  let i32t = Llvm.i32_type llcontext in 
  (* Create the type of bar: int foo(int) *)
  let ttfoo = Llvm.function_type i32t [|i32t|] in 
  (* Define foo *)
  let fundef = Llvm.define_function "foo" ttfoo llmodule in 
  (* Get the instruction builder *)
  let ibuilder = Llvm.builder_at_end llcontext (Llvm.entry_block fundef) in 
  (* We lookup the global variable gname: Be careful ¦> Option.get is very ugly *)
  let global_a = Llvm.lookup_global gname llmodule |> Option.get in 
  (* Load the value of the parameter in a register *)
  let index = Llvm.param fundef 0  in 
  let address = Llvm.build_gep global_a [|(Llvm.const_int i32t 0) ; index |] "access" ibuilder in 
  (* Store the value in the register mul2 into our local variable *) 
  let _ = Llvm.build_store (Llvm.const_int i32t 2) address ibuilder in
  let load_e = Llvm.build_load address "load" ibuilder in  
  let _ = Llvm.build_ret load_e  ibuilder in 
  fundef

let gen_bar llcontext llmodule = 
  (* Create the i32 type *)
  let i32t = Llvm.i32_type llcontext in 
  (* Create the type of bar: int bar() *)
  let ttbar = Llvm.function_type i32t [||] in 
  (* Define bar *)
  let fundef = Llvm.define_function "bar" ttbar llmodule in 
  (* Get the instruction builder *)
  let ibuilder = Llvm.builder_at_end llcontext (Llvm.entry_block fundef) in
  (* Create the type [10 x i32] *)
  let a2i32t = Llvm.array_type i32t 2 in
  (* Allocate an array of 2 elements *)
  let array_local = Llvm.build_array_alloca a2i32t (Llvm.const_int i32t 2) "array_alloca" ibuilder in
  (* Get the address of the element of index 1 *) 
  let address1 = Llvm.build_in_bounds_gep array_local [|(Llvm.const_int i32t 0) ; (Llvm.const_int i32t 1)|] "gep" ibuilder in 
  (* Store the value 10 into the element of the array with index 1*)
  let _ = Llvm.build_store (Llvm.const_int i32t 10) address1 ibuilder in
  (* Load the value just written into a register "load" *) 
  let load_e = Llvm.build_load address1 "load" ibuilder in
  (* return the value in the register "load" *) 
  let _ = Llvm.build_ret load_e ibuilder in 
  fundef 

let gen_global_array llcontext llmodule gname = 
  (* Create the i32 type *)
  let i32t = Llvm.i32_type llcontext in
  (* Create the type [10 x i32] *)
  let a10i32t = Llvm.array_type i32t 10 in 
  (* Create the initial values of the array *)
  let values = Array.init 10 (fun i -> Llvm.const_int i32t (i+1)) in
  (* Create an array literal containing the values above *) 
  let const_a = Llvm.const_array a10i32t values in 
  (* Declare a global array named gname*)
  Llvm.define_global gname const_a llmodule

let _ = 
  let llvm_context = Llvm.global_context () in 
  let llmodule = Llvm.create_module llvm_context "array-access" in
  let _ = gen_global_array llvm_context llmodule "a" in 
  let _ = gen_foo llvm_context llmodule "a" in
  let _ = gen_bar llvm_context llmodule in        
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule