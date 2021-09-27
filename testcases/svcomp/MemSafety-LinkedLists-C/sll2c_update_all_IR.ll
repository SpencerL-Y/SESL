; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-3ekp_xpz.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, i32 }

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
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !45, !verifier.code !21
  store %struct.node* null, %struct.node** %7, align 8, !dbg !46, !verifier.code !21
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !47, !verifier.code !21
  store i32 %0, i32* %8, align 8, !dbg !48, !verifier.code !21
  ret %struct.node* %3, !dbg !49, !verifier.code !21
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @sll_circular_create(i32 %0, i32 %1) #0 !dbg !50 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %3 = call %struct.node* @node_create(i32 %1), !dbg !56, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !57, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !58, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %0, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %4 = icmp sgt i32 %0, 1, !dbg !59, !verifier.code !21
  br i1 %4, label %.lr.ph, label %10, !dbg !60, !verifier.code !21

.lr.ph:                                           ; preds = %2
  br label %5, !dbg !60, !verifier.code !21

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %8, %forwarder ], !verifier.code !21
  %.012 = phi %struct.node* [ %3, %.lr.ph ], [ %6, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.03, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.012, metadata !57, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %6 = call %struct.node* @node_create(i32 %1), !dbg !61, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !63, metadata !DIExpression()), !dbg !64, !verifier.code !21
  %7 = getelementptr inbounds %struct.node, %struct.node* %6, i32 0, i32 0, !dbg !65, !verifier.code !21
  store %struct.node* %.012, %struct.node** %7, align 8, !dbg !66, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !57, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %8 = add nsw i32 %.03, -1, !dbg !67, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %8, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %9 = icmp sgt i32 %8, 1, !dbg !59, !verifier.code !21
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !60, !llvm.loop !68, !verifier.code !21

._crit_edge:                                      ; preds = %5
  %split = phi %struct.node* [ %6, %5 ], !verifier.code !21
  br label %10, !dbg !60, !verifier.code !21

10:                                               ; preds = %._crit_edge, %2
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %3, %2 ], !dbg !54, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !57, metadata !DIExpression()), !dbg !54, !verifier.code !21
  %11 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !70, !verifier.code !21
  store %struct.node* %.01.lcssa, %struct.node** %11, align 8, !dbg !71, !verifier.code !21
  ret %struct.node* %.01.lcssa, !dbg !72, !verifier.code !21

forwarder:                                        ; preds = %5
  br label %5, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define internal void @sll_circular_destroy(%struct.node* %0) #0 !dbg !73 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !76, metadata !DIExpression()), !dbg !77, !verifier.code !21
  %2 = icmp ne %struct.node* null, %0, !dbg !78, !verifier.code !21
  br i1 %2, label %3, label %14, !dbg !80, !verifier.code !21

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !81, !verifier.code !21
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !81, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !83, metadata !DIExpression()), !dbg !84, !verifier.code !21
  %6 = icmp ne %struct.node* %5, %0, !dbg !85, !verifier.code !21
  br i1 %6, label %.lr.ph, label %12, !dbg !86, !verifier.code !21

.lr.ph:                                           ; preds = %3
  br label %7, !dbg !86, !verifier.code !21

7:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %5, %.lr.ph ], [ %9, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !83, metadata !DIExpression()), !dbg !84, !verifier.code !21
  %8 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !87, !verifier.code !21
  %9 = load %struct.node*, %struct.node** %8, align 8, !dbg !87, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %9, metadata !89, metadata !DIExpression()), !dbg !90, !verifier.code !21
  %10 = bitcast %struct.node* %.01 to i8*, !dbg !91, !verifier.code !21
  call void @free(i8* %10) #4, !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %9, metadata !83, metadata !DIExpression()), !dbg !84, !verifier.code !21
  %11 = icmp ne %struct.node* %9, %0, !dbg !85, !verifier.code !21
  br i1 %11, label %forwarder, label %._crit_edge, !dbg !86, !llvm.loop !93, !verifier.code !21

._crit_edge:                                      ; preds = %7
  br label %12, !dbg !86, !verifier.code !21

