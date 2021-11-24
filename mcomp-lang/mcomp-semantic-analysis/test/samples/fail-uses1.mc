interface Foo {
    def foo();
}

component EntryPoint provides Foo, App {
   // Missing definition of foo 

    def main() : int {
      return 0;
    }
}