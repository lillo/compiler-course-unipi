# Setup your development environment

You need `opam` and `dune`, you can install them by following [these instructions](../instructions.md).

Once `opam` and `dune` are installed, you can install the dependencies required to work on the project with:

```bash
make deps
```
You can build the project with:

```bash
make build
```

### Running Compiler

The code for the binary of the compiler is in the `bin` directory.
You can run this binary with 
```bash
make start source_file.mc
```
Running the compiler with `make` does not allow you to pass options to the binary. 
In this case, you can invoke the binary directly using `dune` with:
```bash 
dune exec bin/microcc.exe -- <options> source_file.mc
```

### Running Tests

In the directory `test` you can find some programs that allow you to test the different phases of the compilation. 
In the directory `test/samples` you can find some test cases: file starting with `fail-*` represent non-valid program whose compilation must abort with an error; 
file starting with `test-*` represent valid program whose execution must generate the output in the corresponding `*.out` file. 

You can invoke a test `sample_test.ml` on a given test case `test-hello.mc` using dune with
```bash
dune exec test/sample_test.exe -- test/sample/test-hello.mc
```

### Building documentation

Documentation for the provided files can be generated with:

```bash
make doc
make servedoc
```

### Project Structure

The following snippet describes microc's project structure.

```text
.
├── bin/
|   Source for microc's compiler binary. This links to `Microc` library whose sources are defined in `lib/`.
│
├── lib/
|   Sources for Microc library implementing the different phases of compilation. 
│
├── test/
|   Tests different phases of the compiler.
│
├── dune-project
|   Dune file used to mark the root of the project and define project-wide parameters.
|   For the documentation of the syntax, see https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
│
├── LICENSE
│
├── Makefile
|   Make file containing common development command.
│
├── README.md
│
└── microc-lang.opam
    Opam package definition.
    To know more about creating and publishing opam packages, see https://opam.ocaml.org/doc/Packaging.html.
```
