component Application provides App { 
  def main() : int {
    if (true) {
      foo; /* Error: undeclared variable */
    }
    return 0;
  }
}