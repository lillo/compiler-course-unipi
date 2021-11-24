component Application provides App {
  def foo() : &int {
      var i : int;
      i = 0;
      return &i;
  }
  
  def main() : int {
      return 0;
  }
}  