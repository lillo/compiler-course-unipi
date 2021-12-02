component Application provides App {
  var a : int;
  var b : int;

  def printa() {
    print(a);
  }

  def printb(){
    print(b);
  }

  def incab() {
    a = a + 1;
    b = b + 1;
  }

  def main() : int {
    a = 42;
    b = 21;
    printa();
    printb();
    incab();
    printa();
    printb();
    return 0;
  }
}