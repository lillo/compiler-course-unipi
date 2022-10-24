// Reserve an array
// Code adapted from https://www.geeksforgeeks.org/write-a-program-to-reverse-an-array-or-string/

/* Function to reverse arr[] from start to end*/
void reverseArray(int arr[], int start, int end) 
{ 
    int temp; 
    while (start < end) 
    { 
        temp = arr[start];    
        arr[start] = arr[end]; 
        arr[end] = temp; 
        start = start + 1; 
        end = end - 1; 
    }    
}      
  
/* Utility that prints out an array on a line */
void printArray(int arr[], int size) 
{ 
  int i; 
  for (i=0; i < size; i = i + 1) 
    print(arr[i]);  
}  
  
/* Driver function to test above functions */
int main()  
{ 
    int arr[6]; 
    int i;
    int n;
    n = 6;

    for(i = 0; i < 6; i = i + 1)
      arr[i] = i + 1;

    reverseArray(arr, 0, n-1);  
    printArray(arr, n);     
    return 0; 
} 