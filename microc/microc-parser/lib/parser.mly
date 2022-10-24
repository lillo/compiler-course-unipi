/*
* MicroC Parser specification
*/

%{
     (* Auxiliary definitions *)   

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
  |  EOF                      {Ast.Prog([])}
;
