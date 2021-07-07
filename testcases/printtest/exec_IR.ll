; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-yc1a71d2.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !21 {
  call void @llvm.dbg.value(metadata i32 10, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !26
  %1 = call noalias i8* @malloc(i64 4) #3, !dbg !27, !verifier.code !26
  %2 = bitcast i8* %1 to i32*, !dbg !27, !verifier.code !26
  call void @llvm.dbg.value(metadata i32* %2, metadata !28, metadata !DIExpression()), !dbg !25, !verifier.code !26
  %3 = icmp sgt i32 10, 10, !dbg !29, !verifier.code !26
  br i1 %3, label %4, label %6, !dbg !31, !verifier.code !26

4:                                                ; preds = %0
  %5 = bitcast i32* %2 to i8*, !dbg !32, !verifier.code !26
  call void @free(i8* %5) #3, !dbg !34, !verifier.code !26
  br label %6, !dbg !35, !verifier.code !26

6:                                                ; preds = %4, %0
  ret i32 0, !dbg !36, !verifier.code !26
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
!llvm.ident = !{!17}
!llvm.module.flags = !{!18, !19, !20}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, globals: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!4, !8, !10, !12}
!4 = !DIGlobalVariableExpression(var: !5, expr: !DIExpression())
!5 = distinct !DIGlobalVariable(name: "a", scope: !0, file: !1, line: 15, type: !6, isLocal: false, isDefinition: true)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "b", scope: !0, file: !1, line: 15, type: !6, isLocal: false, isDefinition: true)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "n", scope: !0, file: !1, line: 16, type: !7, isLocal: false, isDefinition: true)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "c", scope: !0, file: !1, line: 18, type: !14, isLocal: false, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 320, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 10)
!17 = !{!"clang version 10.0.0-4ubuntu1 "}
!18 = !{i32 7, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 21, type: !22, scopeLine: 21, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{!7}
!24 = !DILocalVariable(name: "a", scope: !21, file: !1, line: 87, type: !7)
!25 = !DILocation(line: 0, scope: !21)
!26 = !{i1 false}
!27 = !DILocation(line: 88, column: 14, scope: !21)
!28 = !DILocalVariable(name: "j", scope: !21, file: !1, line: 88, type: !6)
!29 = !DILocation(line: 89, column: 10, scope: !30)
!30 = distinct !DILexicalBlock(scope: !21, file: !1, line: 89, column: 8)
!31 = !DILocation(line: 89, column: 8, scope: !21)
!32 = !DILocation(line: 90, column: 14, scope: !33)
!33 = distinct !DILexicalBlock(scope: !30, file: !1, line: 89, column: 15)
!34 = !DILocation(line: 90, column: 9, scope: !33)
!35 = !DILocation(line: 91, column: 5, scope: !33)
!36 = !DILocation(line: 107, column: 5, scope: !21)
