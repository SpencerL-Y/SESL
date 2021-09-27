; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-p_tzw5xk.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, %struct.node* }

; Function Attrs: noinline nounwind uwtable
define internal void @myexit(i32 %0) #0 !dbg !16 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !20, metadata !DIExpression()), !dbg !21, !verifier.code !22
  br label %2, !dbg !23, !verifier.code !22

2:                                                ; preds = %2, %1
  call void @llvm.dbg.label(metadata !24), !dbg !25, !verifier.code !22
  br label %2, !dbg !26, !verifier.code !22
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @dll_circular_create(i32 %0) #0 !dbg !27 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !30, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %2 = call noalias i8* @malloc(i64 16) #4, !dbg !32, !verifier.code !22
  %3 = bitcast i8* %2 to %struct.node*, !dbg !33, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !34, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %4 = icmp eq %struct.node* null, %3, !dbg !35, !verifier.code !22
  br i1 %4, label %5, label %6, !dbg !37, !verifier.code !22

5:                                                ; preds = %1
  call void @myexit(i32 1), !dbg !38, !verifier.code !22
  br label %6, !dbg !40, !verifier.code !22

6:                                                ; preds = %5, %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !41, !verifier.code !22
  store %struct.node* %3, %struct.node** %7, align 8, !dbg !42, !verifier.code !22
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !43, !verifier.code !22
  store %struct.node* %3, %struct.node** %8, align 8, !dbg !44, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !45, metadata !DIExpression()), !dbg !31, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %0, metadata !30, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %9 = icmp sgt i32 %0, 1, !dbg !46, !verifier.code !22
  br i1 %9, label %.lr.ph, label %20, !dbg !47, !verifier.code !22

.lr.ph:                                           ; preds = %6
  br label %10, !dbg !47, !verifier.code !22

10:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %18, %forwarder ], !verifier.code !22
  %.012 = phi %struct.node* [ %3, %.lr.ph ], [ %12, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.03, metadata !30, metadata !DIExpression()), !dbg !31, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.012, metadata !45, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %11 = call noalias i8* @malloc(i64 16) #4, !dbg !48, !verifier.code !22
  %12 = bitcast i8* %11 to %struct.node*, !dbg !50, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %12, metadata !51, metadata !DIExpression()), !dbg !52, !verifier.code !22
  %13 = icmp eq %struct.node* null, %12, !dbg !53, !verifier.code !22
  br i1 %13, label %14, label %15, !dbg !55, !verifier.code !22

14:                                               ; preds = %10
  call void @myexit(i32 1), !dbg !56, !verifier.code !22
  br label %15, !dbg !58, !verifier.code !22

15:                                               ; preds = %14, %10
  %16 = getelementptr inbounds %struct.node, %struct.node* %12, i32 0, i32 0, !dbg !59, !verifier.code !22
  store %struct.node* %.012, %struct.node** %16, align 8, !dbg !60, !verifier.code !22
  %17 = getelementptr inbounds %struct.node, %struct.node* %.012, i32 0, i32 1, !dbg !61, !verifier.code !22
  store %struct.node* %12, %struct.node** %17, align 8, !dbg !62, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %12, metadata !45, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %18 = add nsw i32 %.03, -1, !dbg !63, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %18, metadata !30, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %19 = icmp sgt i32 %18, 1, !dbg !46, !verifier.code !22
  br i1 %19, label %forwarder, label %._crit_edge, !dbg !47, !llvm.loop !64, !verifier.code !22

._crit_edge:                                      ; preds = %15
  %split = phi %struct.node* [ %12, %15 ], !verifier.code !22
  br label %20, !dbg !47, !verifier.code !22

20:                                               ; preds = %._crit_edge, %6
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %3, %6 ], !dbg !31, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !45, metadata !DIExpression()), !dbg !31, !verifier.code !22
  %21 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !66, !verifier.code !22
  store %struct.node* %.01.lcssa, %struct.node** %21, align 8, !dbg !67, !verifier.code !22
  %22 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 1, !dbg !68, !verifier.code !22
  store %struct.node* %3, %struct.node** %22, align 8, !dbg !69, !verifier.code !22
  ret %struct.node* %.01.lcssa, !dbg !70, !verifier.code !22

