open Ast 

let prelude_signature = [
  "print", TFun([TInt],TVoid);
  "getint", TFun([], TInt)
]

let app_signature = [
  "main", TFun([],TInt)
]