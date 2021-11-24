# µcomp-lang semantic analysis

The goal of this assignment is to implement a semantic checker, i.e., types and name usage, for µcomp-lang.

## The static semantics of µcomp-lang

µcomp-lang mainly follows the same rules of many Java-like languages with exceptions described below.

### Semantic rules
µcomp-lang adopts a static scoping:
* Interfaces and components define their own scope;
* Interfaces and components cannot be nested;
* There is a global scope that contains interface and component declarations;
* The declarations inside the global scope are mutually recursive;
* A component must implement all the members defined in the interfaces it provides (the types of the members must be the same);
* The declarations inside a component are mutually recursive;
* The interfaces used by a component must not lead to *ambiguous* names, i.e. names provided by different used interfaces;
* A component can only provides and uses interfaces;  
* The name of an interface must occur only once in a `provides` and `uses` list;
* A component may provide two interfaces that have members with the same name as long as these members have the same type;  
* Block can be nested and the declaration of a variable `x` in a inner block hides possible declarations in outer blocks;
* Functions cannot be nested;
* No function overloading.

µcomp-lang does not support separate compilation, thus, each source file must contain the definition of a component that provides the interface `App`:
```
interface App {
  def main(): int;    
}
```
Note that the interface `App` can be provided by only one component and never used.

We assume there exists a `Prelude` component that provides two library functions to perform I/O operations:
```
interface Prelude {
  def print(v : int);
  def getint() : int;
}
```
The function `print` outputs an integer on the standard output; whereas, `getint` reads an integer from the standard input.
Note that the `Prelude` interface is implicitly used by all components, and that it cannot be provided by any component. 

### Typing rules

µcomp-lang types are defined by the following grammar

    T ::= int | bool | char | void | T& | T[n] | T[] | T1 x ... x Tn -> T | I[name] | C[name] 

where `T&` denotes a reference to a scalar value of type `T`;
`T[n]` denotes the type of an array of `n` values of type `T`;
`T[]` is the type of a reference to an array of `T` values;
`T1 x ... x Tn -> T` is the type of a function with `n` formal parameters;
`I[name]` and `C[name]` are the types of an interface `name` and of a component `name`, respectively.

Note that there are no type coercion:
* booleans and characters cannot be converted to integers;
* references to arrays and references to scalars are different types;
* arithmetic operators expect only integer values;
* logical operators expect only boolean values;
* in `a[i]` we expect `a` to be an array or a reference to an array and `i` to be an integer value;
* only functions can be invoked;
* a function call must provides a number of arguments equals to the parameters of the function;
* conditional guards in `if`, `while` and `for` statements expect boolean values.

Finally, observe that:
* array should have a size of at least 1 element;
* array cannot be assigned, i.e., `array1 = array2` is not allowed;
* array references can occur only as formal parameters;
* variables of type `void` are not allowed;
* references `T&` requires that `T` is a scalar type;
* currently, functions can only return `int`, `bool`, `char` and `void`;
* multi-dimensional arrays are not supported.
* references `T&` supports automatic dereference: when a reference does not occur 
  in the left hand-side of an assignment, it is automatically dereferenced and its type is `T`.
  For example, assume `x` to have type `int&` and `y` to be an `int`, then the statement is 
  ```
  y = x + 1;
  ``` 
  well typed, because `x` can be dereferenced so this expression `x + 1` has type `int` that is 
  compatible to the type of `y`. The result value of `y` will be the one pointed by `x` incremented by 1.   
* when a reference `x` of type `T&` is on the left hand-side of an assignment, the semantics of the assignment depends 
  on the type of the expression `e` on right hand-side. 
  If `e` has type `T&`, the assignment is well typed and its execution changes the address `x` points to with the address resulting from the evaluation of `e`. 
  For example, given `x` of type `int&` and `y` of type `int` the statement
  ```
  x = &y; 
  ```
  is well typed and it will assign the address of `y` to `x`.
  If `e` has type `T`, the assignment is well typed and its evaluation modifies the memory 
  location pointed by `x` with the result of `e`.
  For example, given `z` of type `int` with `x` of type `int&` (`x` points to `z`), the statement 
  ```
  x = x + 1;
  ```   
  is well typed and it will increment the value of `z` by 1.

## Result of the semantic analysis
The semantic analysis phase produces a typed AST where all member names are qualified with the name of the corresponding interface, if the program is well typed, otherwise it raises an error.  

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
Typing `make` will generate a dummy `bin/mcompc.exe` executable and a testing `test/semant_test.exe`:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

To test your parser you can use the files in `test/samples` directory, for example
```
$ dune exec test/semant_test.exe -- samples/test-hello.mc
```
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
    mcomp_stdlib.ml              <-- The module containing the types for the members of App and Prelude interfaces

**The assignment requires you to complete the implementation of `symbol_table.ml` and `semantic_analysis.ml`.**