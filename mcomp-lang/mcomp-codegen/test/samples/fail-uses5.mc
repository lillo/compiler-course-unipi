 interface Foo {
    def foo();
}

component EntryPoint provides App,Foo {
    def foo(a : int) : int {
        return a;
    }
    
    def main() : int {
      return 0;
    }
}