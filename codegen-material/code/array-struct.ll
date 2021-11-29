; ModuleID = 'array.c'
source_filename = "array.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.person = type { i32, [25 x i8], i32 }

@numbers = dso_local global [10 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [25 x i8] c"This is a literal string\00", align 1
@str = dso_local global i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i32 0, i32 0), align 8
@bob = dso_local global %struct.person { i32 1, [25 x i8] c"Bob Smith\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", i32 20 }, align 4
@matrix = common dso_local global [4 x [4 x i32]] zeroinitializer, align 16

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1~18.04.2 "}
