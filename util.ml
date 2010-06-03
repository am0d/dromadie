open Files

let parse_args () =
    if (Array.length Sys.argv) > 1 then
        Array.sub Sys.argv 1 (Array.length Sys.argv - 1)
    else
        Array.make 1 ""
