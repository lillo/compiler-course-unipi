%{
    open Json
%}

%token <int> INT
%token <float> FLOAT
%token <string> STRING
%token TRUE
%token FALSE
%token NULL
%token LBRACE
%token RBRACE
%token LBRACK
%token RBRACK
%token COLON
%token COMMA
%token EOF

%start<Json.value option> json_unit

%%

json_unit:
  | EOF       { None }
  | v=value   { Some v }
;

value:
  | LBRACE fs=separated_list(COMMA, objfield) RBRACE    { Obj(fs) }
  | LBRACK ls=separated_list(COMMA, value)    RBRACK    { List(ls) }
  | s = STRING                                          { String(s) }
  | i = INT                                             { Int(i) }
  | f = FLOAT                                           { Float(f) }
  | TRUE                                                { Bool(true) }
  | FALSE                                               { Bool(false) }
  | NULL                                                { Null }
;

objfield:
  | k = STRING COLON v = value                          { (k, v) }
;
