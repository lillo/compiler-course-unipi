// micro-C example 20 -- composite conditions in different contexts

void main() {
  int b; int m; int n;
  m = 12;
  n = 2;
  
  if (m == 0 && n == 0)
    print(1111);
  else
    print(2222);
  b = m * n;
  print(b);
}

/*
Old forwards compiler:

        0,						allocate b
	GETBP, 0, ADD, LDI, 0, EQ, IFZERO L5,		m == 0
	GETBP, 1, ADD, LDI, 0, EQ, GOTO L4,		n == 0
    L5: 0, 						
    L4: IFZERO L2, 					
        1111, PRINTI, INCSP ~1, GOTO L3,		print 1111
    L2: 2222, PRINTI, INCSP ~1,				print 2222
							
    L3: GETBP, 2, ADD, 					address of b
        GETBP, 0, ADD, LDI, 0, EQ, IFZERO L7,		m == 0
        GETBP, 1, ADD, LDI, 0, EQ, GOTO L6,		n == 0
    L7: 0,						
    L6: STI, INCSP ~1, INCSP ~1, RET 1			b = ...
							
New backwards compiler:					
							
        0,						allocate b
	GETBP, LDI, IFNZRO L5,				m == 0
	GETBP, 1, ADD, LDI, IFNZRO L5,			n == 0
	1111, PRINTI, INCSP ~1, GOTO L4,		print 1111
    L5: 2222, PRINTI, INCSP ~1,				print 2222
							
    L4: GETBP, 2, ADD,					address of b
        GETBP, LDI, IFNZRO L3,				m == 0
        GETBP, 1, ADD, LDI, NOT, GOTO L2,		n == 0
    L3: 0, 						
    L2: STI, RET 3					b = ...
*/

