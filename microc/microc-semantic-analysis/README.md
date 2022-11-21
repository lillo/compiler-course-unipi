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

where `T[]` denote the type of an array of `T` values and `T*` the type of pointers to `T`.

Note that there are no type coercion:
* booleans and characters cannot be converted to integers;
* arrays and pointers are not interchangeable but are different types;
* arithmetic operators expect only integer values;
* logical operators expect only boolean values;
* dereference operator expects a pointer;
* in `a[i]` we expect `a` to be an array and `i` to be an integer value;
* only functions can be invoked;
* a function call must provides a number of arguments equals to the parameters of the function;
* conditional guards in `if` and `while` statements expect boolean values.

Finally, observe that:
* array should have a size of at least 1 element;
* array cannot be assigned, i.e., `array1 = array2` is not allowed;
* variables of type `void` are not allowed;
* function pointers are not supported yet;
* currently, functions only return `int`, `bool`, `char` and `void`;
* multi-dimensional arrays are not supported, yet. 

## Result of the semantic analysis
The semantic analysis phase returns the AST of the program, if the program is well typed, otherwise it raises an error.

## Requirement to build the code
The code requires:
* OCaml >= 4.12.0
* Menhir >= 20210419
* ppx_deriving >= 5.2  

You can install the required dependencies via `opam`
```sh
$ opam install menhir ppx_deriving
```
[Here](https://github.com/ocaml-ppx/ppx_deriving), you can the documentation of `ppx_deriving`.

## Building the code and running the tests
Typing `make` will generate a dummy `bin/microcc.exe` executable and a testing `test/semant_test.exe`:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

To test your analyzer you can use the files in `test/samples` directory, for example
```
$ dune exec test/semant_test.exe -- samples/test-hello.mc
```

## Directory structure #

Read about the organization of the project [here](../SETUP.md#project-structure).

## The source code

The `lib/` directory contains the modules for each phase of the compiler. 
Your code will stay there.

More precisely, the `lib/` directory provides:

    ast.ml                       <-- Definition of the abstract syntax tree of MicroC 
    microcc.ml                   <-- The file from which build the executable 
    location.ml                  <-- The module Location provides two data types to represent code locations
    location.mli                 <-- The interface of the module Location   
    parser.mly                   <-- Menhir specification of the grammar
    parsing.ml                   <-- The module Parsing implements the parser
    parsing.mli                  <-- The interface of the module Parsing  
    scanner.mll                  <-- ocamllex specification of the scanner 
    scanner.mli                  <-- The interface of the module Scanner
    symbol_table.ml              <-- The module Symbol_table provides the implementation of a symbol table
    symbol_table.mli             <-- The interface of the module Symbol_table
    semantic_analysis.ml         <-- The module Semantic_analysis implements the semantic checker
    semantic_analysis.mli        <-- The interface of the module Semantic_analysis

**The assignment requires you to complete the implementation of `symbol_table.ml` and `semantic_analysis.ml`.**