// mComp-lang example 14 -- global data

component Application provides App {

  var r : int;
  
  def main() : int {
    var n : int;
    n = 36;
    print (sqrt(n));
    return 0;
  }
  
  def sqrt(n : int) : int {
    r = 0;
    while (r * r < n) 
      r = r + 1;
    return r;
  }
}