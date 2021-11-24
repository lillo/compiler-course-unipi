component Program provides App {
  def myvoid()
  {
    return;
  }
  
  def main() : int {
    var i : int;
  
    i = myvoid(); /* Fail: assigning a void to an integer */
  }
}