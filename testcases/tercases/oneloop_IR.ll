; ModuleID = '/home/fengwz/Desktop/Smack/SmackBasedPrj/bin/b-vicwpwl3.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 5, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  br label %1, !dbg !14, !verifier.code !13

1:                                                ; preds = %3, %0
  %.0 = phi i32 [ 5, %0 ], [ %4, %3 ], !dbg !12, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.0, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  %2 = icmp sgt i32 %.0, 0, !dbg !15, !verifier.code !13
  br i1 %2, label %3, label %5, !dbg !14, !verifier.code !13

3:                                                ; preds = %1
  %4 = add nsw i32 %.0, -1, !dbg !16, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %4, metadata !11, metadata !DIExpression()), !dbg !12, !verifier.code !13
  br label %1, !dbg !14, !llvm.loop !18, !verifier.code !13

5:                                                ; preds = %1
  ret i32 0, !dbg !20, !verifier.code !13
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

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/tercases/oneloop.c", directory: "/home/fengwz/Desktop/Smack/SmackBasedPrj/bin")
!2 = !{}
!3 = !{!"clang version 10.0.1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 4, type: !10)
!12 = !DILocation(line: 0, scope: !7)
!13 = !{i1 false}
!14 = !DILocation(line: 5, column: 3, scope: !7)
!15 = !DILocation(line: 5, column: 12, scope: !7)
!16 = !DILocation(line: 7, column: 8, scope: !17)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 3)
!18 = distinct !{!18, !14, !19}
!19 = !DILocation(line: 8, column: 3, scope: !7)
!20 = !DILocation(line: 9, column: 3, scope: !7)