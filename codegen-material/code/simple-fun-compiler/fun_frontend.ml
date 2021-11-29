(**
   An example of an interpreter for a small strongly typed functional language.
 *)
(** Syntax of the language *)

type expr =
  | CstI of int
  | CstB of bool
  | Var of string
  | Let of string * expr * expr
  | Prim of string * expr * expr
  | If of expr * expr * expr
  | Call of string * expr
and fundecl = 
  | Fundecl of {fname : string; ftype : ttype; fparam : string; fbody : expr}
and ttype =
  | Tint
  | Tbool
  | Tfun of ttype * ttype

type prog = Prog of fundecl list * expr

(** Definition of environment. An environment is a map from identifier to "something".
   In the semantics this something is a value (what the identifier is bound to).
   In the type system this "something" is a type.
   For simplicity we represent the environment as an association list, i.e., a list of pair (identifier, data).
 *)

type 'v env = (string * 'v) list

(**
   Given an environment {env} and an identifier {x} it returns the data {x} is bound to.
   If there is no binding, it raises an exception.
 *)
let rec lookup env x =
    match env with
    | []        -> failwith (x ^ " not found")
    | (y, v)::r -> if x=y then v else lookup r x

(** The type environment we start with.  It contains the type of primitives
   operators and of other primitive functions *)
let prelude = [
  "+", Tfun(Tint, Tfun(Tint, Tint));
  "-", Tfun(Tint, Tfun(Tint, Tint));
  "*", Tfun(Tint, Tfun(Tint, Tint));
  "/", Tfun(Tint, Tfun(Tint, Tint));
  "<", Tfun(Tint, Tfun(Tint, Tbool));
  "<=", Tfun(Tint, Tfun(Tint, Tbool));
  ">", Tfun(Tint, Tfun(Tint, Tbool));
  ">=", Tfun(Tint, Tfun(Tint, Tbool))
]

let is_functional = function 
  | Tint 
  | Tbool   -> false 
  | _ -> true

exception Type_error of string

let rec type_of_expr gamma e =
  match e with
  | CstI(_) -> Tint
  | CstB(_) -> Tbool
  | Var(x)  -> lookup gamma x
  | Let(x, e1, e2) ->
    let t1 = type_of_expr gamma e1 in
    type_of_expr ((x,t1)::gamma) e2
  | If(e1, e2, e3) ->
    if (type_of_expr gamma e1) = Tbool then
      let t2 = type_of_expr gamma e2 in
      let t3 = type_of_expr gamma e3 in
      if t2 = t3 then t2 else raise (Type_error "if branches have different types")
    else
      raise (Type_error "if with no a boolean guard")
  | Prim("=", e1, e2) ->
    let t1 = type_of_expr gamma e1 in
    let t2 = type_of_expr gamma e2 in
    begin
      match t1, t2 with
      | Tint, Tint
      | Tbool, Tbool -> Tbool
      | Tfun(_,_), Tfun(_,_) ->
        raise (Type_error "Error comparing functional values for equality")
      | _, _ -> raise (Type_error "error in the arguments of =")
    end
  | Prim(op, e1, e2) ->
    let t1 = type_of_expr gamma e1 in
    let t2 = type_of_expr gamma e2 in
    let top = lookup gamma op in
    begin
      match top with
      | Tfun(t1', Tfun(t2', tr')) ->
        if (t1' = t1 && t2' = t2) then
          tr'
        else
          raise (Type_error ("error in the arguments of " ^ op))
      | _ -> failwith "Inconsistent state"
    end
  | Call(f, e2) ->
    let t1 = lookup gamma f in
    let t2 = type_of_expr gamma e2 in
    begin
      match t1 with
      | Tfun(tx, tr) ->
        if tx = t2 then
          tr
        else
          raise (Type_error "fuctional application: argument type mismatch")
      | _ -> raise (Type_error "application to a non functional value")
    end

let type_of_fun gamma (Fundecl {fname; ftype=(Tfun(t1,t2) as t); fparam; fbody}) = 
  let gamma' = (fname, t) :: (fparam, t1) :: gamma in 
    if (type_of_expr gamma' fbody) = t2 then
      (fname, t) :: gamma
    else
      raise (Type_error "Return type does not match")

let type_of_prog gamma (Prog(funs, e)) = 
  let gamma' = List.fold_left type_of_fun gamma funs in 
  type_of_expr gamma' e

let type_check p = type_of_prog prelude p
