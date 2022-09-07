# Exercises on OCaml Programming (Part 2)

### Exercise 1
Write a function `swap_adjacent` that given a string of length `l` with `l` *even* swap the characters at position *i* and *i+1* for all *i* even in `[0, l - 1]`.
For example, `swap_adjacent "abcdpqrs"` returns `"badcqpsr"`.

### Exercise 2
Write a function `print_pascal` that, given an integer `k`, prints the first `k` rows of [Pascal's Triangle](https://en.wikipedia.org/wiki/Pascal%27s_triangle), where values in each row are separated by a space.
For example, given as input
```
4
```
the produced output is
```
1
1 1
1 2 1
1 3 3 1
```

### Exercise 3

Write a function `count_change` that given a list of coin denominations `d` and an amount of money `n`, returns in how many ways we can make the change.

For example, given `d = [1; 3; 5; 7]` and `n = 8` the result of `count_change d n` is `6`, because the possible changes are
```
[1;7]
[3;5]
[1;1;3;3]
[1;1;1;5]
[1;1;1;1;1;3]
[1;1;1;1;1;1;1;1]
```

Given `d = [1;2;3]` and `n = 4` the result of `count_change d n` is `4`, because the possible changes are
```
[1;3]
[2;2]
[1;1;2]
[1;1;1;1]
```

### Exercise 4

Write a function `count_sums` that, given two numbers `x` and `n`, returns the number of ways that `x` can be expressed as the sum of the `n` th power of unique natural numbers.
For example, if `x = 100` and `n = 2` the result of `count_sums x n` is `3` because the ways in which `100` can be expressed as the sums of squares are

$$10^2$$


$$6^2 + 8^2$$


$$1^2 + 3^2 + 4^2 + 5^2 + 7^2$$

