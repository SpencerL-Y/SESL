; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-fjen6hnf.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { i32, %struct.node* }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !17 {
  ret void, !dbg !20, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define internal void @myexit(i32 %0) #0 !dbg !22 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !21
  br label %2, !dbg !27, !verifier.code !21

2:                                                ; preds = %2, %1
  call void @llvm.dbg.label(metadata !28), !dbg !29, !verifier.code !21
  br label %2, !dbg !30, !verifier.code !21
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @node_create(i32 %0) #0 !dbg !31 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !34, metadata !DIExpression()), !dbg !35, !verifier.code !21
  %2 = call noalias i8* @malloc(i64 16) #4, !dbg !36, !verifier.code !21
  %3 = bitcast i8* %2 to %struct.node*, !dbg !37, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !38, metadata !DIExpression()), !dbg !35, !verifier.code !21
  %4 = icmp eq %struct.node* null, %3, !dbg !39, !verifier.code !21
  br i1 %4, label %5, label %6, !dbg !41, !verifier.code !21

5:                                                ; preds = %1
  call void @myexit(i32 1), !dbg !42, !verifier.code !21
  br label %6, !dbg !44, !verifier.code !21

6:                                                ; preds = %5, %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !45, !verifier.code !21
  store %struct.node* null, %struct.node** %7, align 8, !dbg !46, !verifier.code !21
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !47, !verifier.code !21
  store i32 %0, i32* %8, align 8, !dbg !48, !verifier.code !21
  ret %struct.node* %3, !dbg !49, !verifier.code !21
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @sll_create(i32 %0, i32 %1) #0 !dbg !50 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %3 = icmp sgt i32 %0, 0, !dbg !57, !verifier.code !21
  br i1 %3, label %.lr.ph, label %10, !dbg !60, !verifier.code !21

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !60, !verifier.code !21

4:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %8, %forwarder ], !verifier.code !21
  %.012 = phi %struct.node* [ null, %.lr.ph ], [ %5, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.03, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.012, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %5 = call %struct.node* @node_create(i32 %1), !dbg !61, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !63, metadata !DIExpression()), !dbg !64, !verifier.code !21
  %6 = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 1, !dbg !65, !verifier.code !21
  store %struct.node* %.012, %struct.node** %6, align 8, !dbg !66, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !21
  br label %7, !dbg !67, !verifier.code !21

7:                                                ; preds = %4
  %8 = add nsw i32 %.03, -1, !dbg !68, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %8, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %9 = icmp sgt i32 %8, 0, !dbg !57, !verifier.code !21
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !60, !llvm.loop !69, !verifier.code !21

._crit_edge:                                      ; preds = %7
  %split = phi %struct.node* [ %5, %7 ], !verifier.code !21
  br label %10, !dbg !60, !verifier.code !21

10:                                               ; preds = %._crit_edge, %2
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ null, %2 ], !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !21
  ret %struct.node* %.01.lcssa, !dbg !71, !verifier.code !21

forwarder:                                        ; preds = %7
  br label %4, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define internal void @sll_destroy(%struct.node* %0) #0 !dbg !72 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !21
  %2 = icmp ne %struct.node* %0, null, !dbg !77, !verifier.code !21
  br i1 %2, label %.lr.ph, label %8, !dbg !77, !verifier.code !21

.lr.ph:                                           ; preds = %1
  br label %3, !dbg !77, !verifier.code !21

3:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %0, %.lr.ph ], [ %5, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !21
  %4 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !78, !verifier.code !21
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !78, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !80, metadata !DIExpression()), !dbg !81, !verifier.code !21
  %6 = bitcast %struct.node* %.01 to i8*, !dbg !82, !verifier.code !21
  call void @free(i8* %6) #4, !dbg !83, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !21
  %7 = icmp ne %struct.node* %5, null, !dbg !77, !verifier.code !21
  br i1 %7, label %forwarder, label %._crit_edge, !dbg !77, !llvm.loop !84, !verifier.code !21

._crit_edge:                                      ; preds = %3
  br label %8, !dbg !77, !verifier.code !21

