component EntryPoint provides App {
  def main() : int {
    var i : int;
    var a : int[10];

    i = 0;
    while(i < 10){
      a[i] = i + 1;
      i = i + 1;
    }
  
    i = 0;
    while(i < 10){
      print(a[i]);
      i = i + 1;
    }

    return 0;
  }
}