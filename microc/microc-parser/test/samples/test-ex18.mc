// micro-C example 18 -- if within if

void main() {
  int m; 
  int n;
  m = n = 10;
  if (m == 0) {
    if (n == 0)
      print(1111);
  } else
    print(3333);
}

/*
Old forwards compiler:

     GETBP, 0, ADD, LDI, 0, EQ, IFZERO L2,              m == 0
     GETBP, 1, ADD, LDI, 0, EQ, IFZERO L4,              n == 0
     1111, PRINTI, INCSP ~1, GOTO L5,                   print 1111
 L4: INCSP 0, 
 L5: INCSP 0, GOTO L3,
 L2: 3333, PRINTI, INCSP ~1,                            print 3333
 L3: INCSP 0, RET 1

New backwards compiler:

     GETBP, LDI, IFNZRO L2,                             m == 0
     GETBP, 1, ADD, LDI, IFNZRO L3,                     n == 0
     1111, PRINTI, RET 2,                               print 1111
 L3: RET 1,
 L2: 3333, PRINTI, RET 2                                print 3333

*/
