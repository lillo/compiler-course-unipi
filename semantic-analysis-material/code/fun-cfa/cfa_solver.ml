(*
  Our solver is parametric on the type of constraint variables 
  and on the type of tokens. 
  The module type OrderedType represent the requirement we asked 
  on the type implementing constraint variables and tokens.
*)
module type OrderedType = sig
  type t
    [@@deriving show,ord]
end

(*
  The functor that allow us to create a solver.
  Constraint variables denote set of tokens. 
  A solution is an assignment from variables to set of tokens.
*)
module Make(Token : OrderedType)(Var : OrderedType) =
struct

(** The constraints the solver is able to handle *)
type t =
  | IsIn of Token.t * Var.t   (* IsIn(t,v) means {t} ⊆ v *)
  | SubSeteq of Var.t * Var.t (* Subseteq(v1, v2) means v1 ⊆ v2 *)
  | Impl of Token.t * Var.t * Var.t * Var.t (* Impl(t, v, v1, v2) means {t} ⊆ v ==> v1 ⊆ v2 *)
[@@deriving show { with_path = false },ord]

(** A pretty printer *)
let pp fmt v =
  match v with
  | IsIn(t, v) ->
    Format.fprintf fmt "{ %s } ⊆ %s" (Token.show t) (Var.show v)
  | SubSeteq(v1, v2) ->
    Format.fprintf fmt "%s ⊆ %s" (Var.show v1) (Var.show v2)
  | Impl(t, v, v1, v2) ->
    Format.fprintf fmt "%s ⊆ %s ==> %s ⊆ %s" (Token.show t) (Var.show v) (Var.show v1) (Var.show v2)

(** A pretty printer *)
let show v =
  pp (Format.str_formatter) v;
  Format.flush_str_formatter ()

(** [t @^ v] builds the constraint  {t} ⊆ v *)
let (@^) token var = IsIn(token, var)

(** [v1 @< v2] builds the constraint v1 ⊆ v2 *)
let (@<) var1 var2 = SubSeteq(var1, var2)

(** [(t @^ v) @~~> (v1 @< v2)] builds the constraint {t} ⊆ v ==> v1 ⊆ v2 *)
let (@~~>) hyp concl = match (hyp, concl) with
  |(IsIn(t,v1), SubSeteq(v2,v3)) -> Impl(t,v1,v2,v3)
  | _ -> failwith "Malformed constraint"



(** A set of tokens used inside the solve function *)
module TokSet = Set.Make(Token)

(** [solve cc] returns the solution of the constraints cc. 
    The implementation mimics the pseudo-code discussed during the lecture
  *)
let solve constraints : (Var.t * Token.t Seq.t) Seq.t =
  let worklist = Queue.create () in          (* W *)
  let data_field = Hashtbl.create (List.length constraints) in  (* D *)
  let edge_cc = Hashtbl.create (List.length constraints) in     (* E *)
  (* The add sub-procedure *)
  let add p d =
    let d = Option.value d ~default:TokSet.empty in
    let dp = Hashtbl.find_opt data_field p |> Option.value ~default:TokSet.empty in
    if not (TokSet.subset d dp) then
      begin
      Hashtbl.replace data_field p (TokSet.union d dp);
      Queue.push p worklist
      end
  in
  (** Step 2: store in E[p] the constraints affected by p *)
  constraints |> List.iter (function
      | IsIn(tk, p) -> add p (Some (TokSet.singleton tk))
      | SubSeteq(p1, p2) as cc -> Hashtbl.add edge_cc p1 cc
      | Impl(tok, p, p1, p2) as cc -> Hashtbl.add edge_cc p1 cc; Hashtbl.add edge_cc p cc
    ) ;
  (** Step 3: fixpoint iteration. Propagate the information about tokens until
      no further changes occur. 
   *)  
  while not(Queue.is_empty worklist) do
    let q = Queue.pop worklist in
    let cc = Hashtbl.find_all edge_cc q in
    cc |> List.iter (function
        | SubSeteq(p1, p2) -> add p2 (Hashtbl.find_opt data_field p1)
        | Impl(tok, p, p1, p2) ->
          begin
            match Hashtbl.find_opt data_field p with
            | Some(dp)  ->
              if TokSet.mem tok dp then
                add p2 (Hashtbl.find_opt data_field p1)
            | _ -> ()
          end
        | _ -> assert false
    )
  done;
  (** Step 4: build the final solution *)
  Hashtbl.to_seq data_field |> Seq.map (fun (v, s) -> (v, TokSet.to_seq s))
end
