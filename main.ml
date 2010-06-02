(* We need this here because eventually we will need to ask the user if the are
sure they want to quit *)
let delete_event ev =
    print_endline "Delete event occurred";
    flush stdout;
    false

let destroy () = GMain.Main.quit ()

let main () =
    ignore (GMain.Main.init ());
    let window = GWindow.window () in
    ignore (window#event#connect#delete ~callback:delete_event);
    ignore (window#connect#destroy ~callback:destroy);
    window#show ();
    GMain.Main.main ()

let _ = main ()
