.PHONY: all clean test

# Find Menhir.
ifndef MENHIR
  MENHIR := $(shell ../find-menhir.sh)
endif

OCAMLBUILD      := ocamlbuild -use-ocamlfind -use-menhir

MAIN            := calc

all:
	$(OCAMLBUILD) $(MAIN).native

clean:
	rm -f *~ .*~
	$(OCAMLBUILD) -clean

test: all
	@echo "The following command should print 42:"
	echo "(1 + 2 * 10) * 2" | ./$(MAIN).native
