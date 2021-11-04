// mComp-lang example 13 

component EntryPoint provides App {
  def main() : int{
    var y : int;
    y = 1889;
    var n : int;
    n = 2020;
    while (y < n) {
      y = y + 1;
      if (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) 
        print(y);
    }
    return 0;
  }
}