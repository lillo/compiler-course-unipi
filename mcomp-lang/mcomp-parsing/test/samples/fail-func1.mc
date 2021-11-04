component Program provides App {
  def foo() : int {}
  
  def bar() : int {}
  
  def baz() : int {}
  
  def bar() {} /* Error: duplicate function bar */
  
  def main() : int {
    return 0;
  }
}