{
open Parser
exception Error of string
}

let digit = ['0'-'9']
let one_to_nine = ['1'-'9']
let int = ('-'? one_to_nine digit*) | '0'

let frac = '.' digit*
let exp = ['e''E'] ['-''+']? digit+
let float = digit* frac? exp?

let white = [' ''\t']+
let newline = '\r' | '\n' | "\r\n"
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '_' '0'-'9']*

rule token = parse
  | white                   { token lexbuf }
  | newline                 { Lexing.new_line lexbuf; token lexbuf }
  | int                     { INT ( int_of_string (Lexing.lexeme lexbuf) ) }
  | float                   { FLOAT ( float_of_string (Lexing.lexeme lexbuf) ) }
  | "true"                  { TRUE }
  | "false"                 { FALSE }
  | "null"                  { NULL }
  | '{'                     { LBRACE }
  | '}'                     { RBRACE }
  | '['                     { LBRACK }
  | ']'                     { RBRACK }
  | ':'                     { COLON  }
  | ','                     { COMMA  }
  | '"'                     { read_string (Buffer.create 17) lexbuf }
  |  eof                    { EOF }
  |  _                      { raise (Error ("Unexpected char: " ^ (Lexing.lexeme lexbuf))) }

and read_string buffer = parse
  | '"'                     { STRING( Buffer.contents buffer ) }
  | '\\' '/'                { Buffer.add_char buffer '/'; read_string buffer lexbuf }
  | '\\' '\\'               { Buffer.add_char buffer '\\'; read_string buffer lexbuf }
  | '\\' 'b'                { Buffer.add_char buffer '\b'; read_string buffer lexbuf }
  | '\\' 'f'                { Buffer.add_char buffer '\012'; read_string buffer lexbuf }
  | '\\' 'n'                { Buffer.add_char buffer '\n'; read_string buffer lexbuf }
  | '\\' 'r'                { Buffer.add_char buffer '\r'; read_string buffer lexbuf }
  | '\\' 't'                { Buffer.add_char buffer '\t'; read_string buffer lexbuf }
  | [^'"' '\\']+            { Buffer.add_string buffer (Lexing.lexeme lexbuf); read_string buffer lexbuf }
  | eof                     { raise (Error ("Literal string is not terminated")) }
  | _                       { raise (Error ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
