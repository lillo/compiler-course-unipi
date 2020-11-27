/**
 * Insertion Sort
 * Code adapted from https://www.geeksforgeeks.org/insertion-sort/
 */
void insertionSort(int arr[], int n) 
{ 
    int i;
    int key;
    int j;

    for (i = 1; i < n; i = i + 1) { 
        key = arr[i]; 
        j = i - 1; 
  
        /* Move elements of arr[0..i-1], that are 
          greater than key, to one position ahead 
          of their current position */
        while (j >= 0 && arr[j] > key) { 
            arr[j + 1] = arr[j]; 
            j = j - 1; 
        } 
        arr[j + 1] = key; 
    } 
} 

void printArray(int arr[], int n) 
{ 
    int i; 
    for (i = 0; i < n; i = i + 1) 
        print(arr[i]); 
}

int main(){
    int arr[5];
    
    arr[0] = 12;
    arr[1] = 11;
    arr[2] = 13;
    arr[3] = 5;
    arr[4] = 6;

    insertionSort(arr, 5);
    printArray(arr, 5);

    return 0;
}