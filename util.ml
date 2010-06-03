let parse_args () =
    if (Array.length Sys.argv) > 1 then
        for i=1 to Array.length (Sys.argv) -1 do
            print_endline Sys.argv.(i);
        done
