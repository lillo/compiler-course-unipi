component EntryPoint provides App {
  var a : int;
  var b : bool;
  
  def foo(c : int, d : bool) {
    var dd : int;
    var e : bool;
    a + c;
    c - a;
    a * 3;
    c / 2;
    d + a; /* Error: bool + int */
  }
  
  def main() : int {
    return 0;
  }
}