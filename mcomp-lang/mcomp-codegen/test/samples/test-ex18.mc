// mComp-lang example 18 -- if within if

component A provides App {
  def main() : int {
    var m : int; 
    var n : int;

    m = n = 10;
    
    if (m == 0) {
      if (n == 0)
        print(1111);
    } else
      print(3333);
      
    return 0;  
  }

}