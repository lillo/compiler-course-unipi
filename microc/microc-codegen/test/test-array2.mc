void set_element(int i, int a[], int n){
    a[i] = n;
}


int main(){
    int i;
    int b[10];

    for(i = 0; i < 10; i = i + 1)
      set_element(i, b, i + 1);

    for(i = 0; i < 10; i = i + 1)
      print(b[i]);

    return 0;
}