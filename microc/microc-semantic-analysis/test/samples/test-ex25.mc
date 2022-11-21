// micro-C example 25 -- better version of ex13.c?

void main() {
  int y;
  int n;
  y = 1889;
  n = 2020;
  while (y < n) {
    y = y + 1;
    if (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) 
      print(y);
  }
}
