open Syntax

let string_of_loc (startp, endp) =
  let start_column_number = startp.Lexing.pos_cnum  - startp.Lexing.pos_bol + 1 in
  let end_column_number = endp.Lexing.pos_cnum  - endp.Lexing.pos_bol + 1 in
  if start_column_number = end_column_number then
    string_of_int start_column_number
  else
    Printf.sprintf "%d-%d" start_column_number end_column_number



let rec interpret (e : expr) =
  match e.value with
  | ELiteral i ->
      i
  | EBinOp (e1, OpPlus, e2) ->
      interpret e1 + interpret e2
  | EBinOp (e1, OpMinus, e2) ->
      interpret e1 - interpret e2
  | EBinOp (e1, OpTimes, e2) ->
      interpret e1 * interpret e2
  | EBinOp (e1, OpDiv, e2) ->
      interpret e1 / interpret e2
  | EUnOp (OpNeg, e) ->
      - (interpret e)

let process (line : string) =
  let linebuf = Lexing.from_string line in
  try
    (* Run the parser on this line of input. *)
    let e = Parser.main Lexer.token linebuf in
    Printf.printf "%s> %d\n%!" (string_of_loc e.loc) (interpret e)
  with
  | Lexer.Error msg ->
      Printf.fprintf stderr "%s%!" msg
  | Parser.Error ->
      Printf.fprintf stderr "At offset %d: syntax error.\n%!" (Lexing.lexeme_start linebuf)

let process (optional_line : string option) =
  match optional_line with
  | None ->
      ()
  | Some line ->
      process line

let rec repeat channel =
  (* Attempt to read one line. *)
  let optional_line, continue = Lexer.line channel in
  process optional_line;
  if continue then
    repeat channel

let () =
  repeat (Lexing.from_channel stdin)
