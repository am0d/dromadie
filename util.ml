open Files

let parse_args () =
    if (Array.length Sys.argv) > 1 then
        read_file Sys.argv.(1)
    else
        ""
