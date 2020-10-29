%token <int> INT
%token COMMA
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token EOL

%left COMMA
%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */

%start <int list> main

%%

main:
| es = separated_nonempty_list(COMMA, expr) EOL
    { es }

expr:
| i = INT
    { i }
| e = delimited(LPAREN, expr, RPAREN)
    { e }
| e1 = expr PLUS e2 = expr
    { e1 + e2 }
| e1 = expr MINUS e2 = expr
    { e1 - e2 }
| e1 = expr TIMES e2 = expr
    { e1 * e2 }
| e1 = expr DIV e2 = expr
    { e1 / e2 }
| MINUS e = expr %prec UMINUS
    { - e }
