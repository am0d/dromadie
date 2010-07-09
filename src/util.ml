(* Parses the command line arguments and returns an array containing all the
 * files specified on the command line
 *)
let parse_args () =
    if (Array.length Sys.argv) > 1 then
        Array.sub Sys.argv 1 (Array.length Sys.argv - 1)
    else
        Array.make 1 ""

(* Checks if a string (str) ends with another string (suf)
 *  Returns true if str ends with suf
 *)
let ends_with str suf =
    let len_str = String.length str in
    let len_suf = String.length suf in
    len_str >= len_suf && String.sub str (len_str - len_suf) len_str = suf

(* Returns the extension of a file name (everything after the last '.')
 * Returns an empty string ("") if there is no extension
 *)
let extension fn =
    try
        let len_str = String.length fn in
        let last_dot = String.rindex fn '.' in
        String.sub fn (last_dot + 1) (len_str - last_dot - 1)
    with Not_found -> ""
