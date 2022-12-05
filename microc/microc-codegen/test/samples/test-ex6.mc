// micro-C example 6 -- return a result via a pointer argument; nested blocks

void main() {
  int i;
  int n;
  i = 0;
  n = 5;
  while (i < n) {		/* Outer n */
    int n;
    fac(i, &n);
    print(n);			/* Inner n */
    i = i + 1;
  }
  print(n);
}

void fac(int n, int *res) {
  if (n == 0)			/* fac's n */
    *res = 1;
  else {
    int tmp;
    fac(n-1, &tmp);
    *res = tmp * n;
  }
}
