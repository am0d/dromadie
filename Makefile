
LIBS = lablgtk.cma gtkInit.cmo
# CUSTOM = -custom

CAML_FLAGS = $(CUSTOM) -warn-error A -I +lablgtk2

SRCS = \
       main.ml

TARGETS = $(SRCS:.ml=.cmo)

all: dromadie

clean:
	rm -rf *.cmi *.cmo *.cmx *.o *.obj *.opt *~ dromadie

.SUFFIXES: .ml .cmo .cmx .opt

dromadie: $(TARGETS)
	ocamlc $(CAML_FLAGS) -o $@ $(LIBS) $<

.ml.cmo:
	ocamlc -c $(CAML_FLAGS) $<

.ml.cmx:
	ocamlopt -c $(CAML_FLAGS) $<
