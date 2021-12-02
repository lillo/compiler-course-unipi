// mComp-lang example 5 -- return a result via a reference argument; nested blocks

component EntryPoint provides App {

  def main() : int {
    var r : int;
    var n : int;
    n = 6; 
    r = n;
    { 
      var r : int;
      square(n, &r);
      print(r);
    }
    print(r);
    return 0;
  }
  
  def square(i : int, rp : &int) {
    rp = i * i;
  }
}