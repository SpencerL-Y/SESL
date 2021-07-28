; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-uzteeu2l.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

; Function Attrs: noinline nounwind uwtable
define internal i32 @recursive(i32 %0) #1 !dbg !11 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !14, metadata !DIExpression()), !dbg !15, !verifier.code !16
  %2 = icmp eq i32 %0, 1, !dbg !17, !verifier.code !16
  br i1 %2, label %3, label %4, !dbg !19, !verifier.code !16

3:                                                ; preds = %1
  br label %8, !dbg !20, !verifier.code !16

4:                                                ; preds = %1
  %5 = sub nsw i32 %0, 1, !dbg !21, !verifier.code !16
  %6 = call i32 @recursive(i32 %5), !dbg !22, !verifier.code !16
  %7 = add nsw i32 %6, 1, !dbg !23, !verifier.code !16
  br label %8, !dbg !24, !verifier.code !16

8:                                                ; preds = %4, %3
  %.0 = phi i32 [ 1, %3 ], [ %7, %4 ], !dbg !25, !verifier.code !16
  ret i32 %.0, !dbg !26, !verifier.code !16
}

; Function Attrs: noinline nounwind uwtable
define internal void @test_2() #1 !dbg !27 {
  %1 = call i32 @recursive(i32 2), !dbg !30, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 %1, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !16
  ret void, !dbg !33, !verifier.code !16
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #1 !dbg !34 {
  call void @test_2(), !dbg !37, !verifier.code !16
  ret i32 0, !dbg !38, !verifier.code !16
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #0

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!7}
!llvm.module.flags = !{!8, !9, !10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/test_with_function.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !6}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "recursive", scope: !1, file: !1, line: 37, type: !12, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{!5, !5}
!14 = !DILocalVariable(name: "n", arg: 1, scope: !11, file: !1, line: 37, type: !5)
!15 = !DILocation(line: 0, scope: !11)
!16 = !{i1 false}
!17 = !DILocation(line: 38, column: 11, scope: !18)
!18 = distinct !DILexicalBlock(scope: !11, file: !1, line: 38, column: 9)
!19 = !DILocation(line: 38, column: 9, scope: !11)
!20 = !DILocation(line: 38, column: 17, scope: !18)
!21 = !DILocation(line: 39, column: 29, scope: !18)
!22 = !DILocation(line: 39, column: 17, scope: !18)
!23 = !DILocation(line: 39, column: 34, scope: !18)
!24 = !DILocation(line: 39, column: 10, scope: !18)
!25 = !DILocation(line: 0, scope: !18)
!26 = !DILocation(line: 40, column: 1, scope: !11)
!27 = distinct !DISubprogram(name: "test_2", scope: !1, file: !1, line: 42, type: !28, scopeLine: 42, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{null}
!30 = !DILocation(line: 43, column: 13, scope: !27)
!31 = !DILocalVariable(name: "t", scope: !27, file: !1, line: 43, type: !5)
!32 = !DILocation(line: 0, scope: !27)
!33 = !DILocation(line: 48, column: 1, scope: !27)
!34 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 131, type: !35, scopeLine: 131, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!5}
!37 = !DILocation(line: 134, column: 5, scope: !34)
!38 = !DILocation(line: 139, column: 5, scope: !34)
