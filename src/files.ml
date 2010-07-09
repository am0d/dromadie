open Util

(* A global language manager for source highlighting *)
let languages_manager = GSourceView.source_languages_manager ()

(* Load the language with the specified mime-type *)
let language lang =
        languages_manager#get_language_from_mime_type lang

(* Try to match the file's extension with a known mime type and load that
 * language *)
let get_lang fn =
    try
        match extension fn with
        | "ml"
        | "mli"
        | "mll"
        | "mly" -> language "text/x-ocaml"
        | _ -> language "text/plain"
    with Not_found ->
        None

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
    ~patterns:[ "*" ] ()
