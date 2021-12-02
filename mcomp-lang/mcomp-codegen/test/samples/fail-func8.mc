component EntryPoint provides App {
  def foo(a : int, b : bool)
  {
  }
  
  def bar()
  {
  }
  
  def main() : int {
    foo(42, true);
    foo(42, bar()); /* int and void, not int and bool */
  }
}