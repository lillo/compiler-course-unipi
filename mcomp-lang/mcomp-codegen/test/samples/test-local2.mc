component EntryPoint provides App {
  def foo(a : int, b : bool) : int {
    var c : int;
    var d : bool;
  
    c = a;
  
    return c + 10;
  }
  
  def main() : int {
   print(foo(37, false));
   return 0;
  }
}