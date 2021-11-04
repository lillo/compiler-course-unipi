interface Setter {
  def setElement(i : int, a : int[], n : int) : void;
}

component CSetter provides Setter {
  def setElement(i : int, a : int[], n : int) : void {
    a[i] = n;
  }
}

component Application provides App uses Setter {
  def main() : int {
    var i : int;
    var b : int[10];

    i = 0;
    while(i < 10){
      setElement(i, b, i + 1);
      i = i + 1;
    }
      

    i = 0;
    while(i < 10){
      print(b[i]);
      i = i + 1;
    }

    return 0;
  }  
}

connect Application.Setter <- CSetter.Setter