8:                                                ; preds = %._crit_edge, %1
  ret void, !dbg !86, !verifier.code !21

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !21
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @sll_get_data_at(%struct.node* %0, i32 %1) #0 !dbg !87 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !92, metadata !DIExpression()), !dbg !91, !verifier.code !21
  %3 = icmp sgt i32 %1, 0, !dbg !93, !verifier.code !21
  br i1 %3, label %.lr.ph, label %9, !dbg !94, !verifier.code !21

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !94, !verifier.code !21

4:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %6, %forwarder ], !verifier.code !21
  %.012 = phi i32 [ %1, %.lr.ph ], [ %7, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.012, metadata !92, metadata !DIExpression()), !dbg !91, !verifier.code !21
  %5 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 1, !dbg !95, !verifier.code !21
  %6 = load %struct.node*, %struct.node** %5, align 8, !dbg !95, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !21
  %7 = add nsw i32 %.012, -1, !dbg !97, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %7, metadata !92, metadata !DIExpression()), !dbg !91, !verifier.code !21
  %8 = icmp sgt i32 %7, 0, !dbg !93, !verifier.code !21
  br i1 %8, label %forwarder, label %._crit_edge, !dbg !94, !llvm.loop !98, !verifier.code !21

._crit_edge:                                      ; preds = %4
  %split = phi %struct.node* [ %6, %4 ], !verifier.code !21
  br label %9, !dbg !94, !verifier.code !21

9:                                                ; preds = %._crit_edge, %2
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %2 ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !21
  %10 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 0, !dbg !100, !verifier.code !21
  %11 = load i32, i32* %10, align 8, !dbg !100, !verifier.code !21
  ret i32 %11, !dbg !101, !verifier.code !21

forwarder:                                        ; preds = %4
  br label %4, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define internal void @sll_update_at(%struct.node* %0, i32 %1, i32 %2) #0 !dbg !102 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !107, metadata !DIExpression()), !dbg !106, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %2, metadata !108, metadata !DIExpression()), !dbg !106, !verifier.code !21
  %4 = icmp sgt i32 %2, 0, !dbg !109, !verifier.code !21
  br i1 %4, label %.lr.ph, label %10, !dbg !110, !verifier.code !21

.lr.ph:                                           ; preds = %3
  br label %5, !dbg !110, !verifier.code !21

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %7, %forwarder ], !verifier.code !21
  %.012 = phi i32 [ %2, %.lr.ph ], [ %8, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.012, metadata !108, metadata !DIExpression()), !dbg !106, !verifier.code !21
  %6 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 1, !dbg !111, !verifier.code !21
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !111, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !21
  %8 = add nsw i32 %.012, -1, !dbg !113, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %8, metadata !108, metadata !DIExpression()), !dbg !106, !verifier.code !21
  %9 = icmp sgt i32 %8, 0, !dbg !109, !verifier.code !21
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !110, !llvm.loop !114, !verifier.code !21

._crit_edge:                                      ; preds = %5
  %split = phi %struct.node* [ %7, %5 ], !verifier.code !21
  br label %10, !dbg !110, !verifier.code !21

10:                                               ; preds = %._crit_edge, %3
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %3 ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !21
  %11 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 0, !dbg !116, !verifier.code !21
  store i32 %1, i32* %11, align 8, !dbg !117, !verifier.code !21
  ret void, !dbg !118, !verifier.code !21

forwarder:                                        ; preds = %5
  br label %5, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !119 {
  call void @llvm.dbg.value(metadata i32 2, metadata !122, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 1, metadata !125, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %1 = call %struct.node* @sll_create(i32 2, i32 1), !dbg !126, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !127, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 0, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  br label %2, !dbg !129, !verifier.code !21

2:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 2, metadata !131, metadata !DIExpression()), !dbg !134, !verifier.code !21
  call void @sll_update_at(%struct.node* %1, i32 2, i32 0), !dbg !135, !verifier.code !21
  br label %3, !dbg !136, !verifier.code !21

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 1, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 3, metadata !131, metadata !DIExpression()), !dbg !134, !verifier.code !21
  call void @sll_update_at(%struct.node* %1, i32 3, i32 1), !dbg !135, !verifier.code !21
  br label %15, !dbg !136, !verifier.code !21

