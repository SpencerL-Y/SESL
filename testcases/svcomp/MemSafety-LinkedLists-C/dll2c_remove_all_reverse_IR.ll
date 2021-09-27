; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-i35n2qmf.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, %struct.node*, i32 }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !18 {
  ret void, !dbg !21, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define internal void @myexit(i32 %0) #0 !dbg !23 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !26, metadata !DIExpression()), !dbg !27, !verifier.code !22
  br label %2, !dbg !28, !verifier.code !22

2:                                                ; preds = %2, %1
  call void @llvm.dbg.label(metadata !29), !dbg !30, !verifier.code !22
  br label %2, !dbg !31, !verifier.code !22
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @node_create(i32 %0) #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %2 = call noalias i8* @malloc(i64 24) #4, !dbg !37, !verifier.code !22
  %3 = bitcast i8* %2 to %struct.node*, !dbg !38, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !39, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %4 = icmp eq %struct.node* null, %3, !dbg !40, !verifier.code !22
  br i1 %4, label %5, label %6, !dbg !42, !verifier.code !22

5:                                                ; preds = %1
  call void @myexit(i32 1), !dbg !43, !verifier.code !22
  br label %6, !dbg !45, !verifier.code !22

6:                                                ; preds = %5, %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !46, !verifier.code !22
  store %struct.node* null, %struct.node** %7, align 8, !dbg !47, !verifier.code !22
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !48, !verifier.code !22
  store %struct.node* null, %struct.node** %8, align 8, !dbg !49, !verifier.code !22
  %9 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, !dbg !50, !verifier.code !22
  store i32 %0, i32* %9, align 8, !dbg !51, !verifier.code !22
  ret %struct.node* %3, !dbg !52, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @dll_circular_create(i32 %0, i32 %1) #0 !dbg !53 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !58, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %3 = call %struct.node* @node_create(i32 %1), !dbg !59, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !60, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !61, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %0, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %4 = icmp sgt i32 %0, 1, !dbg !62, !verifier.code !22
  br i1 %4, label %.lr.ph, label %14, !dbg !63, !verifier.code !22

.lr.ph:                                           ; preds = %2
  br label %5, !dbg !63, !verifier.code !22

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %12, %forwarder ], !verifier.code !22
  %.012 = phi %struct.node* [ %3, %.lr.ph ], [ %6, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.03, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.012, metadata !60, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %6 = call %struct.node* @node_create(i32 %1), !dbg !64, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !66, metadata !DIExpression()), !dbg !67, !verifier.code !22
  %7 = getelementptr inbounds %struct.node, %struct.node* %6, i32 0, i32 0, !dbg !68, !verifier.code !22
  store %struct.node* %.012, %struct.node** %7, align 8, !dbg !69, !verifier.code !22
  %8 = icmp ne %struct.node* %.012, null, !dbg !70, !verifier.code !22
  br i1 %8, label %9, label %11, !dbg !72, !verifier.code !22

9:                                                ; preds = %5
  %10 = getelementptr inbounds %struct.node, %struct.node* %.012, i32 0, i32 1, !dbg !73, !verifier.code !22
  store %struct.node* %6, %struct.node** %10, align 8, !dbg !75, !verifier.code !22
  br label %11, !dbg !76, !verifier.code !22

11:                                               ; preds = %9, %5
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !60, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %12 = add nsw i32 %.03, -1, !dbg !77, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %12, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %13 = icmp sgt i32 %12, 1, !dbg !62, !verifier.code !22
  br i1 %13, label %forwarder, label %._crit_edge, !dbg !63, !llvm.loop !78, !verifier.code !22

._crit_edge:                                      ; preds = %11
  %split = phi %struct.node* [ %6, %11 ], !verifier.code !22
  br label %14, !dbg !63, !verifier.code !22

14:                                               ; preds = %._crit_edge, %2
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %3, %2 ], !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !60, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %15 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !80, !verifier.code !22
  store %struct.node* %.01.lcssa, %struct.node** %15, align 8, !dbg !81, !verifier.code !22
  %16 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 1, !dbg !82, !verifier.code !22
  store %struct.node* %3, %struct.node** %16, align 8, !dbg !83, !verifier.code !22
  ret %struct.node* %.01.lcssa, !dbg !84, !verifier.code !22

