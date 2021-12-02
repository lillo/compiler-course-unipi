# µcomp-lang component linking and code generation

The goal of this assignment is to implement a linking step that resolve the external names used inside a component, and 
to translate µcomp-lang code into LLVM IR code.

## Linking µcomp-lang components

The semantic analysis phase returns a typed AST where the external names are qualified with the names of the used interface.
The goals of the linking phase the followings:
1. Check that the connections specified by the programmer are meaningful (see below);
2. Rewrite the typed AST in such a way that the external names are qualified with the name of the component specified in the connections.

Consider the function `InsertionSort.insertionSort` presented [here](../OVERVIEW.md). 
In the implementation of this function we invoke the function `compare` defined 
in the interface `Comparator` used by `InsertionSort`. 
After the semantic analysis phase, `compare` is qualified with the name of the interface `Comparator`, i.e.,
`Comparator.compare`. 
After the linking, since there is the connection 
```
connect InsertionSort.Comparator <- EntryPoint.Comparator;
```
the name `compare` is qualified with `EntryPoint`, obtaining `EntryPoint.compare`.  

Given a connection 
```
ID1.ID2 <- ID3.ID4
```
the linker must ensure that:
- `ID1` and `ID3` are the names of two different components;
- `ID2` is the name of an interface *used* by `ID1`;
- `ID4` is the name of an interface *provided* by `ID3`.
- `ID2` and `ID3` are the same interface.

Moreover, once a connection is established between two components, it cannot be overwritten. For example, the snippet of code
```
connection C1.I <- C2.I;
connection C1.I <- C3.I;
```
is illegal because the second connection cannot replace the first one.

Finally, the linker must check that for each component `C` there is a connection for *all* the interfaces it uses.  


## Code generation & runtime support

For the code generation, you should use the LLVM API we presented during the classes.
Remember that you only generate code for semantically correct programs, thus, you can be sure that
some situations are catch in the previous compilation stages.

As we discussed in classes, a LLVM module consists of globals and functions declarations, so you have to define 
a compilation strategy for your components. 
A simple approach could be to "explode" each component in the global namespace taking care that each 
component member has a unique name, e.g., using a mechanism similar to [name mangling](https://en.wikipedia.org/wiki/Name_mangling), and that each usage of that member name is handled accordingly.


µcomp-lang provides the interface `Predule` that includes library functions to perform I/O operations:
* `print` to print an integer on the standard output;
* `getint` to read an integer from the standard input.

Their implementation is written in C and it is the file `bin/rt-support.c`. 
You can modify these functions as you prefer to match your compilation strategy.
During the code generation phase, the module that you generate must include the 
corresponding prototype for these library functions.

Moreover, the entry point of the program is the function `main` of the only component in the source 
file which provides the `App` interface. 
The generated code must take care "calling" this function. 

Once you produce a bitcode file, to run your application you have to link it with 
the object code of the runtime support. 
To do that, you can use the LLVM command line tools we described during the lectures, e.g.,
`llvm-link`, `clang`.

## Result of the linking and code generation phases
The linking phase produces a typed AST where all external names are qualified with the name of the connected component, if the connections are well formed, otherwise it raises an error.
The code generation phase produces a LLVM modules that can be compiled and statically linked with the code the runtime support.  

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
Typing `make` will generate a the compiler executable `bin/mcompc.exe`, and two testing programs `test/linker_test.exe` and `test/codegen_test.exe`:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

To test your parser you can use the files in `test/samples` directory, for example
```
$ dune exec bin/mcompc.exe -- samples/test-hello.mc
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

    ast.ml                       <-- Definition of the abstract syntax tree of µcomp-lang 
    location.ml                  <-- The module Location provides two data types to represent code locations
    location.mli                 <-- The interface of the module Location   
    parser.mly                   <-- Menhir specification of the grammar
    parsing.ml                   <-- The module Parsing implements the parser of µcomp-lang
    parsing.mli                  <-- The interface of the module Parsing  
    scanner.mll                  <-- ocamllex specification of the scanner 
    scanner.mli                  <-- The interface of the module Scanner
    symbol_table.ml              <-- The module Symbol_table provides the implementation of a symbol table
    symbol_table.mli             <-- The interface of the module Symbol_table
    semantic_analysis.ml         <-- The module Semantic_analysis implements the semantic checker of µcomp-lang
    semantic_analysis.mli        <-- The interface of the module Semantic_analysis
    linker.ml                    <-- The module Linker implements the linking phase of µcomp-lang
    linker.mli                   <-- The interface of the module Linker
    codegen.ml                   <-- The module Codegen translates a µcomp-lang into a LLVM module
    codegen.mli                  <-- The interface of the module Codegen
    optimizer.ml                 <-- The module Optimizer runs a sequence of optimization on a LLVM module
    optimizer.mli                <-- The interface of the module Optimizer 

The `bin/` directory provide:

    mcompc.ml                    <-- The code of the compiler executable
    mcompc.mli                   <-- A dummy interface
    rt-support.c                 <-- A simple implementation of the functions provided by `Prelude`

**The assignment requires you to complete the implementation of `linker.ml` and `codegen.ml`. Depending on your compilation strategy in `codegen.ml` you may need to adjust the code in `rt-support.c`.**