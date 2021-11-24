component A provides App {
  def foo() {}
  
  def bar(a : int, b : bool, c: int) : int { return a + c; }
  
  def main() : int {
    print(bar(17, false, 25));
    return 0;
  }
}