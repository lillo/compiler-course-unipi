%{
  open Fun_frontend
%}

%token IF THEN ELSE LET IN FUN TRUE FALSE TINT TBOOL END
%token PLUS MINUS TIMES DIV
%token EQ LESS GREATER LEQ GEQ COLON
%token LPAREN RPAREN EOF
%token <string>ID
%token <int>LINT

%nonassoc prec_let
%nonassoc EQ LESS GREATER LEQ GEQ
%left PLUS MINUS
%left TIMES DIV


%start <prog> main

%%

main: fundef = list(fundef) e=expr EOF { Prog(fundef, e) }
;

fundef:
  | FUN fname=ID LPAREN fparam=ID COLON t1=ptype RPAREN COLON t2=ptype  EQ fbody = expr END
    { Fundecl({fname; fparam; fbody; ftype=Tfun(t1, t2)}) }
;

expr:
  | e = simple_expr
    { e }
  | e1 = expr PLUS e2 = expr
    { Prim("+", e1, e2) }
  | e1 = expr MINUS e2 = expr
    { Prim("-", e1, e2) }
  | e1 = expr TIMES e2 = expr
    { Prim("*", e1, e2) }
  | e1 = expr DIV e2 = expr
    { Prim("/", e1, e2) }
  | e1 = expr LESS e2 = expr
    { Prim("<", e1, e2) }
  | e1 = expr GREATER e2 = expr
    { Prim(">", e1, e2) }
  | e1 = expr LEQ e2 = expr
    { Prim("<=", e1, e2) }
  | e1 = expr GEQ e2 = expr
    { Prim(">=", e1, e2) }
  | e1 = expr EQ e2 = expr
    { Prim("=", e1, e2) }
  | IF cond=expr THEN te=expr ELSE ee=expr  %prec prec_let
    { If(cond, te, ee) }
  | LET id=ID EQ e1=expr IN e2=expr   %prec prec_let
    { Let(id, e1, e2) }
  | e = application
    { e }
;

simple_expr:
  | i = LINT
    { CstI(i) }
  | TRUE
    { CstB(true) }
  | FALSE
    { CstB(false) }
  | id = ID
    { Var(id) }
  | LPAREN e = expr RPAREN
    { e }
;

ptype:
  | TINT
    { Tint }
  | TBOOL
    { Tbool }
;

application:
  | id = ID e=simple_expr
    { Call(id, e) }
;
