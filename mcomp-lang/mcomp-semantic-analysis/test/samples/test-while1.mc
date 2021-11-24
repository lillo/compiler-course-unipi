component EntryPoint provides App {
  def main() : int {
    var i : int;
    i = 5;
    while (i > 0) {
      print(i);
      i = i - 1;
    }
    print(42);
    return 0;
  }
}