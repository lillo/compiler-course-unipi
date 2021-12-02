component Application provides App {
  def cond(b : bool) : int {
    var x : int;
    if (b)
      x = 42;
    else
      x = 17;
    return x;
  }
  
  def main() : int {
   print(cond(true));
   print(cond(false));
   return 0;
  }
}  