// mComp-lang example 7 -- an infinite loop

component Application provides App { 
  def main() : int {
    var i : int;
    i = 0;
    while (true) {
      i = i + 1;
    }
    print(999999);
    return 0;
  }
}



