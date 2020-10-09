# Exercises on OCaml Programming (Part 3)

### Exercise 1
A [leftist heap](https://en.wikipedia.org/wiki/Leftist_tree) is a variant of a binary heap, where every node `x` has an *s-value* which is the distance to the nearest leaf in subtree rooted at `x`.
In contrast to a binary heap, a leftist tree can be  unbalanced. In addition to the heap property, leftist trees are maintained so the right descendant of each node has the lower s-value.

Implement a lestist heap by instantiating the following module signature ([heap.mli](heap.mli))
```ocaml
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
```

### Exercise 2
Extend the *FUN* language and its interpreter that we discussed during the class by adding the following constructs:
- *Tuples:* a tuple is an heterogeneous list of values of a fixed length;  provide also an operation `proj` that given a tuple and a natural number `i` returns the `i`th element of `t`.

- *Lists:* a list is an homogeneous sequence of values; provide the following operations:
    - `cons` that given a value `v` and a list `l`, construct a new list where `v` is the head of `l`;
    - `head` that given a list `l` return the head of the list;
    - `tail` that given a list `l` return the list obtained by removing the head of `l`;


Define the syntax for the new constructs and implement their semantics by taking care of signaling and handling possible run-time error, e.g., `tail` applied to an empty list.