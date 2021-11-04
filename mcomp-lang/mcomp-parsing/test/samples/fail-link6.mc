interface Printer {
    def printArray(arr : int[], size : int);
}

interface Foo {
    def foo();
}

component CPrinter provides Printer {
    def printArray(arr: int[], size : int){
        var i : int;
        for(i = 0; i < size; i = i + 1)
          print(arr[i]);
    }
}

component Program provides App uses Printer,Foo {
    def main() : int {
        return 0;
    }
}

// The component CPrinter does not provide the interface Foo
connect Program.Printer <- CPrinter.Printer
connect Program.Foo <- CPrinter.Foo