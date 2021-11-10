fun f(x : int -> int) : int = x 1 in

fun g(y : int) : int = y + 2 in

fun h(z : int) : int = z + 3 in

(f g) + (f h)
