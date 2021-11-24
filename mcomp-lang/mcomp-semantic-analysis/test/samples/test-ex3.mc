// mComp-lang example 3

component Application provides App {
  def main() : int { 
    var i : int; 
    i=0; 
    var n : int;
    n = 5;
    while (i < n) { 
      print(i); 
      i=i+1;
    } 
  }
}