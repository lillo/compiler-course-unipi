// mCompc example 19 -- 

component A provides App {
  def main() : int {
    var x : int;
    x = 44; 
    if (x == 0) 
      print(33); 
    else 
      print(44);
    return 0;
  }
}