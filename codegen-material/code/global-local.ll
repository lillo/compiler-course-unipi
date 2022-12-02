; ModuleID = 'global.c'
source_filename = "constants.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@foo = global i32 42

define dso_local void @bar(i32 %0) #0 {
  %2 = load i32, i32* @foo
  %3 = add i32 %2, 7
  ret void
}