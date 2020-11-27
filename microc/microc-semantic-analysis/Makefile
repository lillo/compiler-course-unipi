TARGET=microcc

default: $(TARGET).native

$TARGET: default

native: $(TARGET).native

%.native: 
	ocamlbuild -use-ocamlfind $@
	mv $@ $*

clean:
	ocamlbuild -clean

.PHONY: clean default
