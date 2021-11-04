// Heap sort
// Code adapted from https://www.geeksforgeeks.org/heap-sort/

interface Sorter {
    def sort(arr : int[], size : int);
}

interface Comparator {
  def compare(n1 : int, n2 : int) : int;
}

component HeapSort provides Sorter uses Comparator {
  // A utility function to swap two elements 
  def swap(a : &int, b : &int) { 
      var t : int;
      t = a; 
      a = b; 
      b = t; 
  }

  def heapify(arr : int[], n : int, i : int) { 
      var largest : int;
      largest = i; // Initialize largest as root 
      var l : int;
      l = 2*i + 1; // left = 2*i + 1 
      var r : int;
      r = 2*i + 2; // right = 2*i + 2 
    
      // If left child is larger than root 
      if (l < n && compare(arr[l], arr[largest]) > 0) 
          largest = l; 
    
      // If right child is larger than largest so far 
      if (r < n && compare(arr[r], arr[largest]) > 0) 
          largest = r; 
    
      // If largest is not root 
      if (largest != i) 
      { 
          swap(&arr[i], &arr[largest]); 
    
          // Recursively heapify the affected sub-tree 
          heapify(arr, n, largest); 
      } 
  } 
    
  // main function to do heap sort 
  def sort(arr : int[], n : int) { 
      var i : int;
      // Build heap (rearrange array) 
      for (i = n / 2 - 1; i >= 0; i = i - 1) 
          heapify(arr, n, i); 
    
      // One by one extract an element from heap 
      for (i=n-1; i>0; i = i - 1){ 
          // Move current root to end 
          swap(&arr[0], &arr[i]); 
    
          // call max heapify on the reduced heap 
          heapify(arr, i, 0); 
      } 
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

component EntryPoint provides App,Comparator uses Sorter, Printer {
  def compare(n1 : int, n2 : int) : int {
      return n1 - n2;
  }  
  // Driver program 
  def main() : int { 
      var arr : int[6];
  
      arr[0] = 12;
      arr[1] = 11;
      arr[2] = 13;
      arr[3] = 5;
      arr[4] = 6;
      arr[5] = 7;
   
      var n : int;
      n = 6;
  
      sort(arr, n); 
      printArray(arr, n);
      return 0; 
  } 
}


connect {
    EntryPoint.Sorter <- HeapSort.Sorter;
    EntryPoint.Printer <- CPrinter.Printer;
    HeapSort.Comparator <- EntryPoint.Comparator;
}