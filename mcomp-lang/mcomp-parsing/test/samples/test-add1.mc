interface Adder {
  def add(x : int, y : int) : int;
}

component CAdder provides Adder {
  def add(x : int, y : int) : int {
    return x + y;
  }
}

component EntryPoint provides App uses Adder {
  def main() : int {
    print( add(17, 25) );
    return 0;
  }
}

connect EntryPoint.Adder <- CAdder.Adder

