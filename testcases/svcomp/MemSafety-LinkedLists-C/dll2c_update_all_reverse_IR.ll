; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-5xlp6u81.bc'
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
define internal void @dll_circular_destroy(%struct.node* %0) #0 !dbg !85 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !22
  %2 = icmp ne %struct.node* null, %0, !dbg !90, !verifier.code !22
  br i1 %2, label %3, label %14, !dbg !92, !verifier.code !22

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !93, !verifier.code !22
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !93, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !22
  %6 = icmp ne %struct.node* %5, %0, !dbg !97, !verifier.code !22
  br i1 %6, label %.lr.ph, label %12, !dbg !98, !verifier.code !22

.lr.ph:                                           ; preds = %3
  br label %7, !dbg !98, !verifier.code !22

7:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %5, %.lr.ph ], [ %9, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !22
  %8 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !99, !verifier.code !22
  %9 = load %struct.node*, %struct.node** %8, align 8, !dbg !99, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %9, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !22
  %10 = bitcast %struct.node* %.01 to i8*, !dbg !103, !verifier.code !22
  call void @free(i8* %10) #4, !dbg !104, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %9, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !22
  %11 = icmp ne %struct.node* %9, %0, !dbg !97, !verifier.code !22
  br i1 %11, label %forwarder, label %._crit_edge, !dbg !98, !llvm.loop !105, !verifier.code !22

._crit_edge:                                      ; preds = %7
  br label %12, !dbg !98, !verifier.code !22

12:                                               ; preds = %._crit_edge, %3
  %13 = bitcast %struct.node* %0 to i8*, !dbg !107, !verifier.code !22
  call void @free(i8* %13) #4, !dbg !108, !verifier.code !22
  br label %14, !dbg !109, !verifier.code !22

14:                                               ; preds = %12, %1
  ret void, !dbg !110, !verifier.code !22

forwarder:                                        ; preds = %7
  br label %7, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @dll_circular_get_data_at(%struct.node* %0, i32 %1) #0 !dbg !111 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !114, metadata !DIExpression()), !dbg !115, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !116, metadata !DIExpression()), !dbg !115, !verifier.code !22
  %3 = icmp sgt i32 %1, 0, !dbg !117, !verifier.code !22
  br i1 %3, label %.lr.ph, label %9, !dbg !118, !verifier.code !22

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !118, !verifier.code !22

4:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %6, %forwarder ], !verifier.code !22
  %.012 = phi i32 [ %1, %.lr.ph ], [ %7, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !114, metadata !DIExpression()), !dbg !115, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.012, metadata !116, metadata !DIExpression()), !dbg !115, !verifier.code !22
  %5 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 0, !dbg !119, !verifier.code !22
  %6 = load %struct.node*, %struct.node** %5, align 8, !dbg !119, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %6, metadata !114, metadata !DIExpression()), !dbg !115, !verifier.code !22
  %7 = add nsw i32 %.012, -1, !dbg !121, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %7, metadata !116, metadata !DIExpression()), !dbg !115, !verifier.code !22
  %8 = icmp sgt i32 %7, 0, !dbg !117, !verifier.code !22
  br i1 %8, label %forwarder, label %._crit_edge, !dbg !118, !llvm.loop !122, !verifier.code !22

._crit_edge:                                      ; preds = %4
  %split = phi %struct.node* [ %6, %4 ], !verifier.code !22
  br label %9, !dbg !118, !verifier.code !22

9:                                                ; preds = %._crit_edge, %2
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %2 ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !114, metadata !DIExpression()), !dbg !115, !verifier.code !22
  %10 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 2, !dbg !124, !verifier.code !22
  %11 = load i32, i32* %10, align 8, !dbg !124, !verifier.code !22
  ret i32 %11, !dbg !125, !verifier.code !22

