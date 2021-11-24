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

component Program provides App uses Printer {
    def main() : int {
        return 0;
    }
}

// No component provides or uses interface Foo
connect Program.Printer <- CPrinter.Printer
connect Program.Foo <- CPrinter.Foo