component Application provides App {
  def main() : int {
    var i : int;
    var n : int;
    i = 0;
    n = 5; // getint()
    while (i < n) {
      print(fac(i));
      i = i + 1;
    }
    print(n);
    return 0;
  }
  
  def fac(n : int) : int {
    if (n == 0)			/* fac's n */
      return 1;
     
    return n * fac(n-1);
  }
}


