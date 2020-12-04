# Exercises on LLVM-IR

For the following exercises require the usage of the command line tools provided 
by LLVM, i.e., `lli`, `llc`, `llvm-as`, `llvm-link` and `clang`.

The exercises ask you to implement a simple function in LLVM-IR.
You can test your solution using a standard C program. 
Assume that your solution is a function `int foo(int)` in a module `foo.ll`. 
You can test the function by creating something similar to the following
```C
/** Here, include directives, other declarations, etc. */
extern int foo(int);

int main(){
    // ... other code
    if(foo(test1) == expected 1)
        printf("Test 1 passed!"\n);
    // ... other code    
}
```
Then, you can compile the `main` to LLVM IR and link it to your solution
```sh
$ clang -llvm-emit main.c -c -S
$ llvm-link main.bc foo.bc -o output.bc
$ lli output.bc
```

## Exercise 1

Implement a function that given an integer `n` computes the factorial `n`. 
Provide two version of this function the first one that is recursive and the second one that is iterative.

## Exercise 2

Implement a function that given an array of integers `a` returns the sum of the elements of `a`.

## Exercise 3

Implement a function that given an array of integers `a` returns the minimum of `a`.