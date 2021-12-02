// MergeSort
// Code adapted from https://www.geeksforgeeks.org/merge-sort/

// In the code below we assume that the array length is 6

interface Sorter {
    def sort(arr : int[], size : int);
}

interface Comparator {
  def compare(n1 : int, n2 : int) : int;
}

component MergeSort provides Sorter uses Comparator {
  // Merges two subarrays of arr[]. 
  // First subarray is arr[l..m] 
  // Second subarray is arr[m+1..r] 
  def merge(arr : int[], l : int, m : int, r : int) { 
      var i : int;
      var j : int;
      var k : int; 
      var n1 : int;
      n1 = m - l + 1; 
      var n2 : int;
      n2 = r - m; 
    
      /* create temp arrays */
      var L : int[6];
      var R : int[6]; 
    
      /* Copy data to temp arrays L[] and R[] */
      for (i = 0; i < n1; i = i + 1) 
          L[i] = arr[l + i]; 
      for (j = 0; j < n2; j = j + 1) 
          R[j] = arr[m + 1 + j]; 
    
      /* Merge the temp arrays back into arr[l..r]*/
      i = 0; // Initial index of first subarray 
      j = 0; // Initial index of second subarray 
      k = l; // Initial index of merged subarray 
      while (i < n1 && j < n2) { 
          if (compare(L[i],R[j]) <= 0) { 
              arr[k] = L[i]; 
              i = i + 1; 
          } 
          else { 
              arr[k] = R[j]; 
              j = j + 1; 
          } 
          k = k + 1; 
      } 
    
      /* Copy the remaining elements of L[], if there 
         are any */
      while (i < n1) { 
          arr[k] = L[i]; 
          i = i + 1; 
          k = k + 1; 
      } 
    
      /* Copy the remaining elements of R[], if there 
         are any */
      while (j < n2) { 
          arr[k] = R[j]; 
          j = j + 1; 
          k = k + 1; 
      } 
  } 
  
  /* l is for left index and r is right index of the 
     sub-array of arr to be sorted */
  def mergeSort(arr : int[], l : int, r : int) { 
      if (l < r) { 
          // Same as (l+r)/2, but avoids overflow for 
          // large l and h 
          var m : int;
          m = l + (r - l) / 2; 
    
          // Sort first and second halves 
          mergeSort(arr, l, m); 
          mergeSort(arr, m + 1, r); 
    
          merge(arr, l, m, r); 
      } 
  } 

  def sort(arr : int[], size : int) {
      mergeSort(arr, 0, size - 1);
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

/* Driver program to test above functions */
component Entry provides App,Comparator uses Printer, Sorter {
  def compare(n1 : int, n2 : int) : int {
      return n1 - n2;
  }

  def main() : int { 
      var arr : int[6]; 
      arr[0] = 12;
      arr[1] = 11;
      arr[2] = 13;
      arr[3] = 5;
      arr[4] = 6;
      arr[5] = 7;
       
      var arr_size : int; 
      arr_size = 6;
  
      sort(arr, arr_size); 
      printArray(arr, arr_size); 
      return 0; 
  } 
}

connect {
    Entry.Sorter <- MergeSort.Sorter;
    Entry.Printer <- CPrinter.Printer;
    MergeSort.Comparator <- Entry.Comparator;
}