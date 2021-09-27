; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-llt9qwin.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, %struct.node* }

; Function Attrs: noinline nounwind uwtable
define internal void @assume_abort_if_not(i32 %0) #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !12, metadata !DIExpression()), !dbg !13, !verifier.code !14
  %2 = icmp ne i32 %0, 0, !dbg !15, !verifier.code !14
  br i1 %2, label %4, label %3, !dbg !17, !verifier.code !14

3:                                                ; preds = %1
  call void @abort() #5, !dbg !18, !verifier.code !14
  unreachable, !dbg !18, !verifier.code !14

4:                                                ; preds = %1
  ret void, !dbg !20, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn
declare dso_local void @abort() #2

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !21 {
  ret void, !dbg !24, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @__VERIFIER_assert(i32 %0) #0 !dbg !25 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !26, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %2 = icmp ne i32 %0, 0, !dbg !28, !verifier.code !14
  br i1 %2, label %5, label %3, !dbg !30, !verifier.code !14

3:                                                ; preds = %1
  br label %4, !dbg !31, !verifier.code !14

4:                                                ; preds = %3
  call void @llvm.dbg.label(metadata !32), !dbg !34, !verifier.code !14
  call void @reach_error(), !dbg !35, !verifier.code !14
  call void @abort() #5, !dbg !37, !verifier.code !14
  unreachable, !dbg !37, !verifier.code !14

5:                                                ; preds = %1
  ret void, !dbg !38, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @remove(%struct.node* %0) #0 !dbg !39 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !47, metadata !DIExpression()), !dbg !48, !verifier.code !14
  %2 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !49, !verifier.code !14
  %3 = load %struct.node*, %struct.node** %2, align 8, !dbg !49, !verifier.code !14
  %4 = icmp ne %struct.node* %3, null, !dbg !51, !verifier.code !14
  br i1 %4, label %5, label %11, !dbg !52, !verifier.code !14

5:                                                ; preds = %1
  %6 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !53, !verifier.code !14
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !53, !verifier.code !14
  %8 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !54, !verifier.code !14
  %9 = load %struct.node*, %struct.node** %8, align 8, !dbg !54, !verifier.code !14
  %10 = getelementptr inbounds %struct.node, %struct.node* %9, i32 0, i32 0, !dbg !55, !verifier.code !14
  store %struct.node* %7, %struct.node** %10, align 8, !dbg !56, !verifier.code !14
  br label %11, !dbg !57, !verifier.code !14

11:                                               ; preds = %5, %1
  %12 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !58, !verifier.code !14
  %13 = load %struct.node*, %struct.node** %12, align 8, !dbg !58, !verifier.code !14
  %14 = icmp ne %struct.node* %13, null, !dbg !60, !verifier.code !14
  br i1 %14, label %15, label %21, !dbg !61, !verifier.code !14

15:                                               ; preds = %11
  %16 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !62, !verifier.code !14
  %17 = load %struct.node*, %struct.node** %16, align 8, !dbg !62, !verifier.code !14
  %18 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !63, !verifier.code !14
  %19 = load %struct.node*, %struct.node** %18, align 8, !dbg !63, !verifier.code !14
  %20 = getelementptr inbounds %struct.node, %struct.node* %19, i32 0, i32 1, !dbg !64, !verifier.code !14
  store %struct.node* %17, %struct.node** %20, align 8, !dbg !65, !verifier.code !14
  br label %21, !dbg !66, !verifier.code !14

21:                                               ; preds = %15, %11
  ret void, !dbg !67, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @re_insert(%struct.node* %0) #0 !dbg !68 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !69, metadata !DIExpression()), !dbg !70, !verifier.code !14
  %2 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !71, !verifier.code !14
  %3 = load %struct.node*, %struct.node** %2, align 8, !dbg !71, !verifier.code !14
  %4 = icmp ne %struct.node* %3, null, !dbg !73, !verifier.code !14
  br i1 %4, label %5, label %9, !dbg !74, !verifier.code !14

5:                                                ; preds = %1
  %6 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !75, !verifier.code !14
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !75, !verifier.code !14
  %8 = getelementptr inbounds %struct.node, %struct.node* %7, i32 0, i32 0, !dbg !76, !verifier.code !14
  store %struct.node* %0, %struct.node** %8, align 8, !dbg !77, !verifier.code !14
  br label %9, !dbg !78, !verifier.code !14

9:                                                ; preds = %5, %1
  %10 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !79, !verifier.code !14
  %11 = load %struct.node*, %struct.node** %10, align 8, !dbg !79, !verifier.code !14
  %12 = icmp ne %struct.node* %11, null, !dbg !81, !verifier.code !14
  br i1 %12, label %13, label %17, !dbg !82, !verifier.code !14

13:                                               ; preds = %9
  %14 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !83, !verifier.code !14
  %15 = load %struct.node*, %struct.node** %14, align 8, !dbg !83, !verifier.code !14
  %16 = getelementptr inbounds %struct.node, %struct.node* %15, i32 0, i32 1, !dbg !84, !verifier.code !14
  store %struct.node* %0, %struct.node** %16, align 8, !dbg !85, !verifier.code !14
  br label %17, !dbg !86, !verifier.code !14

17:                                               ; preds = %13, %9
  ret void, !dbg !87, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal zeroext i1 @is_list_containing_x(%struct.node* %0, %struct.node* %1) #0 !dbg !88 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !94, metadata !DIExpression()), !dbg !93, !verifier.code !14
  %3 = icmp eq %struct.node* %0, %1, !dbg !95, !verifier.code !14
  br i1 %3, label %4, label %5, !dbg !97, !verifier.code !14

4:                                                ; preds = %2
  br label %14, !dbg !98, !verifier.code !14

5:                                                ; preds = %2
  %6 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !99, !verifier.code !14
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !99, !verifier.code !14
  %8 = icmp ne %struct.node* %7, null, !dbg !101, !verifier.code !14
  br i1 %8, label %9, label %13, !dbg !102, !verifier.code !14

9:                                                ; preds = %5
  %10 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !103, !verifier.code !14
  %11 = load %struct.node*, %struct.node** %10, align 8, !dbg !103, !verifier.code !14
  %12 = call zeroext i1 @is_list_containing_x(%struct.node* %11, %struct.node* %1), !dbg !104, !verifier.code !14
  br label %14, !dbg !105, !verifier.code !14

13:                                               ; preds = %5
  br label %14, !dbg !106, !verifier.code !14

14:                                               ; preds = %13, %9, %4
  %.0 = phi i1 [ true, %4 ], [ %12, %9 ], [ false, %13 ], !dbg !93, !verifier.code !14
  ret i1 %.0, !dbg !107, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !108 {
  %1 = alloca %struct.node, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.node* %1, metadata !111, metadata !DIExpression()), !dbg !112, !verifier.code !14
  %2 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 0, !dbg !113, !verifier.code !14
  store %struct.node* null, %struct.node** %2, align 8, !dbg !114, !verifier.code !14
  %3 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 1, !dbg !115, !verifier.code !14
  store %struct.node* null, %struct.node** %3, align 8, !dbg !116, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !119, metadata !DIExpression()), !dbg !118, !verifier.code !14
  %4 = call zeroext i1 @__VERIFIER_nondet_bool(), !dbg !120, !verifier.code !121
  br i1 %4, label %.lr.ph, label %.loopexit, !dbg !122, !verifier.code !14

