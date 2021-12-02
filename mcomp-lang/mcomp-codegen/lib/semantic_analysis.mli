exception Semantic_error of Location.code_pos * string

val type_check : Ast.located_compilation_unit -> Ast.typed_compilation_unit