12:                                               ; preds = %._crit_edge, %3
  %13 = bitcast %struct.node* %0 to i8*, !dbg !95, !verifier.code !21
  call void @free(i8* %13) #4, !dbg !96, !verifier.code !21
  br label %14, !dbg !97, !verifier.code !21

14:                                               ; preds = %12, %1
  ret void, !dbg !98, !verifier.code !21

forwarder:                                        ; preds = %7
  br label %7, !verifier.code !21
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @sll_circular_get_data_at(%struct.node* %0, i32 %1) #0 !dbg !99 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !104, metadata !DIExpression()), !dbg !103, !verifier.code !21
  %3 = icmp sgt i32 %1, 0, !dbg !105, !verifier.code !21
  br i1 %3, label %.lr.ph, label %9, !dbg !106, !verifier.code !21

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !106, !verifier.code !21

4:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %6, %forwarder ], !verifier.code !21
  %.012 = phi i32 [ %1, %.lr.ph ], [ %7, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.012, metadata !104, metadata !DIExpression()), !dbg !103, !verifier.code !21
  %5 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 0, !dbg !107, !verifier.code !21
  %6 = load %struct.node*, %struct.node** %5, align 8, !dbg !107, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !21
  %7 = add nsw i32 %.012, -1, !dbg !109, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %7, metadata !104, metadata !DIExpression()), !dbg !103, !verifier.code !21
  %8 = icmp sgt i32 %7, 0, !dbg !105, !verifier.code !21
  br i1 %8, label %forwarder, label %._crit_edge, !dbg !106, !llvm.loop !110, !verifier.code !21

._crit_edge:                                      ; preds = %4
  %split = phi %struct.node* [ %6, %4 ], !verifier.code !21
  br label %9, !dbg !106, !verifier.code !21

9:                                                ; preds = %._crit_edge, %2
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %2 ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !21
  %10 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 1, !dbg !112, !verifier.code !21
  %11 = load i32, i32* %10, align 8, !dbg !112, !verifier.code !21
  ret i32 %11, !dbg !113, !verifier.code !21

forwarder:                                        ; preds = %4
  br label %4, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define internal void @sll_circular_update_at(%struct.node* %0, i32 %1, i32 %2) #0 !dbg !114 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !119, metadata !DIExpression()), !dbg !118, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %2, metadata !120, metadata !DIExpression()), !dbg !118, !verifier.code !21
  %4 = icmp sgt i32 %2, 0, !dbg !121, !verifier.code !21
  br i1 %4, label %.lr.ph, label %10, !dbg !122, !verifier.code !21

.lr.ph:                                           ; preds = %3
  br label %5, !dbg !122, !verifier.code !21

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %7, %forwarder ], !verifier.code !21
  %.012 = phi i32 [ %2, %.lr.ph ], [ %8, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.012, metadata !120, metadata !DIExpression()), !dbg !118, !verifier.code !21
  %6 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 0, !dbg !123, !verifier.code !21
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !123, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !21
  %8 = add nsw i32 %.012, -1, !dbg !125, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %8, metadata !120, metadata !DIExpression()), !dbg !118, !verifier.code !21
  %9 = icmp sgt i32 %8, 0, !dbg !121, !verifier.code !21
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !122, !llvm.loop !126, !verifier.code !21

._crit_edge:                                      ; preds = %5
  %split = phi %struct.node* [ %7, %5 ], !verifier.code !21
  br label %10, !dbg !122, !verifier.code !21

10:                                               ; preds = %._crit_edge, %3
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %3 ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !21
  %11 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 1, !dbg !128, !verifier.code !21
  store i32 %1, i32* %11, align 8, !dbg !129, !verifier.code !21
  ret void, !dbg !130, !verifier.code !21

forwarder:                                        ; preds = %5
  br label %5, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !131 {
  call void @llvm.dbg.value(metadata i32 2, metadata !134, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 1, metadata !137, metadata !DIExpression()), !dbg !136, !verifier.code !21
  %1 = call %struct.node* @sll_circular_create(i32 2, i32 1), !dbg !138, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !139, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 0, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  br label %2, !dbg !141, !verifier.code !21

2:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 2, metadata !143, metadata !DIExpression()), !dbg !146, !verifier.code !21
  call void @sll_circular_update_at(%struct.node* %1, i32 2, i32 0), !dbg !147, !verifier.code !21
  br label %3, !dbg !148, !verifier.code !21

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 1, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 3, metadata !143, metadata !DIExpression()), !dbg !146, !verifier.code !21
  call void @sll_circular_update_at(%struct.node* %1, i32 3, i32 1), !dbg !147, !verifier.code !21
  br label %15, !dbg !148, !verifier.code !21

