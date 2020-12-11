# MicroC Compiler

One of the goal of the course is that students experiment with the construction of a compiler of simple language.
MicroC is a subset of the language C where some simplification are made:

* It supports only integers (`int`), characters (`char`) and booleans (`bool`) as scalar values, array and pointers as compound data types;
* There are no structures, unions, doubles, function pointer;
* No dynamic allocation of memory;
* No multi-dimensional arrays;
* No shorthand for initialize variable during declaration;
* Functions can only return `void`, `int`, `bool`, `char`;
* No pointer arithmetic;
* Pointers and arrays are not interchangeable;
* no separate compilation, all the code of a program must stay in a unique compilation unit;
* there are only two library functions
```C
void print(int)  // it outputs an integer to standard output
int getint()     // it inputs an integer from standard input 
```

Even if the language is quite simple, we can express interesting algorithms as the one below:
```C
void insertionSort(int arr[], int n) 
{ 
    int i;
    int key;
    int j;

    for (i = 1; i < n; i = i + 1) { 
        key = arr[i]; 
        j = i - 1; 
  
        /* Move elements of arr[0..i-1], that are 
          greater than key, to one position ahead 
          of their current position */
        while (j >= 0 && arr[j] > key) { 
            arr[j + 1] = arr[j]; 
            j = j - 1; 
        } 
        arr[j + 1] = key; 
    } 
} 
```

As part of the exam students will be asked to implement a compiler for MicroC using the OCaml language, the tools and the techniques presented during the course. 
The project is made of four assignments that are released incrementally during the course, so that students can start working on the project before the end of classes (actually, the last assignment is released in the last lecture). 

# MicroC assignments

The project is split in the following assignments:

* **Parsing**: this assignment asks students to implement a parser for MicroC. The material is available [here](microc-parsing/); 

* **Semantic analysis**: this assignment mainly concerns the implementation of a static analysis for check that a given program obeys the scoping rule and the type system of the language. The material is available [here](microc-semantic-analysis/);

* **Code generation**: this assignment asks to use the LLVM toolchain to compile a MicroC program to low level code (LLVM bitcode) and to perform some simple optimizations. The material is available [here](microc-codegen/); 

* **Language extensions**: this assignment asks to extend the MicroC language by considering further constructs. In particular, students are required to implement **at least four** of the following constructs: 
    * `do-while` loops;
    * pre/post increment/decrement operators, i.e., `++` and `--`;
    * abbreviation for assignment operators, i.e., `+=`, `-=`, `*=`, `/=` and `%=`;
    * variable declaration with initialization, e.g., `int i = 0`;
    * multi-dimensional arrays;
    * floating point arithmetic;
    * strings as in C, i.e. null-terminated arrays of characters;
    * structs. 

To take the exam students must submit their solution, i.e., their OCaml code, the documentation of the code, and a report describing the design and the implementation choices adopted.  

