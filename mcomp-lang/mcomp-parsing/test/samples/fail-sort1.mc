/**
 * Insertion Sort
 * Code adapted from https://www.geeksforgeeks.org/insertion-sort/
 */

interface Sorter {
    def sort(arr : int[], size : int);
}

interface Comparator {
  def compare(n1 : int, n2 : int) : int;
}

component InsertionSort provides Sorter uses Comparator{
  def insertionSort(arr : int[], n : int){ 
      var i : int;
      var key : int;
      var j : int;
  
      for (i = 1; i < n; i = i + 1) { 
          key = arr[i]; 
          j = i - 1; 
    
          /* Move elements of arr[0..i-1], that are 
            greater than key, to one position ahead 
            of their current position */
          while (j >= 0 && compare(arr[j], key) > 0) { 
              arr[j + 1] = arr[j]; 
              j = j - 1; 
          } 
          arr[j + 1] = key; 
      } 
  }
  
  def sort(arr : int[], n : int){
    insertionSort(arr, n);
  }
}

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

component EntryPoint provides App uses Printer, Sorter {

  def main() : int {
      var arr : int[5];
      
      arr[0] = 12;
      arr[1] = 11;
      arr[2] = 13;
      arr[3] = 5;
      arr[4] = 6;
  
      sort(arr, 5);
      printArray(arr, 5);
  
      return 0;
  }
}

connect {
    EntryPoint.Sorter <- InsertionSort.Sorter;
    EntryPoint.Printer <- CPrinter.Printer;
}