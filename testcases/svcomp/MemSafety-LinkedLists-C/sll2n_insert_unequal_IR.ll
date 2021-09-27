; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-pgc2_1nl.bc'
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
define internal void @sll_insert(%struct.node** %0, i32 %1, i32 %2) #0 !dbg !87 {
  call void @llvm.dbg.value(metadata %struct.node** %0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %1, metadata !93, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %2, metadata !94, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %4 = call %struct.node* @node_create(i32 %1), !dbg !95, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !96, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !97, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %5 = load %struct.node*, %struct.node** %0, align 8, !dbg !98, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !99, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !97, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %2, metadata !94, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %6 = icmp sgt i32 %2, 0, !dbg !100, !verifier.code !21
  br i1 %6, label %.lr.ph, label %12, !dbg !101, !verifier.code !21

.lr.ph:                                           ; preds = %3
  br label %7, !dbg !101, !verifier.code !21

7:                                                ; preds = %forwarder, %.lr.ph
  %.04 = phi %struct.node* [ %5, %.lr.ph ], [ %9, %forwarder ], !verifier.code !21
  %.023 = phi i32 [ %2, %.lr.ph ], [ %10, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.04, metadata !99, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.023, metadata !94, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.04, metadata !97, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %8 = getelementptr inbounds %struct.node, %struct.node* %.04, i32 0, i32 1, !dbg !102, !verifier.code !21
  %9 = load %struct.node*, %struct.node** %8, align 8, !dbg !102, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %9, metadata !99, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %10 = add nsw i32 %.023, -1, !dbg !104, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %10, metadata !94, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %11 = icmp sgt i32 %10, 0, !dbg !100, !verifier.code !21
  br i1 %11, label %forwarder, label %._crit_edge, !dbg !101, !llvm.loop !105, !verifier.code !21

._crit_edge:                                      ; preds = %7
  %split = phi %struct.node* [ %.04, %7 ], !verifier.code !21
  %split5 = phi %struct.node* [ %9, %7 ], !verifier.code !21
  br label %12, !dbg !101, !verifier.code !21

12:                                               ; preds = %._crit_edge, %3
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ null, %3 ], !dbg !92, !verifier.code !21
  %.0.lcssa = phi %struct.node* [ %split5, %._crit_edge ], [ %5, %3 ], !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !97, metadata !DIExpression()), !dbg !92, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !99, metadata !DIExpression()), !dbg !92, !verifier.code !21
  %13 = icmp ne %struct.node* %.01.lcssa, null, !dbg !107, !verifier.code !21
  br i1 %13, label %14, label %16, !dbg !109, !verifier.code !21

14:                                               ; preds = %12
  %15 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 1, !dbg !110, !verifier.code !21
  store %struct.node* %4, %struct.node** %15, align 8, !dbg !112, !verifier.code !21
  br label %17, !dbg !113, !verifier.code !21

16:                                               ; preds = %12
  store %struct.node* %4, %struct.node** %0, align 8, !dbg !114, !verifier.code !21
  br label %17, !verifier.code !21

17:                                               ; preds = %16, %14
  %18 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 1, !dbg !116, !verifier.code !21
  store %struct.node* %.0.lcssa, %struct.node** %18, align 8, !dbg !117, !verifier.code !21
  ret void, !dbg !118, !verifier.code !21

