; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-bnitlbxh.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !22 {
  %1 = call noalias i8* @malloc(i64 32) #3, !dbg !25, !verifier.code !26
  %2 = bitcast i8* %1 to i32*, !dbg !27, !verifier.code !26
  call void @llvm.dbg.value(metadata i32* %2, metadata !28, metadata !DIExpression()), !dbg !29, !verifier.code !26
  %3 = getelementptr inbounds i32, i32* %2, i64 3, !dbg !30, !verifier.code !26
  store i32 10, i32* %3, align 4, !dbg !31, !verifier.code !26
  store i32 100, i32* %2, align 4, !dbg !32, !verifier.code !26
  %4 = getelementptr inbounds i32, i32* %2, i64 3, !dbg !33, !verifier.code !26
  store i32 11, i32* %4, align 4, !dbg !34, !verifier.code !26
  %5 = bitcast i32* %2 to i8*, !dbg !35, !verifier.code !26
  call void @free(i8* %5) #3, !dbg !36, !verifier.code !26
  ret i32 0, !dbg !37, !verifier.code !26
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
!llvm.ident = !{!18}
!llvm.module.flags = !{!19, !20, !21}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, globals: !6, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!7, !9, !11, !13}
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(name: "a", scope: !0, file: !1, line: 14, type: !4, isLocal: false, isDefinition: true)
!9 = !DIGlobalVariableExpression(var: !10, expr: !DIExpression())
!10 = distinct !DIGlobalVariable(name: "b", scope: !0, file: !1, line: 14, type: !4, isLocal: false, isDefinition: true)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(name: "n", scope: !0, file: !1, line: 15, type: !5, isLocal: false, isDefinition: true)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(name: "c", scope: !0, file: !1, line: 17, type: !15, isLocal: false, isDefinition: true)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !5, size: 320, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 10)
!18 = !{!"clang version 10.0.0-4ubuntu1 "}
!19 = !{i32 7, !"Dwarf Version", i32 4}
!20 = !{i32 2, !"Debug Info Version", i32 3}
!21 = !{i32 1, !"wchar_size", i32 4}
!22 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !23, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!5}
!25 = !DILocation(line: 117, column: 20, scope: !22)
!26 = !{i1 false}
!27 = !DILocation(line: 117, column: 14, scope: !22)
!28 = !DILocalVariable(name: "j", scope: !22, file: !1, line: 117, type: !4)
!29 = !DILocation(line: 0, scope: !22)
!30 = !DILocation(line: 118, column: 8, scope: !22)
!31 = !DILocation(line: 118, column: 12, scope: !22)
!32 = !DILocation(line: 119, column: 8, scope: !22)
!33 = !DILocation(line: 120, column: 8, scope: !22)
!34 = !DILocation(line: 120, column: 12, scope: !22)
!35 = !DILocation(line: 121, column: 10, scope: !22)
!36 = !DILocation(line: 121, column: 5, scope: !22)
!37 = !DILocation(line: 122, column: 1, scope: !22)
