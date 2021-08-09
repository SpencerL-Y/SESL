; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-_xxpeam5.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !10 {
  %1 = call noalias i8* @malloc(i64 4) #3, !dbg !13, !verifier.code !14
  %2 = bitcast i8* %1 to i32*, !dbg !15, !verifier.code !14
  call void @llvm.dbg.value(metadata i32* %2, metadata !16, metadata !DIExpression()), !dbg !17, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 2, metadata !18, metadata !DIExpression()), !dbg !17, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 2, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 2, metadata !20, metadata !DIExpression()), !dbg !17, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 3, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 3, metadata !18, metadata !DIExpression()), !dbg !17, !verifier.code !14
  %3 = load i32, i32* %2, align 4, !dbg !22, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 %3, metadata !23, metadata !DIExpression()), !dbg !17, !verifier.code !14
  %4 = getelementptr inbounds i32, i32* %2, i32 1, !dbg !24, !verifier.code !14
  call void @llvm.dbg.value(metadata i32* %4, metadata !16, metadata !DIExpression()), !dbg !17, !verifier.code !14
  %5 = add nsw i32 3, 1, !dbg !25, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 %5, metadata !18, metadata !DIExpression()), !dbg !17, !verifier.code !14
  %6 = add nsw i32 %5, 1, !dbg !26, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 %6, metadata !18, metadata !DIExpression()), !dbg !17, !verifier.code !14
  ret i32 0, !dbg !27, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

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
!1 = !DIFile(filename: "../testcases/printtest/test1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !11, scopeLine: 6, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5}
!13 = !DILocation(line: 7, column: 20, scope: !10)
!14 = !{i1 false}
!15 = !DILocation(line: 7, column: 14, scope: !10)
!16 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 7, type: !4)
!17 = !DILocation(line: 0, scope: !10)
!18 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 8, type: !5)
!19 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 9, type: !5)
!20 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 10, type: !5)
!21 = !DILocalVariable(name: "d", scope: !10, file: !1, line: 11, type: !5)
!22 = !DILocation(line: 13, column: 13, scope: !10)
!23 = !DILocalVariable(name: "p", scope: !10, file: !1, line: 13, type: !5)
!24 = !DILocation(line: 14, column: 7, scope: !10)
!25 = !DILocation(line: 15, column: 11, scope: !10)
!26 = !DILocation(line: 16, column: 7, scope: !10)
!27 = !DILocation(line: 18, column: 5, scope: !10)
