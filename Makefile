include src/include.mk

EXEC = dromadie


include Makefile.ocaml

CAML_FLAGS = $(CUSTOM) -warn-error As -w Aelzs -I +lablgtk2
LIBS = lablgtk.cma lablgtksourceview.cma gtkInit.cmx

CAMLC = ocamlc -I src $(CAML_FLAGS)
CAMLOPT = ocamlopt -I src $(CAML_FLAGS)
CAMLDEP = ocamldep -I src 