4:                                                ; preds = %15
  call void @llvm.dbg.value(metadata i32 0, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 2, metadata !137, metadata !DIExpression()), !dbg !141, !verifier.code !21
  %5 = call i32 @sll_get_data_at(%struct.node* %1, i32 0), !dbg !142, !verifier.code !21
  %6 = icmp ne i32 2, %5, !dbg !144, !verifier.code !21
  br i1 %6, label %7, label %8, !dbg !145, !verifier.code !21

7:                                                ; preds = %9, %4
  br label %12, !dbg !146, !verifier.code !21

8:                                                ; preds = %4
  br label %9, !dbg !148, !verifier.code !21

9:                                                ; preds = %8
  call void @llvm.dbg.value(metadata i32 1, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 3, metadata !137, metadata !DIExpression()), !dbg !141, !verifier.code !21
  %10 = call i32 @sll_get_data_at(%struct.node* %1, i32 1), !dbg !142, !verifier.code !21
  %11 = icmp ne i32 3, %10, !dbg !144, !verifier.code !21
  br i1 %11, label %7, label %13, !dbg !145, !verifier.code !21

12:                                               ; preds = %7
  call void @llvm.dbg.label(metadata !149), !dbg !150, !verifier.code !21
  call void @reach_error(), !dbg !151, !verifier.code !21
  call void @abort() #5, !dbg !153, !verifier.code !21
  unreachable, !dbg !153, !verifier.code !21

13:                                               ; preds = %9
  br label %14, !dbg !148, !verifier.code !21

14:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i32 2, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @sll_destroy(%struct.node* %1), !dbg !154, !verifier.code !21
  ret i32 0, !dbg !155, !verifier.code !21

