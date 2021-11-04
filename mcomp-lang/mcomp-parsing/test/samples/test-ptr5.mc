component EntryPoint provides App {
  def main() : int {
    var i : int;
    var j : int; 
    i = j = 0;
    var p : & int;
    var q : & int;
    p = &i;
    q = & j;
    p = p + 2;
    q = q + 3;
    print(p);
    print(i);
    print(q);
    print(j);
    p = &j;   // p now points to j
    p = p + 1; // p and q point both to j
    print(p);
    print(i);
    print(q);
    print(j);
    return 0;
  }
}