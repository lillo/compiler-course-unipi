exception Semantic_error of Location.code_pos * string

val type_check : Ast.program -> Ast.program
