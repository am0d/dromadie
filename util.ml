open Files

(* Parses the command line arguments and returns an array containing all the
files specified on the command line *)
let parse_args () =
    if (Array.length Sys.argv) > 1 then
        Array.sub Sys.argv 1 (Array.length Sys.argv - 1)
    else
        Array.make 1 ""
