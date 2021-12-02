component EntryPoint provides App {
  def foo() {
    if (true) return 42; /* Should return void */
    else return;
  }
  
  def main() : int {
    return 42;
  }
}