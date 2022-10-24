void foo(int* a, int i){
    *a = 0;
}

int main(){
    int a[10];
    foo(a, 0);
    return 0;
}