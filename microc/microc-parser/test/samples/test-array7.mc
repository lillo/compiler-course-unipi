// Code adapted from https://www.geeksforgeeks.org/leaders-in-an-array/

void printLeaders(int arr[], int size) 
{ 
    int i;

    for (i = 0; i < size; i=i+1) 
    { 
        int j; 
        for (j = i+1; j < size && !(arr[i] <= arr[j]); j = j + 1) 
        { 
             
        }     
        if (j == size) // the loop didn't break 
            print(arr[i]); 
  } 
} 
  
/* Driver program to test above function */
int main() 
{ 
    int arr[6];

    arr[0] = 16;
    arr[1] = 17;
    arr[2] = 4;
    arr[3] = 3;
    arr[4] = 5;
    arr[5] = 2; 
    
    int n;
    n = 6; 
    
    printLeaders(arr, n); 
    return 0; 
} 