forwarder:                                        ; preds = %15
  br label %10, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal void @_destroy_in_nondeterministic_order(%struct.node* %0) #0 !dbg !71 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !74, metadata !DIExpression()), !dbg !75, !verifier.code !22
  %2 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !76, !verifier.code !22
  %3 = load %struct.node*, %struct.node** %2, align 8, !dbg !76, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !77, metadata !DIExpression()), !dbg !75, !verifier.code !22
  %4 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !78, !verifier.code !22
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !78, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !79, metadata !DIExpression()), !dbg !75, !verifier.code !22
  %6 = call i32 (...) @__VERIFIER_nondet_int(), !dbg !80, !verifier.code !82
  %7 = icmp ne i32 %6, 0, !dbg !80, !verifier.code !22
  br i1 %7, label %8, label %19, !dbg !83, !verifier.code !22

8:                                                ; preds = %1
  %9 = bitcast %struct.node* %0 to i8*, !dbg !84, !verifier.code !22
  call void @free(i8* %9) #4, !dbg !86, !verifier.code !22
  %10 = call i32 (...) @__VERIFIER_nondet_int(), !dbg !87, !verifier.code !82
  %11 = icmp ne i32 %10, 0, !dbg !87, !verifier.code !22
  br i1 %11, label %12, label %15, !dbg !89, !verifier.code !22

12:                                               ; preds = %8
  %13 = bitcast %struct.node* %5 to i8*, !dbg !90, !verifier.code !22
  call void @free(i8* %13) #4, !dbg !92, !verifier.code !22
  %14 = bitcast %struct.node* %3 to i8*, !dbg !93, !verifier.code !22
  call void @free(i8* %14) #4, !dbg !94, !verifier.code !22
  br label %18, !dbg !95, !verifier.code !22

15:                                               ; preds = %8
  %16 = bitcast %struct.node* %3 to i8*, !dbg !96, !verifier.code !22
  call void @free(i8* %16) #4, !dbg !98, !verifier.code !22
  %17 = bitcast %struct.node* %5 to i8*, !dbg !99, !verifier.code !22
  call void @free(i8* %17) #4, !dbg !100, !verifier.code !22
  br label %18, !verifier.code !22

18:                                               ; preds = %15, %12
  br label %44, !dbg !101, !verifier.code !22

19:                                               ; preds = %1
  %20 = call i32 (...) @__VERIFIER_nondet_int(), !dbg !102, !verifier.code !82
  %21 = icmp ne i32 %20, 0, !dbg !102, !verifier.code !22
  br i1 %21, label %22, label %33, !dbg !104, !verifier.code !22

22:                                               ; preds = %19
  %23 = bitcast %struct.node* %5 to i8*, !dbg !105, !verifier.code !22
  call void @free(i8* %23) #4, !dbg !107, !verifier.code !22
  %24 = call i32 (...) @__VERIFIER_nondet_int(), !dbg !108, !verifier.code !82
  %25 = icmp ne i32 %24, 0, !dbg !108, !verifier.code !22
  br i1 %25, label %26, label %29, !dbg !110, !verifier.code !22

26:                                               ; preds = %22
  %27 = bitcast %struct.node* %0 to i8*, !dbg !111, !verifier.code !22
  call void @free(i8* %27) #4, !dbg !113, !verifier.code !22
  %28 = bitcast %struct.node* %3 to i8*, !dbg !114, !verifier.code !22
  call void @free(i8* %28) #4, !dbg !115, !verifier.code !22
  br label %32, !dbg !116, !verifier.code !22

29:                                               ; preds = %22
  %30 = bitcast %struct.node* %3 to i8*, !dbg !117, !verifier.code !22
  call void @free(i8* %30) #4, !dbg !119, !verifier.code !22
  %31 = bitcast %struct.node* %0 to i8*, !dbg !120, !verifier.code !22
  call void @free(i8* %31) #4, !dbg !121, !verifier.code !22
  br label %32, !verifier.code !22

