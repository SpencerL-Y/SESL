; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-6liqwelg.bc'
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
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !46, !verifier.code !22
  store %struct.node* null, %struct.node** %7, align 8, !dbg !47, !verifier.code !22
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, !dbg !48, !verifier.code !22
  store %struct.node* null, %struct.node** %8, align 8, !dbg !49, !verifier.code !22
  %9 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !50, !verifier.code !22
  store i32 %0, i32* %9, align 8, !dbg !51, !verifier.code !22
  ret %struct.node* %3, !dbg !52, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @dll_create(i32 %0, i32 %1) #0 !dbg !53 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !58, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %3 = icmp sgt i32 %0, 0, !dbg !60, !verifier.code !22
  br i1 %3, label %.lr.ph, label %19, !dbg !61, !verifier.code !22

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !61, !verifier.code !22

4:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ %0, %.lr.ph ], [ %17, %forwarder ], !verifier.code !22
  %.012 = phi %struct.node* [ null, %.lr.ph ], [ %6, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.03, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.012, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %5 = call noalias i8* @malloc(i64 24) #4, !dbg !62, !verifier.code !22
  %6 = bitcast i8* %5 to %struct.node*, !dbg !64, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !65, metadata !DIExpression()), !dbg !66, !verifier.code !22
  %7 = icmp eq %struct.node* null, %6, !dbg !67, !verifier.code !22
  br i1 %7, label %8, label %9, !dbg !69, !verifier.code !22

8:                                                ; preds = %4
  call void @myexit(i32 1), !dbg !70, !verifier.code !22
  br label %9, !dbg !72, !verifier.code !22

9:                                                ; preds = %8, %4
  %10 = getelementptr inbounds %struct.node, %struct.node* %6, i32 0, i32 0, !dbg !73, !verifier.code !22
  store i32 %1, i32* %10, align 8, !dbg !74, !verifier.code !22
  %11 = getelementptr inbounds %struct.node, %struct.node* %6, i32 0, i32 1, !dbg !75, !verifier.code !22
  store %struct.node* %.012, %struct.node** %11, align 8, !dbg !76, !verifier.code !22
  %12 = getelementptr inbounds %struct.node, %struct.node* %6, i32 0, i32 2, !dbg !77, !verifier.code !22
  store %struct.node* null, %struct.node** %12, align 8, !dbg !78, !verifier.code !22
  %13 = icmp ne %struct.node* %.012, null, !dbg !79, !verifier.code !22
  br i1 %13, label %14, label %16, !dbg !81, !verifier.code !22

14:                                               ; preds = %9
  %15 = getelementptr inbounds %struct.node, %struct.node* %.012, i32 0, i32 2, !dbg !82, !verifier.code !22
  store %struct.node* %6, %struct.node** %15, align 8, !dbg !84, !verifier.code !22
  br label %16, !dbg !85, !verifier.code !22

16:                                               ; preds = %14, %9
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %17 = add nsw i32 %.03, -1, !dbg !86, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %17, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !22
  %18 = icmp sgt i32 %17, 0, !dbg !60, !verifier.code !22
  br i1 %18, label %forwarder, label %._crit_edge, !dbg !61, !llvm.loop !87, !verifier.code !22

._crit_edge:                                      ; preds = %16
  %split = phi %struct.node* [ %6, %16 ], !verifier.code !22
  br label %19, !dbg !61, !verifier.code !22

19:                                               ; preds = %._crit_edge, %2
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ null, %2 ], !dbg !57, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !22
  ret %struct.node* %.01.lcssa, !dbg !89, !verifier.code !22

forwarder:                                        ; preds = %16
  br label %4, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define internal void @dll_destroy(%struct.node* %0) #0 !dbg !90 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !22
  %2 = icmp ne %struct.node* %0, null, !dbg !95, !verifier.code !22
  br i1 %2, label %.lr.ph, label %8, !dbg !95, !verifier.code !22

.lr.ph:                                           ; preds = %1
  br label %3, !dbg !95, !verifier.code !22

3:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %0, %.lr.ph ], [ %5, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !22
  %4 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !96, !verifier.code !22
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !96, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !98, metadata !DIExpression()), !dbg !99, !verifier.code !22
  %6 = bitcast %struct.node* %.01 to i8*, !dbg !100, !verifier.code !22
  call void @free(i8* %6) #4, !dbg !101, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !22
  %7 = icmp ne %struct.node* %5, null, !dbg !95, !verifier.code !22
  br i1 %7, label %forwarder, label %._crit_edge, !dbg !95, !llvm.loop !102, !verifier.code !22

._crit_edge:                                      ; preds = %3
  br label %8, !dbg !95, !verifier.code !22

8:                                                ; preds = %._crit_edge, %1
  ret void, !dbg !104, !verifier.code !22

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @dll_get_data_at(%struct.node* %0, i32 %1) #0 !dbg !105 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !110, metadata !DIExpression()), !dbg !109, !verifier.code !22
  %3 = icmp sgt i32 %1, 0, !dbg !111, !verifier.code !22
  br i1 %3, label %.lr.ph, label %9, !dbg !112, !verifier.code !22

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !112, !verifier.code !22

4:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %6, %forwarder ], !verifier.code !22
  %.012 = phi i32 [ %1, %.lr.ph ], [ %7, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.012, metadata !110, metadata !DIExpression()), !dbg !109, !verifier.code !22
  %5 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 1, !dbg !113, !verifier.code !22
  %6 = load %struct.node*, %struct.node** %5, align 8, !dbg !113, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !22
  %7 = add nsw i32 %.012, -1, !dbg !115, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %7, metadata !110, metadata !DIExpression()), !dbg !109, !verifier.code !22
  %8 = icmp sgt i32 %7, 0, !dbg !111, !verifier.code !22
  br i1 %8, label %forwarder, label %._crit_edge, !dbg !112, !llvm.loop !116, !verifier.code !22

._crit_edge:                                      ; preds = %4
  %split = phi %struct.node* [ %6, %4 ], !verifier.code !22
  br label %9, !dbg !112, !verifier.code !22

9:                                                ; preds = %._crit_edge, %2
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %2 ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !22
  %10 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 0, !dbg !118, !verifier.code !22
  %11 = load i32, i32* %10, align 8, !dbg !118, !verifier.code !22
  ret i32 %11, !dbg !119, !verifier.code !22

forwarder:                                        ; preds = %4
  br label %4, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define internal void @dll_update_at(%struct.node* %0, i32 %1, i32 %2) #0 !dbg !120 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !123, metadata !DIExpression()), !dbg !124, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !125, metadata !DIExpression()), !dbg !124, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %2, metadata !126, metadata !DIExpression()), !dbg !124, !verifier.code !22
  %4 = icmp sgt i32 %2, 0, !dbg !127, !verifier.code !22
  br i1 %4, label %.lr.ph, label %10, !dbg !128, !verifier.code !22

.lr.ph:                                           ; preds = %3
  br label %5, !dbg !128, !verifier.code !22

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %7, %forwarder ], !verifier.code !22
  %.012 = phi i32 [ %2, %.lr.ph ], [ %8, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !123, metadata !DIExpression()), !dbg !124, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.012, metadata !126, metadata !DIExpression()), !dbg !124, !verifier.code !22
  %6 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 1, !dbg !129, !verifier.code !22
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !129, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !123, metadata !DIExpression()), !dbg !124, !verifier.code !22
  %8 = add nsw i32 %.012, -1, !dbg !131, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %8, metadata !126, metadata !DIExpression()), !dbg !124, !verifier.code !22
  %9 = icmp sgt i32 %8, 0, !dbg !127, !verifier.code !22
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !128, !llvm.loop !132, !verifier.code !22

._crit_edge:                                      ; preds = %5
  %split = phi %struct.node* [ %7, %5 ], !verifier.code !22
  br label %10, !dbg !128, !verifier.code !22

10:                                               ; preds = %._crit_edge, %3
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %3 ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !123, metadata !DIExpression()), !dbg !124, !verifier.code !22
  %11 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 0, !dbg !134, !verifier.code !22
  store i32 %1, i32* %11, align 8, !dbg !135, !verifier.code !22
  ret void, !dbg !136, !verifier.code !22

