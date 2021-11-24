interface Printer {
    def printArray(arr : int[], size : int);
}

interface Foo {
    def foo();
}

interface Bar {
    def bar();
}

component CPrinter provides Printer, Foo {
    def printArray(arr: int[], size : int){
        var i : int;
        for(i = 0; i < size; i = i + 1)
          print(arr[i]);
    }

    def foo() {

    }
}

component Program provides App uses Printer,Bar {
    def main() : int {
        return 0;
    }
}

// The interface Bar is not compatible with the interface Foo
connect Program.Printer <- CPrinter.Printer
connect Program.Bar <- CPrinter.Foo