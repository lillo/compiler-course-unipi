// mComp-lang example 22 -- leapyear 

interface Date {
  def leapyear(y : int) : bool;
}

component CDate provides Date {
  def leapyear(y : int) : bool {
    return y % 4 == 0 && (y % 100 != 0 || y % 400 == 0);
  }
}

component EntryPoint provides App uses Date {

  def main() : int {
    var y : int;
    var n : int;
  
    y = 1889;
    n = 2020;
    
    while (y < n) {
      y = y + 1;
      if (leapyear(y))
        print(y);
    }
    
    return 0;
  }
}

connect EntryPoint.Date <- CDate.Date