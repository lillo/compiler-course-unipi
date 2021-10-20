open Lexing

let string_of_position lexbuf =
  let pos = lexbuf.lex_curr_p in
  Printf.sprintf "%s:%d:%d" pos.pos_fname pos.pos_lnum (pos.pos_cnum - pos.pos_bol)

let parse_with_error lexbuf =
  try
    Parser.json_unit Lexer.token lexbuf
  with
  | Lexer.Error msg ->
    Printf.fprintf stderr "%s: %s\n" (string_of_position lexbuf) msg;
    None
  | Parser.Error ->
    Printf.fprintf stderr "%s: syntax error\n" (string_of_position lexbuf);
    exit(-1)

let rec parse_and_print lexbuf =
  match parse_with_error lexbuf with
  | Some(value) ->
    Printf.printf "%s\n" (Json.show_value value);
    parse_and_print lexbuf
  | None ->
    ()

let () =
  let filename, in_channel =
    if Array.length (Sys.argv) == 2 then
      (Sys.argv.(1), open_in Sys.argv.(1))
    else
      ("<stdin>", stdin)
  in
  let lexbuf = Lexing.from_channel ~with_positions:true in_channel in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  parse_and_print lexbuf