15:                                               ; preds = %3
  call void @llvm.dbg.value(metadata i32 2, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 0, metadata !128, metadata !DIExpression()), !dbg !124, !verifier.code !21
  br label %4, !dbg !156, !verifier.code !21
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
!llvm.ident = !{!13}
!llvm.module.flags = !{!14, !15, !16}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/sll2n_update_all.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !12}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "SLL", file: !5, line: 12, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//sll2n_update_all.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 9, size: 128, elements: !8)
!8 = !{!9, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !5, line: 10, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 11, baseType: !6, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!13 = !{!"clang version 10.0.0-4ubuntu1 "}
!14 = !{i32 7, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = distinct !DISubprogram(name: "reach_error", scope: !5, file: !5, line: 2, type: !18, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{null}
!20 = !DILocation(line: 2, column: 20, scope: !17)
!21 = !{i1 false}
!22 = distinct !DISubprogram(name: "myexit", scope: !5, file: !5, line: 14, type: !23, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{null, !10}
!25 = !DILocalVariable(name: "s", arg: 1, scope: !22, file: !5, line: 14, type: !10)
!26 = !DILocation(line: 0, scope: !22)
!27 = !DILocation(line: 14, column: 20, scope: !22)
!28 = !DILabel(scope: !22, name: "_EXIT", file: !5, line: 15)
!29 = !DILocation(line: 15, column: 2, scope: !22)
!30 = !DILocation(line: 15, column: 9, scope: !22)
!31 = distinct !DISubprogram(name: "node_create", scope: !5, file: !5, line: 18, type: !32, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!4, !10}
!34 = !DILocalVariable(name: "data", arg: 1, scope: !31, file: !5, line: 18, type: !10)
!35 = !DILocation(line: 0, scope: !31)
!36 = !DILocation(line: 19, column: 20, scope: !31)
!37 = !DILocation(line: 19, column: 14, scope: !31)
!38 = !DILocalVariable(name: "temp", scope: !31, file: !5, line: 19, type: !4)
!39 = !DILocation(line: 20, column: 11, scope: !40)
!40 = distinct !DILexicalBlock(scope: !31, file: !5, line: 20, column: 6)
!41 = !DILocation(line: 20, column: 6, scope: !31)
!42 = !DILocation(line: 21, column: 5, scope: !43)
!43 = distinct !DILexicalBlock(scope: !40, file: !5, line: 20, column: 20)
!44 = !DILocation(line: 22, column: 3, scope: !43)
!45 = !DILocation(line: 23, column: 9, scope: !31)
!46 = !DILocation(line: 23, column: 14, scope: !31)
!47 = !DILocation(line: 24, column: 9, scope: !31)
!48 = !DILocation(line: 24, column: 14, scope: !31)
!49 = !DILocation(line: 25, column: 3, scope: !31)
!50 = distinct !DISubprogram(name: "sll_create", scope: !5, file: !5, line: 28, type: !51, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!51 = !DISubroutineType(types: !52)
!52 = !{!4, !10, !10}
!53 = !DILocalVariable(name: "len", arg: 1, scope: !50, file: !5, line: 28, type: !10)
!54 = !DILocation(line: 0, scope: !50)
!55 = !DILocalVariable(name: "data", arg: 2, scope: !50, file: !5, line: 28, type: !10)
!56 = !DILocalVariable(name: "head", scope: !50, file: !5, line: 29, type: !4)
!57 = !DILocation(line: 30, column: 13, scope: !58)
!58 = distinct !DILexicalBlock(scope: !59, file: !5, line: 30, column: 3)
!59 = distinct !DILexicalBlock(scope: !50, file: !5, line: 30, column: 3)
!60 = !DILocation(line: 30, column: 3, scope: !59)
!61 = !DILocation(line: 31, column: 20, scope: !62)
!62 = distinct !DILexicalBlock(scope: !58, file: !5, line: 30, column: 25)
!63 = !DILocalVariable(name: "new_head", scope: !62, file: !5, line: 31, type: !4)
!64 = !DILocation(line: 0, scope: !62)
!65 = !DILocation(line: 32, column: 15, scope: !62)
!66 = !DILocation(line: 32, column: 20, scope: !62)
!67 = !DILocation(line: 34, column: 3, scope: !62)
!68 = !DILocation(line: 30, column: 21, scope: !58)
!69 = distinct !{!69, !60, !70}
!70 = !DILocation(line: 34, column: 3, scope: !59)
!71 = !DILocation(line: 35, column: 3, scope: !50)
!72 = distinct !DISubprogram(name: "sll_destroy", scope: !5, file: !5, line: 38, type: !73, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !4}
!75 = !DILocalVariable(name: "head", arg: 1, scope: !72, file: !5, line: 38, type: !4)
!76 = !DILocation(line: 0, scope: !72)
!77 = !DILocation(line: 39, column: 3, scope: !72)
!78 = !DILocation(line: 40, column: 22, scope: !79)
!79 = distinct !DILexicalBlock(scope: !72, file: !5, line: 39, column: 15)
!80 = !DILocalVariable(name: "temp", scope: !79, file: !5, line: 40, type: !4)
!81 = !DILocation(line: 0, scope: !79)
!82 = !DILocation(line: 41, column: 10, scope: !79)
!83 = !DILocation(line: 41, column: 5, scope: !79)
!84 = distinct !{!84, !77, !85}
!85 = !DILocation(line: 43, column: 3, scope: !72)
!86 = !DILocation(line: 44, column: 1, scope: !72)
!87 = distinct !DISubprogram(name: "sll_get_data_at", scope: !5, file: !5, line: 46, type: !88, scopeLine: 46, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!88 = !DISubroutineType(types: !89)
!89 = !{!10, !4, !10}
!90 = !DILocalVariable(name: "head", arg: 1, scope: !87, file: !5, line: 46, type: !4)
!91 = !DILocation(line: 0, scope: !87)
!92 = !DILocalVariable(name: "index", arg: 2, scope: !87, file: !5, line: 46, type: !10)
!93 = !DILocation(line: 47, column: 15, scope: !87)
!94 = !DILocation(line: 47, column: 3, scope: !87)
!95 = !DILocation(line: 48, column: 18, scope: !96)
!96 = distinct !DILexicalBlock(scope: !87, file: !5, line: 47, column: 20)
!97 = !DILocation(line: 49, column: 10, scope: !96)
!98 = distinct !{!98, !94, !99}
!99 = !DILocation(line: 50, column: 3, scope: !87)
!100 = !DILocation(line: 51, column: 16, scope: !87)
!101 = !DILocation(line: 51, column: 3, scope: !87)
!102 = distinct !DISubprogram(name: "sll_update_at", scope: !5, file: !5, line: 54, type: !103, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!103 = !DISubroutineType(types: !104)
!104 = !{null, !4, !10, !10}
!105 = !DILocalVariable(name: "head", arg: 1, scope: !102, file: !5, line: 54, type: !4)
!106 = !DILocation(line: 0, scope: !102)
!107 = !DILocalVariable(name: "data", arg: 2, scope: !102, file: !5, line: 54, type: !10)
!108 = !DILocalVariable(name: "index", arg: 3, scope: !102, file: !5, line: 54, type: !10)
!109 = !DILocation(line: 55, column: 15, scope: !102)
!110 = !DILocation(line: 55, column: 3, scope: !102)
!111 = !DILocation(line: 56, column: 18, scope: !112)
!112 = distinct !DILexicalBlock(scope: !102, file: !5, line: 55, column: 20)
!113 = !DILocation(line: 57, column: 10, scope: !112)
!114 = distinct !{!114, !110, !115}
!115 = !DILocation(line: 58, column: 3, scope: !102)
!116 = !DILocation(line: 59, column: 9, scope: !102)
!117 = !DILocation(line: 59, column: 14, scope: !102)
!118 = !DILocation(line: 60, column: 1, scope: !102)
!119 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 62, type: !120, scopeLine: 62, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!120 = !DISubroutineType(types: !121)
!121 = !{!10}
!122 = !DILocalVariable(name: "len", scope: !119, file: !5, line: 63, type: !123)
!123 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!124 = !DILocation(line: 0, scope: !119)
!125 = !DILocalVariable(name: "data", scope: !119, file: !5, line: 64, type: !123)
!126 = !DILocation(line: 65, column: 11, scope: !119)
!127 = !DILocalVariable(name: "s", scope: !119, file: !5, line: 65, type: !4)
!128 = !DILocalVariable(name: "i", scope: !119, file: !5, line: 66, type: !10)
!129 = !DILocation(line: 67, column: 3, scope: !130)
!130 = distinct !DILexicalBlock(scope: !119, file: !5, line: 67, column: 3)
!131 = !DILocalVariable(name: "new_data", scope: !132, file: !5, line: 68, type: !10)
!132 = distinct !DILexicalBlock(scope: !133, file: !5, line: 67, column: 28)
!133 = distinct !DILexicalBlock(scope: !130, file: !5, line: 67, column: 3)
!134 = !DILocation(line: 0, scope: !132)
!135 = !DILocation(line: 69, column: 5, scope: !132)
!136 = !DILocation(line: 70, column: 3, scope: !132)
!137 = !DILocalVariable(name: "expected", scope: !138, file: !5, line: 72, type: !10)
!138 = distinct !DILexicalBlock(scope: !139, file: !5, line: 71, column: 28)
!139 = distinct !DILexicalBlock(scope: !140, file: !5, line: 71, column: 3)
!140 = distinct !DILexicalBlock(scope: !119, file: !5, line: 71, column: 3)
!141 = !DILocation(line: 0, scope: !138)
!142 = !DILocation(line: 73, column: 20, scope: !143)
!143 = distinct !DILexicalBlock(scope: !138, file: !5, line: 73, column: 8)
!144 = !DILocation(line: 73, column: 17, scope: !143)
!145 = !DILocation(line: 73, column: 8, scope: !138)
!146 = !DILocation(line: 74, column: 7, scope: !147)
!147 = distinct !DILexicalBlock(scope: !143, file: !5, line: 73, column: 43)
!148 = !DILocation(line: 76, column: 3, scope: !138)
!149 = !DILabel(scope: !119, name: "ERROR", file: !5, line: 79)
!150 = !DILocation(line: 79, column: 2, scope: !119)
!151 = !DILocation(line: 79, column: 10, scope: !152)
!152 = distinct !DILexicalBlock(scope: !119, file: !5, line: 79, column: 9)
!153 = !DILocation(line: 79, column: 24, scope: !152)
!154 = !DILocation(line: 77, column: 3, scope: !119)
!155 = !DILocation(line: 78, column: 3, scope: !119)
!156 = !DILocation(line: 71, column: 3, scope: !140)
