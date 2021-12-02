component Application provides App {
  def foo(a : &int, i : int){
    a = 0;
  }
  
  def main() : int{
    var a : int[10];
    foo(a, 0);
    return 0;
  }
}  