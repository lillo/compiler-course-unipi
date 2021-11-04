component EntryPoint provides App {
  def main() : int {
    var i : int;
  
    while (true) {
      i = i + 1;
    }
  
    while (true) {
      foo(); /* foo undefined */
    }
    return 0;
  }
}