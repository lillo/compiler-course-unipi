interface Printer {
    def printArray(arr : int[], size : int);
}

component CPrinter provides Printer {
    def printArray(arr: int[], size : int){
        var i : int;
        for(i = 0; i < size; i = i + 1)
          print(arr[i]);
    }
}

interface Foo {
    def foo();
}

component FooBar provides Foo {
  def foo() {

  }
}

component A provides App uses Printer {
    def main() : int {
        return 0;
    }
}

/* A component can be linked only once */
connect {
    A.Printer <- CPrinter.Printer;
    FooBar.Printer <- CPrinter.Printer;
}