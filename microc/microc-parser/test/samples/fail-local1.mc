void foo(bool i)
{
  int i; /* Should not hide the formal i */

  i = 42;
  print(i + i);
}

int main()
{
  foo(true);
  return 0;
}
