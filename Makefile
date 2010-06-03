
LIBS = lablgtk.cma lablgtksourceview.cma gtkInit.cmo
# CUSTOM = -custom

CAML_FLAGS = $(CUSTOM) -warn-error As -w Aelzs -I +lablgtk2

SRCS = \
     files.ml util.ml main.ml 

OBJS = $(SRCS:.ml=.cmo)

all: dromadie

clean:
	rm -rf *.cmi *.cmo *.cmx *.o *.obj *.opt *~ dromadie

.SUFFIXES: .ml .cmo .cmx .opt

dromadie: $(OBJS)
	ocamlc $(CAML_FLAGS) -o $@ $(LIBS) $(OBJS)

.ml.cmo:
	ocamlc -c $(CAML_FLAGS) $<

.ml.cmx:
	ocamlopt -c $(CAML_FLAGS) $<
