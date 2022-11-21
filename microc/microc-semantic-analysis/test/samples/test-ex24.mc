// micro-C example 24
// Ackermann function, P�ter and Robinson's version

void main() {
  print(ack(3, 4));   // should print 125
  print(ack(3, 7));   // should print 1021
  print(ack(4, 1));   // should print 65533
  // do not try to compute ack(4, 2)
}

int ack(int m, int n) {
  if (m == 0)
    return n+1;
  else if (n == 0)
    return ack(m-1, 1);
  else
    return ack(m-1, ack(m, n-1));
}