forwarder:                                        ; preds = %11
  br label %5, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define internal void @dll_circular_remove_last(%struct.node** %0) #0 !dbg !85 {
  call void @llvm.dbg.value(metadata %struct.node** %0, metadata !89, metadata !DIExpression()), !dbg !90, !verifier.code !22
  %2 = load %struct.node*, %struct.node** %0, align 8, !dbg !91, !verifier.code !22
  %3 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 1, !dbg !92, !verifier.code !22
  %4 = load %struct.node*, %struct.node** %3, align 8, !dbg !92, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !93, metadata !DIExpression()), !dbg !90, !verifier.code !22
  %5 = load %struct.node*, %struct.node** %0, align 8, !dbg !94, !verifier.code !22
  %6 = icmp eq %struct.node* %4, %5, !dbg !96, !verifier.code !22
  br i1 %6, label %7, label %10, !dbg !97, !verifier.code !22

7:                                                ; preds = %1
  %8 = load %struct.node*, %struct.node** %0, align 8, !dbg !98, !verifier.code !22
  %9 = bitcast %struct.node* %8 to i8*, !dbg !98, !verifier.code !22
  call void @free(i8* %9) #4, !dbg !100, !verifier.code !22
  store %struct.node* null, %struct.node** %0, align 8, !dbg !101, !verifier.code !22
  br label %18, !dbg !102, !verifier.code !22

10:                                               ; preds = %1
  %11 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 1, !dbg !103, !verifier.code !22
  %12 = load %struct.node*, %struct.node** %11, align 8, !dbg !103, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %12, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !22
  %13 = bitcast %struct.node* %4 to i8*, !dbg !107, !verifier.code !22
  call void @free(i8* %13) #4, !dbg !108, !verifier.code !22
  %14 = load %struct.node*, %struct.node** %0, align 8, !dbg !109, !verifier.code !22
  %15 = getelementptr inbounds %struct.node, %struct.node* %14, i32 0, i32 1, !dbg !110, !verifier.code !22
  store %struct.node* %12, %struct.node** %15, align 8, !dbg !111, !verifier.code !22
  %16 = load %struct.node*, %struct.node** %0, align 8, !dbg !112, !verifier.code !22
  %17 = getelementptr inbounds %struct.node, %struct.node* %12, i32 0, i32 0, !dbg !113, !verifier.code !22
  store %struct.node* %16, %struct.node** %17, align 8, !dbg !114, !verifier.code !22
  br label %18, !verifier.code !22

18:                                               ; preds = %10, %7
  ret void, !dbg !115, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !116 {
  %1 = alloca %struct.node*, align 8, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 2, metadata !119, metadata !DIExpression()), !dbg !121, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !122, metadata !DIExpression()), !dbg !121, !verifier.code !22
  call void @llvm.dbg.declare(metadata %struct.node** %1, metadata !123, metadata !DIExpression()), !dbg !124, !verifier.code !22
  %2 = call %struct.node* @dll_circular_create(i32 2, i32 1), !dbg !125, !verifier.code !22
  store %struct.node* %2, %struct.node** %1, align 8, !dbg !124, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 0, metadata !126, metadata !DIExpression()), !dbg !121, !verifier.code !22
  br label %3, !dbg !127, !verifier.code !22

3:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !126, metadata !DIExpression()), !dbg !121, !verifier.code !22
  call void @dll_circular_remove_last(%struct.node** %1), !dbg !129, !verifier.code !22
  br label %4, !dbg !132, !verifier.code !22

4:                                                ; preds = %3
  call void @llvm.dbg.value(metadata i32 1, metadata !126, metadata !DIExpression()), !dbg !121, !verifier.code !22
  call void @dll_circular_remove_last(%struct.node** %1), !dbg !129, !verifier.code !22
  br label %8, !dbg !132, !verifier.code !22

5:                                                ; preds = %8
  br label %7, !dbg !133, !verifier.code !22

6:                                                ; preds = %8
  ret i32 0, !dbg !136, !verifier.code !22

7:                                                ; preds = %5
  call void @llvm.dbg.label(metadata !137), !dbg !138, !verifier.code !22
  call void @reach_error(), !dbg !139, !verifier.code !22
  call void @abort() #5, !dbg !141, !verifier.code !22
  unreachable, !dbg !141, !verifier.code !22

