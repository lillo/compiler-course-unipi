interface Foo {
    def foo();
}

component EntryPoint provides App uses Foo,Foo {
    def main() : int {
      return 0;
    }
}