component Application provides App {
  def main() : int {
    var i : int;
  
    while (true) {
      i = i + 1;
    }
  
    while (42) { /* Should be boolean */
      i = i + 1;
    }
  }
}