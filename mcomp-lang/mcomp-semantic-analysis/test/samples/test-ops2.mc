component EntryPoint provides App {
  def printb(val : bool) {
    if(val)
      print(1);
    else
      print(0);
  }
  
  def main() : int {
    printb(true);
    printb(false);
    printb(true && true);
    printb(true && false);
    printb(false && true);
    printb(false && false);
    printb(true || true);
    printb(true || false);
    printb(false || true);
    printb(false || false);
    printb(!false);
    printb(!true);
    print(-10);
    print(--42);
  }
}