.lr.ph:                                           ; preds = %0
  br label %5, !dbg !122, !verifier.code !14

5:                                                ; preds = %forwarder, %.lr.ph
  %.04 = phi %struct.node* [ %1, %.lr.ph ], [ %.1, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.04, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !14
  %6 = call noalias i8* @malloc(i64 16) #6, !dbg !123, !verifier.code !14
  %7 = bitcast i8* %6 to %struct.node*, !dbg !123, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !125, metadata !DIExpression()), !dbg !126, !verifier.code !14
  %8 = icmp eq %struct.node* %7, null, !dbg !127, !verifier.code !14
  br i1 %8, label %9, label %10, !dbg !129, !verifier.code !14

9:                                                ; preds = %5
  %.0.lcssa1 = phi %struct.node* [ %.04, %5 ], !dbg !118, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa1, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !14
  br label %18, !dbg !130, !verifier.code !14

10:                                               ; preds = %5
  %11 = getelementptr inbounds %struct.node, %struct.node* %7, i32 0, i32 0, !dbg !131, !verifier.code !14
  store %struct.node* %1, %struct.node** %11, align 8, !dbg !132, !verifier.code !14
  %12 = getelementptr inbounds %struct.node, %struct.node* %7, i32 0, i32 1, !dbg !133, !verifier.code !14
  store %struct.node* null, %struct.node** %12, align 8, !dbg !134, !verifier.code !14
  %13 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 1, !dbg !135, !verifier.code !14
  store %struct.node* %7, %struct.node** %13, align 8, !dbg !136, !verifier.code !14
  %14 = call zeroext i1 @__VERIFIER_nondet_bool(), !dbg !137, !verifier.code !121
  br i1 %14, label %15, label %16, !dbg !139, !verifier.code !14