4:                                                ; preds = %15
  call void @llvm.dbg.value(metadata i32 0, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 2, metadata !149, metadata !DIExpression()), !dbg !153, !verifier.code !21
  %5 = call i32 @sll_circular_get_data_at(%struct.node* %1, i32 0), !dbg !154, !verifier.code !21
  %6 = icmp ne i32 2, %5, !dbg !156, !verifier.code !21
  br i1 %6, label %7, label %8, !dbg !157, !verifier.code !21

7:                                                ; preds = %9, %4
  br label %12, !dbg !158, !verifier.code !21

8:                                                ; preds = %4
  br label %9, !dbg !160, !verifier.code !21

9:                                                ; preds = %8
  call void @llvm.dbg.value(metadata i32 1, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 3, metadata !149, metadata !DIExpression()), !dbg !153, !verifier.code !21
  %10 = call i32 @sll_circular_get_data_at(%struct.node* %1, i32 1), !dbg !154, !verifier.code !21
  %11 = icmp ne i32 3, %10, !dbg !156, !verifier.code !21
  br i1 %11, label %7, label %13, !dbg !157, !verifier.code !21

12:                                               ; preds = %7
  call void @llvm.dbg.label(metadata !161), !dbg !162, !verifier.code !21
  call void @reach_error(), !dbg !163, !verifier.code !21
  call void @abort() #5, !dbg !165, !verifier.code !21
  unreachable, !dbg !165, !verifier.code !21

13:                                               ; preds = %9
  br label %14, !dbg !160, !verifier.code !21

14:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i32 2, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @sll_circular_destroy(%struct.node* %1), !dbg !166, !verifier.code !21
  ret i32 0, !dbg !167, !verifier.code !21

