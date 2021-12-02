component EntryPoint provides App {
  def printb(val : bool) {
    if(val)
      print(1);
    else
      print(0);
  }

  def main() : int {
    print(1 + 2);
    print(1 - 2);
    print(1 * 2);
    print(100 / 2);
    print(99);
    printb(1 == 2);
    printb(1 == 1);
    print(99);
    printb(1 != 2);
    printb(1 != 1);
    print(99);
    printb(1 < 2);
    printb(2 < 1);
    print(99);
    printb(1 <= 2);
    printb(1 <= 1);
    printb(2 <= 1);
    print(99);
    printb(1 > 2);
    printb(2 > 1);
    print(99);
    printb(1 >= 2);
    printb(1 >= 1);
    printb(2 >= 1); 
    return 0;
  }
}