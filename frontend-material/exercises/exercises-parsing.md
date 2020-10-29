# Exercises on parsing

For the following exercises use `menhir`.
Recall that you can generate a parser from a `parser.mly` file using the command
```sh
$ menhir parser.mly
```
and then compile the generated file `parser.ml` as usual.
You can perform the previous steps using `ocamlbuild`, for example,
if the entry point of the program is in the trailer of `parser.mll`, the command
```sh
$ ocamlbuild -use-menhir parser.byte
```

## Exercise 1

Extend the `calc` parser by introducing a construct for declaring variable. Thus,
a line of input can be an expression or a `let` declaration:
```ocaml
let x = expr
```
the result of evaluating a declaration consists in the name of the declared variable together with the bound value.
For example,
```ocaml
let x = 10 * 2
```
produces
```ocaml
val x : 20
```
Once a variable is declared it can be used in subsequent expressions, e.g.,
```ocaml
x + 10
```
results in
```ocaml
30
```
The declaration of the identifier `x` overrides previous declarations of `x`.

## Exercise 2

Extend `calc` so that expressions evaluate to floating-point values.
Moreover, extend the expressions to use the standard trigonometric functions, e.g., `sin` and `cos`, the logarithmic function `log` and the exponentiation `**` operator.
For example, your program should be evaluate
```
sin(3.0) * cos(0.9) + log(2 ** (4 - 2))
```

**Hint**: Pay attention to the associativity and precedence of the operator `**`.


## Exercise 3

Consider the first version of `calc` presented during the lecture.
Modify it so to emit the expressions in an assembly-like representation.

The instruction set is the following one:

```
load rN, NUM            # sets the value of register N to NUM
add  rA, rB, rC         # sets the value of register A to the sum of the values from register B and C
sub  rA, rB, rC         # sets the value of register A to the difference of the values from register B and C
mul  rA, rB, rC         # sets the value of register A to the product of the values from register B and C
div  rA, rB, rC         # sets the value of register A to the quotient of the values from register B and C
```

The available registers are identified by `rN` where `N` is a natural number, e.g., `r0`, `r9` and `r12345` are all valid registers.
For example, consider the expression
```
(3 + 2) * 5
```
once compiled it should generate the following
```asm
load r1, 3
load r2, 2
add  r3, r1, r2
load r4, 5
mul  r5, r3, r4
```

## Exercise 4

Implement a parser for the language *FUN* we presented in the previous lectures, and integrate it with the the interpreter and the lexer we already developed.
