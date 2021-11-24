// Binary search
// Code adapted from https://www.geeksforgeeks.org/search-insert-and-delete-in-a-sorted-array/

interface Searcher { 
    def search(arr : int[], size : int, key : int) : int;
}

component BinarySearcher provides Searcher {
    def search(arr : int[], size : int, key : int) : int {
        return binarySearch(arr, 0, size, key);
    }

    def binarySearch(arr : int[], low : int, high : int, key : int) : int { 
      if (high < low) 
          return -1;
           
      var mid : int;
      mid = (low + high) / 2; /*low + (high - low)/2;*/
  
      if (key == arr[mid]) 
          return mid; 
      
      if (key > arr[mid]) 
          return binarySearch(arr, (mid + 1), high, key); 
      
      return binarySearch(arr, low, (mid - 1), key);
    }
}

component EntryPoint provides App uses Searcher { 
    
  /* Driver program to check above functions */
  def main() : int { 
      // Let us search 3 in below array 
      var arr : int[6];
  
      arr[0] = 5;
      arr[1] = 6;
      arr[2] = 7;
      arr[3] = 8;
      arr[4] = 9;
      arr[5] = 10;
      
      var n : int;
      var key : int; 
       
      key = 10; 
      n = 6;
  
      print(search(arr, n, key)); 
      return 0; 
  } 
}

connect EntryPoint.Searcher <- BinarySearcher.Searcher