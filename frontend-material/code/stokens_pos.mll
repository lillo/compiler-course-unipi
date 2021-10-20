{
type token_type = PLUS | IF | ID of string | NUM of int | EOF
and token = { pos : Lexing.position ; tok_type : token_type }

let string_of_token_type = function
  | PLUS   -> "PLUS"
  | IF     -> "IF"
  | ID(s)  -> Printf.sprintf "ID(%s)" s
  | NUM(i) -> Printf.sprintf "NUM(%d)" i
  | EOF    -> "eof"

let string_of_position p =
  let line_number = p.Lexing.pos_lnum in
  let column = p.Lexing.pos_cnum - p.Lexing.pos_bol + 1 in
  Printf.sprintf "(%d, %d)" line_number column

let rec iterate scanner =
  match scanner () with
  | { tok_type = EOF; pos = _ } -> ()
  | tok -> Printf.printf "%s @ %s\n" (string_of_token_type tok.tok_type) (string_of_position tok.pos); iterate scanner

let make_token ttype lexbuf = { tok_type = ttype ; pos = Lexing.lexeme_start_p lexbuf }
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0' - '9']
let identifier = letter (letter | digit | '_')*

rule token = parse
  | [' ' '\n' '\t']          { token lexbuf } (* ignore whitespace *)
  | '+'                      { make_token PLUS lexbuf }       (* a symbol *)
  | "if"                     { make_token IF  lexbuf  }       (* a keyword *)
  | identifier as id         { make_token (ID(id)) lexbuf }   (* identifiers *)
  | digit+ as lit            { make_token (NUM(int_of_string lit)) lexbuf } (* numeric literals *)
  | eof                      { make_token EOF lexbuf }

{
let () =
  let lexbuf = Lexing.from_channel stdin in
  iterate (fun () -> token lexbuf)
}
