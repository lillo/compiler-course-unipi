// MergeSort
// Code adapted from https://www.geeksforgeeks.org/merge-sort/

// In the code below we assume that the array length is 6

// Merges two subarrays of arr[]. 
// First subarray is arr[l..m] 
// Second subarray is arr[m+1..r] 
void merge(int arr[], int l, int m, int r) 
{ 
    int i;
    int j;
    int k; 
    int n1;
    n1 = m - l + 1; 
    int n2;
    n2 = r - m; 
  
    /* create temp arrays */
    int L[6];
    int R[6]; 
  
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
        if (L[i] <= R[j]) { 
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
void mergeSort(int arr[], int l, int r) 
{ 
    if (l < r) { 
        // Same as (l+r)/2, but avoids overflow for 
        // large l and h 
        int m;
        m = l + (r - l) / 2; 
  
        // Sort first and second halves 
        mergeSort(arr, l, m); 
        mergeSort(arr, m + 1, r); 
  
        merge(arr, l, m, r); 
    } 
} 
  
/* UTILITY FUNCTIONS */
/* Function to print an array */
void printArray(int A[], int size) 
{ 
    int i; 
    for (i = 0; i < size; i = i + 1) 
        print(A[i]);  
} 
  
/* Driver program to test above functions */
int main() 
{ 
    int arr[6]; 
    arr[0] = 12;
    arr[1] = 11;
    arr[2] = 13;
    arr[3] = 5;
    arr[4] = 6;
    arr[5] = 7;
     
    int arr_size; 
    arr_size = 6;

    mergeSort(arr, 0, arr_size - 1); 
    printArray(arr, arr_size); 
    return 0; 
} 