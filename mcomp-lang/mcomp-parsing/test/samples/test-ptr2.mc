component EntryPoint provides App {
  def main() : int {
    var i : int;
    i = 0;
    var p : & int;
    p = &i;
    p = p + 2;
    print(p);
    print(i);
    return 0;
  }
}