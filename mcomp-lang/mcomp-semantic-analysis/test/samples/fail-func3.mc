component Application provides App {
  def foo(a : int, b : bool, c : int) : int { }
  
  def bar(a : int, b : void, c : int) {} /* Error: illegal void formal b */
  
  def main() : int {
    return 0;
  }
}