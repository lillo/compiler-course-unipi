// mComp-lang example 6 -- return a result via a pointer argument; nested blocks

component EntryPoint provides App {
  def main() : int {
    var i : int;
    var n : int;
    i = 0;
    n = 5;
    while (i < n) {		/* Outer n */
      var n : int;
      fac(i, &n);
      print(n);			/* Inner n */
      i = i + 1;
    }
    print(n);
    return 0;
  }
  
  def fac(n : int, res : &int) {
    if (n == 0)			/* fac's n */
      res = 1;
    else {
      var tmp : int;
      fac(n-1, &tmp);
      res = tmp * n;
    }
  }
}