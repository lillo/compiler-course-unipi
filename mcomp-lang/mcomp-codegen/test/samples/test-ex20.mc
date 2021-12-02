// micro-C example 20 -- composite conditions in different contexts

component A provides App {
  def main() : int {
    var b : int; var m : int; var n : int;
    m = 12;
    n = 2;
    
    if (m == 0 && n == 0)
      print(1111);
    else
      print(2222);
    b = m * n;
    print(b);
    return 0;
  }
}  
  
  
  