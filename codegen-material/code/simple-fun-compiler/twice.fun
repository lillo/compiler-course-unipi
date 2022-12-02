fun double(x : int) : int =
  x * 2
end
fun twice(f : int -> int) : int -> int =
  f
end
twice double
