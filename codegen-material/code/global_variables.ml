(*
  Use:
  $ ocamlbuild -use-ocamlfind -package llvm global_variables.byte  
 *)

(** 
  [helloworld_string ctx] given a llvm_context [ctx] returns a value reprenseting
  the literal string "Hello World\n". Note that the returned string is null-terminated.
  To create a string that is not null-terminated use Llvm.const_stringz  
*)
let helloworld_string ctx = Llvm.const_stringz ctx "Hello World\n"

(** 
  [integer_constant ctx] given a llvm_context [ctx] returns a value representing
  the literal integer 42. Note that inside the body of the function we need to create
  a llvalue that represents the type i32. to achieve that we use the function Llvm.i32_type 
  that given a context returns the corresponding type.   
*)
let integer_constant ctx = 
  (** Create a type represeting 32bit integers. For other types see the documentation. *)
  let i32t = Llvm.i32_type ctx in 
  Llvm.const_int i32t 42

 (** 
  [array_constant ctx] returns a llvalue representing an literal array of 10 elements
 *)
  let array_constant ctx = 
    (** the length of the array*)
    let array_length = 10 in 
    (** the type of the element of the array *)
    let floatt = Llvm.float_type ctx in 
    (** the initial values of the array *)
    let array_initializer = Array.init array_length (fun i -> Float.of_int (i + 1) |> Llvm.const_float floatt) in 
    (** The type of the array: float[10]*)
    let array_type = Llvm.array_type floatt array_length in
    (* the literal array *) 
    Llvm.const_array array_type array_initializer

let _ = 
  let llcontext = Llvm.global_context () in 
  let llmodule = Llvm.create_module llcontext "my-module" in 
  (** We define our global specifying their name, their initial value and the module 
      Note the Llvm.define_global returns the llvalue just created, but also it modifies the module llmodule
      thus we can ignore the returned value 
  *)
  let _ = Llvm.define_global "str" (helloworld_string llcontext) llmodule in 
  let _ = Llvm.define_global "number" (integer_constant llcontext) llmodule in 
  let _ = Llvm.define_global "array"  (array_constant llcontext) llmodule in 
  Printf.printf "%s" (Llvm.string_of_llmodule llmodule);
  Llvm.dispose_module llmodule 