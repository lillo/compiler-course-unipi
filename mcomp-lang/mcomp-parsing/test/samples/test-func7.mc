component A provides App {
  var a : int;
  
  def foo(c : int) {
    a = c + 42;
  }
  
  def main() : int {
    foo(73);
    print(a);
    return 0;
  }
}