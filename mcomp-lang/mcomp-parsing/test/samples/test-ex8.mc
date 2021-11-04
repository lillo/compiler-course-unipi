// mComp-lang example 8 -- loop 20 million times

component Application provides App { 
  def main() : int {
    var i : int;
    i = 20000000;
    while (i > 0) {
      i = i - 1;
    }
    print(i);
    return 0;
  }
}