// micro-C example 17 -- conjecture: seq will terminate for any n > 0

void main() {
  int k;
  k = 0;
  while (k < 45000) {
    k = k+1;
    if (seq(k) > 240) {
      print(k);
    }
  }
}

int seq(int i) {
  int count;
  count = 0;
  while (i != 1) {
    count = count + 1;
    if (i % 2 == 0) 
      i = i / 2;
    else
      i = i * 3 + 1;
  }
  return count;
}
