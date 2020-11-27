# MicroC semantic analysis

The goal of this assignment is to implement a semantic checker, i.e., types and name usage, for MicroC.

## The static semantics of MicroC

MicroC mainly follows the same rules of language C with some exceptions described below.

### Semantic rules
MicroC adopts a static scoping: 
* Block can be nested and the declaration of a variable `x` in a inner block hides possible declarations in outer blocks;
* There is a global scope that contains variables and function declarations;
* Functions cannot be nested;
* No function overloading.

MicroC does not support separate compilation, thus, each source file must provide the definition of the `main` function.
The signature of the `main` can be:
* `int main()` when it returns an integer;
* `void main()` when it returns no value.

We assume there exist two library functions to perform I/O operations:
* `void print(int)` to print an integer on the standard output;
* `int getint()` to read an integer from the standard input.

### Typing rules

MicroC types are defined by the following grammar

    T ::= int | bool | char | void | T* | T[]

where `T[]` denote the type of an array of `T` values.

Note that there are no type coercion:
* booleans and characters cannot be converted to integers;
* arrays and pointers are not interchangeable but are different types;
* arithmetic operators expect only integer values;
* logical operators expect only boolean values;
* dereference operator expects a pointer;
* in `a[i]` we expect `a` to be an array and `i` to be an integer value;
* conditional guards in `if` and `while` statements expect boolean values.

Finally, observe that:
* array should have a size of at least 1 element;
* array cannot be assigned, i.e., `array1 = array2` is not allowed;
* variables of type `void` are not allowed;
* function pointers are not supported yet;
* currently, functions cannot return pointers or arrays;
* multi-dimensional arrays are not supported, yet. 

## Requirement to build the code
The code requires:
* OCaml >= 4.10.1
* Menhir >= 20200624
* ppx_deriving >= 4.5 

You can install the required dependencies via `opam`
```sh
$ opam install menhir ppx_deriving
```
[Here](https://github.com/ocaml-ppx/ppx_deriving), you can the documentation of `ppx_deriving`.

## Building the code
Typing `make` will generate a `microcc.native` executable:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

## Directory structure #

Here is a description of content of the repository

    src/                               <-- The source code lives here
    Makefile                           <-- Driver for `make` (uses OCB)
    _tags                              <-- OCamlBuild configuration
    tests/                             <-- Some programs to test your implementation

## The source code

The `src/` directory provides:

    ast.ml                       <-- Definition of the abstract syntax tree of MicroC 
    microcc.ml                   <-- The file from which build the executable 
    parser_engine.ml             <-- Module to interact with the parser
    util.ml                      <-- Utility module  
    parser.mly                   <-- Menhir specification of the grammar 
    scanner.mll                  <-- ocamllex specification of the scanner
    semant.ml                    <-- Module that implements the semantic checker
    symbol_table.mli             <-- Interface of a polymorphic symbol table data type
    symbol_table.ml              <-- Implementation of a polymorphic symbol table data type 