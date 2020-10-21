# Instructions to set a OCaml programming environment

To install and set up the OCaml compilers and REPL following the instructions on the [OCaml website](https://ocaml.org/docs/install.html).

To set up `opam` and to use other tools, you can also read [this tutorial](https://ocaml.org/learn/tutorials/get_up_and_running.html).

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