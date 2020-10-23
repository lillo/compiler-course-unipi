{
type token = PLUS | IF | ID of string | NUM of int | EOF

let string_of_token = function
  | PLUS   -> "PLUS"
  | IF     -> "IF"
  | ID(s)  -> Printf.sprintf "ID(%s)" s
  | NUM(i) -> Printf.sprintf "NUM(%d)" i
  | EOF    -> "eof"

let rec iterate scanner =
  match scanner () with
  | EOF -> ()
  | tok -> Printf.printf "%s\n" (string_of_token tok); iterate scanner
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0' - '9']
let identifier = letter (letter | digit | '_')*

rule token = parse
  | [' ' '\n' '\t']          { token lexbuf } (* ignore whitespace *)
  | '+'                      { PLUS }         (* a symbol *)
  | "if"                     { IF }           (* a keyword *)
  | identifier as id         { ID(id) }       (* identifiers *)
  | digit+ as lit            { NUM(int_of_string lit) } (* numeric literals *)
  | eof                      { EOF }

{
let () =
  let lexbuf = Lexing.from_channel stdin in
  iterate (fun () -> token lexbuf)
}
