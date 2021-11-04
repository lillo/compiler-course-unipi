component Application provides App {
  def foo(i : int) {
    i = 42;
    print(i + i);
  }
  
  def main() : int {
    foo(10);
    return 0;
  }
}