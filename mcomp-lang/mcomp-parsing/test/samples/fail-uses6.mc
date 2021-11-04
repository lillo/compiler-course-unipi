 interface Foo {
    def foo();
    def bar(a :int) : int;
}

component EntryPoint provides App uses Foo {
    def bar(a : int, b : int) {

    }
    
    def main() : int {
      return 0;
    }
}