; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-rpo_wal5.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node* }

; Function Attrs: noinline nounwind uwtable
define internal void @myexit(i32 %0) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !18, metadata !DIExpression()), !dbg !19, !verifier.code !20
  br label %2, !dbg !21, !verifier.code !20

2:                                                ; preds = %2, %1
  call void @llvm.dbg.label(metadata !22), !dbg !23, !verifier.code !20
  br label %2, !dbg !24, !verifier.code !20
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @alloc_node() #0 !dbg !25 {
  %1 = call noalias i8* @malloc(i64 8) #4, !dbg !28, !verifier.code !20
  %2 = bitcast i8* %1 to %struct.node*, !dbg !29, !verifier.code !20
  call void @llvm.dbg.value(metadata %struct.node* %2, metadata !30, metadata !DIExpression()), !dbg !31, !verifier.code !20
  %3 = icmp eq %struct.node* null, %2, !dbg !32, !verifier.code !20
  br i1 %3, label %4, label %5, !dbg !34, !verifier.code !20

4:                                                ; preds = %0
  call void @myexit(i32 1), !dbg !35, !verifier.code !20
  br label %5, !dbg !37, !verifier.code !20

5:                                                ; preds = %4, %0
  ret %struct.node* %2, !dbg !38, !verifier.code !20
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !39 {
  %1 = call %struct.node* @alloc_node(), !dbg !42, !verifier.code !20
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !43, metadata !DIExpression()), !dbg !44, !verifier.code !20
  %2 = call %struct.node* @alloc_node(), !dbg !45, !verifier.code !20
  %3 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 0, !dbg !46, !verifier.code !20
  store %struct.node* %2, %struct.node** %3, align 8, !dbg !47, !verifier.code !20
  %4 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 0, !dbg !48, !verifier.code !20
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !48, !verifier.code !20
  %6 = bitcast %struct.node* %1 to i8*, !dbg !49, !verifier.code !20
  %7 = bitcast %struct.node* %5 to i8*, !dbg !49, !verifier.code !20
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %6, i8* align 8 %7, i64 8, i1 false), !dbg !49, !verifier.code !20
  %8 = bitcast %struct.node* %1 to i8*, !dbg !50, !verifier.code !20
  call void @free(i8* %8) #4, !dbg !51, !verifier.code !20
  ret i32 0, !dbg !52, !verifier.code !20
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

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
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!10}
!llvm.module.flags = !{!11, !12, !13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/sll_shallow_copy-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !9}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !6, line: 8, size: 64, elements: !7)
!6 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//sll_shallow_copy-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!7 = !{!8}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !5, file: !6, line: 9, baseType: !4, size: 64)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!10 = !{!"clang version 10.0.0-4ubuntu1 "}
!11 = !{i32 7, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = distinct !DISubprogram(name: "myexit", scope: !6, file: !6, line: 12, type: !15, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocalVariable(name: "s", arg: 1, scope: !14, file: !6, line: 12, type: !17)
!19 = !DILocation(line: 0, scope: !14)
!20 = !{i1 false}
!21 = !DILocation(line: 12, column: 20, scope: !14)
!22 = !DILabel(scope: !14, name: "_EXIT", file: !6, line: 13)
!23 = !DILocation(line: 13, column: 2, scope: !14)
!24 = !DILocation(line: 13, column: 9, scope: !14)
!25 = distinct !DISubprogram(name: "alloc_node", scope: !6, file: !6, line: 16, type: !26, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!4}
!28 = !DILocation(line: 17, column: 38, scope: !25)
!29 = !DILocation(line: 17, column: 23, scope: !25)
!30 = !DILocalVariable(name: "temp", scope: !25, file: !6, line: 17, type: !4)
!31 = !DILocation(line: 0, scope: !25)
!32 = !DILocation(line: 18, column: 11, scope: !33)
!33 = distinct !DILexicalBlock(scope: !25, file: !6, line: 18, column: 6)
!34 = !DILocation(line: 18, column: 6, scope: !25)
!35 = !DILocation(line: 19, column: 5, scope: !36)
!36 = distinct !DILexicalBlock(scope: !33, file: !6, line: 18, column: 20)
!37 = !DILocation(line: 20, column: 3, scope: !36)
!38 = !DILocation(line: 21, column: 3, scope: !25)
!39 = distinct !DISubprogram(name: "main", scope: !6, file: !6, line: 24, type: !40, scopeLine: 24, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!17}
!42 = !DILocation(line: 26, column: 20, scope: !39)
!43 = !DILocalVariable(name: "s", scope: !39, file: !6, line: 26, type: !4)
!44 = !DILocation(line: 0, scope: !39)
!45 = !DILocation(line: 27, column: 13, scope: !39)
!46 = !DILocation(line: 27, column: 6, scope: !39)
!47 = !DILocation(line: 27, column: 11, scope: !39)
!48 = !DILocation(line: 30, column: 13, scope: !39)
!49 = !DILocation(line: 30, column: 8, scope: !39)
!50 = !DILocation(line: 31, column: 8, scope: !39)
!51 = !DILocation(line: 31, column: 3, scope: !39)
!52 = !DILocation(line: 33, column: 3, scope: !39)
