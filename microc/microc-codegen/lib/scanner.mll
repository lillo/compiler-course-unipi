{
    open Parser

    (* Auxiliary definitions *)
    exception Lexing_error of Location.lexeme_pos * string

}

(* Scanner specification *)

rule next_token = parse 
| _        {EOF}