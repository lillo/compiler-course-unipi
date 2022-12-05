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

Their implementation is written in C and it is the file `bin/rt-support.c`.
You can modify these functions as you prefer to match your compilation strategy. 
During the code generation phase, the module that you generate must include the 
corresponding prototype for these library functions.

Once you produce a bitcode file, to run your application you have to link it with 
the object code of the runtime support. 
To do that, you can use the LLVM command line tools we described during the lectures, e.g.,
`llvm-link`, `clang`.  

## Result of the linking and code generation phases
The code generation phase produces a LLVM modules that can be compiled and statically linked with the code the runtime support. 

## Requirement to build the code
The code requires:
* OCaml >= 4.12.0
* Menhir >= 20210419
* ppx_deriving >= 5.2 
* llvm >= 12.0.0

You can install the required dependencies via `opam`
```sh
$ opam install menhir ppx_deriving llvm
```
[Here](https://github.com/ocaml-ppx/ppx_deriving), you can find the documentation of `ppx_deriving`.

[Here](https://llvm.moe/ocaml/), you can find the documentation of LLVM bindings.

## Building the code and running the tests
Typing `make` will generate a the compiler executable `bin/microcc.exe`, and the testing program `test/codegen_test.exe`:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

To test your parser you can use the files in `test/samples` directory, for example
```
$ dune exec bin/microcc.exe -- samples/test-hello.mc
```
or 
```
$ dune exec test/codegen_test.exe -- samples/test-hello.mc
```
You can also use the bash script `testall.sh` to test the result of your compilation. 
Note that this script may be adapted to your local machine.

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
    codegen.ml                   <-- The module Codegen translates a µcomp-lang into a LLVM module
    codegen.mli                  <-- The interface of the module Codegen
    optimizer.ml                 <-- The module Optimizer runs a sequence of optimization on a LLVM module
    optimizer.mli                <-- The interface of the module Optimizer

The `bin/` directory provide:

    microcc.ml                   <-- The code of the compiler executable
    mcompc.mli                   <-- A dummy interface
    rt-support.c                 <-- A simple implementation of the functions of the standard library

**The assignment requires you to complete the implementation of `codegen.ml`. Depending on your compilation strategy in `codegen.ml` you may need to adjust the code in `rt-support.c`.**
