interface Adder {
  def add(a : int, b : int) : int;
}

component CAdder provides Adder { 
  def add(a : int, b : int) : int {
    var c : int;
    c = a + b;
    return c;
  }
}

component Entry provides App uses Adder {
  def main() : int {
    var d : int;
    d = add(52, 10);
    print(d);
    return 0;
  }
}  

connect Entry.Adder <- CAdder.Adder
