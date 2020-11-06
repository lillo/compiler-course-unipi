exception Syntax_error of string
exception Lexing_error of string


let get_lexing_position lexbuf =
  let p = Lexing.lexeme_start_p lexbuf in
  let line_number = p.Lexing.pos_lnum in
  let column = p.Lexing.pos_cnum - p.Lexing.pos_bol + 1 in
  (line_number, column)

let raise_syntax_error lexbuf msg =
  let pos = get_lexing_position lexbuf in
  let m = Printf.sprintf "%d:%d: %s" (fst pos) (snd pos) msg in
  raise (Syntax_error m)

let raise_lexer_error lexbuf msg =
  let pos = get_lexing_position lexbuf in
  let m = Printf.sprintf "%d:%d: %s" (fst pos) (snd pos) msg in
  raise (Lexing_error m)
