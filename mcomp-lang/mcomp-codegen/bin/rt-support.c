#include <stdio.h>
#include <stdlib.h>

int getint(){
    char buffer[32];
    if(fgets(buffer, 32, stdin) == NULL)
      return 0;
    return atoi(buffer);
}

void print(int n){
  printf("%d\n", n);
}