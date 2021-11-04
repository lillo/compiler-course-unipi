component A provides App {
  /**
   At the moment the compiler does not raise any error,
   it just skips the deadcode
   */
  def main() : int
  {
    var i : int;
  
    {
      i = 15;
      return i;
    }
    i = 32; /* Error: code after a return */
  }
}