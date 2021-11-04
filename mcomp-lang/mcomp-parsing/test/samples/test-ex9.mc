// mComp-lang example 9 -- return a result via a pointer argument

component EntryPoint provides App {
  def main() : int {
    var i : int;
    i = 5;
    var r : int;
    fac(i, &r);
    print(r);
    return 0;
  }
  
  def fac(n : int, res : &int) {
    if (n == 0)
      res = 1;
    else {
      var tmp : int;
      fac(n-1, &tmp);
      res = tmp * n;
    }
  }
}