exception Lexing_error of Location.lexeme_pos * string

val next_token : Lexing.lexbuf -> Parser.token
