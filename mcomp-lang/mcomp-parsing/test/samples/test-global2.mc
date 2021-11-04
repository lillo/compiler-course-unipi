component A provides App {
  var i : bool;
  
  def main() : int {
    var i : int; /* Should hide the global i */
  
    i = 42;
    print(i + i);
    return 0;
  }
}