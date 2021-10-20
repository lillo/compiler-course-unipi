%{
open Syntax
%}

%token <int> INT
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token EOL

%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */

%start <Syntax.expr> main

%%

main:
| e = expr EOL
    { e }

expr:
| i = INT
    { ELiteral i }
| LPAREN e = expr RPAREN
    { e }
| e1 = expr PLUS e2 = expr
    { EBinOp(e1, OpPlus, e2) }
| e1 = expr MINUS e2 = expr
    { EBinOp(e1, OpMinus, e2) }
| e1 = expr TIMES e2 = expr
    { EBinOp(e1, OpTimes, e2) }
| e1 = expr DIV e2 = expr
    { EBinOp(e1, OpDiv, e2) }
| MINUS e = expr %prec UMINUS
    { EUnOp(OpNeg, e) }
