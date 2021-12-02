component EntryPoint provides App {
  def main() : int {
    if (true) {
      42;
    } else {
      bar; /* Error: undeclared variable */
    }
    return 0;
  }
}