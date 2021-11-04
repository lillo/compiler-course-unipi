component Program provides App {
  def double(i : &int) {
    i = i * 2;
  }
  
  def main() : int {
    var i : int;
    i = 2;
  
    print(i);
    double(&i);
    print(i);
    return 0;
  }
}