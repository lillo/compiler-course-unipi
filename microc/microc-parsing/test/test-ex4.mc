// micro-C example 4 -- compute and print array of factorials

int a[20];			/* Must be global */

void main() { 
  int i; 
  i = 0; 
  int f; 
  f = 1;
  int n;
  n = 5;
  while (i < n) {
    a[i] = f;
    i = i + 1;
    f = f * i;
  }
  printarr(n, a);
}

void printarr(int len, int a[]) {
  int i; 
  i = 0; 
  while (i < len) { 
    print(a[i]); 
    i=i+1; 
  } 
}
