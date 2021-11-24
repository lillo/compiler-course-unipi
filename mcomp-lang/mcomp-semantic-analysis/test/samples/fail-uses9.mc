interface Printer {
  def printArray(arr : int[], n : int);
} 

component CPrinter provides Printer {
  def printArray(arr : int[], n : int){
    var i : int; 
    for (i = 0; i < n; i = i + 1) 
        print(arr[i]);
  }
}

/* Cannot provide a component but an interface */
component Application provides App, CPrinter {
    def main() : int {
        print(42);
        return 0;
    }
}