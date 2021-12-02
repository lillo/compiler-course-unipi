// mComp-lang example 17 -- conjecture: seq will terminate for any n > 0

component Entry provides App {

  def main() : int {
    var k : int;
    k = 0;
    while (k < 45000) {
      k = k+1;
      if (seq(k) > 240) {
        print(k);
      }
    }
    return 0;
  }
  
  def seq(i : int) : int {
    var count : int;
    count = 0;
    while (i != 1) {
      count = count + 1;
      if (i % 2 == 0) 
        i = i / 2;
      else
        i = i * 3 + 1;
    }
    return count;
  }
}