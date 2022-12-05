# MicroC Compiler

MicroC is a subset of the language C with the following simplification:

* It supports only integers (`int`), characters (`char`) and booleans (`bool`) as scalar values, array and pointers as compound data types;
* There are no structures, unions, doubles, function pointer;
* No dynamic allocation of memory;
* No multi-dimensional arrays;
* No shorthand for initialize variable during declaration;
* Functions can only return `void`, `int`, `bool`, `char`;
* No pointer arithmetic;
* Pointers and arrays are not interchangeable;
* no separate compilation, all the code of a program must stay in a unique compilation unit;
* there are only two library functions
```C
void print(int)  // it outputs an integer to standard output
int getint()     // it inputs an integer from standard input 
```

As part of the exam students will be asked to implement a compiler for MicroC using the OCaml language, the tools and the techniques presented during the course. 
The project is made of four assignments that are released incrementally during the course, so that students can start working on the project before the end of classes (actually, the last assignment is released in the last lecture).


## Setup your development environment

A description of the provided project kit is [here](SETUP.md).

## MicroC assignments

The project is split in the following assignments:

* **Parsing**: this assignment asks students to implement a parser for MicroC. The material is available [here](microc-parser/); 

* **Semantic analysis**: this assignment mainly concerns the implementation of a static analysis for check that a given program obeys the scoping rule and the type system of the language. The material is available [here](microc-semantic-analysis/);

* **Code generation**: this assignment asks to use the LLVM toolchain to compile a MicroC program to low level code (LLVM bitcode) and to perform some simple optimizations. The material is available [here](microc-codegen/); 

* **Language extensions**: this assignment asks to extend the MicroC language by considering further constructs. In particular, students are required to implement **at least three** of the following items: 
    * pre/post increment/decrement operators, i.e., `++` and `--`, and  abbreviation for assignment operators, i.e., `+=`, `-=`, `*=`, `/=` and `%=`;
    * `do-while` loop, variable declaration with initialization and multiple declarations, e.g., `int i = 0, *j = &z;`;
    * pointers, arrays & multi-dimensional arrays as in C;
    * floating point arithmetic and strings as in C, i.e. null-terminated arrays of characters;
    * structs, `sizeof`, bitwise and comma operators;
    * a new semantic analysis pass to detect deadcode;
    * seperate compilation. 

To take the exam students must submit their solutions to the teacher via email by the deadline reported on the exam registration portal.
The submitted solution must include the OCaml code, the documentation of the code, and a report describing the design and the implementation choices adopted.
