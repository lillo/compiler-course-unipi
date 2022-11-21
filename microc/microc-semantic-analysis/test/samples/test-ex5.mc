// micro-C example 5 -- return a result via a pointer argument; nested blocks

void main() {
  int r;
  int n;
  n = 6; 
  r = n;
  { 
    int r;
    square(n, &r);
    print(r);
  }
  print(r);
}

void square(int i, int *rp) {
  *rp = i * i;
}
