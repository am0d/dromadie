# Dromadie
## An OCaml IDE, written in OCaml using GTK2+ and GtkSourceView

1. #####Building

    You have 2 options for building Dromadie.  The first (and preferred method) is using `omake`.
    To build with `omake`, change into the Dromadie directory and type

        omake
    The second option is to use a standard make command.  In the dromadie directory, type

        make
    Note, however, that if you use the standard Makefile, no package checks are performed, whereas
    omake will check that you have the required packages installed on your system.

2. #####Requirements

    Requirements are quite minimal for Dromadie - you have to have `lablgtk` and GtkSourceView
    installed.

### Why???
Why did I write this application?  I wanted to try my hand at some OCaml/GTK2+ programming, and
this seemed like as good an app as any to try on.  My goals are to have the application handle
projects, auto-generate Makefiles and OMakefiles, and all the other sort of stuff that IDEs usually
do, without too much overhead.  Hopefully it will also provide good syntax highlighting and auto-
indenting for OCaml source code.
