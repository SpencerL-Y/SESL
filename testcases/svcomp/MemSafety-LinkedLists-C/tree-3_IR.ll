; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-9wgl1uwo.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, %struct.node*, %struct.node*, i32 }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  ret void, !dbg !13, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @create_tree() #0 !dbg !15 {
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !26, metadata !DIExpression()), !dbg !27, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !29, !verifier.code !30
  %2 = icmp ne i32 %1, 0, !dbg !31, !verifier.code !14
  br i1 %2, label %.lr.ph8, label %22, !dbg !31, !verifier.code !14

.lr.ph8:                                          ; preds = %0
  br label %3, !dbg !31, !verifier.code !14

3:                                                ; preds = %forwarder11, %.lr.ph8
  %.06 = phi %struct.node* [ null, %.lr.ph8 ], [ %5, %forwarder11 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.06, metadata !26, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %4 = call noalias i8* @malloc(i64 32) #5, !dbg !32, !verifier.code !14
  %5 = bitcast i8* %4 to %struct.node*, !dbg !32, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %6 = icmp ne %struct.node* %5, null, !dbg !34, !verifier.code !14
  br i1 %6, label %8, label %7, !dbg !36, !verifier.code !14

7:                                                ; preds = %3
  call void @abort() #6, !dbg !37, !verifier.code !14
  unreachable, !dbg !37, !verifier.code !14

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 0, !dbg !38, !verifier.code !14
  store %struct.node* null, %struct.node** %9, align 8, !dbg !39, !verifier.code !14
  %10 = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 1, !dbg !40, !verifier.code !14
  store %struct.node* %.06, %struct.node** %10, align 8, !dbg !41, !verifier.code !14
  %11 = icmp ne %struct.node* %.06, null, !dbg !42, !verifier.code !14
  br i1 %11, label %12, label %14, !dbg !44, !verifier.code !14

12:                                               ; preds = %8
  %13 = getelementptr inbounds %struct.node, %struct.node* %.06, i32 0, i32 2, !dbg !45, !verifier.code !14
  store %struct.node* %5, %struct.node** %13, align 8, !dbg !46, !verifier.code !14
  br label %14, !dbg !47, !verifier.code !14

14:                                               ; preds = %12, %8
  %15 = call i32 @__VERIFIER_nondet_int(), !dbg !48, !verifier.code !30
  call void @llvm.dbg.value(metadata i32 %15, metadata !49, metadata !DIExpression()), !dbg !50, !verifier.code !14
  %16 = icmp ne i32 %15, 0, !dbg !51, !verifier.code !14
  br i1 %16, label %18, label %17, !dbg !53, !verifier.code !14

17:                                               ; preds = %14
  call void @llvm.dbg.value(metadata i32 1, metadata !49, metadata !DIExpression()), !dbg !50, !verifier.code !14
  br label %18, !dbg !54, !verifier.code !14

18:                                               ; preds = %17, %14
  %.02 = phi i32 [ %15, %14 ], [ 1, %17 ], !dbg !50, !verifier.code !14
  call void @llvm.dbg.value(metadata i32 %.02, metadata !49, metadata !DIExpression()), !dbg !50, !verifier.code !14
  %19 = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 3, !dbg !55, !verifier.code !14
  store i32 %.02, i32* %19, align 8, !dbg !56, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !26, metadata !DIExpression()), !dbg !27, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %20 = call i32 @__VERIFIER_nondet_int(), !dbg !29, !verifier.code !30
  %21 = icmp ne i32 %20, 0, !dbg !31, !verifier.code !14
  br i1 %21, label %forwarder11, label %._crit_edge9, !dbg !31, !llvm.loop !57, !verifier.code !14

._crit_edge9:                                     ; preds = %18
  %split = phi %struct.node* [ %5, %18 ], !verifier.code !14
  %split10 = phi %struct.node* [ %5, %18 ], !verifier.code !14
  br label %22, !dbg !31, !verifier.code !14