15:                                               ; preds = %10
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !14
  br label %16, !dbg !140, !verifier.code !14

16:                                               ; preds = %15, %10
  %.1 = phi %struct.node* [ %7, %15 ], [ %.04, %10 ], !dbg !118, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.1, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !14
  %17 = call zeroext i1 @__VERIFIER_nondet_bool(), !dbg !120, !verifier.code !121
  br i1 %17, label %forwarder, label %..loopexit_crit_edge, !dbg !122, !llvm.loop !141, !verifier.code !14

..loopexit_crit_edge:                             ; preds = %16
  %split = phi %struct.node* [ %.1, %16 ], !verifier.code !14
  br label %.loopexit, !dbg !122, !verifier.code !14

.loopexit:                                        ; preds = %..loopexit_crit_edge, %0
  %.0.lcssa = phi %struct.node* [ %split, %..loopexit_crit_edge ], [ %1, %0 ], !dbg !118, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !14
  br label %18, !dbg !143, !verifier.code !14

18:                                               ; preds = %.loopexit, %9
  %.02 = phi %struct.node* [ %.0.lcssa, %.loopexit ], [ %.0.lcssa1, %9 ], !verifier.code !14
  %19 = call zeroext i1 @is_list_containing_x(%struct.node* %1, %struct.node* %.02), !dbg !143, !verifier.code !14
  %20 = zext i1 %19 to i32, !dbg !143, !verifier.code !14
  call void @assume_abort_if_not(i32 %20), !dbg !144, !verifier.code !14
  call void @remove(%struct.node* %.02), !dbg !145, !verifier.code !14
  %21 = icmp eq %struct.node* %1, %.02, !dbg !146, !verifier.code !14
  br i1 %21, label %25, label %22, !dbg !147, !verifier.code !14

22:                                               ; preds = %18
  %23 = call zeroext i1 @is_list_containing_x(%struct.node* %1, %struct.node* %.02), !dbg !148, !verifier.code !14
  %24 = xor i1 %23, true, !dbg !149, !verifier.code !121
  br label %25, !dbg !147, !verifier.code !14

25:                                               ; preds = %22, %18
  %.03 = phi %struct.node* [ %.02, %18 ], [ %.02, %22 ], !verifier.code !14
  %26 = phi i1 [ true, %18 ], [ %24, %22 ], !verifier.code !121
  %27 = zext i1 %26 to i32, !dbg !147, !verifier.code !121
  call void @__VERIFIER_assert(i32 %27), !dbg !150, !verifier.code !121
  call void @re_insert(%struct.node* %.02), !dbg !151, !verifier.code !14
  %28 = call zeroext i1 @is_list_containing_x(%struct.node* %1, %struct.node* %.03), !dbg !152, !verifier.code !14
  %29 = zext i1 %28 to i32, !dbg !152, !verifier.code !121
  call void @__VERIFIER_assert(i32 %29), !dbg !153, !verifier.code !121
  ret i32 0, !dbg !154, !verifier.code !14

forwarder:                                        ; preds = %16
  br label %5, !verifier.code !14
}

