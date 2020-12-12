// Array rotation
// Code adapted from https://www.geeksforgeeks.org/array-rotation/
/* Function to left Rotate arr[] of size n by 1*/

void leftRotatebyOne(int arr[], int n) 
{ 
    int temp;
    temp = arr[0];
    int i; 

    for (i = 0; i < n - 1; i = i + 1) 
        arr[i] = arr[i + 1]; 
    
    arr[i] = temp; 
}

/*Function to left rotate arr[] of size n by d*/
void leftRotate(int arr[], int d, int n) 
{ 
    int i; 
    for (i = 0; i < d; i = i + 1) 
        leftRotatebyOne(arr, n); 
} 
  
  
/* utility function to print an array */
void printArray(int arr[], int n) 
{ 
    int i; 
    for (i = 0; i < n; i = i + 1) 
        print(arr[i]); 
} 
  
/* Driver program to test above functions */
int main() 
{ 
    int arr[7];

    arr[0] = 1;
    arr[1] = 2;
    arr[2] = 3;
    arr[3] = 4;
    arr[4] = 5;
    arr[5] = 6;
    arr[6] = 7;
    
    leftRotate(arr, 2, 7); 
    printArray(arr, 7); 
    return 0; 
} 
