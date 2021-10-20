type value =
  | Obj of (string * value) list
  | List of value list
  | String of string
  | Int of int
  | Float of float
  | Bool of bool
  | Null
[@@deriving show]
