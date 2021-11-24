component Application provides App {
  def main() : int {
    var i : int;
  
    for (i = 0; i < 10 ; i = i + 1) {
      foo(); /* Error: no function foo */
    }
  
    return 0;
  }
}