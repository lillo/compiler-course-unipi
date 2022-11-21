int main(){
  int i;
  i = 0;
  int *p;
  p = &i;
  *p = *p + 2;
  print(*p);
  print(i);
  return 0;
}