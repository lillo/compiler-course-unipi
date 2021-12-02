component A provides App {
  def main() : int {
    var i : int;
    i = 0;
    for ( ; i < 5; ) {
      print(i);
      i = i + 1;
    }
    print(42);
    return 0;
  }
}