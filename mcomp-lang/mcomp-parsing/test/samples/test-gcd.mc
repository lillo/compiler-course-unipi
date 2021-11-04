component EntryPoint provides App {

def gcd(a : int, b : int) : int {
  while (a != b) {
    if (a > b) a = a - b;
    else b = b - a;
  }
  return a;
}

def main() : int {
  print(gcd(2,14));
  print(gcd(3,15));
  print(gcd(99,121));
  return 0;
}
}