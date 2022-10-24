// micro-C example 22 -- leapyear, optimization of andalso and orelse

void main() {
  int y;
  int n;

  y = 1889;
  n = 2020;
  
  while (y < n) {
    y = y + 1;
    if (leapyear(y))
      print(y);
  }
}

bool leapyear(int y) {
  return y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);
}
