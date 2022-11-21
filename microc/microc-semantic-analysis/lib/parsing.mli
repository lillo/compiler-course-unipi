exception Syntax_error of Location.lexeme_pos * string

val parse : (Lexing.lexbuf -> Parser.token) -> Lexing.lexbuf -> Ast.program
