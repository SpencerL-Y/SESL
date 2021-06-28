; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-jvwhf68y.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca [10 x i32], align 16, !verifier.code !11
  call void @llvm.dbg.declare(metadata [10 x i32]* %1, metadata !12, metadata !DIExpression()), !dbg !16, !verifier.code !11
  call void @llvm.dbg.value(metadata i32 101, metadata !17, metadata !DIExpression()), !dbg !18, !verifier.code !11
  %2 = add nsw i32 101, 1, !dbg !19, !verifier.code !11
  %3 = zext i32 %2 to i64, !dbg !20, !verifier.code !11
  %4 = call i8* @llvm.stacksave(), !dbg !20, !verifier.code !11
  %5 = alloca i32, i64 %3, align 16, !dbg !20, !verifier.code !11
  call void @llvm.dbg.value(metadata i64 %3, metadata !21, metadata !DIExpression()), !dbg !18, !verifier.code !11
  call void @llvm.dbg.declare(metadata i32* %5, metadata !23, metadata !DIExpression()), !dbg !27, !verifier.code !11
  %6 = getelementptr inbounds [10 x i32], [10 x i32]* %1, i64 0, i64 2, !dbg !28, !verifier.code !11
  store i32 111, i32* %6, align 8, !dbg !29, !verifier.code !11
  %7 = getelementptr inbounds i32, i32* %5, i64 3, !dbg !30, !verifier.code !11
  store i32 222, i32* %7, align 4, !dbg !31, !verifier.code !11
  %8 = getelementptr inbounds [10 x i32], [10 x i32]* %1, i64 0, i64 1, !dbg !32, !verifier.code !11
  %9 = load i32, i32* %8, align 4, !dbg !32, !verifier.code !11
  call void @llvm.dbg.value(metadata i32 %9, metadata !33, metadata !DIExpression()), !dbg !18, !verifier.code !11
  call void @llvm.stackrestore(i8* %4), !dbg !34, !verifier.code !11
  ret i32 0, !dbg !34, !verifier.code !11
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #2

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !8, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i1 false}
!12 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 52, type: !13)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 320, elements: !14)
!14 = !{!15}
!15 = !DISubrange(count: 10)
!16 = !DILocation(line: 52, column: 9, scope: !7)
!17 = !DILocalVariable(name: "num", scope: !7, file: !1, line: 53, type: !10)
!18 = !DILocation(line: 0, scope: !7)
!19 = !DILocation(line: 54, column: 14, scope: !7)
!20 = !DILocation(line: 54, column: 5, scope: !7)
!21 = !DILocalVariable(name: "__vla_expr0", scope: !7, type: !22, flags: DIFlagArtificial)
!22 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!23 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 54, type: !24)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, elements: !25)
!25 = !{!26}
!26 = !DISubrange(count: !21)
!27 = !DILocation(line: 54, column: 9, scope: !7)
!28 = !DILocation(line: 55, column: 5, scope: !7)
!29 = !DILocation(line: 55, column: 10, scope: !7)
!30 = !DILocation(line: 56, column: 5, scope: !7)
!31 = !DILocation(line: 56, column: 10, scope: !7)
!32 = !DILocation(line: 57, column: 19, scope: !7)
!33 = !DILocalVariable(name: "newname", scope: !7, file: !1, line: 57, type: !10)
!34 = !DILocation(line: 58, column: 1, scope: !7)
