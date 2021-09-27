; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-koanbs4h.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { i32, %struct.node*, %struct.node* }

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
define internal %struct.node* @dll_circular_create(i32 %0, i32 %1) #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !37, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %3 = call noalias i8* @malloc(i64 24) #4, !dbg !38, !verifier.code !22
  %4 = bitcast i8* %3 to %struct.node*, !dbg !39, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !40, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %5 = icmp eq %struct.node* null, %4, !dbg !41, !verifier.code !22
  br i1 %5, label %6, label %7, !dbg !43, !verifier.code !22

6:                                                ; preds = %2
  call void @myexit(i32 1), !dbg !44, !verifier.code !22
  br label %7, !dbg !46, !verifier.code !22

7:                                                ; preds = %6, %2
  %8 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 1, !dbg !47, !verifier.code !22
  store %struct.node* %4, %struct.node** %8, align 8, !dbg !48, !verifier.code !22
  %9 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 2, !dbg !49, !verifier.code !22
  store %struct.node* %4, %struct.node** %9, align 8, !dbg !50, !verifier.code !22
  %10 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 0, !dbg !51, !verifier.code !22
  store i32 %1, i32* %10, align 8, !dbg !52, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !53, metadata !DIExpression()), !dbg !36, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %0, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %11 = icmp sgt i32 %0, 1, !dbg !54, !verifier.code !22
  br i1 %11, label %.lr.ph, label %23, !dbg !55, !verifier.code !22

.lr.ph:                                           ; preds = %7
  br label %12, !dbg !55, !verifier.code !22

12:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %21, %forwarder ], !verifier.code !22
  %.012 = phi %struct.node* [ %4, %.lr.ph ], [ %14, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.03, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.012, metadata !53, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %13 = call noalias i8* @malloc(i64 24) #4, !dbg !56, !verifier.code !22
  %14 = bitcast i8* %13 to %struct.node*, !dbg !58, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %14, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !22
  %15 = icmp eq %struct.node* null, %14, !dbg !61, !verifier.code !22
  br i1 %15, label %16, label %17, !dbg !63, !verifier.code !22

16:                                               ; preds = %12
  call void @myexit(i32 1), !dbg !64, !verifier.code !22
  br label %17, !dbg !66, !verifier.code !22

17:                                               ; preds = %16, %12
  %18 = getelementptr inbounds %struct.node, %struct.node* %14, i32 0, i32 1, !dbg !67, !verifier.code !22
  store %struct.node* %.012, %struct.node** %18, align 8, !dbg !68, !verifier.code !22
  %19 = getelementptr inbounds %struct.node, %struct.node* %14, i32 0, i32 0, !dbg !69, !verifier.code !22
  store i32 %1, i32* %19, align 8, !dbg !70, !verifier.code !22
  %20 = getelementptr inbounds %struct.node, %struct.node* %.012, i32 0, i32 2, !dbg !71, !verifier.code !22
  store %struct.node* %14, %struct.node** %20, align 8, !dbg !72, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %14, metadata !53, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %21 = add nsw i32 %.03, -1, !dbg !73, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %21, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %22 = icmp sgt i32 %21, 1, !dbg !54, !verifier.code !22
  br i1 %22, label %forwarder, label %._crit_edge, !dbg !55, !llvm.loop !74, !verifier.code !22

._crit_edge:                                      ; preds = %17
  %split = phi %struct.node* [ %14, %17 ], !verifier.code !22
  br label %23, !dbg !55, !verifier.code !22

23:                                               ; preds = %._crit_edge, %7
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %4, %7 ], !dbg !36, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !53, metadata !DIExpression()), !dbg !36, !verifier.code !22
  %24 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 1, !dbg !76, !verifier.code !22
  store %struct.node* %.01.lcssa, %struct.node** %24, align 8, !dbg !77, !verifier.code !22
  %25 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 2, !dbg !78, !verifier.code !22
  store %struct.node* %4, %struct.node** %25, align 8, !dbg !79, !verifier.code !22
  ret %struct.node* %.01.lcssa, !dbg !80, !verifier.code !22

forwarder:                                        ; preds = %17
  br label %12, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !81 {
  call void @llvm.dbg.value(metadata i32 5, metadata !84, metadata !DIExpression()), !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !87, metadata !DIExpression()), !dbg !86, !verifier.code !22
  %1 = call %struct.node* @dll_circular_create(i32 5, i32 1), !dbg !88, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !89, metadata !DIExpression()), !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !90, metadata !DIExpression()), !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !91, metadata !DIExpression()), !dbg !86, !verifier.code !22
  br label %2, !dbg !92, !verifier.code !22