32:                                               ; preds = %29, %26
  br label %43, !dbg !122, !verifier.code !22

33:                                               ; preds = %19
  %34 = bitcast %struct.node* %3 to i8*, !dbg !123, !verifier.code !22
  call void @free(i8* %34) #4, !dbg !125, !verifier.code !22
  %35 = call i32 (...) @__VERIFIER_nondet_int(), !dbg !126, !verifier.code !82
  %36 = icmp ne i32 %35, 0, !dbg !126, !verifier.code !22
  br i1 %36, label %37, label %40, !dbg !128, !verifier.code !22

37:                                               ; preds = %33
  %38 = bitcast %struct.node* %0 to i8*, !dbg !129, !verifier.code !22
  call void @free(i8* %38) #4, !dbg !131, !verifier.code !22
  %39 = bitcast %struct.node* %5 to i8*, !dbg !132, !verifier.code !22
  call void @free(i8* %39) #4, !dbg !133, !verifier.code !22
  br label %42, !dbg !134, !verifier.code !22

40:                                               ; preds = %33
  %41 = bitcast %struct.node* %0 to i8*, !dbg !135, !verifier.code !22
  call void @free(i8* %41) #4, !dbg !137, !verifier.code !22
  br label %42, !verifier.code !22

42:                                               ; preds = %40, %37
  br label %43, !verifier.code !22

43:                                               ; preds = %42, %32
  br label %44, !verifier.code !22

44:                                               ; preds = %43, %18
  ret void, !dbg !138, !verifier.code !22
}

