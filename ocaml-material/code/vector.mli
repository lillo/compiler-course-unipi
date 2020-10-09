type vector

(** change the sign of a vector *)
val (~.) : vector -> vector

(** vector sum **)
val (+) : vector -> vector -> vector

(** vector difference *)
val (-) : vector -> vector -> vector

(** product with a number *)
val ( * ) : float -> vector -> vector

(** dot product *)
val (&) : vector -> vector -> float

(** length of a vector *)
val norm  : vector -> float

(** make vector *)
val make  : float * float -> vector

(** get coordinates *)
val coord : vector -> float * float
