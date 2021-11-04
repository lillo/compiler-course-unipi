{
 (* OCaml declaration*)   
 exception Lexing_error of Location.lexeme_pos * string    
}

(* Declaration of regular expressions *)

(* Declaration of scanner functions *)


rule next_token = parse
  | _             { failwith "Not implemented yet" }