forwarder:                                        ; preds = %5
  br label %5, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !137 {
  call void @llvm.dbg.value(metadata i32 2, metadata !140, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !143, metadata !DIExpression()), !dbg !142, !verifier.code !22
  %1 = call %struct.node* @dll_create(i32 2, i32 1), !dbg !144, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !145, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 0, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  br label %2, !dbg !147, !verifier.code !22

2:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 2, metadata !149, metadata !DIExpression()), !dbg !152, !verifier.code !22
  call void @dll_update_at(%struct.node* %1, i32 2, i32 0), !dbg !153, !verifier.code !22
  br label %3, !dbg !154, !verifier.code !22

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 1, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 3, metadata !149, metadata !DIExpression()), !dbg !152, !verifier.code !22
  call void @dll_update_at(%struct.node* %1, i32 3, i32 1), !dbg !153, !verifier.code !22
  br label %15, !dbg !154, !verifier.code !22

4:                                                ; preds = %15
  call void @llvm.dbg.value(metadata i32 0, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 2, metadata !155, metadata !DIExpression()), !dbg !159, !verifier.code !22
  %5 = call i32 @dll_get_data_at(%struct.node* %1, i32 0), !dbg !160, !verifier.code !22
  %6 = icmp ne i32 2, %5, !dbg !162, !verifier.code !22
  br i1 %6, label %7, label %8, !dbg !163, !verifier.code !22

7:                                                ; preds = %9, %4
  br label %12, !dbg !164, !verifier.code !22

8:                                                ; preds = %4
  br label %9, !dbg !166, !verifier.code !22

9:                                                ; preds = %8
  call void @llvm.dbg.value(metadata i32 1, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 3, metadata !155, metadata !DIExpression()), !dbg !159, !verifier.code !22
  %10 = call i32 @dll_get_data_at(%struct.node* %1, i32 1), !dbg !160, !verifier.code !22
  %11 = icmp ne i32 3, %10, !dbg !162, !verifier.code !22
  br i1 %11, label %7, label %13, !dbg !163, !verifier.code !22

12:                                               ; preds = %7
  call void @llvm.dbg.label(metadata !167), !dbg !168, !verifier.code !22
  call void @reach_error(), !dbg !169, !verifier.code !22
  call void @abort() #5, !dbg !171, !verifier.code !22
  unreachable, !dbg !171, !verifier.code !22

13:                                               ; preds = %9
  br label %14, !dbg !166, !verifier.code !22

14:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i32 2, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @dll_destroy(%struct.node* %1), !dbg !172, !verifier.code !22
  ret i32 0, !dbg !173, !verifier.code !22

