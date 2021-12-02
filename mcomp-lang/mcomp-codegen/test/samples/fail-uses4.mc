 interface Foo {
    def foo();
}

interface Foo1 {
    def foo();
}

component EntryPoint provides App,Foo uses Foo1 {
    def main() : int {
      return 0;
    }
}