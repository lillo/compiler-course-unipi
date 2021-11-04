component EntryPoint provides App {
  def foo(a : int, b : bool)
  {
  }
  
  def main() : int {
    foo(42, true);
    foo(42); /* Wrong number of arguments */
    return 0;
  }
}