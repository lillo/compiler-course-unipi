# Languages, Compilers and Interpreters (Lab) - 3 CFU
**Teacher**: Letterio Galletta

**Page of theory part of the course held by Prof. Roberta Gori**: http://pages.di.unipi.it/gori/Linguaggi-Compilatori2020/

## Course description
The course will present tools and techniques used in the implementation of programming languages. 
In particular, the course will guide students in the implementation of a compiler for a small 
subset of language C, called *MicroC*, and of an interpreter of a small functional language, called *FUN*. During the lectures students will work on programming assignments covering different aspects of language implementation. The programming language adopted for the exercises and the project is OCaml. At the end of the course students who completed all the assignments will have developed an interpreter for the *FUN* language and a compiler for *MicroC*. 


## Learning objectives

After completing the course, students will have  
* Known the basics of the functional programming language OCaml
* Implemented parsers using state-of-the-art parsers generators 
* Designed and implemented semantic analyses for a functional and an imperative languages
* Used the LLVM toolchain for generating and optimize code 
* Had some fun along the way! :smile: 

## Program of the course

* Introduction to functional programming and to OCaml language;
* Lexing and parsing using `ocamllex` and `menhir`;
* Semantic analysis implementation: type checking and control-flow analysis;
* Introduction to LLVM infrastructure and LLVM intermediate language;
* Code generation.

## Lectures
This table specifies the lecture schedule with topics and materials.

| Date  | Topics | Slides | Examples | Assignments| 
| ------|------- | -------|----------|------------|
| 9/25  | ...    |  ...   | ....     | ....       |



## Material

### Software
Programming assignments will use the following pieces of sotfware:
* [OCaml](https://ocaml.org/) - try to install the latest version. All the code shown during the course is tested with **the version 4.10.1**. 
* [Opam](https://opam.ocaml.org/) - OCaml package manager.
* [Menhir](http://gallium.inria.fr/~fpottier/menhir/) - a LR(1) parser generator for the OCaml programming language.
* [Clang](https://clang.llvm.org/) - a compiler for C programs.
* [LLVM](http://llvm.org/) - The LLVM compiler infrastructure. All the code shown during the course is tested with **the version 10.0**.

### Online Resources
* OCaml [user manual](http://caml.inria.fr/pub/docs/manual-ocaml/index.html)
* The book [Functional Programming in OCaml](https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/
)
* The book [Real World OCaml](https://dev.realworldocaml.org/)
* [LLVM Language Reference Manual](http://llvm.org/docs/LangRef.html)
* [OCaml Discourse](https://discuss.ocaml.org/) community
* The book [OCaml Scientific Computing](https://ocaml.xyz/book/)
* An [interactive tutorial](https://learngitbranching.js.org/) on using `git`