forwarder:                                        ; preds = %4
  br label %4, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define internal void @dll_circular_update_at(%struct.node* %0, i32 %1, i32 %2) #0 !dbg !126 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %1, metadata !131, metadata !DIExpression()), !dbg !130, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %2, metadata !132, metadata !DIExpression()), !dbg !130, !verifier.code !22
  %4 = icmp sgt i32 %2, 0, !dbg !133, !verifier.code !22
  br i1 %4, label %.lr.ph, label %10, !dbg !134, !verifier.code !22

.lr.ph:                                           ; preds = %3
  br label %5, !dbg !134, !verifier.code !22

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.node* [ %0, %.lr.ph ], [ %7, %forwarder ], !verifier.code !22
  %.012 = phi i32 [ %2, %.lr.ph ], [ %8, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.012, metadata !132, metadata !DIExpression()), !dbg !130, !verifier.code !22
  %6 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 0, !dbg !135, !verifier.code !22
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !135, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !22
  %8 = add nsw i32 %.012, -1, !dbg !137, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %8, metadata !132, metadata !DIExpression()), !dbg !130, !verifier.code !22
  %9 = icmp sgt i32 %8, 0, !dbg !133, !verifier.code !22
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !134, !llvm.loop !138, !verifier.code !22

._crit_edge:                                      ; preds = %5
  %split = phi %struct.node* [ %7, %5 ], !verifier.code !22
  br label %10, !dbg !134, !verifier.code !22

10:                                               ; preds = %._crit_edge, %3
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %0, %3 ], !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !22
  %11 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 2, !dbg !140, !verifier.code !22
  store i32 %1, i32* %11, align 8, !dbg !141, !verifier.code !22
  ret void, !dbg !142, !verifier.code !22

forwarder:                                        ; preds = %5
  br label %5, !verifier.code !22
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !143 {
  call void @llvm.dbg.value(metadata i32 2, metadata !146, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !149, metadata !DIExpression()), !dbg !148, !verifier.code !22
  %1 = call %struct.node* @dll_circular_create(i32 2, i32 1), !dbg !150, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !151, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 0, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  br label %2, !dbg !153, !verifier.code !22

2:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 1, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 3, metadata !155, metadata !DIExpression()), !dbg !158, !verifier.code !22
  call void @dll_circular_update_at(%struct.node* %1, i32 3, i32 1), !dbg !159, !verifier.code !22
  br label %3, !dbg !160, !verifier.code !22

3:                                                ; preds = %2
  call void @llvm.dbg.value(metadata i32 0, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 2, metadata !155, metadata !DIExpression()), !dbg !158, !verifier.code !22
  call void @dll_circular_update_at(%struct.node* %1, i32 2, i32 0), !dbg !159, !verifier.code !22
  br label %15, !dbg !160, !verifier.code !22

4:                                                ; preds = %15
  call void @llvm.dbg.value(metadata i32 1, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 3, metadata !161, metadata !DIExpression()), !dbg !165, !verifier.code !22
  %5 = call i32 @dll_circular_get_data_at(%struct.node* %1, i32 1), !dbg !166, !verifier.code !22
  %6 = icmp ne i32 3, %5, !dbg !168, !verifier.code !22
  br i1 %6, label %7, label %8, !dbg !169, !verifier.code !22

7:                                                ; preds = %9, %4
  br label %12, !dbg !170, !verifier.code !22

8:                                                ; preds = %4
  br label %9, !dbg !172, !verifier.code !22

9:                                                ; preds = %8
  call void @llvm.dbg.value(metadata i32 0, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 2, metadata !161, metadata !DIExpression()), !dbg !165, !verifier.code !22
  %10 = call i32 @dll_circular_get_data_at(%struct.node* %1, i32 0), !dbg !166, !verifier.code !22
  %11 = icmp ne i32 2, %10, !dbg !168, !verifier.code !22
  br i1 %11, label %7, label %13, !dbg !169, !verifier.code !22

12:                                               ; preds = %7
  call void @llvm.dbg.label(metadata !173), !dbg !174, !verifier.code !22
  call void @reach_error(), !dbg !175, !verifier.code !22
  call void @abort() #5, !dbg !177, !verifier.code !22
  unreachable, !dbg !177, !verifier.code !22

