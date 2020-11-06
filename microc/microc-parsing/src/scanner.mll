{
    open Parser

    (* Put here your auxiliary definitions *)
}

rule token = parse
    | _ as c           { Util.raise_lexer_error lexbuf ("Illegal character " ^ Char.escaped c) }
