// Binary search
// Code adapted from https://www.geeksforgeeks.org/search-insert-and-delete-in-a-sorted-array/

int binarySearch(int arr[], int low, int high, int key) 
{ 
    if (high < low) 
        return -1; 
    int mid;
    mid = (low + high) / 2; /*low + (high - low)/2;*/

    if (key == arr[mid]) 
        return mid; 
    
    if (key > arr[mid]) 
        return binarySearch(arr, (mid + 1), high, key); 
    
    return binarySearch(arr, low, (mid - 1), key); 
} 
  
/* Driver program to check above functions */
int main() 
{ 
    // Let us search 3 in below array 
    int arr[6];

    arr[0] = 5;
    arr[1] = 6;
    arr[2] = 7;
    arr[3] = 8;
    arr[4] = 9;
    arr[5] = 10;
    
    int n;
    int key; 
     
    key = 10; 
    n = 6;

    print(binarySearch(arr, 0, n, key)); 
    return 0; 
} 