13:                                               ; preds = %9
  br label %14, !dbg !172, !verifier.code !22

14:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i32 -1, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @dll_circular_destroy(%struct.node* %1), !dbg !178, !verifier.code !22
  ret i32 0, !dbg !179, !verifier.code !22

15:                                               ; preds = %3
  call void @llvm.dbg.value(metadata i32 -1, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 1, metadata !152, metadata !DIExpression()), !dbg !148, !verifier.code !22
  br label %4, !dbg !180, !verifier.code !22
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
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dll2c_update_all_reverse.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !13}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DLL", file: !5, line: 13, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dll2c_update_all_reverse.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
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
!85 = distinct !DISubprogram(name: "dll_circular_destroy", scope: !5, file: !5, line: 47, type: !86, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !4}
!88 = !DILocalVariable(name: "head", arg: 1, scope: !85, file: !5, line: 47, type: !4)
!89 = !DILocation(line: 0, scope: !85)
!90 = !DILocation(line: 48, column: 11, scope: !91)
!91 = distinct !DILexicalBlock(scope: !85, file: !5, line: 48, column: 6)
!92 = !DILocation(line: 48, column: 6, scope: !85)
!93 = !DILocation(line: 49, column: 19, scope: !94)
!94 = distinct !DILexicalBlock(scope: !91, file: !5, line: 48, column: 20)
!95 = !DILocalVariable(name: "p", scope: !94, file: !5, line: 49, type: !4)
!96 = !DILocation(line: 0, scope: !94)
!97 = !DILocation(line: 50, column: 13, scope: !94)
!98 = !DILocation(line: 50, column: 5, scope: !94)
!99 = !DILocation(line: 51, column: 18, scope: !100)
!100 = distinct !DILexicalBlock(scope: !94, file: !5, line: 50, column: 22)
!101 = !DILocalVariable(name: "q", scope: !100, file: !5, line: 51, type: !4)
!102 = !DILocation(line: 0, scope: !100)
!103 = !DILocation(line: 52, column: 12, scope: !100)
!104 = !DILocation(line: 52, column: 7, scope: !100)
!105 = distinct !{!105, !98, !106}
!106 = !DILocation(line: 54, column: 5, scope: !94)
!107 = !DILocation(line: 55, column: 10, scope: !94)
!108 = !DILocation(line: 55, column: 5, scope: !94)
!109 = !DILocation(line: 56, column: 3, scope: !94)
!110 = !DILocation(line: 57, column: 1, scope: !85)
!111 = distinct !DISubprogram(name: "dll_circular_get_data_at", scope: !5, file: !5, line: 59, type: !112, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!112 = !DISubroutineType(types: !113)
!113 = !{!12, !4, !12}
!114 = !DILocalVariable(name: "head", arg: 1, scope: !111, file: !5, line: 59, type: !4)
!115 = !DILocation(line: 0, scope: !111)
!116 = !DILocalVariable(name: "index", arg: 2, scope: !111, file: !5, line: 59, type: !12)
!117 = !DILocation(line: 60, column: 15, scope: !111)
!118 = !DILocation(line: 60, column: 3, scope: !111)
!119 = !DILocation(line: 61, column: 18, scope: !120)
!120 = distinct !DILexicalBlock(scope: !111, file: !5, line: 60, column: 20)
!121 = !DILocation(line: 62, column: 10, scope: !120)
!122 = distinct !{!122, !118, !123}
!123 = !DILocation(line: 63, column: 3, scope: !111)
!124 = !DILocation(line: 64, column: 16, scope: !111)
!125 = !DILocation(line: 64, column: 3, scope: !111)
!126 = distinct !DISubprogram(name: "dll_circular_update_at", scope: !5, file: !5, line: 67, type: !127, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!127 = !DISubroutineType(types: !128)
!128 = !{null, !4, !12, !12}
!129 = !DILocalVariable(name: "head", arg: 1, scope: !126, file: !5, line: 67, type: !4)
!130 = !DILocation(line: 0, scope: !126)
!131 = !DILocalVariable(name: "data", arg: 2, scope: !126, file: !5, line: 67, type: !12)
!132 = !DILocalVariable(name: "index", arg: 3, scope: !126, file: !5, line: 67, type: !12)
!133 = !DILocation(line: 68, column: 15, scope: !126)
!134 = !DILocation(line: 68, column: 3, scope: !126)
!135 = !DILocation(line: 69, column: 18, scope: !136)
!136 = distinct !DILexicalBlock(scope: !126, file: !5, line: 68, column: 20)
!137 = !DILocation(line: 70, column: 10, scope: !136)
!138 = distinct !{!138, !134, !139}
!139 = !DILocation(line: 71, column: 3, scope: !126)
!140 = !DILocation(line: 72, column: 9, scope: !126)
!141 = !DILocation(line: 72, column: 14, scope: !126)
!142 = !DILocation(line: 73, column: 1, scope: !126)
!143 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 75, type: !144, scopeLine: 75, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!144 = !DISubroutineType(types: !145)
!145 = !{!12}
!146 = !DILocalVariable(name: "len", scope: !143, file: !5, line: 76, type: !147)
!147 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !12)
!148 = !DILocation(line: 0, scope: !143)
!149 = !DILocalVariable(name: "data", scope: !143, file: !5, line: 77, type: !147)
!150 = !DILocation(line: 78, column: 11, scope: !143)
!151 = !DILocalVariable(name: "s", scope: !143, file: !5, line: 78, type: !4)
!152 = !DILocalVariable(name: "i", scope: !143, file: !5, line: 79, type: !12)
!153 = !DILocation(line: 80, column: 5, scope: !154)
!154 = distinct !DILexicalBlock(scope: !143, file: !5, line: 80, column: 5)
!155 = !DILocalVariable(name: "new_data", scope: !156, file: !5, line: 81, type: !12)
!156 = distinct !DILexicalBlock(scope: !157, file: !5, line: 80, column: 35)
!157 = distinct !DILexicalBlock(scope: !154, file: !5, line: 80, column: 5)
!158 = !DILocation(line: 0, scope: !156)
!159 = !DILocation(line: 82, column: 5, scope: !156)
!160 = !DILocation(line: 83, column: 3, scope: !156)
!161 = !DILocalVariable(name: "expected", scope: !162, file: !5, line: 85, type: !12)
!162 = distinct !DILexicalBlock(scope: !163, file: !5, line: 84, column: 33)
!163 = distinct !DILexicalBlock(scope: !164, file: !5, line: 84, column: 3)
!164 = distinct !DILexicalBlock(scope: !143, file: !5, line: 84, column: 3)
!165 = !DILocation(line: 0, scope: !162)
!166 = !DILocation(line: 86, column: 20, scope: !167)
!167 = distinct !DILexicalBlock(scope: !162, file: !5, line: 86, column: 8)
!168 = !DILocation(line: 86, column: 17, scope: !167)
!169 = !DILocation(line: 86, column: 8, scope: !162)
!170 = !DILocation(line: 87, column: 7, scope: !171)
!171 = distinct !DILexicalBlock(scope: !167, file: !5, line: 86, column: 52)
!172 = !DILocation(line: 89, column: 3, scope: !162)
!173 = !DILabel(scope: !143, name: "ERROR", file: !5, line: 92)
!174 = !DILocation(line: 92, column: 2, scope: !143)
!175 = !DILocation(line: 92, column: 10, scope: !176)
!176 = distinct !DILexicalBlock(scope: !143, file: !5, line: 92, column: 9)
!177 = !DILocation(line: 92, column: 24, scope: !176)
!178 = !DILocation(line: 90, column: 3, scope: !143)
!179 = !DILocation(line: 91, column: 3, scope: !143)
!180 = !DILocation(line: 84, column: 3, scope: !164)
