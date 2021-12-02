component Application provides App {
  def change(ptr : &int, mode : int) : bool {
      if (mode != 0)
        ptr = ptr + 1;
      return true;
  }
  def main() : int {
      var i : int;
      i = 42;

      if(true && change(&i,0) || change(&i,1))
        print(i);
      else
        print(51);

    return 0;
  }
}