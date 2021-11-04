// QuickSort
// Code adapted from https://www.geeksforgeeks.org/quick-sort/

interface Sorter {
    def sort(arr : int[], size : int);
}

interface Comparator {
  def compare(n1 : int, n2 : int) : int;
}


component QuickSort provides Sorter uses Comparator {
  // A utility function to swap two elements 
  def swap(a : &int, b : &int) { 
      var t : int;
      t = a; 
      a = b; 
      b = t; 
  } 
  
  /* This function takes last element as pivot, places 
     the pivot element at its correct position in sorted 
      array, and places all smaller (smaller than pivot) 
     to left of pivot and all greater elements to right 
     of pivot */
  def partition (arr : int[], low : int, high : int) : int { 
      var pivot : int;
      pivot = arr[high];    // pivot 
      var i : int;
      i = (low - 1);  // Index of smaller element 
      var j : int;
  
      for(j = low; j <= high - 1; j = j + 1) 
      { 
          // If current element is smaller than the pivot 
          if (compare(arr[j], pivot) < 0) 
          { 
              i = i + 1;    // increment index of smaller element 
              swap(&arr[i], &arr[j]); 
          } 
      } 
      swap(&arr[i + 1], &arr[high]); 
      return (i + 1); 
  } 
  
  /* The main function that implements QuickSort 
    arr[] --> Array to be sorted, 
    low  --> Starting index, 
    high  --> Ending index */
  def quickSort(arr : int [], low : int, high : int) { 
      if (low < high){ 
          /* pi is partitioning index, arr[p] is now 
             at right place */
          var pi : int;
          pi = partition(arr, low, high); 
    
          // Separately sort elements before 
          // partition and after partition 
          quickSort(arr, low, pi - 1); 
          quickSort(arr, pi + 1, high); 
      } 
  }

  def sort(arr : int[], size : int){
      quickSort(arr, 0, size - 1);
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
 
component Program provides App,Comparator uses Sorter, Printer {

  def compare(n1 : int, n2 : int) : int {
      return n1 - n2;
  }    

  // Driver program to test above functions 
  def main() : int { 
      var arr : int [6];
  
      arr[0] = 10;
      arr[1] = 7; 
      arr[2] = 8;
      arr[3] = 9;
      arr[4] = 1;
      arr[5] = 5; 
      
      var n : int;
      n = 6; 
      
      sort(arr, n); 
      printArray(arr, n); 
      return 0; 
  } 
}

connect {
    Program.Sorter <- QuickSort.Sorter;
    Program.Printer <- CPrinter.Printer;
    QuickSort.Comparator <- Program.Comparator;
}