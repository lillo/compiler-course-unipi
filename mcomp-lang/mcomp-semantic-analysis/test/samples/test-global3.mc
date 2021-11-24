component EntryPoint provides App {
  var i : int;
  var b : bool;
  var j : int;
  
  def main() : int {
    i = 42;
    j = 10;
    print(i + j);
    return 0;
  }
}