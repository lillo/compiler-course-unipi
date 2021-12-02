// Reserve an array
// Code adapted from https://www.geeksforgeeks.org/write-a-program-to-reverse-an-array-or-string/

interface Reverser {
  def reverse(arr : int[], start : int, end : int) : void;
}

interface Printer {
  def printArray(arr : int[], n : int) : void;
}

component CPrinter provides Printer {
    /* utility function to print an array */
  def printArray(arr : int[], n : int) : void { 
      var i : int; 
      for (i = 0; i < n; i = i + 1) 
          print(arr[i]); 
  }
}

component CReverser provides Reverser {
  /* Function to reverse arr[] from start to end*/
  def reverse(arr : int[], start : int, end : int) : void { 
      var temp : int; 
      while (start < end) 
      { 
          temp = arr[start];    
          arr[start] = arr[end]; 
          arr[end] = temp; 
          start = start + 1; 
          end = end - 1; 
      }    
  }
}


component Application provides App uses Reverser, Printer { 
  /* Driver function to test above functions */
  def main() : int { 
      var arr : int[6]; 
      var i : int;
      var n : int;
      n = 6;
  
      for(i = 0; i < 6; i = i + 1)
        arr[i] = i + 1;
  
      reverse(arr, 0, n-1);  
      printArray(arr, n);     
      return 0; 
  }
}

connect {
  Application.Reverser <- CReverser.Reverser;
  Application.Printer <- CPrinter.Printer;
}
  
  
 