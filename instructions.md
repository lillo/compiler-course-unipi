# Instructions to set a OCaml programming environment

To install and set up the OCaml compilers and REPL following the instructions on the [OCaml website](https://ocaml.org/docs/install.html).

To set up `opam` and to use other tools, you can also read [this tutorial](https://ocaml.org/learn/tutorials/up_and_running.html) or [this chapter](https://cs3110.github.io/textbook/chapters/preface/install.html) from OCaml Programming.

## Set up an editor
If you want to use `emacs` or `vim`  as OCaml editor, install the package `user-setup` via `opam`
```sh
$ opam user-setup install
```
This package will install all the needed dependencies and the configuration for your editor. To see the status of the
configuration use the command
```sh
opam-user-setup status
```

If you want to use `vscode` as OCaml editor, install the [OCaml OCaml Platform](https://marketplace.visualstudio.com/items?itemName=ocamllabs.ocaml-platform) extension from the market. 
Remember to install LSP server for OCaml using
```sh
$ opam install ocaml-lsp-server
```

## Create our OCaml Project

For simple programs you can directly [load](https://ocaml.org/learn/tutorials/a_first_hour_with_ocaml.html#Running-OCaml-programs) our code in the OCaml toplevel or [compile](https://ocaml.org/learn/tutorials/a_first_hour_with_ocaml.html#Compiling-OCaml-programs) it using the compiler. For simple projects you can also use `ocamlbuild`.

For larger projects it is convenient using a build system.
The most popular modern system for building OCaml is [dune](https://dune.build/) that can be installed via `opam`.

See [here](https://ocaml.org/learn/tutorials/up_and_running.html#A-first-project) to see how create a simple project using dune. 

You can also use the template at https://github.com/mjambon/dune-starter :
```sh
$ git clone https://github.com/mjambon/dune-starter
$ cp -a dune-starter/proj my-project
$ cd my-project
$ git init
```

Here are also some tools that can generate a project structure for you:   
- [spin](https://github.com/tmattio/spin) is a Reasonml and OCaml project generator. It provides templates for many kinds of projects. 
- [drom](https://ocamlpro.github.io/drom/)  is a wrapper over `opam/dune` in an attempt to provide a `cargo`-like user experience. 
- [oskel](https://github.com/CraigFe/oskel) is a skeleton generator for OCaml that provides templates for libraries and binary. 

They can be install via `opam`.