{
open Printf

let create_hashtable size init =
    let tbl = Hashtbl.create size in
    List.iter (fun (key, data) -> Hashtbl.add tbl key data) init;
    tbl

type token =
  | IF
  | THEN
  | ELSE
  | BEGIN
  | END
  | FUNCTION
  | ID of string
  | OP of char
  | INT of int
  | FLOAT of float
  | CHAR of char


let keyword_table =
  create_hashtable 8 [
    ("if", IF);
    ("then", THEN);
    ("else", ELSE);
    ("begin", BEGIN);
    ("end", END);
    ("function", FUNCTION)
  ]

}

let digit = ['0'-'9']
let id = ['a'-'z' 'A'-'Z']['a'-'z' '0'-'9']*

rule toy_lang = parse
  | digit+ as inum    {
                        let num = int_of_string inum in
                        printf "integer: %s (%d)\n" inum num;
                        INT num
                      }
  | digit+ '.' digit* as fnum {
                               let num = float_of_string fnum in
                               printf "float: %s (%f)\n" fnum num;
                               FLOAT num
                             }
  | id as word             { try
                             let token = Hashtbl.find keyword_table word in
                             printf "keyword: %s\n" word;
                             token
                           with Not_found ->
                             printf "identifier: %s\n" word;
                             ID word
                         }
  | '+'
  | '-'
  | '*'
  | '/' as op           { printf "operator: %c\n" op;  OP op }
  | '{' [^ '\n']* '}' (* eat up one-line comments *)
  | [' ' '\t' '\n']   (* eat up whitespace *)
                       { toy_lang lexbuf }
  | _ as c             { printf "Unrecognized character: %c\n" c; CHAR c }
  | eof                { raise End_of_file }


{
let rec parse lexbuf =
  let _ = toy_lang lexbuf in
  parse lexbuf

let () =
  let cin =
    if Array.length Sys.argv > 1 then
      open_in Sys.argv.(1)
    else
      stdin
  in
  let lexbuf = Lexing.from_channel cin in
  try
    parse lexbuf
  with End_of_file -> ()
}
