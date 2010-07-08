(* Parses the command line arguments and returns an array containing all the
files specified on the command line *)
let parse_args () =
    if (Array.length Sys.argv) > 1 then
        Array.sub Sys.argv 1 (Array.length Sys.argv - 1)
    else
        Array.make 1 ""

let ends_with str suf =
    let len_str = String.length str in
    let len_suf = String.length suf in
    len_str >= len_suf && String.sub str (len_str - len_suf) len_str = suf

let extension fn =
    let len_str = String.length fn in
    let last_dot = String.rindex fn '.' in
    String.sub fn (last_dot + 1) (len_str - last_dot - 1)
