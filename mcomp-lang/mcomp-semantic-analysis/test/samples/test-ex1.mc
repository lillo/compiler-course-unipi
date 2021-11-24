// Simple example 

component EntryPoint provides App { 
  def main() : int {
    var n : int;
    n = 5;
    while (n > 0) {
      print(n);
      n = n - 1;
    }
    return 0;
  }
}