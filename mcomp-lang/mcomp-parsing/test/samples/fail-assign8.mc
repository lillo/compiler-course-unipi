component Program provides App {
  def main() : int {
    var ptr : &int;
    var a : int [5];
    ptr = &a[0];
    *(ptr + 1) = 10;
    return 0;
  }
}  