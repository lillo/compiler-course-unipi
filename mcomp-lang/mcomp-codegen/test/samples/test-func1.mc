interface Adder {
  def add(a : int, b : int) : int;
}

component CAdder provides Adder { 
  def add(a : int, b : int) : int {
    return a + b;
  }
}

component Entry provides App uses Adder {
  def main() : int {
    var a : int;
    a = add(39, 3);
    print(a);
    return 0;
  }
}  

connect Entry.Adder <- CAdder.Adder