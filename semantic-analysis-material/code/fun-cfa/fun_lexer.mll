{

open Fun_parser

exception Lexing_error of string

let create_hashtable size init =
    let tbl = Hashtbl.create size in
    List.iter (fun (key, data) -> Hashtbl.add tbl key data) init;
    tbl

let keyword_table =
  create_hashtable 8 [
    ("if", IF);
    ("then", THEN);
    ("else", ELSE);
    ("let", LET);
    ("in", IN);
    ("fun", FUN);
    ("true", TRUE);
    ("false", FALSE);
    ("int", TINT);
    ("bool", TBOOL)
  ]

}

let digit = ['0' - '9']
let id = ['a'-'z' 'A'-'Z']['a'-'z' '0'-'9']*

rule next_token = parse
  | digit+ as inum         {
                             let num = int_of_string inum in
			     LINT(num)
                           }
  | id as word             {
                             try
                               Hashtbl.find keyword_table word
                             with Not_found ->
			       ID(word)
                           }
  | '+'                    { PLUS }
  | '-'                    { MINUS }
  | '*'                    { TIMES }
  | '/'                    { DIV }
  | '='                    { EQ }
  | '<'                    { LESS }
  | '>'                    { GREATER }
  | "<="                   { LEQ }
  | ">="                   { GEQ }
  | '('                    { LPAREN }
  | ')'                    { RPAREN }
  | ':'                    { COLON }
  | "->"                   { ARROW }
  | [' ' '\t']             { next_token lexbuf }
  | '\n'                   { Lexing.new_line lexbuf; next_token lexbuf }
  | eof                    { EOF }
  | _                      { raise (Lexing_error ("Unexpected character: " ^ (Lexing.lexeme lexbuf))) }
