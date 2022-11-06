let () =
  let channel =
    if Array.length Sys.argv > 1 then
      Sys.argv.(1) |> open_in
    else
      stdin
  in
  try
    let lexbuf = Lexing.from_channel channel in
    let prog = Fun_parser.main Fun_lexer.next_token lexbuf in
    let _ = Fun.type_check prog in
    match Fun.run prog with
    | Int n -> Printf.printf "val - : %d\n" n
    | _     -> Printf.printf "val -: fun"
  with
  | Fun_lexer.Lexing_error msg ->
      Printf.fprintf stderr "%s%!" msg
  | Fun_parser.Error ->
      Printf.fprintf stderr "Syntax error.\n"