2:                                                ; preds = %forwarder4, %0
  %.01 = phi i32 [ 1, %0 ], [ %11, %forwarder4 ], !dbg !86, !verifier.code !22
  %.0 = phi %struct.node* [ %1, %0 ], [ %10, %forwarder4 ], !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.0, metadata !91, metadata !DIExpression()), !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.01, metadata !90, metadata !DIExpression()), !dbg !86, !verifier.code !22
  %3 = getelementptr inbounds %struct.node, %struct.node* %.0, i32 0, i32 0, !dbg !93, !verifier.code !22
  %4 = load i32, i32* %3, align 8, !dbg !93, !verifier.code !22
  %5 = icmp ne i32 1, %4, !dbg !96, !verifier.code !22
  br i1 %5, label %6, label %7, !dbg !97, !verifier.code !22

6:                                                ; preds = %2
  br label %31, !dbg !98, !verifier.code !22

7:                                                ; preds = %2
  %8 = getelementptr inbounds %struct.node, %struct.node* %.0, i32 0, i32 0, !dbg !100, !verifier.code !22
  store i32 %.01, i32* %8, align 8, !dbg !101, !verifier.code !22
  %9 = getelementptr inbounds %struct.node, %struct.node* %.0, i32 0, i32 1, !dbg !102, !verifier.code !22
  %10 = load %struct.node*, %struct.node** %9, align 8, !dbg !102, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %10, metadata !91, metadata !DIExpression()), !dbg !86, !verifier.code !22
  %11 = add nsw i32 %.01, 1, !dbg !103, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %11, metadata !90, metadata !DIExpression()), !dbg !86, !verifier.code !22
  br label %12, !dbg !104, !verifier.code !22

12:                                               ; preds = %7
  %13 = icmp ne %struct.node* %10, %1, !dbg !105, !verifier.code !22
  br i1 %13, label %forwarder4, label %14, !dbg !104, !llvm.loop !106, !verifier.code !22

14:                                               ; preds = %12
  %.lcssa3 = phi %struct.node* [ %10, %12 ], !dbg !102, !verifier.code !22
  %.lcssa = phi i32 [ %11, %12 ], !dbg !103, !verifier.code !22
  %15 = getelementptr inbounds %struct.node, %struct.node* %.lcssa3, i32 0, i32 2, !dbg !108, !verifier.code !22
  %16 = load %struct.node*, %struct.node** %15, align 8, !dbg !108, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %16, metadata !91, metadata !DIExpression()), !dbg !86, !verifier.code !22
  %17 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 2, !dbg !109, !verifier.code !22
  store %struct.node* null, %struct.node** %17, align 8, !dbg !110, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !89, metadata !DIExpression()), !dbg !86, !verifier.code !22
  br label %18, !dbg !111, !verifier.code !22

18:                                               ; preds = %forwarder, %14
  %.12 = phi i32 [ %.lcssa, %14 ], [ %19, %forwarder ], !dbg !86, !verifier.code !22
  %.1 = phi %struct.node* [ %16, %14 ], [ %26, %forwarder ], !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.1, metadata !91, metadata !DIExpression()), !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.12, metadata !90, metadata !DIExpression()), !dbg !86, !verifier.code !22
  %19 = add nsw i32 %.12, -1, !dbg !112, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %19, metadata !90, metadata !DIExpression()), !dbg !86, !verifier.code !22
  %20 = getelementptr inbounds %struct.node, %struct.node* %.1, i32 0, i32 0, !dbg !114, !verifier.code !22
  %21 = load i32, i32* %20, align 8, !dbg !114, !verifier.code !22
  %22 = icmp ne i32 %19, %21, !dbg !116, !verifier.code !22
  br i1 %22, label %23, label %24, !dbg !117, !verifier.code !22

23:                                               ; preds = %18
  br label %31, !dbg !118, !verifier.code !22

24:                                               ; preds = %18
  %25 = getelementptr inbounds %struct.node, %struct.node* %.1, i32 0, i32 2, !dbg !120, !verifier.code !22
  %26 = load %struct.node*, %struct.node** %25, align 8, !dbg !120, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %26, metadata !121, metadata !DIExpression()), !dbg !122, !verifier.code !22
  %27 = bitcast %struct.node* %.1 to i8*, !dbg !123, !verifier.code !22
  call void @free(i8* %27) #4, !dbg !124, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %26, metadata !91, metadata !DIExpression()), !dbg !86, !verifier.code !22
  br label %28, !dbg !125, !verifier.code !22

