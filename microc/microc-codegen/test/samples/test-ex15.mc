// micro-C example 15 -- tail calls

void tail_call(int n) {
  if (n!=0) {
    print(n);
    tail_call(n-1);
  } else 
    print(999999);
}

int main(){
  tail_call(5);
  return 0;
}