15:                                               ; preds = %3
  call void @llvm.dbg.value(metadata i32 2, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 0, metadata !146, metadata !DIExpression()), !dbg !142, !verifier.code !22
  br label %4, !dbg !174, !verifier.code !22
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
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dll2n_update_all.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !13}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DLL", file: !5, line: 13, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dll2n_update_all.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 9, size: 192, elements: !8)
!8 = !{!9, !11, !12}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !5, line: 10, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 11, baseType: !6, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !7, file: !5, line: 12, baseType: !6, size: 64, offset: 128)
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
!25 = !{null, !10}
!26 = !DILocalVariable(name: "s", arg: 1, scope: !23, file: !5, line: 15, type: !10)
!27 = !DILocation(line: 0, scope: !23)
!28 = !DILocation(line: 15, column: 20, scope: !23)
!29 = !DILabel(scope: !23, name: "_EXIT", file: !5, line: 16)
!30 = !DILocation(line: 16, column: 2, scope: !23)
!31 = !DILocation(line: 16, column: 9, scope: !23)
!32 = distinct !DISubprogram(name: "node_create", scope: !5, file: !5, line: 19, type: !33, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!4, !10}
!35 = !DILocalVariable(name: "data", arg: 1, scope: !32, file: !5, line: 19, type: !10)
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
!53 = distinct !DISubprogram(name: "dll_create", scope: !5, file: !5, line: 30, type: !54, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!54 = !DISubroutineType(types: !55)
!55 = !{!4, !10, !10}
!56 = !DILocalVariable(name: "len", arg: 1, scope: !53, file: !5, line: 30, type: !10)
!57 = !DILocation(line: 0, scope: !53)
!58 = !DILocalVariable(name: "data", arg: 2, scope: !53, file: !5, line: 30, type: !10)
!59 = !DILocalVariable(name: "head", scope: !53, file: !5, line: 31, type: !4)
!60 = !DILocation(line: 32, column: 13, scope: !53)
!61 = !DILocation(line: 32, column: 3, scope: !53)
!62 = !DILocation(line: 33, column: 26, scope: !63)
!63 = distinct !DILexicalBlock(scope: !53, file: !5, line: 32, column: 18)
!64 = !DILocation(line: 33, column: 20, scope: !63)
!65 = !DILocalVariable(name: "new_head", scope: !63, file: !5, line: 33, type: !4)
!66 = !DILocation(line: 0, scope: !63)
!67 = !DILocation(line: 34, column: 13, scope: !68)
!68 = distinct !DILexicalBlock(scope: !63, file: !5, line: 34, column: 8)
!69 = !DILocation(line: 34, column: 8, scope: !63)
!70 = !DILocation(line: 35, column: 7, scope: !71)
!71 = distinct !DILexicalBlock(scope: !68, file: !5, line: 34, column: 26)
!72 = !DILocation(line: 36, column: 5, scope: !71)
!73 = !DILocation(line: 37, column: 15, scope: !63)
!74 = !DILocation(line: 37, column: 20, scope: !63)
!75 = !DILocation(line: 38, column: 15, scope: !63)
!76 = !DILocation(line: 38, column: 20, scope: !63)
!77 = !DILocation(line: 39, column: 15, scope: !63)
!78 = !DILocation(line: 39, column: 20, scope: !63)
!79 = !DILocation(line: 40, column: 8, scope: !80)
!80 = distinct !DILexicalBlock(scope: !63, file: !5, line: 40, column: 8)
!81 = !DILocation(line: 40, column: 8, scope: !63)
!82 = !DILocation(line: 41, column: 13, scope: !83)
!83 = distinct !DILexicalBlock(scope: !80, file: !5, line: 40, column: 14)
!84 = !DILocation(line: 41, column: 18, scope: !83)
!85 = !DILocation(line: 42, column: 5, scope: !83)
!86 = !DILocation(line: 44, column: 8, scope: !63)
!87 = distinct !{!87, !61, !88}
!88 = !DILocation(line: 45, column: 3, scope: !53)
!89 = !DILocation(line: 46, column: 3, scope: !53)
!90 = distinct !DISubprogram(name: "dll_destroy", scope: !5, file: !5, line: 49, type: !91, scopeLine: 49, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!91 = !DISubroutineType(types: !92)
!92 = !{null, !4}
!93 = !DILocalVariable(name: "head", arg: 1, scope: !90, file: !5, line: 49, type: !4)
!94 = !DILocation(line: 0, scope: !90)
!95 = !DILocation(line: 50, column: 3, scope: !90)
!96 = !DILocation(line: 51, column: 22, scope: !97)
!97 = distinct !DILexicalBlock(scope: !90, file: !5, line: 50, column: 15)
!98 = !DILocalVariable(name: "temp", scope: !97, file: !5, line: 51, type: !4)
!99 = !DILocation(line: 0, scope: !97)
!100 = !DILocation(line: 52, column: 10, scope: !97)
!101 = !DILocation(line: 52, column: 5, scope: !97)
!102 = distinct !{!102, !95, !103}
!103 = !DILocation(line: 54, column: 3, scope: !90)
!104 = !DILocation(line: 55, column: 1, scope: !90)
!105 = distinct !DISubprogram(name: "dll_get_data_at", scope: !5, file: !5, line: 57, type: !106, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!106 = !DISubroutineType(types: !107)
!107 = !{!10, !4, !10}
!108 = !DILocalVariable(name: "head", arg: 1, scope: !105, file: !5, line: 57, type: !4)
!109 = !DILocation(line: 0, scope: !105)
!110 = !DILocalVariable(name: "index", arg: 2, scope: !105, file: !5, line: 57, type: !10)
!111 = !DILocation(line: 58, column: 15, scope: !105)
!112 = !DILocation(line: 58, column: 3, scope: !105)
!113 = !DILocation(line: 59, column: 18, scope: !114)
!114 = distinct !DILexicalBlock(scope: !105, file: !5, line: 58, column: 20)
!115 = !DILocation(line: 60, column: 10, scope: !114)
!116 = distinct !{!116, !112, !117}
!117 = !DILocation(line: 61, column: 3, scope: !105)
!118 = !DILocation(line: 62, column: 16, scope: !105)
!119 = !DILocation(line: 62, column: 3, scope: !105)
!120 = distinct !DISubprogram(name: "dll_update_at", scope: !5, file: !5, line: 65, type: !121, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!121 = !DISubroutineType(types: !122)
!122 = !{null, !4, !10, !10}
!123 = !DILocalVariable(name: "head", arg: 1, scope: !120, file: !5, line: 65, type: !4)
!124 = !DILocation(line: 0, scope: !120)
!125 = !DILocalVariable(name: "data", arg: 2, scope: !120, file: !5, line: 65, type: !10)
!126 = !DILocalVariable(name: "index", arg: 3, scope: !120, file: !5, line: 65, type: !10)
!127 = !DILocation(line: 66, column: 15, scope: !120)
!128 = !DILocation(line: 66, column: 3, scope: !120)
!129 = !DILocation(line: 67, column: 18, scope: !130)
!130 = distinct !DILexicalBlock(scope: !120, file: !5, line: 66, column: 20)
!131 = !DILocation(line: 68, column: 10, scope: !130)
!132 = distinct !{!132, !128, !133}
!133 = !DILocation(line: 69, column: 3, scope: !120)
!134 = !DILocation(line: 70, column: 9, scope: !120)
!135 = !DILocation(line: 70, column: 14, scope: !120)
!136 = !DILocation(line: 71, column: 1, scope: !120)
!137 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 73, type: !138, scopeLine: 73, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!138 = !DISubroutineType(types: !139)
!139 = !{!10}
!140 = !DILocalVariable(name: "len", scope: !137, file: !5, line: 74, type: !141)
!141 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!142 = !DILocation(line: 0, scope: !137)
!143 = !DILocalVariable(name: "data", scope: !137, file: !5, line: 75, type: !141)
!144 = !DILocation(line: 76, column: 11, scope: !137)
!145 = !DILocalVariable(name: "s", scope: !137, file: !5, line: 76, type: !4)
!146 = !DILocalVariable(name: "i", scope: !137, file: !5, line: 77, type: !10)
!147 = !DILocation(line: 78, column: 3, scope: !148)
!148 = distinct !DILexicalBlock(scope: !137, file: !5, line: 78, column: 3)
!149 = !DILocalVariable(name: "new_data", scope: !150, file: !5, line: 79, type: !10)
!150 = distinct !DILexicalBlock(scope: !151, file: !5, line: 78, column: 28)
!151 = distinct !DILexicalBlock(scope: !148, file: !5, line: 78, column: 3)
!152 = !DILocation(line: 0, scope: !150)
!153 = !DILocation(line: 80, column: 5, scope: !150)
!154 = !DILocation(line: 81, column: 3, scope: !150)
!155 = !DILocalVariable(name: "expected", scope: !156, file: !5, line: 83, type: !10)
!156 = distinct !DILexicalBlock(scope: !157, file: !5, line: 82, column: 28)
!157 = distinct !DILexicalBlock(scope: !158, file: !5, line: 82, column: 3)
!158 = distinct !DILexicalBlock(scope: !137, file: !5, line: 82, column: 3)
!159 = !DILocation(line: 0, scope: !156)
!160 = !DILocation(line: 84, column: 20, scope: !161)
!161 = distinct !DILexicalBlock(scope: !156, file: !5, line: 84, column: 8)
!162 = !DILocation(line: 84, column: 17, scope: !161)
!163 = !DILocation(line: 84, column: 8, scope: !156)
!164 = !DILocation(line: 85, column: 7, scope: !165)
!165 = distinct !DILexicalBlock(scope: !161, file: !5, line: 84, column: 43)
!166 = !DILocation(line: 87, column: 3, scope: !156)
!167 = !DILabel(scope: !137, name: "ERROR", file: !5, line: 90)
!168 = !DILocation(line: 90, column: 2, scope: !137)
!169 = !DILocation(line: 90, column: 10, scope: !170)
!170 = distinct !DILexicalBlock(scope: !137, file: !5, line: 90, column: 9)
!171 = !DILocation(line: 90, column: 24, scope: !170)
!172 = !DILocation(line: 88, column: 3, scope: !137)
!173 = !DILocation(line: 89, column: 3, scope: !137)
!174 = !DILocation(line: 82, column: 3, scope: !158)
