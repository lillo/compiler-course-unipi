component EntryPoint provides App {
  def main() : int{
    var i : int;
    i = 2;
    var p : &int;
    p = &i;
    print(p);
    return 0;
  }
}