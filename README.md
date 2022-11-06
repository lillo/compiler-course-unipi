# Languages, Compilers and Interpreters (Lab) - 3 CFU
**Teacher**: Letterio Galletta

**Contact**: *name.surname*(at)imtlucca.it

**Office hours**: contact me by e-mail

**Page of theory part of the course held by Prof. Roberta Gori**: http://pages.di.unipi.it/gori/Linguaggi-Compilatori2022/

## Course description
The course will present tools and techniques used in the implementation of programming languages. 
During the lectures students will work on programming assignments covering different aspects of language implementation. 
The programming language adopted for the exercises and the project is OCaml. 
At the end of the course students who completed all the assignments and the project will have developed an simple interpreter and a compiler. 


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
| 10/03 | Intro to OCaml  |  [Intro to the lab](ocaml-material/slides/lab-presentation.pdf)<br/>[OCaml Tutorial](http://www.cs.columbia.edu/~sedwards/classes/2018/4115-fall/ocaml.pdf)<br/>[OCaml Tools](ocaml-material/slides/ocaml-tools.pdf) | [ocaml-basics.ml](ocaml-material/code/ocaml-basics.ml) <br/> [OCaml Programming Problems](https://ocaml.org/problems)  | [Exercises 1](ocaml-material/exercises/exercises-1.md)       |
| 10/10 | - Intro to OCaml: records, algebraic data types <br/> module, imperative features <br/> - The interpreter of FUN  | [OCaml Tutorial](http://www.cs.columbia.edu/~sedwards/classes/2018/4115-fall/ocaml.pdf) <br/> [The interpreter of FUN](ocaml-material/slides/fun-interpreter.pdf)   | [ocaml-basics.ml](ocaml-material/code/ocaml-basics.ml) <br/> [vector.mli](ocaml-material/code/vector.mli)</br>[vector.ml](ocaml-material/code/vector.ml)  <br/> [fun.ml](ocaml-material/code/fun.ml)  | [Exercises 2](ocaml-material/exercises/exercises-2.md) </br> [Exercises 3](ocaml-material/exercises/exercises-3.md) |
| 10/17 | Introduction to lexing with `ocamllex` | [Lexing with ocamllex](frontend-material/slides/lexical-analysis.pdf)| [cwd.mll](frontend-material/code/cwd.mll) <br/> [count.mll](frontend-material/code/count.mll) </br> [count_fun.mll](frontend-material/code/count_fun.mll) </br> [stokens.mll](frontend-material/code/stokens.mll) </br> [stokens_pos.mll](frontend-material/code/stokens_pos.mll) </br> [comments.mll](frontend-material/code/comments.mll) </br> [csv_simple.mll](frontend-material/code/csv_simple.mll) </br> [toy_lang.mll](frontend-material/code/toy_lang.mll) | [Exercises 4](frontend-material/exercises/exercises-lexing.md) |
| 10/24 | - Parsing with `menhir`</br> - Presentation of MicroC project | [Syntactic analysis with `menhir`](frontend-material/slides/syntactic-analysis.pdf)</br> [Introduction to MicrocC](frontend-material/slides/intro-microc.pdf) | [calc](frontend-material/code/calc) </br> [calc-alias](https://gitlab.inria.fr/fpottier/menhir/-/tree/master/demos/calc-alias) </br> [calc-ast](frontend-material/code/calc-ast) </br> [calc-ast-pos](frontend-material/code/calc-ast-pos) </br> [calc-two](https://gitlab.inria.fr/fpottier/menhir/-/tree/master/demos/calc-two) </br> [calc-multi](frontend-material/code/calc-multi) </br> [calc-incremental](https://gitlab.inria.fr/fpottier/menhir/-/tree/master/demos/calc-incremental) </br> [json](frontend-material/code/json) <br/> [FUN parser](frontend-material/code/fun-parser) solutions of exercises 4.5 & 5.4</br>  [IoT-Lysa parser](https://bitbucket.org/lillo/iotlysa/src/master/) as an example of parser using [FParsec](https://www.quanttec.com/fparsec/) </br> [MinCaml parser](https://github.com/matteobusi/incremental-mincaml/tree/master/src/fun/langspec) as an example of parser using `ocamlyacc` </br> [FrontC](https://github.com/BinaryAnalysisPlatform/FrontC) as an example of a `menhir` parser for a real language </br> [Solidity-parser](https://github.com/OCamlPro/ocaml-solidity/tree/master/src/solidity-parser) for an example of a `menhir` parser for a real language | [Exercise 5](frontend-material/exercises/exercises-parsing.md) <br/> [MicroC parser](microc/microc-parser/)| 
| 10/31   | No Lecture    |  -   | -      | -      |
| 11/07   |  -Discussion on previous assignments </br> - Type analysis | [Type analysis](semantic-analysis-material/slides/type-analysis.pdf) | [FUN type checker](semantic-analysis-material/code/fun-types) </br> [MinCaml](https://github.com/esumii/min-caml) </br> [Incremental MinCaml](https://github.com/matteobusi/incremental-mincaml) </br> [CADL](https://github.com/freek9807/CADL) </br> [Grow Your Own Type System](https://github.com/tomprimozic/type-systems) </br> [The PL Zoo](http://plzoo.andrej.com/) | [Exercises 6](semantic-analysis-material/exercises/exercises-types.md) |
| 11/14   | ... | ... | ... | ... |

## Final project
The final project of the course consists in implementing a compiler for MicroC. See [here](microc/) for the instructions.

## Material

### Software
Programming assignments will use the following pieces of software:
* [OCaml](https://ocaml.org/) - try to install the latest version. All the code shown during the course is tested with **the version 4.14.0**. 
* [Opam](https://opam.ocaml.org/) - OCaml package manager.
* [Menhir](http://gallium.inria.fr/~fpottier/menhir/) - a LR(1) parser generator for the OCaml programming language.
* [Clang](https://clang.llvm.org/) - a compiler for C programs.
* [LLVM](http://llvm.org/) - The LLVM compiler infrastructure. All the code shown during the course is tested with **the version 14.0**.
* [rlwrap](https://github.com/hanslub42/rlwrap) - a small utility to improve the editing capability of the OCaml REPL.
* [utop](https://github.com/ocaml-community/utop) - an improved toplevel (i.e., Read-Eval-Print Loop) for OCaml.

### Online Resources
* [OCaml API](https://ocaml.org/api/index.html)
* OCaml [user manual](http://caml.inria.fr/pub/docs/manual-ocaml/index.html)
* [OCaml Discourse](https://discuss.ocaml.org/) the community forum
* [OCamlverse](https://ocamlverse.github.io/) an attempt to documenting everything about OCaml
* The book [OCaml Programming: Correct + Efficient + Beautiful](https://cs3110.github.io/textbook/cover.html)
* The book [Real World OCaml](https://dev.realworldocaml.org/)
* The book [OCaml Scientific Computing](https://ocaml.xyz/book/)
* [OCaml MOOC](https://www.youtube.com/playlist?list=PLALAWXhLW3667sFw1Lfo3LmHC7CFib2EN)
* The videos of the book [OCaml Programming: Correct + Efficient + Beautiful](https://www.youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU)
* An [interactive tutorial](https://learngitbranching.js.org/) on using `git`
* [LLVM Language Reference Manual](http://llvm.org/docs/LangRef.html)
* [LLVM OCaml Binding Documentation](https://llvm.moe/ocaml/)
* [Kaleidoscope: Implementing a Language with LLVM in Objective Caml](https://llvm.org/docs/tutorial/)
* [Mapping High Level Constructs to LLVM IR](https://mapping-high-level-constructs-to-llvm-ir.readthedocs.io/en/latest/README.html)
* [The Programming Languages Zoo - A potpourri of programming languages](http://plzoo.andrej.com/)
* [Compiler Explorer](https://godbolt.org/)
* [Resources for Amateur Compiler Writers](https://c9x.me/compile/bib/)
* [CompilerJobs](https://mgaudet.github.io/CompilerJobs/) a list of compiler, language and runtime teams for people looking for jobs in this area.

### Further resources

[Here](references.md) you find a list of further references that complete and deepen the various topics covered during the course.
A rich collection of articles related to the course can be found in [Prof. Matt Might's blog](http://matt.might.net/articles/).
