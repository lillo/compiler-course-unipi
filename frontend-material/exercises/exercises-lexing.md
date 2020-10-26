# Exercises on Lexing

For the following exercises use `ocamllex`.
Recall that you can generate a scanner from a `lexer.mll` file using the command
```sh
$ ocamllex lexer.mll
```
and then compile the generated file `lexer.ml` as usual.
You can perform the previous steps using `ocamlbuild`, for example,
if the entry point of the program is in the trailer of `lexer.mll`, the command
```sh
$ ocamlbuild lexer.byte
```

## Exercise 1

Write a scanner that tokenizes a (whitespace-separated) sequence of decimal
floating point numbers, and print them in a separated line with a precision of 4
fractional digit (see the module
[Printf](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Printf.html)).
Example input:
```
10 0.7 1.3e07 -37
-0 2. .27 1.5E+9 150E-9
```

## Exercise 2

Write a scanner that tokenizes a sequence of C-like string and that replaces
escape sequences with the correspondig characters.
Example input:
```
"Hello\n\tGoodbye"
"Some\"special\'characters.*\\"
"A simple string"
```

## Exercise 3

The comment-density in a source file is the ratio between the number of
characters in comments and the number of characters in code.  Write a scanner
that given a source file with `ocaml` comments, i.e., delimited by `(*` and
`*)`, print the number of characters inside comments, outside comments and the
comment-density.

## Exercise 4

Modify the scanner for the toy language presented during the class (file [toy_lang.mll](../code/toy_lang.mll))
in such a way it prints for each occurrence of an identifer, its position in the file.

## Exercise 5

Write a scanner for the *FUN* language that we presented during the previous
classes.  You need to identify the relevant kinds of tokens and what pieace of
data each token should carry.  To test your scanner write a program that reads
some code from either a file or standard input, and prints all the tokens.
