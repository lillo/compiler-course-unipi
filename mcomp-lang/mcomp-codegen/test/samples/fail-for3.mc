component Application provides App {
  def main() : int {
    var i : int;
  
    for (i = 0; i ; i = i + 1) {} /* i is an integer, not Boolean */
  
    return 0;
  }
}