; We defines the LLVM module for add.c file. An LLVM module is 
; a top–level data structure that has the entire contents of the 
; input LLVM file. It consists of functions, global variables, 
; external function prototypes, and symbol table entries.
; ModuleID = 'add.c'

; The following lines show the target data layout and target triple from which we can know
; that the target is x86_64 processor with Linux running on it. 

source_filename = "add.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; We define a global variable: all globals start with ‘@‘ 
; It is a i32 integer and it is initialized to 2 and it is aligned to 4 bytes in memory
; dso_local attribute means the symbol will resolve to a definition within the current linkage unit 
@global_var = dso_local global i32 2, align 4

; We define a function called @sum that takes an i32 and returns a i32
; local identifiers start with '%' (usually registers)
; note: we have to allocate local variables explicitly  
; here registers are denoted by numbers
; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @sum(i32 %0) #0 {
  %2 = alloca i32, align 4                ; allocate an i32 integer on the stack for storing the value of the parameter
  store i32 %0, i32* %2, align 4          ; store the value of the parameter inside the new memory location
  %3 = load i32, i32* %2, align 4         ; load the value of the local variable in the register %3
  %4 = load i32, i32* @global_var, align 4 ; load the value of the global variable in the register %4
  %5 = add nsw i32 %3, %4                  ; compute the sum of %3 e %4 (note the type i32) and stores it in %5 
  ret i32 %5                              ; return the value stored in register %5 (note the type i32) 
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1~18.04.2 "}
