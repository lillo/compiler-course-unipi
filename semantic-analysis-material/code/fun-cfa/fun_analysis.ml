(*
Compiles with
$ ocamlbuild -use-ocamlfind -package ppx_deriving.std -use-menhir fun_analysis.byte
*)
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
    let annotated_prog = Fun_cfa.to_aexpr prog in
    Printf.printf "Annotated expression:\n\n%s\n\n" (Fun_cfa.show_aexpr annotated_prog);
    let constraints = Fun_cfa.constrs_of_aexpr annotated_prog in
    Printf.printf "Generated constraints:\n\n";
    List.iter (fun c ->
        Printf.printf "%s\n\n" (Fun_cfa.Solver.show c)) constraints;
    let solution = Fun_cfa.Solver.solve constraints in
    Printf.printf "Solution:\n\n";
    Seq.iter (fun (v, c) ->
        Printf.printf "%s =: [" (Fun_cfa.Var.show v);
        Seq.iter (fun s -> Printf.printf "%s " (Fun_cfa.Token.show s)) c;
        Printf.printf "]\n"
      ) solution
  with
  | Fun_lexer.Lexing_error msg ->
      Printf.fprintf stderr "%s%!" msg
  | Fun_parser.Error ->
      Printf.fprintf stderr "Syntax error.\n"
