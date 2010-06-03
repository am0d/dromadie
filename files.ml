let languages_manager = GSourceView.source_languages_manager ()

let read_file fn =
    if Sys.file_exists fn then
        let ic = open_in fn in
        let size = in_channel_length ic in
        let buf = String.create size in
        really_input ic buf 0 size;
        close_in ic;
        buf
    else
        ""
