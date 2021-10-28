; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build/b-d3gluy20.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca %struct.TData, align 8, !verifier.code !11
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !12, metadata !DIExpression()), !dbg !19, !verifier.code !11
  call void @llvm.dbg.value(metadata i32 4, metadata !20, metadata !DIExpression()), !dbg !21, !verifier.code !11
  call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !24, !verifier.code !11
  br label %2, !dbg !25, !verifier.code !11

2:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !24, !verifier.code !11
  call void @main0_bb(%struct.TData* %1), !dbg !26, !verifier.code !11
  br label %3, !dbg !29, !verifier.code !11

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 1, metadata !22, metadata !DIExpression()), !dbg !24, !verifier.code !11
  call void @main0_bb(%struct.TData* %1), !dbg !26, !verifier.code !11
  br label %4, !dbg !29, !verifier.code !11

4:                                                ; preds = %3
  call void @llvm.dbg.value(metadata i32 2, metadata !22, metadata !DIExpression()), !dbg !24, !verifier.code !11
  call void @main0_bb(%struct.TData* %1), !dbg !26, !verifier.code !11
  br label %5, !dbg !29, !verifier.code !11

5:                                                ; preds = %4
  call void @llvm.dbg.value(metadata i32 3, metadata !22, metadata !DIExpression()), !dbg !24, !verifier.code !11
  call void @main0_bb(%struct.TData* %1), !dbg !26, !verifier.code !11
  br label %6, !dbg !29, !verifier.code !11

6:                                                ; preds = %5
  call void @llvm.dbg.value(metadata i32 4, metadata !22, metadata !DIExpression()), !dbg !24, !verifier.code !11
  ret i32 0, !dbg !30, !verifier.code !11
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @main0_bb(%struct.TData* %0) #0 !dbg !31 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !11
  %2 = call noalias i8* @malloc(i64 4) #3, !dbg !37, !verifier.code !11
  %3 = bitcast i8* %2 to i32*, !dbg !37, !verifier.code !11
  call void @llvm.dbg.value(metadata i32* %3, metadata !38, metadata !DIExpression()), !dbg !36, !verifier.code !11
  ret void, !dbg !40, !verifier.code !11
}

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
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 22, type: !8, scopeLine: 22, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i1 false}
!12 = !DILocalVariable(name: "data", scope: !7, file: !1, line: 23, type: !13)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !1, line: 6, baseType: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 3, size: 128, elements: !15)
!15 = !{!16, !18}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !14, file: !1, line: 4, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !14, file: !1, line: 5, baseType: !17, size: 64, offset: 64)
!19 = !DILocation(line: 23, column: 11, scope: !7)
!20 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 24, type: !10)
!21 = !DILocation(line: 0, scope: !7)
!22 = !DILocalVariable(name: "i", scope: !23, file: !1, line: 25, type: !10)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 25, column: 5)
!24 = !DILocation(line: 0, scope: !23)
!25 = !DILocation(line: 25, column: 5, scope: !23)
!26 = !DILocation(line: 26, column: 9, scope: !27)
!27 = distinct !DILexicalBlock(scope: !28, file: !1, line: 25, column: 31)
!28 = distinct !DILexicalBlock(scope: !23, file: !1, line: 25, column: 5)
!29 = !DILocation(line: 27, column: 5, scope: !27)
!30 = !DILocation(line: 28, column: 5, scope: !7)
!31 = distinct !DISubprogram(name: "main0_bb", scope: !1, file: !1, line: 7, type: !32, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !34}
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!35 = !DILocalVariable(name: "pdata", arg: 1, scope: !31, file: !1, line: 7, type: !34)
!36 = !DILocation(line: 0, scope: !31)
!37 = !DILocation(line: 9, column: 14, scope: !31)
!38 = !DILocalVariable(name: "i", scope: !31, file: !1, line: 9, type: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!40 = !DILocation(line: 10, column: 1, scope: !31)
