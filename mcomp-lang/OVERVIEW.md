# An overview of µcomp-lang

Basically, µcomp-lang is a simple imperative language where programs are built out from components.

Consider the following simple program:
```
interface Sorter {
  def sort(arr : int[], size : int) : void;
}

interface Comparator {
  def compare(n1 : int, n2 : int) : int;
}

interface Printer {
  def printArray(arr : int[], n : int);
}

component InsertionSort provides Sorter uses Comparator {
  def insertionSort(arr : int[], n : int){ 
      var i : int;
      var key : int;
      var j : int;
  
      for (i = 1; i < n; i = i + 1) { 
          key = arr[i]; 
          j = i - 1; 
    
          /* Move elements of arr[0..i-1], that are 
            greater than key, to one position ahead 
            of their current position */
          while (j >= 0 && compare(arr[j], key) > 0) { 
              arr[j + 1] = arr[j]; 
              j = j - 1; 
          } 
          arr[j + 1] = key; 
      } 
  }
  
  def sort(arr : int[], n : int){
    insertionSort(arr, n);
  }
}

component CPrinter provides Printer {
  def printArray(arr : int[], n : int){
    var i : int; 
    for (i = 0; i < n; i = i + 1) 
        print(arr[i]);
  }
}

component EntryPoint provides App,Comparator uses Printer, Sorter {

  def compare(n1 : int, n2 : int) : int {
      return n1 - n2;
  }

  def main() : int {
      var arr : int[5];
      
      arr[0] = 12;
      arr[1] = 11;
      arr[2] = 13;
      arr[3] = 5;
      arr[4] = 6;
  
      sort(arr, 5);
      printArray(arr, 5);
  
      return 0;
  }
}

connect {
    EntryPoint.Sorter <- InsertionSort.Sorter;
    EntryPoint.Printer <- CPrinter.Printer;
    InsertionSort.Comparator <- EntryPoint.Comparator;
}
```

This program sorts an array and prints its elements on the standard output. Below, we use the code above to present the main features of  
our language.

## Interfaces
At the beginning of our code we defines the interfaces `Sorter`, `Comparator` and `Printer`.
Interfaces represent a sort of types for components and specifies the signatures of functions and variables that the components providing that interface need to implement.
Moreover, interfaces are fundamental to compose components:
a component can interact with another one only using the functions of its interfaces.
 
Consider the `Sorter` interface.
It defines a function `sort` that takes the following parameters as input: 

- a reference to an array (`arr` of type `int[]`);
- the length of the array (`size` of type `int`).

and returns no value, as denoted by its return type  `void`. 
Note that the return type can be omitted when is `void` as done for the function `printArray` of the interface `Printer`.

A component that provides this interface **must** implement a function with the same signature.

Finally, there are two special predefined interfaces: `Prelude` and `App`.
The first one is intuitively defined as follows
```
interface Prelude {
  def print(v : int);
  def getint() : int;
}
```
and contains the signatures of the functions offered by the (very small) standard library of µcomp-lang.
The function `print` outputs an integer on the standard output; whereas, `getint` reads an integer from the standard input. 

The `App` interface is defined as follows
```
interface App {
  def main(): int;    
}
```
and represents the entry point of the program.

## Components

Components are the main units of code in µcomp-lang.
A component defines its own local namespace and has its state.
For each component, there is only one instance at runtime, i.e., components are not similar to classes but to singleton objects.
In the code above we define three components: `Printer`, `InsertionSort` and `EntryPoint`. 

Typically, components `provides` and `uses` an arbitrary number of interfaces. 
The provided interfaces represent the functionalities that a component implements and makes available to others. 
Whereas, the used interfaces represent a sort of dependencies, i.e., the functionalities required by the component to achieve its goals.

For example, the component `InsertionSort` provides the interface `Sorter`. 
It implements two functions, `sort` and `insertionSort` but only the first one is accessible from the outside because belonging to the interface `Sorter`; instead, the second function is private to the component. 

Moreover, the component uses the interface `Comparator`.
This interface provides the function `compare` which is used inside the code of the function `insertionSort`.
Actually, the component is parametric to the actual implementation of this function. 
It must provided by another component (`EntryPoint` in the code above).   

Finally, note that each component uses implicitly the interface `Prelude` (the call to `print` in the function `printArray` of the component `CPrinter` is legal) and that only one component can provide the interface `App` (`EntryPoint` in the code above).

## Connections

Once we have defined our components we need to wire them together in order to make a program. 
Actually, we link a component that uses an interface `A` with a component that provides that interface. 
The `connect` block above has exactly this goal.
The first line of the block is a link statement wiring the interface `Sorter` used by `EntryPoint` to the one provided by the component `InsertionSort`. 
This link statement is resolved statically by the compiler: every  call to the function `sort` inside `EntryPoint` is resolved calling the corresponding function of `InsertionSort`.
The other link statements of the block link the interface `Printer` used by `EntryPoint` to the one of provided by the component `CPrinter`, and the interface `Comparator` of `Sorter` to `EntryPoint`.

For each component in our program the compiler checks that each used interface is linked to a component.

## Other features

Besides components and interfaces µcomp-lang is a simple imperative language with standard 
constructs, e.g., `if`, `while`, `for`.
It supports integers, characters, booleans as primitive data, whereas arrays are the only form of compound data.
Functions can only returns values of primitive data or nothing.

The language provides also two kinds of references, those to primitive types (called *references*) and those to arrays (called *array references*).

### References

References in µcomp-lang are similar to the ones of other programming languages. 
They store addresses of primitives variables and are automatically dereferenced depending on their usage.

Consider the following snippet of code that defines a `swap` function:
```
def swap(a : &int, b : &int) { 
      var t : int;
      t = a; 
      a = b; 
      b = t; 
  }
```
The functions takes two references `a` and `b` to integers (the type `&int` means reference to `int` values).
In the second line, we assign the value `a` points to the variable `t` of type `int`.
The compiler automatically dereferences `a` because the variable on the left-hand-side of the assignment has type `int`.
Similarly, in the last line the compiler automatically dereferences `b` because the expression on the left-hand-side of the assignment has type `int`, thus, this assignment will modify the value `b` points to.
The assignment in the third line is a bit more involved because both side of the assignment are references.
However, in µcomp-lang addresses are not expressible values so the expression `b` is automatically dereferenced.
So the resulting value has type `int` and it is assigned to the memory location pointed by `a`.

Note that functions cannot return references.

### Array references

Array references are special references to array that can only be defined as argument of functions.
For example, the first argument of the function `sort` above is an array reference (type `int[]`). 
Note that array references do not provide any information about the length of the array they are pointing to, but only on the type of their elements.

Note that functions cannot return array reference and references and array references are incompatible.