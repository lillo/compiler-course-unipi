// micro-C example 11 -- count n queens solutions * 1996-12-20, 2017-04-11


void main() {
  int i;
  int u;
  int n;
  bool used[100];
  bool diag1[100];
  bool diag2[100];
  int col[100];
  int count;
  count = 0;

  n = 12;
  u = 1;
  while (u <= n) {
    used[u] = false;
    u = u+1;
  }

  u = 1;
  while (u <= 2 * n) {
    diag1[u] = diag2[u] = false;
    u = u+1;
  }

  i = u = 1;
  while (i > 0) {
    while (i <= n && i != 0) {
      while (u <= n && (used[u] || diag1[u-i+n] || diag2[u+i]))
	u = u + 1;
      if (u <= n) { // not used[u]; fill col[i] then try col[i+1]
	col[i] = u;
	diag1[u-i+n] = diag2[u+i] = used[u] = true;
	i = i+1; u = 1;
      } else {			// backtrack; try to find a new col[i-1]
	i = i-1;
	if (i > 0) {
	  u = col[i];
	  diag1[u-i+n] = diag2[u+i] = used[u] = false;
	  u = u+1;
	}
      }
    }

    if (i > n) {                // count solution, then backtrack
      count = count + 1;
      i = i-1;
      if (i > 0) {
	u = col[i];
	diag1[u-i+n] = diag2[u+i] = used[u] = false;
	u = u+1;
      }
    }
  }
  print(count);
}
