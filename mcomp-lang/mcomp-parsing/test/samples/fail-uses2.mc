interface Foo {
    def foo();
}

component EntryPoint provides Foo,Foo, App {
   def foo() {
       
   } 

    def main() : int {
      return 0;
    }
}