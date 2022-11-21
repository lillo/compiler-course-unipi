// Heap sort
// Code adapted from https://www.geeksforgeeks.org/heap-sort/

// A utility function to swap two elements 
void swap(int* a, int* b) 
{ 
    int t;
    t = *a; 
    *a = *b; 
    *b = t; 
}

void heapify(int arr[], int n, int i) 
{ 
    int largest;
    largest = i; // Initialize largest as root 
    int l;
    l = 2*i + 1; // left = 2*i + 1 
    int r;
    r = 2*i + 2; // right = 2*i + 2 
  
    // If left child is larger than root 
    if (l < n && arr[l] > arr[largest]) 
        largest = l; 
  
    // If right child is larger than largest so far 
    if (r < n && arr[r] > arr[largest]) 
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
void heapSort(int arr[], int n) 
{ 
    int i;
    // Build heap (rearrange array) 
    for (i = n / 2 - 1; i >= 0; i = i - 1) 
        heapify(arr, n, i); 
  
    // One by one extract an element from heap 
    for (i=n-1; i>0; i = i - 1) 
    { 
        // Move current root to end 
        swap(&arr[0], &arr[i]); 
  
        // call max heapify on the reduced heap 
        heapify(arr, i, 0); 
    } 
} 
  
/* A utility function to print array of size n */
void printArray(int arr[], int n) 
{ 
    int i;
    for (i=0; i<n; i = i + 1) 
        print(arr[i]); 
} 
  
// Driver program 
int main() 
{ 
    int arr[6];

    arr[0] = 12;
    arr[1] = 11;
    arr[2] = 13;
    arr[3] = 5;
    arr[4] = 6;
    arr[5] = 7;
 
    int n;
    n = 6;

    heapSort(arr, n); 
    printArray(arr, n); 
} 