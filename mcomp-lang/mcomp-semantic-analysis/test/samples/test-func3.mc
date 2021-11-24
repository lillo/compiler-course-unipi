component A provides App {
  def printem(a : int, b : int, c : int, d : int) {
    print(a);
    print(b);
    print(c);
    print(d);
  }
  
  def main() : int {
    printem(42,17,192,8);
    return 0;
  }
}