component Program provides App {
  def foo(a : int, b : bool, c : int) : int { }
  
  def bar(a : int, b : bool, a : int) {} /* Error: duplicate formal a in bar */
  
  def main() : int{
    return 0;
  }
}