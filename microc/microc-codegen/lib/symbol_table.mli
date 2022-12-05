exception DuplicateEntry of Ast.identifier
type 'a t 
val empty_table : 'a t 
val begin_block : 'a t -> 'a t 
val end_block : 'a t -> 'a t
val add_entry : Ast.identifier -> 'a -> 'a t -> 'a t 
val lookup : Ast.identifier -> 'a t -> 'a
val of_alist : (Ast.identifier * 'a) list -> 'a t 
