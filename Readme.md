# Dromadie
## An OCaml IDE, written in OCaml using GTK2+ and GtkSourceView

1. #####Building

    To build dromadie, use the standard make command.  In the dromadie directory, type

        make
    Note, however, that no package checks are performed, so you will have to manually 
    check that you have the required packages installed on your system.

2. #####Requirements

    Requirements are quite minimal for Dromadie - you have to have `lablgtk` and GtkSourceView
    installed.

### Why???
Why did I write this application?  I wanted to try my hand at some OCaml/GTK2+ programming, and
this seemed like as good an app as any to try on.  My goals are to have the application handle
projects, auto-generate Makefiles and OMakefiles, and all the other sort of stuff that IDEs usually
do, without too much overhead.  Hopefully it will also provide good syntax highlighting and auto-
indenting for OCaml source code.