28:                                               ; preds = %24
  %29 = icmp ne %struct.node* %26, null, !dbg !126, !verifier.code !22
  br i1 %29, label %forwarder, label %30, !dbg !125, !llvm.loop !127, !verifier.code !22

30:                                               ; preds = %28
  ret i32 0, !dbg !129, !verifier.code !22

31:                                               ; preds = %23, %6
  call void @llvm.dbg.label(metadata !130), !dbg !131, !verifier.code !22
  call void @reach_error(), !dbg !132, !verifier.code !22
  call void @abort() #5, !dbg !134, !verifier.code !22
  unreachable, !dbg !134, !verifier.code !22

forwarder:                                        ; preds = %28
  br label %18, !verifier.code !22

forwarder4:                                       ; preds = %12
  br label %2, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

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
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dll_circular_traversal-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !13}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DLL", file: !5, line: 15, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dll_circular_traversal-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 11, size: 192, elements: !8)
!8 = !{!9, !11, !12}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !5, line: 12, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 13, baseType: !6, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !7, file: !5, line: 14, baseType: !6, size: 64, offset: 128)
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
!23 = distinct !DISubprogram(name: "myexit", scope: !5, file: !5, line: 17, type: !24, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{null, !10}
!26 = !DILocalVariable(name: "s", arg: 1, scope: !23, file: !5, line: 17, type: !10)
!27 = !DILocation(line: 0, scope: !23)
!28 = !DILocation(line: 17, column: 20, scope: !23)
!29 = !DILabel(scope: !23, name: "_EXIT", file: !5, line: 18)
!30 = !DILocation(line: 18, column: 2, scope: !23)
!31 = !DILocation(line: 18, column: 9, scope: !23)
!32 = distinct !DISubprogram(name: "dll_circular_create", scope: !5, file: !5, line: 21, type: !33, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!4, !10, !10}
!35 = !DILocalVariable(name: "len", arg: 1, scope: !32, file: !5, line: 21, type: !10)
!36 = !DILocation(line: 0, scope: !32)
!37 = !DILocalVariable(name: "data", arg: 2, scope: !32, file: !5, line: 21, type: !10)
!38 = !DILocation(line: 22, column: 20, scope: !32)
!39 = !DILocation(line: 22, column: 14, scope: !32)
!40 = !DILocalVariable(name: "last", scope: !32, file: !5, line: 22, type: !4)
!41 = !DILocation(line: 23, column: 11, scope: !42)
!42 = distinct !DILexicalBlock(scope: !32, file: !5, line: 23, column: 6)
!43 = !DILocation(line: 23, column: 6, scope: !32)
!44 = !DILocation(line: 24, column: 5, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !5, line: 23, column: 19)
!46 = !DILocation(line: 25, column: 3, scope: !45)
!47 = !DILocation(line: 26, column: 9, scope: !32)
!48 = !DILocation(line: 26, column: 14, scope: !32)
!49 = !DILocation(line: 27, column: 9, scope: !32)
!50 = !DILocation(line: 27, column: 14, scope: !32)
!51 = !DILocation(line: 28, column: 9, scope: !32)
!52 = !DILocation(line: 28, column: 14, scope: !32)
!53 = !DILocalVariable(name: "head", scope: !32, file: !5, line: 29, type: !4)
!54 = !DILocation(line: 30, column: 13, scope: !32)
!55 = !DILocation(line: 30, column: 3, scope: !32)
!56 = !DILocation(line: 31, column: 26, scope: !57)
!57 = distinct !DILexicalBlock(scope: !32, file: !5, line: 30, column: 18)
!58 = !DILocation(line: 31, column: 20, scope: !57)
!59 = !DILocalVariable(name: "new_head", scope: !57, file: !5, line: 31, type: !4)
!60 = !DILocation(line: 0, scope: !57)
!61 = !DILocation(line: 32, column: 13, scope: !62)
!62 = distinct !DILexicalBlock(scope: !57, file: !5, line: 32, column: 8)
!63 = !DILocation(line: 32, column: 8, scope: !57)
!64 = !DILocation(line: 33, column: 7, scope: !65)
!65 = distinct !DILexicalBlock(scope: !62, file: !5, line: 32, column: 26)
!66 = !DILocation(line: 34, column: 5, scope: !65)
!67 = !DILocation(line: 35, column: 15, scope: !57)
!68 = !DILocation(line: 35, column: 20, scope: !57)
!69 = !DILocation(line: 36, column: 15, scope: !57)
!70 = !DILocation(line: 36, column: 20, scope: !57)
!71 = !DILocation(line: 37, column: 11, scope: !57)
!72 = !DILocation(line: 37, column: 16, scope: !57)
!73 = !DILocation(line: 39, column: 8, scope: !57)
!74 = distinct !{!74, !55, !75}
!75 = !DILocation(line: 40, column: 3, scope: !32)
!76 = !DILocation(line: 41, column: 9, scope: !32)
!77 = !DILocation(line: 41, column: 14, scope: !32)
!78 = !DILocation(line: 42, column: 9, scope: !32)
!79 = !DILocation(line: 42, column: 14, scope: !32)
!80 = !DILocation(line: 43, column: 3, scope: !32)
!81 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 46, type: !82, scopeLine: 46, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!82 = !DISubroutineType(types: !83)
!83 = !{!10}
!84 = !DILocalVariable(name: "len", scope: !81, file: !5, line: 47, type: !85)
!85 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!86 = !DILocation(line: 0, scope: !81)
!87 = !DILocalVariable(name: "data_init", scope: !81, file: !5, line: 48, type: !85)
!88 = !DILocation(line: 49, column: 14, scope: !81)
!89 = !DILocalVariable(name: "head", scope: !81, file: !5, line: 49, type: !4)
!90 = !DILocalVariable(name: "data_new", scope: !81, file: !5, line: 51, type: !10)
!91 = !DILocalVariable(name: "ptr", scope: !81, file: !5, line: 52, type: !4)
!92 = !DILocation(line: 53, column: 3, scope: !81)
!93 = !DILocation(line: 54, column: 26, scope: !94)
!94 = distinct !DILexicalBlock(scope: !95, file: !5, line: 54, column: 8)
!95 = distinct !DILexicalBlock(scope: !81, file: !5, line: 53, column: 6)
!96 = !DILocation(line: 54, column: 18, scope: !94)
!97 = !DILocation(line: 54, column: 8, scope: !95)
!98 = !DILocation(line: 55, column: 7, scope: !99)
!99 = distinct !DILexicalBlock(scope: !94, file: !5, line: 54, column: 32)
!100 = !DILocation(line: 57, column: 10, scope: !95)
!101 = !DILocation(line: 57, column: 15, scope: !95)
!102 = !DILocation(line: 58, column: 16, scope: !95)
!103 = !DILocation(line: 59, column: 13, scope: !95)
!104 = !DILocation(line: 60, column: 3, scope: !95)
!105 = !DILocation(line: 60, column: 15, scope: !81)
!106 = distinct !{!106, !92, !107}
!107 = !DILocation(line: 60, column: 22, scope: !81)
!108 = !DILocation(line: 62, column: 14, scope: !81)
!109 = !DILocation(line: 63, column: 9, scope: !81)
!110 = !DILocation(line: 63, column: 14, scope: !81)
!111 = !DILocation(line: 65, column: 3, scope: !81)
!112 = !DILocation(line: 66, column: 13, scope: !113)
!113 = distinct !DILexicalBlock(scope: !81, file: !5, line: 65, column: 6)
!114 = !DILocation(line: 67, column: 25, scope: !115)
!115 = distinct !DILexicalBlock(scope: !113, file: !5, line: 67, column: 8)
!116 = !DILocation(line: 67, column: 17, scope: !115)
!117 = !DILocation(line: 67, column: 8, scope: !113)
!118 = !DILocation(line: 68, column: 7, scope: !119)
!119 = distinct !DILexicalBlock(scope: !115, file: !5, line: 67, column: 31)
!120 = !DILocation(line: 70, column: 21, scope: !113)
!121 = !DILocalVariable(name: "temp", scope: !113, file: !5, line: 70, type: !4)
!122 = !DILocation(line: 0, scope: !113)
!123 = !DILocation(line: 71, column: 10, scope: !113)
!124 = !DILocation(line: 71, column: 5, scope: !113)
!125 = !DILocation(line: 73, column: 3, scope: !113)
!126 = !DILocation(line: 73, column: 15, scope: !81)
!127 = distinct !{!127, !111, !128}
!128 = !DILocation(line: 73, column: 22, scope: !81)
!129 = !DILocation(line: 74, column: 3, scope: !81)
!130 = !DILabel(scope: !81, name: "ERROR", file: !5, line: 75)
!131 = !DILocation(line: 75, column: 2, scope: !81)
!132 = !DILocation(line: 75, column: 10, scope: !133)
!133 = distinct !DILexicalBlock(scope: !81, file: !5, line: 75, column: 9)
!134 = !DILocation(line: 75, column: 24, scope: !133)
