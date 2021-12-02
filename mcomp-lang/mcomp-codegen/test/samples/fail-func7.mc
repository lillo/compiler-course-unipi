component Application provides App {
  def foo(a : int, b : bool)
  {
  }
  
  def main() : int {
    foo(42, true);
    foo(42, true, false); /* Wrong number of arguments */
  }
}