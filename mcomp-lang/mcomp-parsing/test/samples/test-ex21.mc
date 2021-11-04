// mComp-lang example 21 -- tail call optimization is unsound

component A provides App {
  def main() : int { 
    var a : int[10];
    a[1] = 117;
    f(1, a);
    return 0;
  }
  
  def f(i : int, a : int[]) {
    print(a[i]); 
  }
}