22:                                               ; preds = %._crit_edge9, %0
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge9 ], [ null, %0 ], !dbg !27, !verifier.code !14
  %.0.lcssa = phi %struct.node* [ %split10, %._crit_edge9 ], [ null, %0 ], !dbg !27, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !26, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %23 = icmp ne %struct.node* %.01.lcssa, null, !dbg !59, !verifier.code !14
  br i1 %23, label %24, label %26, !dbg !61, !verifier.code !14

24:                                               ; preds = %22
  %25 = getelementptr inbounds %struct.node, %struct.node* %.01.lcssa, i32 0, i32 2, !dbg !62, !verifier.code !14
  store %struct.node* null, %struct.node** %25, align 8, !dbg !63, !verifier.code !14
  br label %26, !dbg !64, !verifier.code !14

26:                                               ; preds = %24, %22
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %27 = icmp ne %struct.node* %.01.lcssa, null, !dbg !65, !verifier.code !14
  br i1 %27, label %.lr.ph, label %50, !dbg !66, !verifier.code !14

.lr.ph:                                           ; preds = %26
  br label %28, !dbg !66, !verifier.code !14

28:                                               ; preds = %forwarder, %.lr.ph
  %.15 = phi %struct.node* [ %.01.lcssa, %.lr.ph ], [ %48, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.15, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %29 = call noalias i8* @malloc(i64 32) #5, !dbg !67, !verifier.code !14
  %30 = bitcast i8* %29 to %struct.node*, !dbg !67, !verifier.code !14
  %31 = getelementptr inbounds %struct.node, %struct.node* %.15, i32 0, i32 0, !dbg !69, !verifier.code !14
  store %struct.node* %30, %struct.node** %31, align 8, !dbg !70, !verifier.code !14
  %32 = icmp ne %struct.node* %.15, null, !dbg !71, !verifier.code !14
  br i1 %32, label %34, label %33, !dbg !73, !verifier.code !14

33:                                               ; preds = %28
  call void @abort() #6, !dbg !74, !verifier.code !14
  unreachable, !dbg !74, !verifier.code !14

34:                                               ; preds = %28
  %35 = getelementptr inbounds %struct.node, %struct.node* %.15, i32 0, i32 0, !dbg !75, !verifier.code !14
  %36 = load %struct.node*, %struct.node** %35, align 8, !dbg !75, !verifier.code !14
  %37 = getelementptr inbounds %struct.node, %struct.node* %36, i32 0, i32 0, !dbg !76, !verifier.code !14
  store %struct.node* null, %struct.node** %37, align 8, !dbg !77, !verifier.code !14
  %38 = getelementptr inbounds %struct.node, %struct.node* %.15, i32 0, i32 0, !dbg !78, !verifier.code !14
  %39 = load %struct.node*, %struct.node** %38, align 8, !dbg !78, !verifier.code !14
  %40 = getelementptr inbounds %struct.node, %struct.node* %39, i32 0, i32 1, !dbg !79, !verifier.code !14
  store %struct.node* null, %struct.node** %40, align 8, !dbg !80, !verifier.code !14
  %41 = getelementptr inbounds %struct.node, %struct.node* %.15, i32 0, i32 0, !dbg !81, !verifier.code !14
  %42 = load %struct.node*, %struct.node** %41, align 8, !dbg !81, !verifier.code !14
  %43 = getelementptr inbounds %struct.node, %struct.node* %42, i32 0, i32 3, !dbg !82, !verifier.code !14
  store i32 42, i32* %43, align 8, !dbg !83, !verifier.code !14
  %44 = getelementptr inbounds %struct.node, %struct.node* %.15, i32 0, i32 0, !dbg !84, !verifier.code !14
  %45 = load %struct.node*, %struct.node** %44, align 8, !dbg !84, !verifier.code !14
  %46 = getelementptr inbounds %struct.node, %struct.node* %45, i32 0, i32 2, !dbg !85, !verifier.code !14
  store %struct.node* %.15, %struct.node** %46, align 8, !dbg !86, !verifier.code !14
  %47 = getelementptr inbounds %struct.node, %struct.node* %.15, i32 0, i32 1, !dbg !87, !verifier.code !14
  %48 = load %struct.node*, %struct.node** %47, align 8, !dbg !87, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %48, metadata !28, metadata !DIExpression()), !dbg !27, !verifier.code !14
  %49 = icmp ne %struct.node* %48, null, !dbg !65, !verifier.code !14
  br i1 %49, label %forwarder, label %._crit_edge, !dbg !66, !llvm.loop !88, !verifier.code !14

