# Exercises on Types

## Exercise 1

Extend the interpreter and the type system of *FUN* by introducing the following constructs:

* a construct for annotating an expression with a type. Intuitively,
```ocaml
   (e : t)
```
means that the expression `e` must have type `t`;

* constructs for tuples, i.e., tuple constructors and projections;

* constructs for lists, i.e., cons, head, tail.
