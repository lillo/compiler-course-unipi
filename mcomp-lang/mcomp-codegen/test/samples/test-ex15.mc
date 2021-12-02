// mComp-lang example 15 -- tail calls

component Application provides App {
  def tail_call(n : int) {
    if (n!=0) {
      print(n);
      tail_call(n-1);
    } else 
      print(999999);
  }
  
  def main() : int {
    tail_call(5);
    return 0;
  }
}  