declare dso_local i32 @__VERIFIER_nondet_int(...) #3

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !139 {
  call void @llvm.dbg.value(metadata i32 3, metadata !142, metadata !DIExpression()), !dbg !144, !verifier.code !22
  %1 = call %struct.node* @dll_circular_create(i32 3), !dbg !145, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !146, metadata !DIExpression()), !dbg !144, !verifier.code !22
  call void @_destroy_in_nondeterministic_order(%struct.node* %1), !dbg !147, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !146, metadata !DIExpression()), !dbg !144, !verifier.code !22
  ret i32 0, !dbg !148, !verifier.code !22
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!12}
!llvm.module.flags = !{!13, !14, !15}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dll_nondet_free_order-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !11}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DLL", file: !5, line: 13, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dll_nondet_free_order-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 10, size: 128, elements: !8)
!8 = !{!9, !10}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 11, baseType: !6, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !7, file: !5, line: 12, baseType: !6, size: 64, offset: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!12 = !{!"clang version 10.0.0-4ubuntu1 "}
!13 = !{i32 7, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = distinct !DISubprogram(name: "myexit", scope: !5, file: !5, line: 15, type: !17, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{null, !19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocalVariable(name: "s", arg: 1, scope: !16, file: !5, line: 15, type: !19)
!21 = !DILocation(line: 0, scope: !16)
!22 = !{i1 false}
!23 = !DILocation(line: 15, column: 20, scope: !16)
!24 = !DILabel(scope: !16, name: "_EXIT", file: !5, line: 16)
!25 = !DILocation(line: 16, column: 2, scope: !16)
!26 = !DILocation(line: 16, column: 9, scope: !16)
!27 = distinct !DISubprogram(name: "dll_circular_create", scope: !5, file: !5, line: 19, type: !28, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{!4, !19}
!30 = !DILocalVariable(name: "len", arg: 1, scope: !27, file: !5, line: 19, type: !19)
!31 = !DILocation(line: 0, scope: !27)
!32 = !DILocation(line: 20, column: 20, scope: !27)
!33 = !DILocation(line: 20, column: 14, scope: !27)
!34 = !DILocalVariable(name: "last", scope: !27, file: !5, line: 20, type: !4)
!35 = !DILocation(line: 21, column: 11, scope: !36)
!36 = distinct !DILexicalBlock(scope: !27, file: !5, line: 21, column: 6)
!37 = !DILocation(line: 21, column: 6, scope: !27)
!38 = !DILocation(line: 22, column: 5, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !5, line: 21, column: 20)
!40 = !DILocation(line: 23, column: 3, scope: !39)
!41 = !DILocation(line: 24, column: 9, scope: !27)
!42 = !DILocation(line: 24, column: 14, scope: !27)
!43 = !DILocation(line: 25, column: 9, scope: !27)
!44 = !DILocation(line: 25, column: 14, scope: !27)
!45 = !DILocalVariable(name: "head", scope: !27, file: !5, line: 26, type: !4)
!46 = !DILocation(line: 27, column: 13, scope: !27)
!47 = !DILocation(line: 27, column: 3, scope: !27)
!48 = !DILocation(line: 28, column: 26, scope: !49)
!49 = distinct !DILexicalBlock(scope: !27, file: !5, line: 27, column: 18)
!50 = !DILocation(line: 28, column: 20, scope: !49)
!51 = !DILocalVariable(name: "new_head", scope: !49, file: !5, line: 28, type: !4)
!52 = !DILocation(line: 0, scope: !49)
!53 = !DILocation(line: 29, column: 13, scope: !54)
!54 = distinct !DILexicalBlock(scope: !49, file: !5, line: 29, column: 8)
!55 = !DILocation(line: 29, column: 8, scope: !49)
!56 = !DILocation(line: 30, column: 7, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !5, line: 29, column: 26)
!58 = !DILocation(line: 31, column: 5, scope: !57)
!59 = !DILocation(line: 32, column: 15, scope: !49)
!60 = !DILocation(line: 32, column: 20, scope: !49)
!61 = !DILocation(line: 33, column: 11, scope: !49)
!62 = !DILocation(line: 33, column: 16, scope: !49)
!63 = !DILocation(line: 35, column: 8, scope: !49)
!64 = distinct !{!64, !47, !65}
!65 = !DILocation(line: 36, column: 3, scope: !27)
!66 = !DILocation(line: 37, column: 9, scope: !27)
!67 = !DILocation(line: 37, column: 14, scope: !27)
!68 = !DILocation(line: 38, column: 9, scope: !27)
!69 = !DILocation(line: 38, column: 14, scope: !27)
!70 = !DILocation(line: 39, column: 3, scope: !27)
!71 = distinct !DISubprogram(name: "_destroy_in_nondeterministic_order", scope: !5, file: !5, line: 43, type: !72, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!72 = !DISubroutineType(types: !73)
!73 = !{null, !4}
!74 = !DILocalVariable(name: "head", arg: 1, scope: !71, file: !5, line: 43, type: !4)
!75 = !DILocation(line: 0, scope: !71)
!76 = !DILocation(line: 44, column: 20, scope: !71)
!77 = !DILocalVariable(name: "pred", scope: !71, file: !5, line: 44, type: !4)
!78 = !DILocation(line: 45, column: 20, scope: !71)
!79 = !DILocalVariable(name: "succ", scope: !71, file: !5, line: 45, type: !4)
!80 = !DILocation(line: 46, column: 6, scope: !81)
!81 = distinct !DILexicalBlock(scope: !71, file: !5, line: 46, column: 6)
!82 = !{i1 true}
!83 = !DILocation(line: 46, column: 6, scope: !71)
!84 = !DILocation(line: 47, column: 10, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !5, line: 46, column: 31)
!86 = !DILocation(line: 47, column: 5, scope: !85)
!87 = !DILocation(line: 48, column: 8, scope: !88)
!88 = distinct !DILexicalBlock(scope: !85, file: !5, line: 48, column: 8)
!89 = !DILocation(line: 48, column: 8, scope: !85)
!90 = !DILocation(line: 49, column: 12, scope: !91)
!91 = distinct !DILexicalBlock(scope: !88, file: !5, line: 48, column: 33)
!92 = !DILocation(line: 49, column: 7, scope: !91)
!93 = !DILocation(line: 50, column: 12, scope: !91)
!94 = !DILocation(line: 50, column: 7, scope: !91)
!95 = !DILocation(line: 51, column: 5, scope: !91)
!96 = !DILocation(line: 52, column: 12, scope: !97)
!97 = distinct !DILexicalBlock(scope: !88, file: !5, line: 51, column: 12)
!98 = !DILocation(line: 52, column: 7, scope: !97)
!99 = !DILocation(line: 53, column: 12, scope: !97)
!100 = !DILocation(line: 53, column: 7, scope: !97)
!101 = !DILocation(line: 55, column: 3, scope: !85)
!102 = !DILocation(line: 55, column: 13, scope: !103)
!103 = distinct !DILexicalBlock(scope: !81, file: !5, line: 55, column: 13)
!104 = !DILocation(line: 55, column: 13, scope: !81)
!105 = !DILocation(line: 56, column: 10, scope: !106)
!106 = distinct !DILexicalBlock(scope: !103, file: !5, line: 55, column: 38)
!107 = !DILocation(line: 56, column: 5, scope: !106)
!108 = !DILocation(line: 57, column: 8, scope: !109)
!109 = distinct !DILexicalBlock(scope: !106, file: !5, line: 57, column: 8)
!110 = !DILocation(line: 57, column: 8, scope: !106)
!111 = !DILocation(line: 58, column: 12, scope: !112)
!112 = distinct !DILexicalBlock(scope: !109, file: !5, line: 57, column: 33)
!113 = !DILocation(line: 58, column: 7, scope: !112)
!114 = !DILocation(line: 59, column: 12, scope: !112)
!115 = !DILocation(line: 59, column: 7, scope: !112)
!116 = !DILocation(line: 60, column: 5, scope: !112)
!117 = !DILocation(line: 61, column: 12, scope: !118)
!118 = distinct !DILexicalBlock(scope: !109, file: !5, line: 60, column: 12)
!119 = !DILocation(line: 61, column: 7, scope: !118)
!120 = !DILocation(line: 62, column: 12, scope: !118)
!121 = !DILocation(line: 62, column: 7, scope: !118)
!122 = !DILocation(line: 64, column: 3, scope: !106)
!123 = !DILocation(line: 65, column: 10, scope: !124)
!124 = distinct !DILexicalBlock(scope: !103, file: !5, line: 64, column: 10)
!125 = !DILocation(line: 65, column: 5, scope: !124)
!126 = !DILocation(line: 66, column: 8, scope: !127)
!127 = distinct !DILexicalBlock(scope: !124, file: !5, line: 66, column: 8)
!128 = !DILocation(line: 66, column: 8, scope: !124)
!129 = !DILocation(line: 67, column: 12, scope: !130)
!130 = distinct !DILexicalBlock(scope: !127, file: !5, line: 66, column: 33)
!131 = !DILocation(line: 67, column: 7, scope: !130)
!132 = !DILocation(line: 68, column: 12, scope: !130)
!133 = !DILocation(line: 68, column: 7, scope: !130)
!134 = !DILocation(line: 69, column: 5, scope: !130)
!135 = !DILocation(line: 71, column: 12, scope: !136)
!136 = distinct !DILexicalBlock(scope: !127, file: !5, line: 69, column: 12)
!137 = !DILocation(line: 71, column: 7, scope: !136)
!138 = !DILocation(line: 74, column: 1, scope: !71)
!139 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 76, type: !140, scopeLine: 76, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!140 = !DISubroutineType(types: !141)
!141 = !{!19}
!142 = !DILocalVariable(name: "len", scope: !139, file: !5, line: 78, type: !143)
!143 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !19)
!144 = !DILocation(line: 0, scope: !139)
!145 = !DILocation(line: 79, column: 14, scope: !139)
!146 = !DILocalVariable(name: "head", scope: !139, file: !5, line: 79, type: !4)
!147 = !DILocation(line: 81, column: 3, scope: !139)
!148 = !DILocation(line: 83, column: 3, scope: !139)
