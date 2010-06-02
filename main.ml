let print msg () =
    print_endline msg;
    flush stdout

(* We need this here because eventually we will need to ask the user if the are
sure they want to quit *)
let delete_event ev =
    print_endline "Delete event occurred";
    flush stdout;
    false

let destroy () = GMain.Main.quit ()

(* Entries for the file menu *)
let file_menu_entries = [
    `I ("New", print "New");
    `S;
    `I ("Quit", GMain.Main.quit)
]

let menu_entries = [
    `M ("File", file_menu_entries);
]

let create_menu label menubar =
    let item = GMenu.menu_item ~label ~packing:menubar#append () in
    GMenu.menu ~packing:item#set_submenu ()

let main () =
    GMain.Main.init ();
    let window = GWindow.window ~title:"Dromadie" () in
    window#event#connect#delete ~callback:delete_event;
    window#connect#destroy ~callback:destroy;

    (* Create the menus *)
    let vbox1 = GPack.vbox ~spacing:5 ~packing:window#add () in
    let menubar = GMenu.menu_bar ~packing:(vbox1#pack ~expand:false) () in
    let menu = create_menu "File" menubar in
    GToolbox.build_menu menu ~entries:file_menu_entries;

    (* Create the toolbar *)
    let toolbar = GButton.toolbar ~packing:(vbox1#pack ~expand:false) () in
    toolbar#insert_button ~text:"B" ();
    toolbar#insert_space ();
    toolbar#insert_button ~text:"I" ();

    (* The body of the window *)
    let hbox1 = GPack.hbox ~spacing:5 ~packing:(vbox1#pack ~expand:true) () in
    GMisc.label ~text:"Tree placeholder" ~packing:hbox1#pack ();
    let source_notebook = GPack.notebook ~packing:(hbox1#pack ~expand:true) () in
    let source_view = GSourceView.source_view ~width:640 ~height:480
        ~auto_indent:true ~insert_spaces_instead_of_tabs:true
        ~show_line_numbers:true ~tabs_width:4 ~margin:80 ~show_margin:true () in
    source_notebook#append_page source_view#coerce;
    window#set_allow_shrink true;
    window#show ();
    GMain.Main.main ()

let _ = main ()
