// mComp-lang example 12 -- tail calls

component A provides App {

  def tail_call(n : int) : int {
    if (n > 0) 
      return tail_call(n-1);
    else 
      return 17;
  }
  
  def main() : int {
    print(tail_call(10));
    return 0;
  }
}