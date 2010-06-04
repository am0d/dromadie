let languages_manager = GSourceView.source_languages_manager ()

let get_lang =
    match GSourceView.source_language_from_file ~languages_manager "ocaml.lang"
    with
    | None -> failwith "No language file available"
    | Some lang -> lang

(* Reads a file into a buffer, and then returns the buffer *)
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

(* File chooser filter for OCaml files *)
let ocaml_file_filter () =
    GFile.filter ~name:"OCaml source code"
    ~patterns:[ "*.ml"; "*.mli"; "*.mll"; "*.mly" ] ()

(* File chooser filter for All files *)
let all_file_filter () =
    GFile.filter ~name:"All files"
    ~patterns:[ "*.*" ] ()
