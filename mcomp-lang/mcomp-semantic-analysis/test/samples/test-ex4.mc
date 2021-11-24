// mComp-lang example 4 -- compute and print array of factorials

interface Printer {
  def printArray(arr : int[], size : int);
}

component EntryPoint provides App uses Printer {

  var a : int[20];			/* Must be global */
  
  def main() : int { 
    var i : int; 
    i = 0; 
    var f : int; 
    f = 1;
    var n : int;
    n = 5;
    while (i < n) {
      a[i] = f;
      i = i + 1;
      f = f * i;
    }
    printArray(a, n);
    return 0;
  }

}

component CPrinter provides Printer {
  def printArray(arr : int[], n : int){
    var i : int; 
    for (i = 0; i < n; i = i + 1) 
        print(arr[i]);
  }
}

connect EntryPoint.Printer <- CPrinter.Printer
