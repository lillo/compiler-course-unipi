fun double(x : int) : int =
  x * 2
in
fun twice(f : int -> int) : int -> int =
  fun app(x : int) : int =
    f (f x)
  in
  app
in
twice double 4
