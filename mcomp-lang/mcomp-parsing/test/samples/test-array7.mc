// Code adapted from https://www.geeksforgeeks.org/leaders-in-an-array/

interface Printer {
  def printArray(arr : int[], size : int);
}

component LeaderPrinter provides Printer {
  def printArray(arr : int[], size : int) { 
    var i : int;

    for (i = 0; i < size; i=i+1){ 
        var j : int; 
        for (j = i+1; j < size && !(arr[i] <= arr[j]); j = j + 1);

        if (j == size) // the loop didn't break 
            print(arr[i]); 
    } 
  }
}

component Application provides App uses Printer { 
  
  /* Driver program to test above function */
  def main() : int { 
      var arr : int[6];
  
      arr[0] = 16;
      arr[1] = 17;
      arr[2] = 4;
      arr[3] = 3;
      arr[4] = 5;
      arr[5] = 2; 
      
      var n : int;
      n = 6; 
      
      printArray(arr, n); 
      return 0; 
  } 
}

connect Application.Printer <- LeaderPrinter.Printer // The End