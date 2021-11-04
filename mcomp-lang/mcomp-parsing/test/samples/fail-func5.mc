component Application provides App {
  def foo() : int {}
  
  def bar() : int {
    var a : int;
    var b : void; /* Error: illegal void local b */
    var c : bool;
  
    return 0;
  }
  
  def main() : int {
    return 0;
  }
}