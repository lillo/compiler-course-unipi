// mComp-lang example 23 -- exponentially slow Fibonacci

component A provides App {

  def main() : int {
    var i : int;
    i = 0;
    while (i < 10) {
      print(i);
      print(fib(i));
      i = i + 1;
    }
    return 0;
  }
  
  def fib(n : int) : int {
    if (n < 2)
      return 1;
    else 
      return fib(n-2) + fib(n-1);
  }
}