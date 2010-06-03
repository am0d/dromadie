open Util

(* Print a message to the terminal *)
let print msg () =
    print_endline msg;
    flush stdout

(* We need this here because eventually we will need to ask the user if the are
sure they want to quit *)
let delete_event ev =
    print_endline "Delete event occurred";
    flush stdout;
    false

(* Close our main window *)
let destroy () = GMain.Main.quit ()

(* Entries for the file menu *)
let file_menu_entries = [
    `I ("New", print "New");
    `I ("Open", print "Open");
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
    let file = parse_args () in
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
    let source_notebook = GPack.notebook ~packing:(hbox1#pack ~expand:true) () in
    let source_view = GSourceView.source_view ~width:640 ~height:480
        ~auto_indent:true ~insert_spaces_instead_of_tabs:true
        ~show_line_numbers:true ~tabs_width:4 ~margin:80 ~show_margin:true () in
    source_notebook#append_page source_view#coerce;
    source_view#source_buffer#set_text file;

    (* Show the window *)
    window#set_allow_shrink true;
    window#show ();
    GMain.Main.main ()

let _ = main ()