forwarder:                                        ; preds = %7
  br label %7, !verifier.code !21
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !119 {
  %1 = alloca %struct.node*, align 8, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 2, metadata !122, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 1, metadata !125, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.declare(metadata %struct.node** %1, metadata !126, metadata !DIExpression()), !dbg !127, !verifier.code !21
  %2 = call %struct.node* @sll_create(i32 2, i32 1), !dbg !128, !verifier.code !21
  store %struct.node* %2, %struct.node** %1, align 8, !dbg !127, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 5, metadata !129, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 1, metadata !130, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @sll_insert(%struct.node** %1, i32 5, i32 1), !dbg !131, !verifier.code !21
  %3 = load %struct.node*, %struct.node** %1, align 8, !dbg !132, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 0, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  br label %4, !dbg !135, !verifier.code !21

4:                                                ; preds = %17, %0
  %.01 = phi %struct.node* [ %3, %0 ], [ %12, %17 ], !dbg !124, !verifier.code !21
  %.0 = phi i32 [ 0, %0 ], [ %18, %17 ], !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.0, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %5 = icmp ne %struct.node* %.01, null, !dbg !136, !verifier.code !21
  br i1 %5, label %6, label %8, !dbg !137, !verifier.code !21

6:                                                ; preds = %4
  %7 = icmp ne i32 %.0, 1, !dbg !138, !verifier.code !21
  br label %8, !verifier.code !21

8:                                                ; preds = %6, %4
  %9 = phi i1 [ false, %4 ], [ %7, %6 ], !dbg !124, !verifier.code !21
  br i1 %9, label %10, label %19, !dbg !135, !verifier.code !21

10:                                               ; preds = %8
  %11 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !139, !verifier.code !21
  %12 = load %struct.node*, %struct.node** %11, align 8, !dbg !139, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %12, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !21
  %13 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !143, !verifier.code !21
  %14 = load i32, i32* %13, align 8, !dbg !143, !verifier.code !21
  %15 = icmp ne i32 1, %14, !dbg !145, !verifier.code !21
  br i1 %15, label %16, label %17, !dbg !146, !verifier.code !21

16:                                               ; preds = %10
  br label %44, !dbg !147, !verifier.code !21

17:                                               ; preds = %10
  call void @llvm.dbg.value(metadata %struct.node* %12, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %18 = add nsw i32 %.0, 1, !dbg !149, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %18, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  br label %4, !dbg !135, !llvm.loop !150, !verifier.code !21

19:                                               ; preds = %8
  %.01.lcssa = phi %struct.node* [ %.01, %8 ], !dbg !124, !verifier.code !21
  %.0.lcssa = phi i32 [ %.0, %8 ], !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.0.lcssa, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %20 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 0, !dbg !152, !verifier.code !21
  %21 = load i32, i32* %20, align 8, !dbg !152, !verifier.code !21
  %22 = icmp ne i32 5, %21, !dbg !154, !verifier.code !21
  br i1 %22, label %23, label %24, !dbg !155, !verifier.code !21

23:                                               ; preds = %19
  br label %44, !dbg !156, !verifier.code !21

24:                                               ; preds = %19
  %25 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 1, !dbg !158, !verifier.code !21
  %26 = load %struct.node*, %struct.node** %25, align 8, !dbg !158, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %26, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %27 = add nsw i32 %.0.lcssa, 1, !dbg !159, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %27, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %26, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %28 = icmp ne %struct.node* %26, null, !dbg !160, !verifier.code !21
  br i1 %28, label %.lr.ph, label %39, !dbg !160, !verifier.code !21

.lr.ph:                                           ; preds = %24
  br label %29, !dbg !160, !verifier.code !21

29:                                               ; preds = %forwarder, %.lr.ph
  %.17 = phi i32 [ %27, %.lr.ph ], [ %37, %forwarder ], !verifier.code !21
  %.126 = phi %struct.node* [ %26, %.lr.ph ], [ %31, %forwarder ], !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.17, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %.126, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %30 = getelementptr inbounds %struct.node, %struct.node* %.126, i32 0, i32 1, !dbg !161, !verifier.code !21
  %31 = load %struct.node*, %struct.node** %30, align 8, !dbg !161, !verifier.code !21
  call void @llvm.dbg.value(metadata %struct.node* %31, metadata !163, metadata !DIExpression()), !dbg !164, !verifier.code !21
  %32 = getelementptr inbounds %struct.node, %struct.node* %.126, i32 0, i32 0, !dbg !165, !verifier.code !21
  %33 = load i32, i32* %32, align 8, !dbg !165, !verifier.code !21
  %34 = icmp ne i32 1, %33, !dbg !167, !verifier.code !21
  br i1 %34, label %35, label %36, !dbg !168, !verifier.code !21

35:                                               ; preds = %29
  br label %44, !dbg !169, !verifier.code !21

36:                                               ; preds = %29
  call void @llvm.dbg.value(metadata %struct.node* %31, metadata !133, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %37 = add nsw i32 %.17, 1, !dbg !171, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %37, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %38 = icmp ne %struct.node* %31, null, !dbg !160, !verifier.code !21
  br i1 %38, label %forwarder, label %._crit_edge, !dbg !160, !llvm.loop !172, !verifier.code !21

._crit_edge:                                      ; preds = %36
  %split = phi i32 [ %37, %36 ], !verifier.code !21
  br label %39, !dbg !160, !verifier.code !21

39:                                               ; preds = %._crit_edge, %24
  %.1.lcssa = phi i32 [ %split, %._crit_edge ], [ %27, %24 ], !dbg !124, !verifier.code !21
  call void @llvm.dbg.value(metadata i32 %.1.lcssa, metadata !134, metadata !DIExpression()), !dbg !124, !verifier.code !21
  %40 = icmp ne i32 %.1.lcssa, 3, !dbg !174, !verifier.code !21
  br i1 %40, label %41, label %42, !dbg !176, !verifier.code !21

41:                                               ; preds = %39
  br label %44, !dbg !177, !verifier.code !21

42:                                               ; preds = %39
  %43 = load %struct.node*, %struct.node** %1, align 8, !dbg !179, !verifier.code !21
  call void @sll_destroy(%struct.node* %43), !dbg !180, !verifier.code !21
  ret i32 0, !dbg !181, !verifier.code !21

44:                                               ; preds = %41, %35, %23, %16
  call void @llvm.dbg.label(metadata !182), !dbg !183, !verifier.code !21
  call void @reach_error(), !dbg !184, !verifier.code !21
  call void @abort() #5, !dbg !186, !verifier.code !21
  unreachable, !dbg !186, !verifier.code !21

forwarder:                                        ; preds = %36
  br label %29, !verifier.code !21
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
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/sll2n_insert_unequal.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !12}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "SLL", file: !5, line: 13, baseType: !6)
!5 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//sll2n_insert_unequal.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !5, line: 10, size: 128, elements: !8)
!8 = !{!9, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !5, line: 11, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !7, file: !5, line: 12, baseType: !6, size: 64, offset: 64)
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
!22 = distinct !DISubprogram(name: "myexit", scope: !5, file: !5, line: 15, type: !23, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{null, !10}
!25 = !DILocalVariable(name: "s", arg: 1, scope: !22, file: !5, line: 15, type: !10)
!26 = !DILocation(line: 0, scope: !22)
!27 = !DILocation(line: 15, column: 20, scope: !22)
!28 = !DILabel(scope: !22, name: "_EXIT", file: !5, line: 16)
!29 = !DILocation(line: 16, column: 2, scope: !22)
!30 = !DILocation(line: 16, column: 9, scope: !22)
!31 = distinct !DISubprogram(name: "node_create", scope: !5, file: !5, line: 19, type: !32, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!4, !10}
!34 = !DILocalVariable(name: "data", arg: 1, scope: !31, file: !5, line: 19, type: !10)
!35 = !DILocation(line: 0, scope: !31)
!36 = !DILocation(line: 20, column: 20, scope: !31)
!37 = !DILocation(line: 20, column: 14, scope: !31)
!38 = !DILocalVariable(name: "temp", scope: !31, file: !5, line: 20, type: !4)
!39 = !DILocation(line: 21, column: 11, scope: !40)
!40 = distinct !DILexicalBlock(scope: !31, file: !5, line: 21, column: 6)
!41 = !DILocation(line: 21, column: 6, scope: !31)
!42 = !DILocation(line: 22, column: 5, scope: !43)
!43 = distinct !DILexicalBlock(scope: !40, file: !5, line: 21, column: 20)
!44 = !DILocation(line: 23, column: 3, scope: !43)
!45 = !DILocation(line: 24, column: 9, scope: !31)
!46 = !DILocation(line: 24, column: 14, scope: !31)
!47 = !DILocation(line: 25, column: 9, scope: !31)
!48 = !DILocation(line: 25, column: 14, scope: !31)
!49 = !DILocation(line: 26, column: 3, scope: !31)
!50 = distinct !DISubprogram(name: "sll_create", scope: !5, file: !5, line: 29, type: !51, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!51 = !DISubroutineType(types: !52)
!52 = !{!4, !10, !10}
!53 = !DILocalVariable(name: "len", arg: 1, scope: !50, file: !5, line: 29, type: !10)
!54 = !DILocation(line: 0, scope: !50)
!55 = !DILocalVariable(name: "data", arg: 2, scope: !50, file: !5, line: 29, type: !10)
!56 = !DILocalVariable(name: "head", scope: !50, file: !5, line: 30, type: !4)
!57 = !DILocation(line: 31, column: 13, scope: !58)
!58 = distinct !DILexicalBlock(scope: !59, file: !5, line: 31, column: 3)
!59 = distinct !DILexicalBlock(scope: !50, file: !5, line: 31, column: 3)
!60 = !DILocation(line: 31, column: 3, scope: !59)
!61 = !DILocation(line: 32, column: 20, scope: !62)
!62 = distinct !DILexicalBlock(scope: !58, file: !5, line: 31, column: 25)
!63 = !DILocalVariable(name: "new_head", scope: !62, file: !5, line: 32, type: !4)
!64 = !DILocation(line: 0, scope: !62)
!65 = !DILocation(line: 33, column: 15, scope: !62)
!66 = !DILocation(line: 33, column: 20, scope: !62)
!67 = !DILocation(line: 35, column: 3, scope: !62)
!68 = !DILocation(line: 31, column: 21, scope: !58)
!69 = distinct !{!69, !60, !70}
!70 = !DILocation(line: 35, column: 3, scope: !59)
!71 = !DILocation(line: 36, column: 3, scope: !50)
!72 = distinct !DISubprogram(name: "sll_destroy", scope: !5, file: !5, line: 39, type: !73, scopeLine: 39, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !4}
!75 = !DILocalVariable(name: "head", arg: 1, scope: !72, file: !5, line: 39, type: !4)
!76 = !DILocation(line: 0, scope: !72)
!77 = !DILocation(line: 40, column: 3, scope: !72)
!78 = !DILocation(line: 41, column: 22, scope: !79)
!79 = distinct !DILexicalBlock(scope: !72, file: !5, line: 40, column: 15)
!80 = !DILocalVariable(name: "temp", scope: !79, file: !5, line: 41, type: !4)
!81 = !DILocation(line: 0, scope: !79)
!82 = !DILocation(line: 42, column: 10, scope: !79)
!83 = !DILocation(line: 42, column: 5, scope: !79)
!84 = distinct !{!84, !77, !85}
!85 = !DILocation(line: 44, column: 3, scope: !72)
!86 = !DILocation(line: 45, column: 1, scope: !72)
!87 = distinct !DISubprogram(name: "sll_insert", scope: !5, file: !5, line: 47, type: !88, scopeLine: 47, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !90, !10, !10}
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!91 = !DILocalVariable(name: "head", arg: 1, scope: !87, file: !5, line: 47, type: !90)
!92 = !DILocation(line: 0, scope: !87)
!93 = !DILocalVariable(name: "data", arg: 2, scope: !87, file: !5, line: 47, type: !10)
!94 = !DILocalVariable(name: "index", arg: 3, scope: !87, file: !5, line: 47, type: !10)
!95 = !DILocation(line: 48, column: 18, scope: !87)
!96 = !DILocalVariable(name: "new_node", scope: !87, file: !5, line: 48, type: !4)
!97 = !DILocalVariable(name: "snd_to_last", scope: !87, file: !5, line: 49, type: !4)
!98 = !DILocation(line: 50, column: 14, scope: !87)
!99 = !DILocalVariable(name: "last", scope: !87, file: !5, line: 50, type: !4)
!100 = !DILocation(line: 51, column: 15, scope: !87)
!101 = !DILocation(line: 51, column: 3, scope: !87)
!102 = !DILocation(line: 53, column: 18, scope: !103)
!103 = distinct !DILexicalBlock(scope: !87, file: !5, line: 51, column: 20)
!104 = !DILocation(line: 54, column: 10, scope: !103)
!105 = distinct !{!105, !101, !106}
!106 = !DILocation(line: 55, column: 3, scope: !87)
!107 = !DILocation(line: 56, column: 6, scope: !108)
!108 = distinct !DILexicalBlock(scope: !87, file: !5, line: 56, column: 6)
!109 = !DILocation(line: 56, column: 6, scope: !87)
!110 = !DILocation(line: 57, column: 18, scope: !111)
!111 = distinct !DILexicalBlock(scope: !108, file: !5, line: 56, column: 19)
!112 = !DILocation(line: 57, column: 23, scope: !111)
!113 = !DILocation(line: 58, column: 3, scope: !111)
!114 = !DILocation(line: 59, column: 11, scope: !115)
!115 = distinct !DILexicalBlock(scope: !108, file: !5, line: 58, column: 10)
!116 = !DILocation(line: 61, column: 13, scope: !87)
!117 = !DILocation(line: 61, column: 18, scope: !87)
!118 = !DILocation(line: 62, column: 1, scope: !87)
!119 = distinct !DISubprogram(name: "main", scope: !5, file: !5, line: 64, type: !120, scopeLine: 64, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!120 = !DISubroutineType(types: !121)
!121 = !{!10}
!122 = !DILocalVariable(name: "len", scope: !119, file: !5, line: 66, type: !123)
!123 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!124 = !DILocation(line: 0, scope: !119)
!125 = !DILocalVariable(name: "data", scope: !119, file: !5, line: 67, type: !123)
!126 = !DILocalVariable(name: "s", scope: !119, file: !5, line: 68, type: !4)
!127 = !DILocation(line: 68, column: 7, scope: !119)
!128 = !DILocation(line: 68, column: 11, scope: !119)
!129 = !DILocalVariable(name: "uneq", scope: !119, file: !5, line: 70, type: !123)
!130 = !DILocalVariable(name: "mid_index", scope: !119, file: !5, line: 71, type: !123)
!131 = !DILocation(line: 72, column: 3, scope: !119)
!132 = !DILocation(line: 74, column: 13, scope: !119)
!133 = !DILocalVariable(name: "ptr", scope: !119, file: !5, line: 74, type: !4)
!134 = !DILocalVariable(name: "count", scope: !119, file: !5, line: 75, type: !10)
!135 = !DILocation(line: 76, column: 3, scope: !119)
!136 = !DILocation(line: 76, column: 9, scope: !119)
!137 = !DILocation(line: 76, column: 13, scope: !119)
!138 = !DILocation(line: 76, column: 22, scope: !119)
!139 = !DILocation(line: 77, column: 21, scope: !140)
!140 = distinct !DILexicalBlock(scope: !119, file: !5, line: 76, column: 36)
!141 = !DILocalVariable(name: "temp", scope: !140, file: !5, line: 77, type: !4)
!142 = !DILocation(line: 0, scope: !140)
!143 = !DILocation(line: 78, column: 21, scope: !144)
!144 = distinct !DILexicalBlock(scope: !140, file: !5, line: 78, column: 8)
!145 = !DILocation(line: 78, column: 13, scope: !144)
!146 = !DILocation(line: 78, column: 8, scope: !140)
!147 = !DILocation(line: 79, column: 7, scope: !148)
!148 = distinct !DILexicalBlock(scope: !144, file: !5, line: 78, column: 27)
!149 = !DILocation(line: 82, column: 10, scope: !140)
!150 = distinct !{!150, !135, !151}
!151 = !DILocation(line: 83, column: 3, scope: !119)
!152 = !DILocation(line: 85, column: 19, scope: !153)
!153 = distinct !DILexicalBlock(scope: !119, file: !5, line: 85, column: 6)
!154 = !DILocation(line: 85, column: 11, scope: !153)
!155 = !DILocation(line: 85, column: 6, scope: !119)
!156 = !DILocation(line: 86, column: 5, scope: !157)
!157 = distinct !DILexicalBlock(scope: !153, file: !5, line: 85, column: 25)
!158 = !DILocation(line: 88, column: 14, scope: !119)
!159 = !DILocation(line: 89, column: 8, scope: !119)
!160 = !DILocation(line: 90, column: 3, scope: !119)
!161 = !DILocation(line: 91, column: 21, scope: !162)
!162 = distinct !DILexicalBlock(scope: !119, file: !5, line: 90, column: 14)
!163 = !DILocalVariable(name: "temp", scope: !162, file: !5, line: 91, type: !4)
!164 = !DILocation(line: 0, scope: !162)
!165 = !DILocation(line: 92, column: 21, scope: !166)
!166 = distinct !DILexicalBlock(scope: !162, file: !5, line: 92, column: 8)
!167 = !DILocation(line: 92, column: 13, scope: !166)
!168 = !DILocation(line: 92, column: 8, scope: !162)
!169 = !DILocation(line: 93, column: 7, scope: !170)
!170 = distinct !DILexicalBlock(scope: !166, file: !5, line: 92, column: 27)
!171 = !DILocation(line: 96, column: 10, scope: !162)
!172 = distinct !{!172, !160, !173}
!173 = !DILocation(line: 97, column: 3, scope: !119)
!174 = !DILocation(line: 98, column: 12, scope: !175)
!175 = distinct !DILexicalBlock(scope: !119, file: !5, line: 98, column: 6)
!176 = !DILocation(line: 98, column: 6, scope: !119)
!177 = !DILocation(line: 99, column: 5, scope: !178)
!178 = distinct !DILexicalBlock(scope: !175, file: !5, line: 98, column: 24)
!179 = !DILocation(line: 102, column: 15, scope: !119)
!180 = !DILocation(line: 102, column: 3, scope: !119)
!181 = !DILocation(line: 104, column: 3, scope: !119)
!182 = !DILabel(scope: !119, name: "ERROR", file: !5, line: 105)
!183 = !DILocation(line: 105, column: 2, scope: !119)
!184 = !DILocation(line: 105, column: 10, scope: !185)
!185 = distinct !DILexicalBlock(scope: !119, file: !5, line: 105, column: 9)
!186 = !DILocation(line: 105, column: 24, scope: !185)
