# MicroC code generation

The goal of this assignment is to translate MicroC code into LLVM IR code.

## The static semantics of MicroC

MicroC mainly follows the same rules of language C with some exceptions described below.

### Code generation & runtime support
For the code generation, you should use the LLVM API we presented during the classes.
Remember that you only generate code for semantically correct programs, thus, you can be sure that
some situations are catch in the previous compilation stages.

MicroC support two library functions to perform I/O operations:
* `void print(int)` to print an integer on the standard output;
* `int getint()` to read an integer from the standard input.

Their implementation is written in C and it is the file `src/rt-support.c`. 
During the code generation phase, the module that you generate must include the 
corresponding prototype for these library functions.

Once you produce a bitcode file, to run your application you have to link it with 
the object code of the runtime support. 
To do that, you can use the LLVM command line tools we described during the lectures, e.g.,
`llvm-link`, `clang`.  

## Requirement to build the code
The code requires:
* OCaml >= 4.10.1
* Menhir >= 20200624
* ppx_deriving >= 4.5 
* llvm >= 10.0.0

You can install the required dependencies via `opam`
```sh
$ opam install menhir ppx_deriving llvm
```
[Here](https://github.com/ocaml-ppx/ppx_deriving), you can find the documentation of `ppx_deriving`.

[Here](https://llvm.moe/ocaml/), you can find the documentation of LLVM bindings.

## Building the code
Typing `make` will generate a `microcc.native` executable:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

## Testing of implementation
The directory `test` contains some test cases that you can use to test your implementation. 
Each test case consists of a small MicroC program (the file with extension `*.mc`) together 
with the result that the program is supposed to produce (the file with extension `*.out`).

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
    codegen.ml                   <-- Module that implements the code generation
    util.ml                      <-- Utility module  
    opt_pass.ml                  <-- Module that implements some simple optimizations
    rt-support.c                 <-- The runtime support to be linked to bitcode files produced by your compiler
    parser.mly                   <-- Menhir specification of the grammar 
    scanner.mll                  <-- ocamllex specification of the scanner
    semant.ml                    <-- Module that implements the semantic checker
    symbol_table.mli             <-- Interface of a polymorphic symbol table data type
    symbol_table.ml              <-- Implementation of a polymorphic symbol table data type 