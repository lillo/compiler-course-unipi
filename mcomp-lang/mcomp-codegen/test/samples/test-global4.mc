component EntryPoint provides App {
  var i : int;
  
  def incr(i : int) : int{
      return i + 1;
  }
  
  def main() : int {
      i = 2;
      print(incr(i));
      print(i);
      return 0;
  }
}