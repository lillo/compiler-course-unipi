// micro-C example 9 -- return a result via a pointer argument

void main() {
  int i;
  i = 5;
  int r;
  fac(i, &r);
  print(r);
}

void fac(int n, int *res) {
  // print &n;			// Show n's address
  if (n == 0)
    *res = 1;
  else {
    int tmp;
    fac(n-1, &tmp);
    *res = tmp * n;
  }
}
