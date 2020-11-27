/*
* MicroC Parser specification
*/

%{
    open Ast

    (* Define here your utility functions *)


%}

/* Tokens declarations */


%token EOF

/* Precedence and associativity specification */



/* Starting symbol */

%start program
%type <Ast.program> program    /* the parser returns a Ast.program value */

%%

/* Grammar specification */

program:
  |  EOF                      {Prog([])}
;
