; ModuleID = '/home/center/Documents/SmackBasedPrj/build/b-vrj5jsu5.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 0, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 0, metadata !14, metadata !DIExpression()), !dbg !16, !verifier.code !13
  br label %1, !dbg !17, !verifier.code !13

1:                                                ; preds = %15, %0
  %.02 = phi i32 [ 0, %0 ], [ %16, %15 ], !dbg !16, !verifier.code !13
  %.01 = phi i32 [ 0, %0 ], [ %.1, %15 ], !dbg !18, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.01, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.02, metadata !14, metadata !DIExpression()), !dbg !16, !verifier.code !13
  %2 = icmp slt i32 %.02, 6, !dbg !19, !verifier.code !13
  br i1 %2, label %3, label %17, !dbg !21, !verifier.code !13

3:                                                ; preds = %1
  %4 = icmp slt i32 %.02, 2, !dbg !22, !verifier.code !13
  br i1 %4, label %5, label %6, !dbg !25, !verifier.code !13

5:                                                ; preds = %3
  br label %15, !dbg !26, !verifier.code !13

6:                                                ; preds = %3
  %7 = add nsw i32 %.01, 1, !dbg !28, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %7, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.02, metadata !29, metadata !DIExpression()), !dbg !31, !verifier.code !13
  br label %8, !dbg !32, !verifier.code !13

8:                                                ; preds = %12, %6
  %.0 = phi i32 [ %.02, %6 ], [ %13, %12 ], !dbg !31, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.0, metadata !29, metadata !DIExpression()), !dbg !31, !verifier.code !13
  %9 = icmp slt i32 %.0, %7, !dbg !33, !verifier.code !13
  br i1 %9, label %10, label %14, !dbg !35, !verifier.code !13

10:                                               ; preds = %8
  %11 = add nsw i32 %.0, 1, !dbg !36, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %11, metadata !29, metadata !DIExpression()), !dbg !31, !verifier.code !13
  br label %12, !dbg !38, !verifier.code !13

12:                                               ; preds = %10
  %13 = add nsw i32 %11, 1, !dbg !39, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %13, metadata !29, metadata !DIExpression()), !dbg !31, !verifier.code !13
  br label %8, !dbg !40, !llvm.loop !41, !verifier.code !13

14:                                               ; preds = %8
  br label %15, !dbg !43, !verifier.code !13

15:                                               ; preds = %14, %5
  %.1 = phi i32 [ %.01, %5 ], [ %7, %14 ], !dbg !12, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.1, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  %16 = add nsw i32 %.02, 1, !dbg !44, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %16, metadata !14, metadata !DIExpression()), !dbg !16, !verifier.code !13
  br label %1, !dbg !45, !llvm.loop !46, !verifier.code !13

17:                                               ; preds = %1
  ret i32 0, !dbg !48, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 10.0.1-++20210313014558+ef32c611aa21-1~exp1~20210313125203.63", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/test3.c", directory: "/home/center/Documents/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"Ubuntu clang version 10.0.1-++20210313014558+ef32c611aa21-1~exp1~20210313125203.63"}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !8, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "sum", scope: !7, file: !1, line: 6, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !{i1 false}
!14 = !DILocalVariable(name: "i", scope: !15, file: !1, line: 7, type: !10)
!15 = distinct !DILexicalBlock(scope: !7, file: !1, line: 7, column: 5)
!16 = !DILocation(line: 0, scope: !15)
!17 = !DILocation(line: 7, column: 10, scope: !15)
!18 = !DILocation(line: 6, column: 9, scope: !7)
!19 = !DILocation(line: 7, column: 23, scope: !20)
!20 = distinct !DILexicalBlock(scope: !15, file: !1, line: 7, column: 5)
!21 = !DILocation(line: 7, column: 5, scope: !15)
!22 = !DILocation(line: 8, column: 15, scope: !23)
!23 = distinct !DILexicalBlock(scope: !24, file: !1, line: 8, column: 13)
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 7, column: 34)
!25 = !DILocation(line: 8, column: 13, scope: !24)
!26 = !DILocation(line: 9, column: 13, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 8, column: 20)
!28 = !DILocation(line: 11, column: 13, scope: !24)
!29 = !DILocalVariable(name: "j", scope: !30, file: !1, line: 12, type: !10)
!30 = distinct !DILexicalBlock(scope: !24, file: !1, line: 12, column: 9)
!31 = !DILocation(line: 0, scope: !30)
!32 = !DILocation(line: 12, column: 14, scope: !30)
!33 = !DILocation(line: 12, column: 27, scope: !34)
!34 = distinct !DILexicalBlock(scope: !30, file: !1, line: 12, column: 9)
!35 = !DILocation(line: 12, column: 9, scope: !30)
!36 = !DILocation(line: 13, column: 15, scope: !37)
!37 = distinct !DILexicalBlock(scope: !34, file: !1, line: 12, column: 40)
!38 = !DILocation(line: 14, column: 9, scope: !37)
!39 = !DILocation(line: 12, column: 34, scope: !34)
!40 = !DILocation(line: 12, column: 9, scope: !34)
!41 = distinct !{!41, !35, !42}
!42 = !DILocation(line: 14, column: 9, scope: !30)
!43 = !DILocation(line: 15, column: 5, scope: !24)
!44 = !DILocation(line: 7, column: 28, scope: !20)
!45 = !DILocation(line: 7, column: 5, scope: !20)
!46 = distinct !{!46, !21, !47}
!47 = !DILocation(line: 15, column: 5, scope: !15)
!48 = !DILocation(line: 17, column: 5, scope: !7)