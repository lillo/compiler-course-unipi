# µcomp-lang Compiler

µcomp-lang is a simple component-based imperative language.

The distinguishing features of µcomp-lang are:
* Programs are built out of components, which are **linked**/**wired** together to form whole programs (separation of construction and composition);

* A component is stateful and is a singleton, i.e., there is **only** an instance of each component, available at the beginning of the execution;

* The specification of component behaviour is given in terms **interfaces**. 
  Interfaces may be **provided** or **used** by the component. 
  The provided interfaces are intended to represent the functionality that the component provides to its clients, the used interfaces represent the functionality the component needs to perform its job;

* Interfaces specify a set of **functions** and **global variables** to be provided by the interface's provider;

* Components are statically linked to each other via their interfaces.


As part of the exam students will be asked to implement a compiler for µcomp-lang using the OCaml language, the tools and the techniques presented during the course. 
The project is made of four assignments that are released incrementally during the course, so that students can start working on the project before the end of classes (actually, the last assignment is released in the last lecture).

## An introduction to µcomp-lang

An high-level overview of the language is [here](OVERVIEW.md).

## Setup your development environment

A description of the provided project kit is [here](SETUP.md).

## µcomp-lang assignments

The project is split in the following assignments:

* **Parsing**: this assignment asks students to implement a parser for µcomp-lang. The specification of the syntax is available [here](mcomp-parsing/README.md); 

* **Semantic analysis**: this assignment mainly concerns the implementation of a static analysis for checking that a given program obeys the scoping rules and the type system of the language. The description of the semantic rules are here;

* **Component linking and code generation**: this assignment asks first to link component together according to what specified by the programmer and to use the LLVM toolchain to translate a µcomp-lang program to low level code (LLVM bitcode). 
The description of the linking rules are available here; 

* **Language extensions**: this assignment asks to extend the µcomp-lang language by considering further constructs. In particular, students are required to implement **at least two** of the following constructs: 
    * `do-while` loops;
    * pre/post increment/decrement operators, i.e., `++` and `--`;
    * abbreviation for assignment operators, i.e., `+=`, `-=`, `*=`, `/=` and `%=`;
    * variable declaration with initialization, e.g., `var i : int = 0`;
    * multi-dimensional arrays;
    * floating point arithmetic;
    * strings of characters;
    * inheritance among interfaces;
    * interfaces that can use other interfaces;
    * overloading of functions. 

To take the exam students must submit their solution, i.e., their OCaml code, the documentation of the code, and a report describing the design and the implementation choices adopted.  
