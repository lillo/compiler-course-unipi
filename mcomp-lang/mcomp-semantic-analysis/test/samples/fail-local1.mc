component Application provides App {
  def foo(i : bool) {
    var i : int;
    var i : int; /* Should not hide the local i */
  
    i = 42;
    print(i + i);
  }
  
  def main() : int {
    foo(true);
    return 0;
  }
}