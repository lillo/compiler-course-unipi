component Program provides App {
  def main() : int {
    var i : int;
    var b : bool;
  
    i = 42;
    i = 10;
    b = true;
    b = false;
    i = false; /* Fail: assigning a bool to an integer */
    return 0;
  }
}