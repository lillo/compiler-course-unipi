component EntryPoint provides App {
  var a : int;
  var b : bool;
  
  def foo(c : int, d : bool) {
    //int d;
    var e : bool;
    b + a; /* Error: bool + int */
  }
  
  def main() : int {
    return 0;
  }
}