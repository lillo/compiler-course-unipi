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
    // No reference to reference assign to a reference
    p = &q;
    return 0;
  }
}