# Languages, Compilers and Interpreters (Lab) - 3 CFU
**Teacher**: Letterio Galletta

**Contact**: *name.surname*(at)imtlucca.it

**Office hours**: contact me by e-mail

**Page of theory part of the course held by Prof. Roberta Gori**: http://pages.di.unipi.it/gori/Linguaggi-Compilatori2020/

## Course description
The course will present tools and techniques used in the implementation of programming languages. 
In particular, the course will guide students in the implementation of a compiler for a small 
subset of language C, called *MicroC*, and of an interpreter of a small functional language, called *FUN*. During the lectures students will work on programming assignments covering different aspects of language implementation. The programming language adopted for the exercises and the project is OCaml. At the end of the course students who completed all the assignments will have developed an simple interpreter and a compiler. 


## Learning objectives

After completing the course, students will have  
* Known the basics of the functional programming language OCaml;
* Implemented parsers using state-of-the-art parsers generators; 
* Designed and implemented semantic analyses for a functional and an imperative languages;
* Used the LLVM toolchain for generating and optimize code; 
* Had some fun along the way! :smile: 

## Program of the course

* Introduction to functional programming and to OCaml language;
* Lexing and parsing using `ocamllex` and `menhir`;
* Semantic analysis implementation: type checking, scope management, control-flow analysis;
* Introduction to LLVM infrastructure and LLVM intermediate language;
* Code generation.

## Lectures
This table specifies the lecture schedule with topics and materials.

See [these instructions](instructions.md) to set up your programming environment. 

| Date  | Topics | Slides | Examples | Assignments| 
| ------|------- | -------|----------|------------|
| 9/25  | Intro to OCaml: functions, string</br> REPL, compilation |  [Intro to the lab](ocaml-material/slides/lab-presentation.pdf)</br>[OCaml Tutorial](http://www.cs.columbia.edu/~sedwards/classes/2018/4115-fall/ocaml.pdf)</br>[OCaml Tools](ocaml-material/slides/ocaml-tools.pdf) | [ocaml-basics.ml](ocaml-material/code/ocaml-basics.ml)   | [Exercises 1](ocaml-material/exercises/exercises-1.md)       |
| 10/2 | Intro to OCaml: lists, tuples, records,</br> algebraic data types, pattern matching     | [OCaml Tutorial](http://www.cs.columbia.edu/~sedwards/classes/2018/4115-fall/ocaml.pdf)    | [ocaml-basics.ml](ocaml-material/code/ocaml-basics.ml)       | [Exercises 2](ocaml-material/exercises/exercises-2.md)
| 10/9 | - Intro to OCaml: module, imperative features.</br> - The interpreter of *FUN* | [OCaml Tutorial](http://www.cs.columbia.edu/~sedwards/classes/2018/4115-fall/ocaml.pdf)</br> [The interpreter of FUN](ocaml-material/slides/fun-interpreter.pdf) | [vector.mli](ocaml-material/code/vector.mli)</br>[vector.ml](ocaml-material/code/vector.ml)</br> [fun.ml](ocaml-material/code/fun.ml) | [Exercises 3](ocaml-material/exercises/exercises-3.md) |         
| 10/15 | - Discussion on previous programming assignments </br> - Introduction to lexing with `ocamllex` | [Lexing with ocamllex](frontend-material/slides/lexical-analysis.pdf) | - | - |
| 10/23 | Tutorial on `ocamllex` | [Lexing with ocamllex](frontend-material/slides/lexical-analysis.pdf) | [cwd.mll](frontend-material/code/cwd.mll) </br> [count.mll](frontend-material/code/count.mll) </br> [count_fun.mll](frontend-material/code/count_fun.mll) </br> [stokens.mll](frontend-material/code/stokens.mll) </br> [stokens_pos.mll](frontend-material/code/stokens_pos.mll) </br> [comments.mll](frontend-material/code/comments.mll) </br> [csv_simple.mll](frontend-material/code/csv_simple.mll) </br> [toy_lang.mll](frontend-material/code/toy_lang.mll) | [Exercises 4](frontend-material/exercises/exercises-lexing.md) 
| 10/30 | Tutorial on `menhir` | [Syntactic analysis with `menhir`](frontend-material/slides/syntactic-analysis.pdf) | [calc](frontend-material/code/calc) </br> [calc-alias](https://gitlab.inria.fr/fpottier/menhir/-/tree/master/demos/calc-alias) </br> [calc-ast](frontend-material/code/calc-ast) </br> [calc-ast-pos](frontend-material/code/calc-ast-pos) </br> [calc-two](https://gitlab.inria.fr/fpottier/menhir/-/tree/master/demos/calc-two) </br> [calc-multi](frontend-material/code/calc-multi) </br> [calc-incremental](https://gitlab.inria.fr/fpottier/menhir/-/tree/master/demos/calc-incremental) </br> [json](frontend-material/code/json)  | [Exercise 5](frontend-material/exercises/exercises-parsing.md)|  
| ... | ... | ... | ... | ... |


## Material

### Software
Programming assignments will use the following pieces of sotfware:
* [OCaml](https://ocaml.org/) - try to install the latest version. All the code shown during the course is tested with **the version 4.10.1**. 
* [Opam](https://opam.ocaml.org/) - OCaml package manager.
* [Menhir](http://gallium.inria.fr/~fpottier/menhir/) - a LR(1) parser generator for the OCaml programming language.
* [Clang](https://clang.llvm.org/) - a compiler for C programs.
* [LLVM](http://llvm.org/) - The LLVM compiler infrastructure. All the code shown during the course is tested with **the version 10.0**.
* [rlwrap](https://github.com/hanslub42/rlwrap) - a small utility to improve the editing capability of the OCaml REPL.

### Online Resources
* OCaml [user manual](http://caml.inria.fr/pub/docs/manual-ocaml/index.html)
* [OCaml Discourse](https://discuss.ocaml.org/) community
* [OCamlverse](https://ocamlverse.github.io/)
* The book [Functional Programming in OCaml](https://www.cs.cornell.edu/courses/cs3110/2019sp/textbook/)
* The book [Real World OCaml](https://dev.realworldocaml.org/)
* The book [OCaml Scientific Computing](https://ocaml.xyz/book/)
* [OCaml MOOC](https://www.youtube.com/playlist?list=PLALAWXhLW3667sFw1Lfo3LmHC7CFib2EN)
* An [interactive tutorial](https://learngitbranching.js.org/) on using `git`
* [LLVM Language Reference Manual](http://llvm.org/docs/LangRef.html)

### Further resources

[Here](references.md) you find a list of further references that complete and deepen the various topics covered during the course.
A rich collection of articles related to the course can be found in [Prof. Matt Might's blog](http://matt.might.net/articles/).