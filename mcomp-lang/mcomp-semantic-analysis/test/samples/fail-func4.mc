component Application provides App {
  def foo() : int {}
  
  def bar() {}
  
  def print() : int {} /* Should not be able to define print */
  
  def baz() {}
  
  def main() : int {
    return 0;
  }
}