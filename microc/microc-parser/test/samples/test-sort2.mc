// QuickSort
// Code adapted from https://www.geeksforgeeks.org/quick-sort/

// A utility function to swap two elements 
void swap(int* a, int* b) 
{ 
    int t;
    t = *a; 
    *a = *b; 
    *b = t; 
} 
  
/* This function takes last element as pivot, places 
   the pivot element at its correct position in sorted 
    array, and places all smaller (smaller than pivot) 
   to left of pivot and all greater elements to right 
   of pivot */
int partition (int arr[], int low, int high) 
{ 
    int pivot;
    pivot = arr[high];    // pivot 
    int i;
    i = (low - 1);  // Index of smaller element 
    int j;

    for(j = low; j <= high - 1; j = j + 1) 
    { 
        // If current element is smaller than the pivot 
        if (arr[j] < pivot) 
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
void quickSort(int arr[], int low, int high) 
{ 
    if (low < high) 
    { 
        /* pi is partitioning index, arr[p] is now 
           at right place */
        int pi;
        pi = partition(arr, low, high); 
  
        // Separately sort elements before 
        // partition and after partition 
        quickSort(arr, low, pi - 1); 
        quickSort(arr, pi + 1, high); 
    } 
} 
  
/* Function to print an array */
void printArray(int arr[], int size) 
{ 
    int i; 
    for (i=0; i < size; i = i + 1) 
        print(arr[i]);  
} 
  
// Driver program to test above functions 
int main() 
{ 
    int arr[6];

    arr[0] = 10;
    arr[1] = 7; 
    arr[2] = 8;
    arr[3] = 9;
    arr[4] = 1;
    arr[5] = 5; 
    
    int n;
    n = 6; 
    
    quickSort(arr, 0, n-1); 
    printArray(arr, n); 
    return 0; 
} 