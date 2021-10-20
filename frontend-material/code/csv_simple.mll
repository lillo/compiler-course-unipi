{
let row = ref(1)
let col = ref(1)
}

let comma = ','
let cr = '\r'
let lf = '\n'
let newline = "\r\n" | cr | lf

let textdata = [ ^',' '"' '\x00'-'\x1F' ]
let dquote = '"'
let ddquote = "\"\""

rule csv_parser = parse
  | newline     { Printf.printf "\n===NEW RECORD===\n"; incr row; col := 1 }
  | comma       { print_newline (); incr col }
  | textdata*   { Printf.printf "t-row %d col %d: >%s<" !row !col (Lexing.lexeme lexbuf) }
  | dquote      { Printf.printf "d-row %d col %d: >" !row !col; escaped lexbuf }
  | eof         { Printf.printf "\n=== DONE ===\n"; exit 0 }
  | _ as c      { Printf.printf "\nSyntax error: %d\n" ( int_of_char c )}
and escaped = parse
  | dquote      { Printf.printf "<" }
  | ddquote     { Printf.printf "\""; escaped lexbuf }
  | (textdata | comma | cr | lf)*  { Printf.printf "%s" (Lexing.lexeme lexbuf) ; escaped lexbuf}

{
  let () =
    let lexbuf = Lexing.from_channel stdin in
    while true do
      csv_parser lexbuf
    done
}