declare dso_local zeroext i1 @__VERIFIER_nondet_bool() #3

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #4

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dancing.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "assume_abort_if_not", scope: !8, file: !8, line: 2, type: !9, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dancing.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !DISubroutineType(types: !10)
!10 = !{null, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "cond", arg: 1, scope: !7, file: !8, line: 2, type: !11)
!13 = !DILocation(line: 0, scope: !7)
!14 = !{i1 false}
!15 = !DILocation(line: 3, column: 7, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !8, line: 3, column: 6)
!17 = !DILocation(line: 3, column: 6, scope: !7)
!18 = !DILocation(line: 3, column: 14, scope: !19)
!19 = distinct !DILexicalBlock(scope: !16, file: !8, line: 3, column: 13)
!20 = !DILocation(line: 4, column: 1, scope: !7)
!21 = distinct !DISubprogram(name: "reach_error", scope: !8, file: !8, line: 61, type: !22, scopeLine: 61, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{null}
!24 = !DILocation(line: 61, column: 20, scope: !21)
!25 = distinct !DISubprogram(name: "__VERIFIER_assert", scope: !8, file: !8, line: 63, type: !9, scopeLine: 63, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!26 = !DILocalVariable(name: "cond", arg: 1, scope: !25, file: !8, line: 63, type: !11)
!27 = !DILocation(line: 0, scope: !25)
!28 = !DILocation(line: 64, column: 8, scope: !29)
!29 = distinct !DILexicalBlock(scope: !25, file: !8, line: 64, column: 7)
!30 = !DILocation(line: 64, column: 7, scope: !25)
!31 = !DILocation(line: 64, column: 16, scope: !29)
!32 = !DILabel(scope: !33, name: "ERROR", file: !8, line: 65)
!33 = distinct !DILexicalBlock(scope: !29, file: !8, line: 64, column: 16)
!34 = !DILocation(line: 65, column: 5, scope: !33)
!35 = !DILocation(line: 65, column: 13, scope: !36)
!36 = distinct !DILexicalBlock(scope: !33, file: !8, line: 65, column: 12)
!37 = !DILocation(line: 65, column: 27, scope: !36)
!38 = !DILocation(line: 67, column: 3, scope: !25)
!39 = distinct !DISubprogram(name: "remove", scope: !8, file: !8, line: 78, type: !40, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{null, !42}
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !8, line: 72, size: 128, elements: !44)
!44 = !{!45, !46}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "L", scope: !43, file: !8, line: 74, baseType: !42, size: 64)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "R", scope: !43, file: !8, line: 75, baseType: !42, size: 64, offset: 64)
!47 = !DILocalVariable(name: "x", arg: 1, scope: !39, file: !8, line: 78, type: !42)
!48 = !DILocation(line: 0, scope: !39)
!49 = !DILocation(line: 80, column: 9, scope: !50)
!50 = distinct !DILexicalBlock(scope: !39, file: !8, line: 80, column: 6)
!51 = !DILocation(line: 80, column: 6, scope: !50)
!52 = !DILocation(line: 80, column: 6, scope: !39)
!53 = !DILocation(line: 81, column: 16, scope: !50)
!54 = !DILocation(line: 81, column: 8, scope: !50)
!55 = !DILocation(line: 81, column: 11, scope: !50)
!56 = !DILocation(line: 81, column: 12, scope: !50)
!57 = !DILocation(line: 81, column: 5, scope: !50)
!58 = !DILocation(line: 82, column: 9, scope: !59)
!59 = distinct !DILexicalBlock(scope: !39, file: !8, line: 82, column: 6)
!60 = !DILocation(line: 82, column: 6, scope: !59)
!61 = !DILocation(line: 82, column: 6, scope: !39)
!62 = !DILocation(line: 83, column: 16, scope: !59)
!63 = !DILocation(line: 83, column: 8, scope: !59)
!64 = !DILocation(line: 83, column: 11, scope: !59)
!65 = !DILocation(line: 83, column: 12, scope: !59)
!66 = !DILocation(line: 83, column: 5, scope: !59)
!67 = !DILocation(line: 84, column: 1, scope: !39)
!68 = distinct !DISubprogram(name: "re_insert", scope: !8, file: !8, line: 86, type: !40, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!69 = !DILocalVariable(name: "x", arg: 1, scope: !68, file: !8, line: 86, type: !42)
!70 = !DILocation(line: 0, scope: !68)
!71 = !DILocation(line: 88, column: 9, scope: !72)
!72 = distinct !DILexicalBlock(scope: !68, file: !8, line: 88, column: 6)
!73 = !DILocation(line: 88, column: 6, scope: !72)
!74 = !DILocation(line: 88, column: 6, scope: !68)
!75 = !DILocation(line: 89, column: 8, scope: !72)
!76 = !DILocation(line: 89, column: 11, scope: !72)
!77 = !DILocation(line: 89, column: 12, scope: !72)
!78 = !DILocation(line: 89, column: 5, scope: !72)
!79 = !DILocation(line: 90, column: 9, scope: !80)
!80 = distinct !DILexicalBlock(scope: !68, file: !8, line: 90, column: 6)
!81 = !DILocation(line: 90, column: 6, scope: !80)
!82 = !DILocation(line: 90, column: 6, scope: !68)
!83 = !DILocation(line: 91, column: 8, scope: !80)
!84 = !DILocation(line: 91, column: 11, scope: !80)
!85 = !DILocation(line: 91, column: 12, scope: !80)
!86 = !DILocation(line: 91, column: 5, scope: !80)
!87 = !DILocation(line: 92, column: 1, scope: !68)
!88 = distinct !DISubprogram(name: "is_list_containing_x", scope: !8, file: !8, line: 94, type: !89, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!89 = !DISubroutineType(types: !90)
!90 = !{!91, !42, !42}
!91 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!92 = !DILocalVariable(name: "l", arg: 1, scope: !88, file: !8, line: 94, type: !42)
!93 = !DILocation(line: 0, scope: !88)
!94 = !DILocalVariable(name: "x", arg: 2, scope: !88, file: !8, line: 94, type: !42)
!95 = !DILocation(line: 96, column: 7, scope: !96)
!96 = distinct !DILexicalBlock(scope: !88, file: !8, line: 96, column: 6)
!97 = !DILocation(line: 96, column: 6, scope: !88)
!98 = !DILocation(line: 97, column: 5, scope: !96)
!99 = !DILocation(line: 99, column: 9, scope: !100)
!100 = distinct !DILexicalBlock(scope: !88, file: !8, line: 99, column: 6)
!101 = !DILocation(line: 99, column: 6, scope: !100)
!102 = !DILocation(line: 99, column: 6, scope: !88)
!103 = !DILocation(line: 100, column: 36, scope: !100)
!104 = !DILocation(line: 100, column: 12, scope: !100)
!105 = !DILocation(line: 100, column: 5, scope: !100)
!106 = !DILocation(line: 102, column: 3, scope: !88)
!107 = !DILocation(line: 103, column: 1, scope: !88)
!108 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 105, type: !109, scopeLine: 106, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!109 = !DISubroutineType(types: !110)
!110 = !{!11}
!111 = !DILocalVariable(name: "list", scope: !108, file: !8, line: 107, type: !43)
!112 = !DILocation(line: 107, column: 15, scope: !108)
!113 = !DILocation(line: 108, column: 8, scope: !108)
!114 = !DILocation(line: 108, column: 9, scope: !108)
!115 = !DILocation(line: 109, column: 8, scope: !108)
!116 = !DILocation(line: 109, column: 9, scope: !108)
!117 = !DILocalVariable(name: "x", scope: !108, file: !8, line: 111, type: !42)
!118 = !DILocation(line: 0, scope: !108)
!119 = !DILocalVariable(name: "tail", scope: !108, file: !8, line: 111, type: !42)
!120 = !DILocation(line: 113, column: 9, scope: !108)
!121 = !{i1 true}
!122 = !DILocation(line: 113, column: 3, scope: !108)
!123 = !DILocation(line: 115, column: 20, scope: !124)
!124 = distinct !DILexicalBlock(scope: !108, file: !8, line: 114, column: 3)
!125 = !DILocalVariable(name: "n", scope: !124, file: !8, line: 115, type: !42)
!126 = !DILocation(line: 0, scope: !124)
!127 = !DILocation(line: 116, column: 9, scope: !128)
!128 = distinct !DILexicalBlock(scope: !124, file: !8, line: 116, column: 8)
!129 = !DILocation(line: 116, column: 8, scope: !124)
!130 = !DILocation(line: 117, column: 7, scope: !128)
!131 = !DILocation(line: 119, column: 8, scope: !124)
!132 = !DILocation(line: 119, column: 9, scope: !124)
!133 = !DILocation(line: 120, column: 8, scope: !124)
!134 = !DILocation(line: 120, column: 9, scope: !124)
!135 = !DILocation(line: 121, column: 11, scope: !124)
!136 = !DILocation(line: 121, column: 12, scope: !124)
!137 = !DILocation(line: 123, column: 8, scope: !138)
!138 = distinct !DILexicalBlock(scope: !124, file: !8, line: 123, column: 8)
!139 = !DILocation(line: 123, column: 8, scope: !124)
!140 = !DILocation(line: 124, column: 7, scope: !138)
!141 = distinct !{!141, !122, !142}
!142 = !DILocation(line: 125, column: 3, scope: !108)
!143 = !DILocation(line: 127, column: 23, scope: !108)
!144 = !DILocation(line: 127, column: 3, scope: !108)
!145 = !DILocation(line: 128, column: 3, scope: !108)
!146 = !DILocation(line: 129, column: 26, scope: !108)
!147 = !DILocation(line: 129, column: 30, scope: !108)
!148 = !DILocation(line: 129, column: 34, scope: !108)
!149 = !DILocation(line: 129, column: 33, scope: !108)
!150 = !DILocation(line: 129, column: 3, scope: !108)
!151 = !DILocation(line: 130, column: 3, scope: !108)
!152 = !DILocation(line: 131, column: 21, scope: !108)
!153 = !DILocation(line: 131, column: 3, scope: !108)
!154 = !DILocation(line: 133, column: 3, scope: !108)
