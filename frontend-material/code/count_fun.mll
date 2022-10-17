{
}

rule count num_lines num_chars =
parse
| '\n'    { count (num_lines + 1) (num_chars + 1) lexbuf }
| _       { count num_lines (num_chars + 1) lexbuf }
| eof     { (num_lines, num_chars) }

{

let count = count 0 0 

let () =
    let lexbuf = Lexing.from_channel stdin in
    let (num_lines, num_chars) = count lexbuf in
    Printf.printf "# of lines = %d, # of chars = %d\n" num_lines num_chars

}
