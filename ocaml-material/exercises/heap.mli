(** Represent a min-heap of data of type 'a *)
type 'a t

(**
   Empty heap
 *)
val empty : 'a t

(** Create a heap with a single element.  [singleton k] returns a heap
   containing only k *)
val singleton : 'a -> 'a t

(** Insert a new element in the given list.  [insert k h] returns a new heap
   that contains all the elements of [h] plus [k].  *)
val insert : 'a -> 'a t -> 'a t

(** Merge together two given heaps.  [merge h1 h2] returns a new heap that
   contains all the element of [h1] and [h2].  *)
val merge : 'a t -> 'a t -> 'a t

(** Get the minimum element of the heap.  [get_min h] returns the minimum
   element of [h], [None] otherwise.  *)
val get_min : 'a t -> 'a option

(** Remove the minimum element from the heap.  [delete_min h] returns a new heap
   containing all the element of [h] except for the minimum element, if [h] is
   not empty. It returns an empty heap if [h] is empty.  *)
val delete_min : 'a t -> 'a t
