// micro-C example 14 -- global data

int r;

void main() {
  int n;
  n = 36;
  print (sqrt(n));
}

int sqrt(int n) {
  r = 0;
  while (r * r < n) 
    r = r + 1;
  return r;
}
