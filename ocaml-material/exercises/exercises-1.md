# Exercises on OCaml Programming (Part 1)

## Exercise 1
The *series expansion* of $e^x$ is given by:

$$1 + x + \frac{x^2}{2!} + \frac{x^3}{3!} + \frac{x^4}{4!} + \dots$$

Evaluate $e^x$ for given values of **x** by using the above expansion for the first 10 terms.


## Exercise 2
We define *super digit* of an integer *x* as follows:
1. if *x* has only 1 digit, then its super digit is *x*;
2. otherwise, the super digit of *x* is equal to the super digit of the sum of its digits.

For example, the super digit of *3* is calculated as
```
super_digit(3) = 3
```
Instead, the super digit of
```
super_digit(148148148) = super_digit(1+4+8+1+4+8+1+4+8)
                       = super_digit(39)
                       = super_digit(3+9)
                       = super_digit(12)
                       = super_digit(1+2)
                       = super_digit(3)
                       = 3.
```
Write a function `super_digit` that given an integer `n` returns the super digit of `n`.

## Exercise 3

Write a function `list_replication` that, given a list `l` and a natural number `n`, returns a new list where each element is replicated `n` times. For example, if `l = [1;2;3;4]` and `n = 3`, the result of `list_replication l n` is `[1;1;1;2;2;2;3;3;3;4;4;4]`.

## Exercise 4
Write a function `list_replication1` that, given a list `l` and a natural number `n`, returns a new list that is obtained by concatenating `l` with itself `n` times. For example, if `l = [1;2;3;4]` and `n = 3`, the result of `list_replication l n` is `[1;2;3;4;1;2;3;4;1;2;3;4]`.

## Exercise 5
Write a function `is_function` that takes a relation `r` on integers as input, i.e., a list of pair `(x,y)` of integers, and returns `true` if `r` represents a valid function.
For example, `is_function r1` where `r1 = [(1,1); (2,2); (3,3)]` returns `true` because `r1` represents the identity function on the set `{1,2,3}`.
Instead, `is_function r2` with `r2 = [(1,2); (2,4); (3,6); (4,8); (1,0)]` returns `false` because `r2` cannot be a function.

## Exercise 6
Write a function `mingle_string` that given two string `p` and `q` of the same lenght and mingles them together.
For example, `mingle_string "abcde" "pqrst"` returns `"apbqcrdset"`.