15:                                               ; preds = %3
  call void @llvm.dbg.value(metadata i32 2, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 0, metadata !140, metadata !DIExpression()), !dbg !136, !verifier.code !21
  br label %4, !dbg !168, !verifier.code !21
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
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/sll2c_update_all.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !12}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "SLL", file: !5, line: 12, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//sll2c_update_all.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 9, size: 128, elements: !8)
!8 = !{!9, !10}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 10, baseType: !6, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !5, line: 11, baseType: !11, size: 32, offset: 64)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
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
!24 = !{null, !11}
!25 = !DILocalVariable(name: "s", arg: 1, scope: !22, file: !5, line: 14, type: !11)
!26 = !DILocation(line: 0, scope: !22)
!27 = !DILocation(line: 14, column: 20, scope: !22)
!28 = !DILabel(scope: !22, name: "_EXIT", file: !5, line: 15)
!29 = !DILocation(line: 15, column: 2, scope: !22)
!30 = !DILocation(line: 15, column: 9, scope: !22)
!31 = distinct !DISubprogram(name: "node_create", scope: !5, file: !5, line: 18, type: !32, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!4, !11}
!34 = !DILocalVariable(name: "data", arg: 1, scope: !31, file: !5, line: 18, type: !11)
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
!50 = distinct !DISubprogram(name: "sll_circular_create", scope: !5, file: !5, line: 28, type: !51, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!51 = !DISubroutineType(types: !52)
!52 = !{!4, !11, !11}
!53 = !DILocalVariable(name: "len", arg: 1, scope: !50, file: !5, line: 28, type: !11)
!54 = !DILocation(line: 0, scope: !50)
!55 = !DILocalVariable(name: "data", arg: 2, scope: !50, file: !5, line: 28, type: !11)
!56 = !DILocation(line: 29, column: 14, scope: !50)
!57 = !DILocalVariable(name: "head", scope: !50, file: !5, line: 29, type: !4)
!58 = !DILocalVariable(name: "last", scope: !50, file: !5, line: 30, type: !4)
!59 = !DILocation(line: 31, column: 13, scope: !50)
!60 = !DILocation(line: 31, column: 3, scope: !50)
!61 = !DILocation(line: 32, column: 20, scope: !62)
!62 = distinct !DILexicalBlock(scope: !50, file: !5, line: 31, column: 18)
!63 = !DILocalVariable(name: "new_head", scope: !62, file: !5, line: 32, type: !4)
!64 = !DILocation(line: 0, scope: !62)
!65 = !DILocation(line: 33, column: 15, scope: !62)
!66 = !DILocation(line: 33, column: 20, scope: !62)
!67 = !DILocation(line: 35, column: 8, scope: !62)
!68 = distinct !{!68, !60, !69}
!69 = !DILocation(line: 36, column: 3, scope: !50)
!70 = !DILocation(line: 37, column: 9, scope: !50)
!71 = !DILocation(line: 37, column: 14, scope: !50)
!72 = !DILocation(line: 38, column: 3, scope: !50)
!73 = distinct !DISubprogram(name: "sll_circular_destroy", scope: !5, file: !5, line: 41, type: !74, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!74 = !DISubroutineType(types: !75)
!75 = !{null, !4}
!76 = !DILocalVariable(name: "head", arg: 1, scope: !73, file: !5, line: 41, type: !4)
!77 = !DILocation(line: 0, scope: !73)
!78 = !DILocation(line: 42, column: 11, scope: !79)
!79 = distinct !DILexicalBlock(scope: !73, file: !5, line: 42, column: 6)
!80 = !DILocation(line: 42, column: 6, scope: !73)
!81 = !DILocation(line: 43, column: 19, scope: !82)
!82 = distinct !DILexicalBlock(scope: !79, file: !5, line: 42, column: 20)
!83 = !DILocalVariable(name: "p", scope: !82, file: !5, line: 43, type: !4)
!84 = !DILocation(line: 0, scope: !82)
!85 = !DILocation(line: 44, column: 13, scope: !82)
!86 = !DILocation(line: 44, column: 5, scope: !82)
!87 = !DILocation(line: 45, column: 18, scope: !88)
!88 = distinct !DILexicalBlock(scope: !82, file: !5, line: 44, column: 22)
!89 = !DILocalVariable(name: "q", scope: !88, file: !5, line: 45, type: !4)
!90 = !DILocation(line: 0, scope: !88)
!91 = !DILocation(line: 46, column: 12, scope: !88)
!92 = !DILocation(line: 46, column: 7, scope: !88)
!93 = distinct !{!93, !86, !94}
!94 = !DILocation(line: 48, column: 5, scope: !82)
!95 = !DILocation(line: 49, column: 10, scope: !82)
!96 = !DILocation(line: 49, column: 5, scope: !82)
!97 = !DILocation(line: 50, column: 3, scope: !82)
!98 = !DILocation(line: 51, column: 1, scope: !73)
!99 = distinct !DISubprogram(name: "sll_circular_get_data_at", scope: !5, file: !5, line: 53, type: !100, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!100 = !DISubroutineType(types: !101)
!101 = !{!11, !4, !11}
!102 = !DILocalVariable(name: "head", arg: 1, scope: !99, file: !5, line: 53, type: !4)
!103 = !DILocation(line: 0, scope: !99)
!104 = !DILocalVariable(name: "index", arg: 2, scope: !99, file: !5, line: 53, type: !11)
!105 = !DILocation(line: 54, column: 15, scope: !99)
!106 = !DILocation(line: 54, column: 3, scope: !99)
!107 = !DILocation(line: 55, column: 18, scope: !108)
!108 = distinct !DILexicalBlock(scope: !99, file: !5, line: 54, column: 20)
!109 = !DILocation(line: 56, column: 10, scope: !108)
!110 = distinct !{!110, !106, !111}
!111 = !DILocation(line: 57, column: 3, scope: !99)
!112 = !DILocation(line: 58, column: 16, scope: !99)
!113 = !DILocation(line: 58, column: 3, scope: !99)
!114 = distinct !DISubprogram(name: "sll_circular_update_at", scope: !5, file: !5, line: 61, type: !115, scopeLine: 61, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!115 = !DISubroutineType(types: !116)
!116 = !{null, !4, !11, !11}
!117 = !DILocalVariable(name: "head", arg: 1, scope: !114, file: !5, line: 61, type: !4)
!118 = !DILocation(line: 0, scope: !114)
!119 = !DILocalVariable(name: "data", arg: 2, scope: !114, file: !5, line: 61, type: !11)
!120 = !DILocalVariable(name: "index", arg: 3, scope: !114, file: !5, line: 61, type: !11)
!121 = !DILocation(line: 62, column: 15, scope: !114)
!122 = !DILocation(line: 62, column: 3, scope: !114)
!123 = !DILocation(line: 63, column: 18, scope: !124)
!124 = distinct !DILexicalBlock(scope: !114, file: !5, line: 62, column: 20)
!125 = !DILocation(line: 64, column: 10, scope: !124)
!126 = distinct !{!126, !122, !127}
!127 = !DILocation(line: 65, column: 3, scope: !114)
!128 = !DILocation(line: 66, column: 9, scope: !114)
!129 = !DILocation(line: 66, column: 14, scope: !114)
!130 = !DILocation(line: 67, column: 1, scope: !114)
!131 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 69, type: !132, scopeLine: 69, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!132 = !DISubroutineType(types: !133)
!133 = !{!11}
!134 = !DILocalVariable(name: "len", scope: !131, file: !5, line: 70, type: !135)
!135 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!136 = !DILocation(line: 0, scope: !131)
!137 = !DILocalVariable(name: "data", scope: !131, file: !5, line: 71, type: !135)
!138 = !DILocation(line: 72, column: 11, scope: !131)
!139 = !DILocalVariable(name: "s", scope: !131, file: !5, line: 72, type: !4)
!140 = !DILocalVariable(name: "i", scope: !131, file: !5, line: 73, type: !11)
!141 = !DILocation(line: 74, column: 5, scope: !142)
!142 = distinct !DILexicalBlock(scope: !131, file: !5, line: 74, column: 5)
!143 = !DILocalVariable(name: "new_data", scope: !144, file: !5, line: 75, type: !11)
!144 = distinct !DILexicalBlock(scope: !145, file: !5, line: 74, column: 30)
!145 = distinct !DILexicalBlock(scope: !142, file: !5, line: 74, column: 5)
!146 = !DILocation(line: 0, scope: !144)
!147 = !DILocation(line: 76, column: 5, scope: !144)
!148 = !DILocation(line: 77, column: 3, scope: !144)
!149 = !DILocalVariable(name: "expected", scope: !150, file: !5, line: 79, type: !11)
!150 = distinct !DILexicalBlock(scope: !151, file: !5, line: 78, column: 28)
!151 = distinct !DILexicalBlock(scope: !152, file: !5, line: 78, column: 3)
!152 = distinct !DILexicalBlock(scope: !131, file: !5, line: 78, column: 3)
!153 = !DILocation(line: 0, scope: !150)
!154 = !DILocation(line: 80, column: 20, scope: !155)
!155 = distinct !DILexicalBlock(scope: !150, file: !5, line: 80, column: 8)
!156 = !DILocation(line: 80, column: 17, scope: !155)
!157 = !DILocation(line: 80, column: 8, scope: !150)
!158 = !DILocation(line: 81, column: 7, scope: !159)
!159 = distinct !DILexicalBlock(scope: !155, file: !5, line: 80, column: 52)
!160 = !DILocation(line: 83, column: 3, scope: !150)
!161 = !DILabel(scope: !131, name: "ERROR", file: !5, line: 86)
!162 = !DILocation(line: 86, column: 2, scope: !131)
!163 = !DILocation(line: 86, column: 10, scope: !164)
!164 = distinct !DILexicalBlock(scope: !131, file: !5, line: 86, column: 9)
!165 = !DILocation(line: 86, column: 24, scope: !164)
!166 = !DILocation(line: 84, column: 3, scope: !131)
!167 = !DILocation(line: 85, column: 3, scope: !131)
!168 = !DILocation(line: 78, column: 3, scope: !152)
