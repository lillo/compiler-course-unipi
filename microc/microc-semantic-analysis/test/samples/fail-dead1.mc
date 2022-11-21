/**
 At the moment the compiler does not raise any error,
 it just skips the deadcode
 */
int main()
{
  int i;

  i = 15;
  return i;
  i = 32; /* Error: code after a return */
}
