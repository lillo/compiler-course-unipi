void main() {
  int i;
  int n;
  i = 0;
  n = 5; // getint()
  while (i < n) {
    print(fac(i));
    i = i + 1;
  }
  print(n);
}

int fac(int n) {
  if (n == 0)			/* fac's n */
    return 1;
  else 
    return n * fac(n-1);
}
