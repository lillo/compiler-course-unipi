component A provides App {
  /* Bug noticed by Pin-Chin Huang */
  
  def fun(x : int, y : int) : int {
    return 0;
  }
  
  def main() : int {
    var i : int;
    i = 1;
  
    fun(i = 2, i = i+1);
  
    print(i);
    return 0;
  }
}
