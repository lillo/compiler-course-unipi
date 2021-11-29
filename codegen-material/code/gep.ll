; ModuleID = 'gep.c'
source_filename = "gep.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.person = type { [20 x i8], i32 }

@ptr = dso_local local_unnamed_addr global i32* inttoptr (i64 1 to i32*), align 8
@array = dso_local local_unnamed_addr global [3 x i32] [i32 1, i32 2, i32 3], align 4
@matrix = dso_local local_unnamed_addr global [3 x [3 x i32]] zeroinitializer, align 16
@p = common dso_local local_unnamed_addr global %struct.person zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly uwtable
define dso_local i32 @get_elem_ptr(i32 %0) local_unnamed_addr #0 {
  %2 = load i32*, i32** @ptr, align 8, !tbaa !2
  %3 = sext i32 %0 to i64
  %4 = getelementptr inbounds i32, i32* %2, i64 %3
  %5 = load i32, i32* %4, align 4, !tbaa !6
  ret i32 %5
}

; Function Attrs: norecurse nounwind readonly uwtable
define dso_local i32 @get_elem_ar(i32 %0) local_unnamed_addr #0 {
  %2 = sext i32 %0 to i64
  %3 = getelementptr inbounds [3 x i32], [3 x i32]* @array, i64 0, i64 %2
  %4 = load i32, i32* %3, align 4, !tbaa !6
  ret i32 %4
}

; Function Attrs: norecurse nounwind readonly uwtable
define dso_local i32 @get_age() local_unnamed_addr #0 {
  %1 = load i32, i32* getelementptr inbounds (%struct.person, %struct.person* @p, i64 0, i32 1), align 4, !tbaa !8
  ret i32 %1
}

; Function Attrs: norecurse nounwind readonly uwtable
define dso_local i32 @get_elem_m(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* @matrix, i64 0, i64 %0, i64 %1
  %4 = load i32, i32* %3, align 4, !tbaa !6
  ret i32 %4
}

attributes #0 = { norecurse nounwind readonly uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1~18.04.2 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !4, i64 0}
!8 = !{!9, !7, i64 20}
!9 = !{!"person", !4, i64 0, !7, i64 20}
