interface Foo {
    def foo();
}
/* Provided and used interfaces must be disjoint */
component EntryPoint provides App, Foo uses Foo {
    def main() : int {
        return 0;
    }

}