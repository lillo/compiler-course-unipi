# Instructions to set a OCaml programming environment

To install and set up the OCaml compilers and REPL following the instructions on the [OCaml website](https://ocaml.org/docs/install.html).

To set up `opam` and to use other tools, you can also read [this tutorial](https://ocaml.org/learn/tutorials/up_and_running.html).

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

## Project templates

Here are some templates you can use to start setting your code. 

If you want to use `ocamlbuild` for building your code you can use the project template at https://github.com/kmicinski/example-ocaml-merlin as scaffolding:
```sh
$ git clone https://github.com/kmicinski/example-ocaml-merlin.git
$ mv example-ocaml-merlin my-project
$ cd my-project
$ rm -rf .git               # delete the current repo
$ git init                  # set a new repo
```

If you want to use `dune` for building your code you can use the template at https://github.com/mjambon/dune-starter :
```sh
$ git clone https://github.com/mjambon/dune-starter
$ cp -a dune-starter/proj my-project
$ cd my-project
$ git init
```

Here are also some tools that can generate a project structure for you. 
- [oskel](https://github.com/CraigFe/oskel) is a skeleton generator for OCaml that provides templates for libraries and binary. The generated projects use `dune` as build system.  
- [spin](https://github.com/tmattio/spin) is a Reasonml and OCaml project generator. It provides templates for many kinds of projects. The generated projects use `dune` as build system and can use `esy` as package manager. 

Both tools can be install via `opam`:
```sh
$ opam install oskel
```
or 
```sh
$ opam install spin
```