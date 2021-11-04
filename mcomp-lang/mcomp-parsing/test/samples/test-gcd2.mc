component A provides App {
def gcd(a : int, b : int) : int {
  while (a != b)
    if (a > b) a = a - b;
    else b = b - a;
  return a;
}

def main() : int {
  print(gcd(14,21));
  print(gcd(8,36));
  print(gcd(99,121));
  return 0;
}
}