// mComp-lang example 16 -- optimization needed

component A provides App {
  def main() : int {
    var n : int;
    n = 5;
    if (n != 0) 
      { } 
    else 
      print(1111);
    print(2222);
    return 0;
  }
}