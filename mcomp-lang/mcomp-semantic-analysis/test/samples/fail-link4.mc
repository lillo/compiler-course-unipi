interface Foo {
    def foo();
}

component Program provides App uses Foo{
    def main() : int {
        return 0;
    }
}

// The component CFoo is not declared
connect Program.Foo <- CFoo.Foo