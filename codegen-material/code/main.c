#include <stdio.h>

extern int sum(int);

int main(){
    int a = sum(2);
    printf("%d\n", a);
    return 0;
}