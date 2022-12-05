// micro-C example 21 -- tail call optimization is unsound

void main() { 
  int a[10];
  a[1] = 117;
  f(1, a);
}

void f(int i, int a[]) {
  print(a[i]); 
}
