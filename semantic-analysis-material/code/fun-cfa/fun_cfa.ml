(** 
  Type representing the label associated to each sub-expression
*)
type label = int
[@@deriving show, eq, ord]

(**
  To make our analysis precise, we usually assume that bound variables
  are distinct. To achieve that we represent a variable as an identifier and a unique 
  label. Thus, the pair (name, id) are unique inside the expression to analyze. 
  Actually, id is the declaration site, i.e., the label of the program point where the variable is declared. 
  For example, {name="x";id=5} denotes the variables x declared in the program point 5.
 *)
type var = { name : string ; id : label }
[@@deriving show, eq, ord]

(**
  An annotated expression is made of a term and of a unique label 
*)
type aexpr = { t : term ; l : label }
[@@deriving show]

and term =
  | CstI of int
  | CstB of bool
  | Var of var
  | Let of var * aexpr * aexpr
  | Prim of string * aexpr * aexpr
  | If of aexpr * aexpr * aexpr
  | Letfun of var * var * aexpr * aexpr    (* (f, x, fBody, letBody) *)
  | Call of aexpr * aexpr
[@@deriving show]

(** 
  [to_aexpr e] returns an annotated version of e.
*)
let to_aexpr (e : Fun.expr) : aexpr =
  let counter = ref(0) in                (* counter to generated unique labels *)
  let next_label () = incr counter; !counter in  (* returns a new label *)
  let mk_aexpr t = { t = t ; l = next_label ()} in  (* helper to build an annotated expression from a term *)

  (* tail recursive helper function to carry out the annotation. 
     env is an enrivonment storing for each variable the corresponding unique id.
  *)
  let rec transform env = function
  | Fun.CstI(i) -> CstI(i) |> mk_aexpr
  | Fun.CstB(b) -> CstB(b) |> mk_aexpr
  | Fun.Var(id) -> Var({name = id; id = Fun.lookup env id }) |> mk_aexpr
  | Fun.Let(x, e1, e2) ->
    let ae1 = transform env e1 in
    let var_id = next_label() in
    let ae2 = transform ((x, var_id)::env) e2 in
    Let({name = x; id = var_id}, ae1, ae2) |> mk_aexpr
  | Fun.Prim(op, e1, e2) ->
    let ae1 = transform env e1 in
    let ae2 = transform env e2 in
    Prim(op, ae1, ae2) |> mk_aexpr
  | Fun.If(e1, e2, e3) ->
    let ae1 = transform env e1 in
    let ae2 = transform env e2 in
    let ae3 = transform env e3 in
    If(ae1, ae2, ae3) |> mk_aexpr
  | Fun.Letfun(f, x, _, body, exp) ->
    let fvar = { name = f; id = next_label () } in
    let xvar = { name = x; id = next_label () } in
    let abody = transform ((fvar.name, fvar.id)::(xvar.name, xvar.id)::env) body in
    let aexp  = transform ((fvar.name, fvar.id)::env) exp in
    Letfun(fvar, xvar, abody, aexp) |> mk_aexpr
  | Fun.Call(e1, e2) ->
    let ae1 = transform env e1 in
    let ae2 = transform env e2 in
    Call(ae1, ae2) |> mk_aexpr
  in
  transform [] e

(*
type cvar = IdVar of var [@printer fun fmt v -> Format.fprintf fmt "r(%s:%d)" v.name v.id]
          | CacheVar of label [@printer fun fmt c -> Format.fprintf fmt "C(%d)" c]
[@@deriving show{ with_path = false }, eq, ord]


type token = var
[@@deriving show, eq, ord]
*)

(** Our solver is parametric on the type of variables. 
    The module Var defines a type t that express both cache entries and environment entries.
 *)
module Var =
  struct
    type t = 
           (* IdVar(v) is a variable representing the entry in the environment for the identifier v *)
           | IdVar of var [@printer fun fmt v -> Format.fprintf fmt "r(%s:%d)" v.name v.id]
           (* CacheVar(l) is a variable representing the entry in the cache for the label l *)
           | CacheVar of label [@printer fun fmt c -> Format.fprintf fmt "C(%d)" c]
      [@@deriving show{ with_path = false }, eq, ord]
  end

(** Our solver is parametric on the type of tokens. 
    The module Token defines a type t that represent the name and the definition site of a function.
 *)
module Token =
struct
  type t = var
    [@@deriving show, eq, ord]
end

(** Solver is an instantiation of the CFA solver for the language fun *)
module Solver = Cfa_solver.Make(Token)(Var)

(** [lambdas e] returns a list of the all function definition occurring in e *)
let lambdas e =
  let rec f_aux e acc =
    match e.t with
    | CstI(_)
    | CstB(_)
    | Var(_)   -> acc
    | Let(_, e1, e2)
    | Prim(_, e1, e2)
    | Call(e1, e2) -> acc |> f_aux e1 |> f_aux e2
    | If(e1, e2, e3) ->  acc |> f_aux e1 |> f_aux e2 |> f_aux e3
    | Letfun(f, x, body, exp) ->
      (f,x,body)::acc |> f_aux body |> f_aux exp
  in
  f_aux e []

(** [constrs_of_aexpr ae] returns the CFA constraints for the annotated expression ae. *)
let constrs_of_aexpr aexp =
  let lambda_star = lambdas aexp in
  let open Solver in
  let rec f_aux e acc =
    match e.t with
    | CstI(_)
    | CstB(_) -> acc
    | Var(v)  -> (IdVar(v) @< CacheVar(e.l)) :: acc
    | Prim(_, e1, e2) -> acc |> f_aux e1 |> f_aux e2
    | Let(x, e1, e2) ->
      let acc' = (CacheVar(e1.l) @< IdVar(x)) :: (CacheVar(e2.l) @< CacheVar(e.l)) :: acc in
      acc' |> f_aux e1 |> f_aux e2
    | If(e1, e2, e3) ->
      let acc' = (CacheVar(e2.l) @< CacheVar(e.l)) :: (CacheVar(e3.l) @< CacheVar(e.l)) :: acc in
      acc' |> f_aux e1 |> f_aux e2 |> f_aux e3
    | Letfun(f, x, body, exp) ->
      let acc' = (f @^ IdVar(f)) :: (CacheVar(exp.l) @< CacheVar(e.l)) :: acc in
      acc' |> f_aux body |> f_aux exp
    | Call(e1, e2) ->
      let acc' = List.fold_left (fun cs (f,x,e') ->
          ((f @^ CacheVar(e1.l)) @~~> (CacheVar(e2.l) @< IdVar(x))) ::
          ((f @^ CacheVar(e1.l)) @~~> (CacheVar(e'.l) @< CacheVar(e.l))) :: cs
        ) acc lambda_star
      in
      acc' |> f_aux e1 |> f_aux e2
  in
  f_aux aexp []