._crit_edge:                                      ; preds = %34
  br label %50, !dbg !66, !verifier.code !14

50:                                               ; preds = %._crit_edge, %26
  ret %struct.node* %.0.lcssa, !dbg !90, !verifier.code !14

forwarder:                                        ; preds = %34
  br label %28, !verifier.code !14

forwarder11:                                      ; preds = %18
  br label %3, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #4

; Function Attrs: noinline nounwind uwtable
define internal void @free_tree(%struct.node* %0) #0 !dbg !91 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !96, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %2 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !97, !verifier.code !14
  %3 = load %struct.node*, %struct.node** %2, align 8, !dbg !97, !verifier.code !14
  %4 = icmp eq %struct.node* %3, null, !dbg !100, !verifier.code !14
  br i1 %4, label %5, label %.lr.ph5, !dbg !101, !verifier.code !14

.lr.ph5:                                          ; preds = %1
  br label %6, !dbg !101, !verifier.code !14

._crit_edge6:                                     ; preds = %6
  %split7 = phi %struct.node* [ %8, %6 ], !verifier.code !14
  br label %5, !dbg !101, !verifier.code !14

5:                                                ; preds = %._crit_edge6, %1
  %.0.lcssa = phi %struct.node* [ %split7, %._crit_edge6 ], [ %0, %1 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  br label %12, !dbg !102, !verifier.code !14

6:                                                ; preds = %forwarder8, %.lr.ph5
  %.03 = phi %struct.node* [ %0, %.lr.ph5 ], [ %8, %forwarder8 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.03, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %7 = getelementptr inbounds %struct.node, %struct.node* %.03, i32 0, i32 1, !dbg !103, !verifier.code !14
  %8 = load %struct.node*, %struct.node** %7, align 8, !dbg !103, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %8, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %9 = getelementptr inbounds %struct.node, %struct.node* %8, i32 0, i32 1, !dbg !97, !verifier.code !14
  %10 = load %struct.node*, %struct.node** %9, align 8, !dbg !97, !verifier.code !14
  %11 = icmp eq %struct.node* %10, null, !dbg !100, !verifier.code !14
  br i1 %11, label %._crit_edge6, label %forwarder8, !dbg !101, !llvm.loop !104, !verifier.code !14

12:                                               ; preds = %5
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !96, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %13 = icmp ne %struct.node* %.0.lcssa, null, !dbg !107, !verifier.code !14
  br i1 %13, label %.lr.ph, label %34, !dbg !108, !verifier.code !14

.lr.ph:                                           ; preds = %12
  br label %14, !dbg !108, !verifier.code !14

14:                                               ; preds = %forwarder, %.lr.ph
  %.12 = phi %struct.node* [ %.0.lcssa, %.lr.ph ], [ %32, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.12, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %15 = getelementptr inbounds %struct.node, %struct.node* %.12, i32 0, i32 0, !dbg !109, !verifier.code !14
  %16 = load %struct.node*, %struct.node** %15, align 8, !dbg !109, !verifier.code !14
  %17 = icmp ne %struct.node* %16, null, !dbg !112, !verifier.code !14
  br i1 %17, label %18, label %22, !dbg !113, !verifier.code !14

18:                                               ; preds = %14
  %19 = getelementptr inbounds %struct.node, %struct.node* %.12, i32 0, i32 0, !dbg !114, !verifier.code !14
  %20 = load %struct.node*, %struct.node** %19, align 8, !dbg !114, !verifier.code !14
  %21 = bitcast %struct.node* %20 to i8*, !dbg !115, !verifier.code !14
  call void @free(i8* %21) #5, !dbg !116, !verifier.code !14
  br label %22, !dbg !116, !verifier.code !14

22:                                               ; preds = %18, %14
  %23 = getelementptr inbounds %struct.node, %struct.node* %.12, i32 0, i32 1, !dbg !117, !verifier.code !14
  %24 = load %struct.node*, %struct.node** %23, align 8, !dbg !117, !verifier.code !14
  %25 = icmp ne %struct.node* %24, null, !dbg !119, !verifier.code !14
  br i1 %25, label %26, label %30, !dbg !120, !verifier.code !14

26:                                               ; preds = %22
  %27 = getelementptr inbounds %struct.node, %struct.node* %.12, i32 0, i32 1, !dbg !121, !verifier.code !14
  %28 = load %struct.node*, %struct.node** %27, align 8, !dbg !121, !verifier.code !14
  %29 = bitcast %struct.node* %28 to i8*, !dbg !122, !verifier.code !14
  call void @free(i8* %29) #5, !dbg !123, !verifier.code !14
  br label %30, !dbg !123, !verifier.code !14

30:                                               ; preds = %26, %22
  call void @llvm.dbg.value(metadata %struct.node* %.12, metadata !96, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %31 = getelementptr inbounds %struct.node, %struct.node* %.12, i32 0, i32 2, !dbg !124, !verifier.code !14
  %32 = load %struct.node*, %struct.node** %31, align 8, !dbg !124, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %32, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %33 = icmp ne %struct.node* %32, null, !dbg !107, !verifier.code !14
  br i1 %33, label %forwarder, label %._crit_edge, !dbg !108, !llvm.loop !125, !verifier.code !14

._crit_edge:                                      ; preds = %30
  %split = phi %struct.node* [ %.12, %30 ], !verifier.code !14
  br label %34, !dbg !108, !verifier.code !14

34:                                               ; preds = %._crit_edge, %12
  %.01.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ null, %12 ], !dbg !95, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.01.lcssa, metadata !96, metadata !DIExpression()), !dbg !95, !verifier.code !14
  %35 = bitcast %struct.node* %.01.lcssa to i8*, !dbg !127, !verifier.code !14
  call void @free(i8* %35) #5, !dbg !128, !verifier.code !14
  ret void, !dbg !129, !verifier.code !14

forwarder:                                        ; preds = %30
  br label %14, !verifier.code !14

forwarder8:                                       ; preds = %6
  br label %6, !verifier.code !14
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !130 {
  %1 = call %struct.node* @create_tree(), !dbg !133, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !14
  %2 = icmp ne %struct.node* %1, null, !dbg !136, !verifier.code !14
  br i1 %2, label %4, label %3, !dbg !138, !verifier.code !14

3:                                                ; preds = %0
  br label %5, !dbg !139, !verifier.code !14

4:                                                ; preds = %0
  call void @inspect(%struct.node* %1), !dbg !140, !verifier.code !14
  call void @free_tree(%struct.node* %1), !dbg !141, !verifier.code !14
  br label %5, !dbg !142, !verifier.code !14

5:                                                ; preds = %4, %3
  ret i32 0, !dbg !143, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @inspect(%struct.node* %0) #0 !dbg !144 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !14
  br label %2, !dbg !147, !verifier.code !14

2:                                                ; preds = %1
  %3 = icmp ne %struct.node* %0, null, !dbg !148, !verifier.code !14
  br i1 %3, label %5, label %4, !dbg !151, !verifier.code !14

4:                                                ; preds = %2
  call void @fail(), !dbg !148, !verifier.code !14
  br label %5, !dbg !148, !verifier.code !14

5:                                                ; preds = %4, %2
  br label %6, !dbg !151, !verifier.code !14

6:                                                ; preds = %5
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !14
  %7 = icmp ne %struct.node* %0, null, !dbg !152, !verifier.code !14
  br i1 %7, label %.lr.ph, label %33, !dbg !153, !verifier.code !14

.lr.ph:                                           ; preds = %6
  br label %8, !dbg !153, !verifier.code !14

8:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %0, %.lr.ph ], [ %31, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !14
  %9 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !154, !verifier.code !14
  %10 = load %struct.node*, %struct.node** %9, align 8, !dbg !154, !verifier.code !14
  %11 = icmp ne %struct.node* %10, null, !dbg !157, !verifier.code !14
  br i1 %11, label %12, label %22, !dbg !158, !verifier.code !14

12:                                               ; preds = %8
  br label %13, !dbg !159, !verifier.code !14

13:                                               ; preds = %12
  %14 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !160, !verifier.code !14
  %15 = load %struct.node*, %struct.node** %14, align 8, !dbg !160, !verifier.code !14
  %16 = getelementptr inbounds %struct.node, %struct.node* %15, i32 0, i32 3, !dbg !160, !verifier.code !14
  %17 = load i32, i32* %16, align 8, !dbg !160, !verifier.code !14
  %18 = icmp eq i32 %17, 42, !dbg !160, !verifier.code !14
  br i1 %18, label %20, label %19, !dbg !163, !verifier.code !14

19:                                               ; preds = %13
  call void @fail(), !dbg !160, !verifier.code !14
  br label %20, !dbg !160, !verifier.code !14

20:                                               ; preds = %19, %13
  br label %21, !dbg !163, !verifier.code !14

21:                                               ; preds = %20
  br label %22, !dbg !163, !verifier.code !14

22:                                               ; preds = %21, %8
  br label %23, !dbg !164, !verifier.code !14

23:                                               ; preds = %22
  %24 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 3, !dbg !165, !verifier.code !14
  %25 = load i32, i32* %24, align 8, !dbg !165, !verifier.code !14
  %26 = icmp ne i32 %25, 0, !dbg !165, !verifier.code !14
  br i1 %26, label %28, label %27, !dbg !168, !verifier.code !14

27:                                               ; preds = %23
  call void @fail(), !dbg !165, !verifier.code !14
  br label %28, !dbg !165, !verifier.code !14

28:                                               ; preds = %27, %23
  br label %29, !dbg !168, !verifier.code !14

29:                                               ; preds = %28
  %30 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 2, !dbg !169, !verifier.code !14
  %31 = load %struct.node*, %struct.node** %30, align 8, !dbg !169, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %31, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !14
  %32 = icmp ne %struct.node* %31, null, !dbg !152, !verifier.code !14
  br i1 %32, label %forwarder, label %._crit_edge, !dbg !153, !llvm.loop !170, !verifier.code !14

._crit_edge:                                      ; preds = %29
  br label %33, !dbg !153, !verifier.code !14

33:                                               ; preds = %._crit_edge, %6
  ret void, !dbg !172, !verifier.code !14

forwarder:                                        ; preds = %29
  br label %8, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @fail() #0 !dbg !173 {
  br label %1, !dbg !174, !verifier.code !14

1:                                                ; preds = %0
  call void @llvm.dbg.label(metadata !175), !dbg !176, !verifier.code !14
  call void @reach_error(), !dbg !177, !verifier.code !14
  call void @abort() #6, !dbg !179, !verifier.code !14
  unreachable, !dbg !179, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/tree-3.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !10, file: !10, line: 2, type: !11, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//tree-3.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 2, column: 20, scope: !9)
!14 = !{i1 false}
!15 = distinct !DISubprogram(name: "create_tree", scope: !10, file: !10, line: 39, type: !16, scopeLine: 40, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !10, line: 21, size: 256, elements: !20)
!20 = !{!21, !22, !23, !24}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "left", scope: !19, file: !10, line: 22, baseType: !18, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "right", scope: !19, file: !10, line: 23, baseType: !18, size: 64, offset: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "parent", scope: !19, file: !10, line: 24, baseType: !18, size: 64, offset: 128)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !19, file: !10, line: 25, baseType: !25, size: 32, offset: 192)
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !DILocalVariable(name: "nodelast", scope: !15, file: !10, line: 41, type: !18)
!27 = !DILocation(line: 0, scope: !15)
!28 = !DILocalVariable(name: "node", scope: !15, file: !10, line: 42, type: !18)
!29 = !DILocation(line: 43, column: 12, scope: !15)
!30 = !{i1 true}
!31 = !DILocation(line: 43, column: 5, scope: !15)
!32 = !DILocation(line: 44, column: 16, scope: !33)
!33 = distinct !DILexicalBlock(scope: !15, file: !10, line: 43, column: 37)
!34 = !DILocation(line: 45, column: 14, scope: !35)
!35 = distinct !DILexicalBlock(scope: !33, file: !10, line: 45, column: 13)
!36 = !DILocation(line: 45, column: 13, scope: !33)
!37 = !DILocation(line: 46, column: 13, scope: !35)
!38 = !DILocation(line: 48, column: 15, scope: !33)
!39 = !DILocation(line: 48, column: 20, scope: !33)
!40 = !DILocation(line: 49, column: 15, scope: !33)
!41 = !DILocation(line: 49, column: 21, scope: !33)
!42 = !DILocation(line: 50, column: 13, scope: !43)
!43 = distinct !DILexicalBlock(scope: !33, file: !10, line: 50, column: 13)
!44 = !DILocation(line: 50, column: 13, scope: !33)
!45 = !DILocation(line: 51, column: 23, scope: !43)
!46 = !DILocation(line: 51, column: 30, scope: !43)
!47 = !DILocation(line: 51, column: 13, scope: !43)
!48 = !DILocation(line: 52, column: 21, scope: !33)
!49 = !DILocalVariable(name: "value", scope: !33, file: !10, line: 52, type: !25)
!50 = !DILocation(line: 0, scope: !33)
!51 = !DILocation(line: 53, column: 14, scope: !52)
!52 = distinct !DILexicalBlock(scope: !33, file: !10, line: 53, column: 13)
!53 = !DILocation(line: 53, column: 13, scope: !33)
!54 = !DILocation(line: 54, column: 13, scope: !52)
!55 = !DILocation(line: 55, column: 15, scope: !33)
!56 = !DILocation(line: 55, column: 21, scope: !33)
!57 = distinct !{!57, !31, !58}
!58 = !DILocation(line: 57, column: 5, scope: !15)
!59 = !DILocation(line: 58, column: 14, scope: !60)
!60 = distinct !DILexicalBlock(scope: !15, file: !10, line: 58, column: 9)
!61 = !DILocation(line: 58, column: 9, scope: !15)
!62 = !DILocation(line: 59, column: 13, scope: !60)
!63 = !DILocation(line: 59, column: 20, scope: !60)
!64 = !DILocation(line: 59, column: 7, scope: !60)
!65 = !DILocation(line: 60, column: 17, scope: !15)
!66 = !DILocation(line: 60, column: 5, scope: !15)
!67 = !DILocation(line: 61, column: 22, scope: !68)
!68 = distinct !DILexicalBlock(scope: !15, file: !10, line: 60, column: 26)
!69 = !DILocation(line: 61, column: 15, scope: !68)
!70 = !DILocation(line: 61, column: 20, scope: !68)
!71 = !DILocation(line: 62, column: 14, scope: !72)
!72 = distinct !DILexicalBlock(scope: !68, file: !10, line: 62, column: 13)
!73 = !DILocation(line: 62, column: 13, scope: !68)
!74 = !DILocation(line: 63, column: 13, scope: !72)
!75 = !DILocation(line: 64, column: 15, scope: !68)
!76 = !DILocation(line: 64, column: 21, scope: !68)
!77 = !DILocation(line: 64, column: 26, scope: !68)
!78 = !DILocation(line: 65, column: 15, scope: !68)
!79 = !DILocation(line: 65, column: 21, scope: !68)
!80 = !DILocation(line: 65, column: 27, scope: !68)
!81 = !DILocation(line: 66, column: 15, scope: !68)
!82 = !DILocation(line: 66, column: 21, scope: !68)
!83 = !DILocation(line: 66, column: 27, scope: !68)
!84 = !DILocation(line: 67, column: 15, scope: !68)
!85 = !DILocation(line: 67, column: 21, scope: !68)
!86 = !DILocation(line: 67, column: 28, scope: !68)
!87 = !DILocation(line: 68, column: 22, scope: !68)
!88 = distinct !{!88, !66, !89}
!89 = !DILocation(line: 69, column: 5, scope: !15)
!90 = !DILocation(line: 70, column: 5, scope: !15)
!91 = distinct !DISubprogram(name: "free_tree", scope: !10, file: !10, line: 73, type: !92, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!92 = !DISubroutineType(types: !93)
!93 = !{null, !18}
!94 = !DILocalVariable(name: "node", arg: 1, scope: !91, file: !10, line: 73, type: !18)
!95 = !DILocation(line: 0, scope: !91)
!96 = !DILocalVariable(name: "last", scope: !91, file: !10, line: 74, type: !18)
!97 = !DILocation(line: 76, column: 19, scope: !98)
!98 = distinct !DILexicalBlock(scope: !99, file: !10, line: 76, column: 13)
!99 = distinct !DILexicalBlock(scope: !91, file: !10, line: 75, column: 15)
!100 = !DILocation(line: 76, column: 25, scope: !98)
!101 = !DILocation(line: 76, column: 13, scope: !99)
!102 = !DILocation(line: 77, column: 13, scope: !98)
!103 = !DILocation(line: 78, column: 22, scope: !99)
!104 = distinct !{!104, !105, !106}
!105 = !DILocation(line: 75, column: 5, scope: !91)
!106 = !DILocation(line: 79, column: 5, scope: !91)
!107 = !DILocation(line: 80, column: 17, scope: !91)
!108 = !DILocation(line: 80, column: 5, scope: !91)
!109 = !DILocation(line: 81, column: 19, scope: !110)
!110 = distinct !DILexicalBlock(scope: !111, file: !10, line: 81, column: 13)
!111 = distinct !DILexicalBlock(scope: !91, file: !10, line: 80, column: 26)
!112 = !DILocation(line: 81, column: 13, scope: !110)
!113 = !DILocation(line: 81, column: 13, scope: !111)
!114 = !DILocation(line: 82, column: 24, scope: !110)
!115 = !DILocation(line: 82, column: 18, scope: !110)
!116 = !DILocation(line: 82, column: 13, scope: !110)
!117 = !DILocation(line: 83, column: 19, scope: !118)
!118 = distinct !DILexicalBlock(scope: !111, file: !10, line: 83, column: 13)
!119 = !DILocation(line: 83, column: 13, scope: !118)
!120 = !DILocation(line: 83, column: 13, scope: !111)
!121 = !DILocation(line: 84, column: 24, scope: !118)
!122 = !DILocation(line: 84, column: 18, scope: !118)
!123 = !DILocation(line: 84, column: 13, scope: !118)
!124 = !DILocation(line: 86, column: 22, scope: !111)
!125 = distinct !{!125, !108, !126}
!126 = !DILocation(line: 87, column: 5, scope: !91)
!127 = !DILocation(line: 88, column: 10, scope: !91)
!128 = !DILocation(line: 88, column: 5, scope: !91)
!129 = !DILocation(line: 89, column: 1, scope: !91)
!130 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 91, type: !131, scopeLine: 92, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!131 = !DISubroutineType(types: !132)
!132 = !{!25}
!133 = !DILocation(line: 93, column: 25, scope: !130)
!134 = !DILocalVariable(name: "data", scope: !130, file: !10, line: 93, type: !18)
!135 = !DILocation(line: 0, scope: !130)
!136 = !DILocation(line: 95, column: 10, scope: !137)
!137 = distinct !DILexicalBlock(scope: !130, file: !10, line: 95, column: 9)
!138 = !DILocation(line: 95, column: 9, scope: !130)
!139 = !DILocation(line: 96, column: 9, scope: !137)
!140 = !DILocation(line: 98, column: 5, scope: !130)
!141 = !DILocation(line: 100, column: 5, scope: !130)
!142 = !DILocation(line: 102, column: 5, scope: !130)
!143 = !DILocation(line: 103, column: 1, scope: !130)
!144 = distinct !DISubprogram(name: "inspect", scope: !10, file: !10, line: 28, type: !92, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!145 = !DILocalVariable(name: "node", arg: 1, scope: !144, file: !10, line: 28, type: !18)
!146 = !DILocation(line: 0, scope: !144)
!147 = !DILocation(line: 30, column: 5, scope: !144)
!148 = !DILocation(line: 30, column: 5, scope: !149)
!149 = distinct !DILexicalBlock(scope: !150, file: !10, line: 30, column: 5)
!150 = distinct !DILexicalBlock(scope: !144, file: !10, line: 30, column: 5)
!151 = !DILocation(line: 30, column: 5, scope: !150)
!152 = !DILocation(line: 31, column: 17, scope: !144)
!153 = !DILocation(line: 31, column: 5, scope: !144)
!154 = !DILocation(line: 32, column: 19, scope: !155)
!155 = distinct !DILexicalBlock(scope: !156, file: !10, line: 32, column: 13)
!156 = distinct !DILexicalBlock(scope: !144, file: !10, line: 31, column: 26)
!157 = !DILocation(line: 32, column: 13, scope: !155)
!158 = !DILocation(line: 32, column: 13, scope: !156)
!159 = !DILocation(line: 33, column: 13, scope: !155)
!160 = !DILocation(line: 33, column: 13, scope: !161)
!161 = distinct !DILexicalBlock(scope: !162, file: !10, line: 33, column: 13)
!162 = distinct !DILexicalBlock(scope: !155, file: !10, line: 33, column: 13)
!163 = !DILocation(line: 33, column: 13, scope: !162)
!164 = !DILocation(line: 34, column: 9, scope: !156)
!165 = !DILocation(line: 34, column: 9, scope: !166)
!166 = distinct !DILexicalBlock(scope: !167, file: !10, line: 34, column: 9)
!167 = distinct !DILexicalBlock(scope: !156, file: !10, line: 34, column: 9)
!168 = !DILocation(line: 34, column: 9, scope: !167)
!169 = !DILocation(line: 35, column: 22, scope: !156)
!170 = distinct !{!170, !153, !171}
!171 = !DILocation(line: 36, column: 5, scope: !144)
!172 = !DILocation(line: 37, column: 1, scope: !144)
!173 = distinct !DISubprogram(name: "fail", scope: !10, file: !10, line: 12, type: !11, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!174 = !DILocation(line: 12, column: 24, scope: !173)
!175 = !DILabel(scope: !173, name: "ERROR", file: !10, line: 13)
!176 = !DILocation(line: 13, column: 1, scope: !173)
!177 = !DILocation(line: 13, column: 9, scope: !178)
!178 = distinct !DILexicalBlock(scope: !173, file: !10, line: 13, column: 8)
!179 = !DILocation(line: 13, column: 23, scope: !178)
