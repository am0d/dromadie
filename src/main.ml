open Files
open Util

(* Global variables - ugh! *)
let source_notebook = GPack.notebook ()

(* Print a message to the terminal *)
let print msg () =
    print_endline msg;
    flush stdout

(* We need this here because eventually we will need to ask the user if the are
sure they want to quit *)
let delete_event ev =
    false

(* Close our main window *)
let destroy () = GMain.Main.quit ()

(* Helper function for adding a new source tab *)
let add_source_pane fn (notebook:GPack.notebook) () =
    (* The title for the tab *)
    let hbox = GPack.hbox () in
    GMisc.label ~text:fn ~packing:hbox#pack ();
    let close_button =
        GButton.button ~label:"X" ~packing:(hbox#pack ~padding:5) () in
    (* Create a scrolled window *)
    let scrolled_win =
        GBin.scrolled_window ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC () in
    (* Create and add our source view *)
    let source_view = GSourceView.source_view ~width:640 ~height:480
    ~auto_indent:true ~insert_spaces_instead_of_tabs:true
    ~show_line_numbers:true ~tabs_width:4 ~margin:80 ~show_margin:true
    ~packing:scrolled_win#add () in
    (* Read in the file and display it *)
    let buf = read_file fn in
    source_view#source_buffer#set_text buf;
    source_view#source_buffer#set_language get_lang;
    source_view#source_buffer#set_highlight true;
    notebook#append_page ~tab_label:hbox#coerce scrolled_win#coerce;
    close_button#connect#clicked ~callback:(
        fun () -> notebook#remove_page (notebook#page_num scrolled_win#coerce));
    ()

(* Open a new file *)
let file_open fn () =
    let filew = GWindow.file_chooser_dialog ~title:"Open ..." ~action:`OPEN () in
    filew#add_button_stock `CANCEL `CANCEL;
    filew#add_select_button_stock `OPEN `OPEN;
    filew#add_filter (ocaml_file_filter ());
    filew#add_filter (all_file_filter ());
    begin match filew#run () with
    | `OPEN ->
            begin match filew#filename with
            | None -> ()
            | Some fn -> add_source_pane fn source_notebook ()
            end
    | `DELETE_EVENT | `CANCEL -> ()
    end;
    filew#destroy ()

(* Entries for the file menu *)
let file_menu_entries = [
    `I ("New", print "New");
    `I ("Open", file_open "");
    `I ("Save", print "Save");
    `I ("Save As", print "Save as");
    `S;
    `I ("Quit", GMain.Main.quit)
]

(* Entries for the help menu *)
let help_menu_entries = [
    `I ("About", print "About")
]

(* Helper function for creating the menubar *)
let create_menu label menubar =
    let item = GMenu.menu_item ~label ~packing:menubar#append () in
    GMenu.menu ~packing:item#set_submenu ()

let main () =
    (* Parse the command line arguments to see what we need to do *)
    let files = parse_args () in
    (* Setup the window *)
    GMain.Main.init ();
    let window = GWindow.window ~title:"Dromadie" () in
    window#event#connect#delete ~callback:delete_event;
    window#connect#destroy ~callback:destroy;

    (* Create the menus *)
    let vbox1 = GPack.vbox ~spacing:5 ~packing:window#add () in
    let menubar = GMenu.menu_bar ~packing:(vbox1#pack ~expand:false) () in
    let menu = create_menu "File" menubar in
    GToolbox.build_menu menu ~entries:file_menu_entries;
    let menu = create_menu "Help" menubar in
    GToolbox.build_menu menu ~entries:help_menu_entries;

    (* Create the toolbar *)
    let toolbar = GButton.toolbar ~packing:(vbox1#pack ~expand:false) () in
    toolbar#insert_button ~text:"B" ();
    toolbar#insert_space ();
    toolbar#insert_button ~text:"I" ();

    (* The body of the window *)
    let hbox1 = GPack.hbox ~spacing:5 ~packing:(vbox1#pack ~expand:true) () in

    (* The browser on the left *)
    GMisc.label ~text:"Tree placeholder" ~packing:hbox1#pack ();

    (* And the sourceviews on the right *)
    hbox1#pack ~expand:true source_notebook#coerce;
    for i=0 to Array.length files - 1 do
        add_source_pane files.(i) source_notebook ()
    done;

    (* Show the window *)
    window#set_allow_shrink true;
    window#show ();
    GMain.Main.main ()

let _ = main ()
