# µcomp-lang Parser

The goal of this assignment is to implement a parser for µcomp-lang. 
You must use `ocamllex` for implementing the scanner and `menhir` for the parser.

## µcomp-lang syntax
In the following there is the specification of the syntax of µcomp-lang. 
 

### Lexical elements

* Identifiers starts with a letter or an underscore and then can contain letters, underscore and numbers, e.g., `i`, `_local_var`, `string_of_int32`.
By convention, names follow the *camel case* notation: we use *lower camel case* for variables and functions, and *upper camel case* for components and interfaces. 
Identifiers have a max length of 64 characters.

* Integer literals are sequence of digits in base 10 or digits in base 16 prefixed with `0x` (integers are 32bit values), e.g., `32`, `1024`, `3232`, `0xFF`, `0x10`;

* Character literals have the form `'c'` where c is a character, e.g., `a`, `A`, `1`,  special characters are `\'`,`\b`, `\f`, `\t`, `\\`, `\r`, and `\n`;

* Boolean literals are `true` and `false`;

* Keywords are: `var`, `if`, `return`, `else`, `while`, `int`, `char`, `void`, `bool`, `interface`, `uses`, `provides`, `component`, `connect`, `def`, `for` ;

* Operators are: &,  +, -, *, /, %,  =, ==, !=, <, <=, >, >=, &&, ||, !

* Other symbols: (, ), {, }, [, ], ., <-, :;

* Comments:
    * `//...` single line comments;
    * `/* ... */` multi line comments (no nesting).

The operators have the following precedence and associativity:

    right    =             /* lowest precedence */
    left     ||
    left     &&
    left     ==  != 
    nonassoc >  <  >=  <=
    left     +  - 
    left     *  /  %
    nonassoc !  &
    nonassoc [  .          /* highest precedence  */


### Syntax

Here is an ambiguous grammar for µcomp-lang where tokens with no semantic values are enclosed between quotes, e.g., `"("`, whereas tokens with semantic values are capitalized, e.g., `INT`. 
As usual in EBNF notation, the operator `*` means zero or more occurrences, `+` means one or more occurrences, and `?` means at most one.

    CompilationUnit ::= TopDecl* EOF
 
    TopDecl ::= "interface" ID "{" IMemberDecl+ "}" 
              | "component" ID ProvideClause? UseClause? "{" CMemberDecl+ "}"
              | "connect" Link ';'
              | "connect" "{" (Link ";")* "}"

    Link ::=  ID "." ID "<-" ID "." ID 

    IMemberDecl ::= "var" VarSign ";" | FunProto ";"

    ProvideClause ::= "provides" (ID ",")* ID 

    UseClause ::= "uses" (ID ",")* ID

    VarSign ::= ID ":" Type
    
    FunProto ::= "def" ID "("((VarSign ",")* VarSign)? ")" (":" BasicType)? 

    CMemberDecl ::= "var" VarSign ";"  | FunDecl
    
    Fundecl ::= FunProto Block
    
    Block ::= "{" (Stmt | "var" VarSign ";")* "}"
    
    Type ::= BasicType | Type "[" "]" | Type "[" INT "]" | "&" BasicType

    BasicType ::= "int" | "char" | "void" | "bool"  
    
    Stmt ::= "return" Expr? ";" | Expr? ";" | Block | "while" "(" Expr ")" Stmt 
           | "if" "(" Expr ")" Stmt "else" Stmt  | "if" "(" Expr ")" Stmt
           | "for" "(" Expr? ";" Expr? ";" Expr? ")" Stmt

    Expr ::= INT | CHAR | BOOL | "(" Expr ")" | "&" LValue | LValue "=" Expr | "!" Expr 
           | ID "(" ((Expr ",")* Expr)? ")" | LValue | "-" Expr | Expr BinOp Expr  

    LValue ::= ID | ID "[" Expr "]"

    BinOp ::= "+" | "-" | "*" | "%" | "/" | "&&" | "||" | "<" | ">" | "<=" | ">=" | "==" | "!="

## Result of the parsing
The parsing phase produces an located AST where all names are not qualified, if the program is syntactically correct, otherwise it raises an error.  

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
Typing `make` will generate a dummy `bin/mcompc.exe` executable and a testing `test/parser_test.exe`:
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

    ast.ml                       <-- Definition of the abstract syntax tree of mcomp-lang 
    location.ml                  <-- The module Location provides two data types to represent code locations
    location.mli                 <-- The interface of the module Location   
    parser.mly                   <-- Menhir specification of the grammar
    parsing.ml                   <-- The module Parsing implements the parser of mcomp-lang
    parsing.mli                  <-- The interface of the module Parsing  
    scanner.mll                  <-- ocamllex specification of the scanner 
    scanner.mli                  <-- The interface of the module Scanner

**The assignment requires you to complete the implementation of `scanner.mll`, `parser.mly` and `parsing.ml`.**    