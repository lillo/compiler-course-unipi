(* Readings https://www.cs.cornell.edu/courses/cs3110/2019fa/textbook/ *)

(* Examples on function definition *)

(* print n times Hello World on screen *)
let rec print_hello n =
  match n with
  | 0 -> ()
  | n -> print_endline "Hello World"; print_hello (n - 1)

(* returns true if n is prime *)
let is_prime n =
    let n = abs n in
    let rec is_not_divisor d =
      d * d > n || (n mod d <> 0 && is_not_divisor (d+1)) in
    n <> 1 && is_not_divisor 2

(* returns true if a and b are coprime *)
let coprime a b =
    let rec gcd a b =
      if a = 0 then b else gcd (b mod a) a
    in
    (gcd a b) = 1


(* modular exponentiation
   b^n % m = (b * b)^(n/2) % m   if n % 2 = 0
   b^n % m = b*(b^(n-1)) % m     if n % 2 != 0
 *)
let rec mod_exp base exp modulus =
  match exp with
  | 0                -> 1
  | 1                -> base mod modulus
  | n when n mod 2 = 0 -> mod_exp (base * base mod modulus) (exp / 2) modulus
  | n                -> base * (mod_exp base (exp - 1) modulus) mod modulus


(* Modular multiplicative inverse:
   an integer x such that a x = 1 (mod m)
   the value of x should be in {0, 1, 2, ..., m - 1}.
   The multiplicative inverse of "a modulo m" exists if and only if a and m are coprime
*)
let modinv a m =
  (*
   Extended Euclidean algorithm also finds integer coefficients x and y such that:
     ax + by = gcd(a, b)
   Let values of x and y calculated by the recursive call be x1 and y1:
     x = y1 - [b/a] * x1
     y = x1
   *)
  let rec egcd a b =
    if a = 0 then
      (b, 0, 1)
    else
      let (g, x, y) = egcd b (a mod b) in
      (g, y - (b/a) * x, x)
  in
  match egcd a m with
  | (1, _, _) -> None
  | (_, x, _) -> Some (x mod m)

(* Definition of functions over lists and strings *)

(* Function defined by cases: it returns the last element *)
let rec last = function
    | [] -> None
    | [x] -> Some x
    | _ :: t -> last t

(* returns the last two elements *)
let rec last_two = function
    | [] | [_] -> None
    | [x;y] -> Some (x,y)
    | _::t -> last_two t

(* returns true if a list is palindrome *)
let is_palindrome list =
    list = List.rev list

(* returns a list where consecutive duplicate elements are removed *)
let rec compress = function
    | a :: (b :: _ as t) -> if a = b then compress t else a :: compress t
    | smaller -> smaller

(* returns a list where the elements are duplicated *)
let rec duplicate = function
    | [] -> []
    | h :: t -> h :: h :: duplicate t

(* given a string containing only lowercase letters, the function returns
   a version of the string compressed using rle encoding.
   For example,
   aaaabbbc -> a4b3c
*)
let rle_encoding str =
  let rec go current_index last_char seen acc =
    if current_index >= (String.length str) then
      (last_char, seen)::acc
    else if str.[current_index] = last_char then
      go (current_index + 1) last_char (seen + 1) acc
    else
      go (current_index + 1) str.[current_index] 1 ((last_char, seen)::acc)
  in
  if str = "" then
    str
  else
    let occ = go 1 str.[0] 1 [] in
    let buffer = Buffer.create (String.length str) in
    (occ
     |> List.rev
     |> List.iter (fun (char,occ) ->
         (if occ > 1 then
            Printf.sprintf "%c%n" char occ
          else
            Printf.sprintf "%c" char)
         |> Buffer.add_string buffer));
    Buffer.contents buffer


(* A very simple type: a person *)
type person = { name : string ; fiscalcode : string }

let make_person name code = {name = name; fiscalcode = code}

(* Update the record: note the function returns a new piece of data *)
let change_name name p = { p with name = name }


type 'a binary_tree =
    | Empty
    | Node of 'a * 'a binary_tree * 'a binary_tree

let example_tree =
  Node('a',
       Node('b', Node('d', Empty, Empty), Node('e', Empty, Empty)),
         Node('c', Empty, Node('f', Node('g', Empty, Empty), Empty)))

let example_int_tree =
    Node(1, Node(2, Node(4, Empty, Empty), Node(5, Empty, Empty)),
         Node(3, Empty, Node(6, Node(7, Empty, Empty), Empty)))

(* Insert a node into a search binary tree *)
let rec insert tree x = match tree with
    | Empty -> Node(x, Empty, Empty)
    | Node(y, l, r) ->
       if x = y then tree
       else if x < y then Node(y, insert l x, r)
       else Node(y, l, insert r x)

(* transform a list into a binary_tree *)
let construct l = List.fold_left insert Empty l
let _ = construct [3;2;5;7;1]
