// Array rotation
// Code adapted from https://www.geeksforgeeks.org/array-rotation/
/* Function to left Rotate arr[] of size n by 1*/

interface Rotor {
  def leftRotate(arr : int[], d : int, n : int) : void;
}

interface Printer {
  def printArray(arr : int[], n : int) : void;
}

component CRotor provides Rotor {
  
  /*Function to left rotate arr[] of size n by d*/
  def leftRotate(arr : int[], d : int, n : int) : void { 
      var i : int; 
      for (i = 0; i < d; i = i + 1) 
          leftRotatebyOne(arr, n); 
  } 
    
  def leftRotatebyOne(arr : int[], n : int) : void { 
      var temp : int;
      temp = arr[0];
      var i : int; 
  
      for (i = 0; i < n - 1; i = i + 1) 
          arr[i] = arr[i + 1]; 
      
      arr[i] = temp; 
  } 
}  

component CPrinter provides Printer {
    /* utility function to print an array */
  def printArray(arr : int[], n : int) : void { 
      var i : int; 
      for (i = 0; i < n; i = i + 1) 
          print(arr[i]); 
  }
}

component Application provides App uses Rotor, Printer { 
      
  /* Driver program to test above functions */
  def main() : int 
  { 
      var arr : int[7];
  
      arr[0] = 1;
      arr[1] = 2;
      arr[2] = 3;
      arr[3] = 4;
      arr[4] = 5;
      arr[5] = 6;
      arr[6] = 7;
      
      leftRotate(arr, 2, 7); 
      printArray(arr, 7); 
      return 0; 
  } 
}

connect {
    Application.Rotor <- CRotor.Rotor;
    Application.Printer <- CPrinter.Printer;
}