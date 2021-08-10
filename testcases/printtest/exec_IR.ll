; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-4h1mzgej.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !21 {
  %1 = alloca [2 x i8*], align 16, !verifier.code !24
  call void @llvm.dbg.declare(metadata [2 x i8*]* %1, metadata !25, metadata !DIExpression()), !dbg !30, !verifier.code !24
  %2 = call noalias i8* @malloc(i64 4) #3, !dbg !31, !verifier.code !24
  %3 = getelementptr inbounds [2 x i8*], [2 x i8*]* %1, i64 0, i64 1, !dbg !32, !verifier.code !24
  store i8* %2, i8** %3, align 8, !dbg !33, !verifier.code !24
  %4 = bitcast [2 x i8*]* %1 to i8*, !dbg !34, !verifier.code !24
  %5 = getelementptr inbounds [2 x i8*], [2 x i8*]* %1, i64 0, i64 1, !dbg !35, !verifier.code !24
  store i8* %4, i8** %5, align 8, !dbg !36, !verifier.code !24
  %6 = getelementptr inbounds [2 x i8*], [2 x i8*]* %1, i64 0, i64 1, !dbg !37, !verifier.code !24
  %7 = load i8*, i8** %6, align 8, !dbg !37, !verifier.code !24
  call void @free(i8* %7) #3, !dbg !38, !verifier.code !24
  ret i32 0, !dbg !39, !verifier.code !24
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

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
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !8, !10, !12}
!4 = !DIGlobalVariableExpression(var: !5, expr: !DIExpression())
!5 = distinct !DIGlobalVariable(name: "a", scope: !0, file: !1, line: 14, type: !6, isLocal: false, isDefinition: true)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "b", scope: !0, file: !1, line: 14, type: !6, isLocal: false, isDefinition: true)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "n", scope: !0, file: !1, line: 15, type: !7, isLocal: false, isDefinition: true)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "c", scope: !0, file: !1, line: 17, type: !14, isLocal: false, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 320, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 10)
!17 = !{!"clang version 10.0.0-4ubuntu1 "}
!18 = !{i32 7, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !22, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{!7}
!24 = !{i1 false}
!25 = !DILocalVariable(name: "a", scope: !21, file: !1, line: 117, type: !26)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, size: 128, elements: !28)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!28 = !{!29}
!29 = !DISubrange(count: 2)
!30 = !DILocation(line: 117, column: 11, scope: !21)
!31 = !DILocation(line: 118, column: 12, scope: !21)
!32 = !DILocation(line: 118, column: 5, scope: !21)
!33 = !DILocation(line: 118, column: 10, scope: !21)
!34 = !DILocation(line: 119, column: 12, scope: !21)
!35 = !DILocation(line: 119, column: 5, scope: !21)
!36 = !DILocation(line: 119, column: 10, scope: !21)
!37 = !DILocation(line: 120, column: 10, scope: !21)
!38 = !DILocation(line: 120, column: 5, scope: !21)
!39 = !DILocation(line: 121, column: 1, scope: !21)
