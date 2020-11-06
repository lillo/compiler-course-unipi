fun double x =
  x * 2
in
fun twice f =
  fun app x =
    f (f x)
  in
  app
in
twice double 4
