// mComp example 25 -- better version of ex13.c?

component A provides App {
  def main() : int {
    var y : int;
    var n : int;
    y = 1889;
    n = 2020;
    while (y < n) {
      y = y + 1;
      if (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) 
        print(y);
    }
    return 0;
  }
}