8:                                                ; preds = %4
  call void @llvm.dbg.value(metadata i32 2, metadata !126, metadata !DIExpression()), !dbg !121, !verifier.code !22
  %9 = load %struct.node*, %struct.node** %1, align 8, !dbg !142, !verifier.code !22
  %10 = icmp ne %struct.node* null, %9, !dbg !143, !verifier.code !22
  br i1 %10, label %5, label %6, !dbg !144, !verifier.code !22
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!14}
!llvm.module.flags = !{!15, !16, !17}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dll2c_remove_all_reverse.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !13}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DLL", file: !5, line: 13, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dll2c_remove_all_reverse.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 9, size: 192, elements: !8)
!8 = !{!9, !10, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 10, baseType: !6, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !7, file: !5, line: 11, baseType: !6, size: 64, offset: 64)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !5, line: 12, baseType: !12, size: 32, offset: 128)
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!14 = !{!"clang version 10.0.0-4ubuntu1 "}
!15 = !{i32 7, !"Dwarf Version", i32 4}
!16 = !{i32 2, !"Debug Info Version", i32 3}
!17 = !{i32 1, !"wchar_size", i32 4}
!18 = distinct !DISubprogram(name: "reach_error", scope: !5, file: !5, line: 2, type: !19, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!19 = !DISubroutineType(types: !20)
!20 = !{null}
!21 = !DILocation(line: 2, column: 20, scope: !18)
!22 = !{i1 false}
!23 = distinct !DISubprogram(name: "myexit", scope: !5, file: !5, line: 15, type: !24, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{null, !12}
!26 = !DILocalVariable(name: "s", arg: 1, scope: !23, file: !5, line: 15, type: !12)
!27 = !DILocation(line: 0, scope: !23)
!28 = !DILocation(line: 15, column: 20, scope: !23)
!29 = !DILabel(scope: !23, name: "_EXIT", file: !5, line: 16)
!30 = !DILocation(line: 16, column: 2, scope: !23)
!31 = !DILocation(line: 16, column: 9, scope: !23)
!32 = distinct !DISubprogram(name: "node_create", scope: !5, file: !5, line: 19, type: !33, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!4, !12}
!35 = !DILocalVariable(name: "data", arg: 1, scope: !32, file: !5, line: 19, type: !12)
!36 = !DILocation(line: 0, scope: !32)
!37 = !DILocation(line: 20, column: 20, scope: !32)
!38 = !DILocation(line: 20, column: 14, scope: !32)
!39 = !DILocalVariable(name: "temp", scope: !32, file: !5, line: 20, type: !4)
!40 = !DILocation(line: 21, column: 11, scope: !41)
!41 = distinct !DILexicalBlock(scope: !32, file: !5, line: 21, column: 6)
!42 = !DILocation(line: 21, column: 6, scope: !32)
!43 = !DILocation(line: 22, column: 5, scope: !44)
!44 = distinct !DILexicalBlock(scope: !41, file: !5, line: 21, column: 20)
!45 = !DILocation(line: 23, column: 3, scope: !44)
!46 = !DILocation(line: 24, column: 9, scope: !32)
!47 = !DILocation(line: 24, column: 14, scope: !32)
!48 = !DILocation(line: 25, column: 9, scope: !32)
!49 = !DILocation(line: 25, column: 14, scope: !32)
!50 = !DILocation(line: 26, column: 9, scope: !32)
!51 = !DILocation(line: 26, column: 14, scope: !32)
!52 = !DILocation(line: 27, column: 3, scope: !32)
!53 = distinct !DISubprogram(name: "dll_circular_create", scope: !5, file: !5, line: 30, type: !54, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!54 = !DISubroutineType(types: !55)
!55 = !{!4, !12, !12}
!56 = !DILocalVariable(name: "len", arg: 1, scope: !53, file: !5, line: 30, type: !12)
!57 = !DILocation(line: 0, scope: !53)
!58 = !DILocalVariable(name: "data", arg: 2, scope: !53, file: !5, line: 30, type: !12)
!59 = !DILocation(line: 31, column: 14, scope: !53)
!60 = !DILocalVariable(name: "head", scope: !53, file: !5, line: 31, type: !4)
!61 = !DILocalVariable(name: "last", scope: !53, file: !5, line: 32, type: !4)
!62 = !DILocation(line: 33, column: 13, scope: !53)
!63 = !DILocation(line: 33, column: 3, scope: !53)
!64 = !DILocation(line: 34, column: 20, scope: !65)
!65 = distinct !DILexicalBlock(scope: !53, file: !5, line: 33, column: 18)
!66 = !DILocalVariable(name: "new_head", scope: !65, file: !5, line: 34, type: !4)
!67 = !DILocation(line: 0, scope: !65)
!68 = !DILocation(line: 35, column: 15, scope: !65)
!69 = !DILocation(line: 35, column: 20, scope: !65)
!70 = !DILocation(line: 36, column: 8, scope: !71)
!71 = distinct !DILexicalBlock(scope: !65, file: !5, line: 36, column: 8)
!72 = !DILocation(line: 36, column: 8, scope: !65)
!73 = !DILocation(line: 37, column: 13, scope: !74)
!74 = distinct !DILexicalBlock(scope: !71, file: !5, line: 36, column: 14)
!75 = !DILocation(line: 37, column: 18, scope: !74)
!76 = !DILocation(line: 38, column: 5, scope: !74)
!77 = !DILocation(line: 40, column: 8, scope: !65)
!78 = distinct !{!78, !63, !79}
!79 = !DILocation(line: 41, column: 3, scope: !53)
!80 = !DILocation(line: 42, column: 9, scope: !53)
!81 = !DILocation(line: 42, column: 14, scope: !53)
!82 = !DILocation(line: 43, column: 9, scope: !53)
!83 = !DILocation(line: 43, column: 14, scope: !53)
!84 = !DILocation(line: 44, column: 3, scope: !53)
!85 = distinct !DISubprogram(name: "dll_circular_remove_last", scope: !5, file: !5, line: 47, type: !86, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !88}
!88 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!89 = !DILocalVariable(name: "head", arg: 1, scope: !85, file: !5, line: 47, type: !88)
!90 = !DILocation(line: 0, scope: !85)
!91 = !DILocation(line: 48, column: 15, scope: !85)
!92 = !DILocation(line: 48, column: 23, scope: !85)
!93 = !DILocalVariable(name: "last", scope: !85, file: !5, line: 48, type: !4)
!94 = !DILocation(line: 49, column: 14, scope: !95)
!95 = distinct !DILexicalBlock(scope: !85, file: !5, line: 49, column: 6)
!96 = !DILocation(line: 49, column: 11, scope: !95)
!97 = !DILocation(line: 49, column: 6, scope: !85)
!98 = !DILocation(line: 50, column: 10, scope: !99)
!99 = distinct !DILexicalBlock(scope: !95, file: !5, line: 49, column: 21)
!100 = !DILocation(line: 50, column: 5, scope: !99)
!101 = !DILocation(line: 51, column: 11, scope: !99)
!102 = !DILocation(line: 52, column: 3, scope: !99)
!103 = !DILocation(line: 53, column: 31, scope: !104)
!104 = distinct !DILexicalBlock(scope: !95, file: !5, line: 52, column: 10)
!105 = !DILocalVariable(name: "snd_to_last", scope: !104, file: !5, line: 53, type: !4)
!106 = !DILocation(line: 0, scope: !104)
!107 = !DILocation(line: 54, column: 10, scope: !104)
!108 = !DILocation(line: 54, column: 5, scope: !104)
!109 = !DILocation(line: 55, column: 6, scope: !104)
!110 = !DILocation(line: 55, column: 14, scope: !104)
!111 = !DILocation(line: 55, column: 19, scope: !104)
!112 = !DILocation(line: 56, column: 25, scope: !104)
!113 = !DILocation(line: 56, column: 18, scope: !104)
!114 = !DILocation(line: 56, column: 23, scope: !104)
!115 = !DILocation(line: 58, column: 1, scope: !85)
!116 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 60, type: !117, scopeLine: 60, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!117 = !DISubroutineType(types: !118)
!118 = !{!12}
!119 = !DILocalVariable(name: "len", scope: !116, file: !5, line: 61, type: !120)
!120 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !12)
!121 = !DILocation(line: 0, scope: !116)
!122 = !DILocalVariable(name: "data", scope: !116, file: !5, line: 62, type: !120)
!123 = !DILocalVariable(name: "s", scope: !116, file: !5, line: 63, type: !4)
!124 = !DILocation(line: 63, column: 7, scope: !116)
!125 = !DILocation(line: 63, column: 11, scope: !116)
!126 = !DILocalVariable(name: "i", scope: !116, file: !5, line: 64, type: !12)
!127 = !DILocation(line: 65, column: 3, scope: !128)
!128 = distinct !DILexicalBlock(scope: !116, file: !5, line: 65, column: 3)
!129 = !DILocation(line: 66, column: 5, scope: !130)
!130 = distinct !DILexicalBlock(scope: !131, file: !5, line: 65, column: 28)
!131 = distinct !DILexicalBlock(scope: !128, file: !5, line: 65, column: 3)
!132 = !DILocation(line: 67, column: 3, scope: !130)
!133 = !DILocation(line: 69, column: 5, scope: !134)
!134 = distinct !DILexicalBlock(scope: !135, file: !5, line: 68, column: 17)
!135 = distinct !DILexicalBlock(scope: !116, file: !5, line: 68, column: 6)
!136 = !DILocation(line: 71, column: 3, scope: !116)
!137 = !DILabel(scope: !116, name: "ERROR", file: !5, line: 72)
!138 = !DILocation(line: 72, column: 2, scope: !116)
!139 = !DILocation(line: 72, column: 10, scope: !140)
!140 = distinct !DILexicalBlock(scope: !116, file: !5, line: 72, column: 9)
!141 = !DILocation(line: 72, column: 24, scope: !140)
!142 = !DILocation(line: 68, column: 14, scope: !135)
!143 = !DILocation(line: 68, column: 11, scope: !135)
!144 = !DILocation(line: 68, column: 6, scope: !116)
