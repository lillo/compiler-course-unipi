// micro-C example 12 -- tail calls

int tail_call(int n) {
  if (n > 0) 
    return tail_call(n-1);
  else 
    return 17;
}

int main(){
  print(tail_call(10));
  return 0;
}
