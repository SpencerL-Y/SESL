; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build/b-_r_j6wqx.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !10 {
  call void @llvm.dbg.value(metadata i32 undef, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  br i1 false, label %.lr.ph, label %14, !dbg !16, !verifier.code !15

.lr.ph:                                           ; preds = %0
  br label %1, !dbg !16, !verifier.code !15

1:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi i32 [ undef, %.lr.ph ], [ %12, %forwarder ], !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.01, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 5, metadata !17, metadata !DIExpression()), !dbg !19, !verifier.code !15
  %2 = sext i32 5 to i64, !dbg !20, !verifier.code !15
  %3 = mul i64 %2, 4, !dbg !21, !verifier.code !15
  %4 = call noalias i8* @malloc(i64 %3) #3, !dbg !22, !verifier.code !15
  %5 = bitcast i8* %4 to i32*, !dbg !23, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %5, metadata !24, metadata !DIExpression()), !dbg !19, !verifier.code !15
  %6 = add nsw i32 5, -1, !dbg !25, !verifier.code !15
  %7 = getelementptr inbounds i32, i32* %5, i64 1, !dbg !26, !verifier.code !15
  store i32 %6, i32* %7, align 4, !dbg !27, !verifier.code !15
  %8 = getelementptr inbounds i32, i32* %5, i64 1, !dbg !28, !verifier.code !15
  %9 = load i32, i32* %8, align 4, !dbg !29, !verifier.code !15
  %10 = add nsw i32 %9, -1, !dbg !30, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %10, metadata !31, metadata !DIExpression()), !dbg !19, !verifier.code !15
  %11 = bitcast i32* %5 to i8*, !dbg !32, !verifier.code !15
  call void @free(i8* %11) #3, !dbg !33, !verifier.code !15
  %12 = add nsw i32 %.01, 1, !dbg !34, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %12, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %13 = icmp slt i32 %12, 10, !dbg !35, !verifier.code !15
  br i1 %13, label %forwarder, label %._crit_edge, !dbg !16, !llvm.loop !36, !verifier.code !15

._crit_edge:                                      ; preds = %1
  br label %14, !dbg !16, !verifier.code !15

14:                                               ; preds = %._crit_edge, %0
  ret i32 0, !dbg !38, !verifier.code !15

forwarder:                                        ; preds = %1
  br label %1, !verifier.code !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!6}
!llvm.module.flags = !{!7, !8, !9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 153, type: !11, scopeLine: 153, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5}
!13 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 154, type: !5)
!14 = !DILocation(line: 0, scope: !10)
!15 = !{i1 false}
!16 = !DILocation(line: 155, column: 5, scope: !10)
!17 = !DILocalVariable(name: "num", scope: !18, file: !1, line: 156, type: !5)
!18 = distinct !DILexicalBlock(scope: !10, file: !1, line: 155, column: 18)
!19 = !DILocation(line: 0, scope: !18)
!20 = !DILocation(line: 157, column: 31, scope: !18)
!21 = !DILocation(line: 157, column: 34, scope: !18)
!22 = !DILocation(line: 157, column: 24, scope: !18)
!23 = !DILocation(line: 157, column: 18, scope: !18)
!24 = !DILocalVariable(name: "j", scope: !18, file: !1, line: 157, type: !4)
!25 = !DILocation(line: 158, column: 22, scope: !18)
!26 = !DILocation(line: 158, column: 12, scope: !18)
!27 = !DILocation(line: 158, column: 16, scope: !18)
!28 = !DILocation(line: 159, column: 23, scope: !18)
!29 = !DILocation(line: 159, column: 20, scope: !18)
!30 = !DILocation(line: 159, column: 27, scope: !18)
!31 = !DILocalVariable(name: "nnum", scope: !18, file: !1, line: 159, type: !5)
!32 = !DILocation(line: 160, column: 14, scope: !18)
!33 = !DILocation(line: 160, column: 9, scope: !18)
!34 = !DILocation(line: 161, column: 10, scope: !18)
!35 = !DILocation(line: 155, column: 13, scope: !10)
!36 = distinct !{!36, !16, !37}
!37 = !DILocation(line: 162, column: 5, scope: !10)
!38 = !DILocation(line: 163, column: 5, scope: !10)
