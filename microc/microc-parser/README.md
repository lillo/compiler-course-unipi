# MicroC Parser

The goal of this assignment is to implement a parser for MicroC. 
You must use `ocamllex` for implementing the scanner and `menhir` for the parser.

## MicroC syntax
In the following there is the specification of the syntax of MicroC.
Note that the syntax is a small variant of the syntax of the C language.

### Lexical elements

* Identifiers starts with a letter or an underscore and then can contain letters, underscore and numbers, e.g., `i`, `_local_var`, `string_of_int32`;

* Integer literals are sequence of digits in base 10 or digits in base 16 prefixed with `0x` (integers are 32bit values), e.g., `32`, `1024`, `3232`, `0xFF`, `0x10`;

* Character literals have the form `'c'` where c is a character, e.g., `a`, `A`, `1`, special characters are `\'`,`\b`, `\f`, `\t`, `\\`, `\r`, and `\n`;

* Boolean literals are `true` and `false`;

* Keywords are: `if`, `return`, `else`, `for`, `while`, `int`, `char`, `void`, `NULL`, `bool`;

* Operators are: &,  +, -, *, /, %,  =, ==, !=, <, <=, >, >=, &&, ||, !

* Other symbols: (, ), {, }, [, ], &, ;

* Comments:
    * `//...` single line comments;
    * `/* ... */` multi line comments.

The operators have the following precedence and associativity:

    right    =             /* lowest precedence */
    left     ||
    left     &&
    left     ==  != 
    nonassoc >  <  >=  <=
    left     +  - 
    left     *  /  %
    nonassoc !  &
    nonassoc [             /* highest precedence  */



### Syntax

Here is an ambiguous grammar for MicroC where tokens with no semantic values are enclosed between quotes, e.g., `"("`, whereas tokens with semantic values are capitalized, e.g., `INT`. 
As usual in EBNF notation, the operator `*` means zero or more occurrences, `+` means one or more occurrences, and `?` means at most one.

    Program ::= Topdecl* EOF
    
    Topdecl ::= Vardecl ";"  | Fundecl
    
    Vardecl ::= Typ Vardesc
    
    Vardesc ::= ID | "*" Vardesc | "(" Vardesc ")" | Vardesc "[" "]" | Vardesc "[" INT "]" 
    
    Fundecl ::= Typ ID "("((Vardecl ",")* Vardecl)? ")" Block
    
    Block ::= "{" (Stmt | Vardecl ";")* "}"
    
    Typ ::= "int" | "char" | "void" | "bool" 
    
    Stmt ::= "return" Expr? ";" | Expr? ";" | Block | "while" "(" Expr ")" Stmt 
        |    "for" "(" Expr? ";" Expr? ";" Expr? ")" Stmt
        |    "if" "(" Expr ")" Stmt "else" Stmt  | "if" "(" Expr ")" Stmt

    Expr ::= RExpr | LExpr

    LExpr ::= ID | "(" LExpr ")" | "*" LExpr | "*" AExpr | LExpr "[" Expr "]"

    RExpr ::= AExpr | ID "(" ((Expr ",")* Expr)? ")" | LExpr "=" Expr | "!" Expr 
        |  "-" Expr | Expr BinOp Expr 

    BinOp ::= "+" | "-" | "*" | "%" | "/" | "&&" | "||" | "<" | ">" | "<=" | ">=" | "==" | "!="

    AExpr ::= INT | CHAR | BOOL | "NULL" | "(" RExpr ")" | "&" LExpr

## Result of the parsing
The parsing phase produces an AST whose node are annotated with a location in the code, if the program is syntactically correct, 
otherwise it raises an error.

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
Typing `make` will generate a dummy `bin/microcc.exe` executable and a testing `test/parser_test.exe`:
```
$ make
```

To clean-up the folder, run:
```
$ make clean
```

To test your parser you can use the files in `test/samples` directory, for example
```
$ dune exec test/parser_test.exe -- samples/test-hello.mc
```

## Directory structure #

Read about the organization of the project [here](../SETUP.md#project-structure).

## The source code

The `lib/` directory contains the modules for each phase of the compiler. 
Your code will stay there.

More precisely, the `lib/` directory provides:

    ast.ml                       <-- Definition of the abstract syntax tree of MicroC 
    location.ml                  <-- The module Location provides two data types to represent code locations
    location.mli                 <-- The interface of the module Location   
    parser.mly                   <-- Menhir specification of the grammar
    parsing.ml                   <-- The module Parsing implements the parser 
    parsing.mli                  <-- The interface of the module Parsing  
    scanner.mll                  <-- ocamllex specification of the scanner 
    scanner.mli                  <-- The interface of the module Scanner

**The assignment requires you to complete the implementation of `scanner.mll`, `parser.mly` and `parsing.ml`.**