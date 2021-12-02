interface Foo { 
  def foo(a : int) : int;
}

component CFoo provides Foo {
  def foo(a : int) : int {
    return a;
  }
}

component EntryPoint 
     provides App 
     uses Foo       
{
  def main() : int {
    var a : int;
    a = 42;
    a = a + 5;
    print(foo(a));
    return 0;
  }
}   

connect EntryPoint.Foo <- CFoo.Foo

