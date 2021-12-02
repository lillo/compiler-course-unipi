// mComp-lang example 2

component A provides App {
  def main() : int {
    var p : &int;                               // ref to int
    var i : int;                                // int
    i = 1;
    var ia : int[10];                           // array of 10 ints
    ia[0] = 2;
    var ia2 : &int;                             // ref to int
    var ipa : &int [10];                        // array of 10 ref to int
  
    print(i);                                   // ~1
    p = &i;                                     // now p points to i
    print(p);                                   // 1
    ia2 = &ia[0];                               // now ia2 points to ia[0]
    print (ia2);                                // 2
    p = 227;                                    // now i is 227
    print(p); print(i);                         // 227
    i = 12;                                     // now i is 12
    print(i);                                   // 12
    print(p);                                   // 12
    p = &ia[0];                                 // now p points to ia[0]
    ia[0] = 14;                                 // now ia[0] is 14
    print(ia[0]);                               // 14
    ia[9] = 114;                                // now ia[9] is 114
    print(ia[9]);                               // 114
    ipa[2] = &ia[0];                            // now ipa[2] points to ia[0]
    print(ipa[2]);                              // 2
    return 0;
  }
}