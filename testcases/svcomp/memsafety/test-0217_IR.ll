; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-3zexmvl5.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { [2 x i8*], [257 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [33 x i8] c"../svcomp/memsafety//test-0217.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global [2 x i8*] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !35 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !38, !verifier.code !41
  unreachable, !dbg !38, !verifier.code !41
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal i32 @is_empty([2 x i8*]* %0) #0 !dbg !42 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !47, metadata !DIExpression()), !dbg !48, !verifier.code !41
  %2 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !49, !verifier.code !41
  %3 = load i8*, i8** %2, align 8, !dbg !49, !verifier.code !41
  %4 = icmp ne i8* %3, null, !dbg !50, !verifier.code !41
  %5 = xor i1 %4, true, !dbg !50, !verifier.code !41
  %6 = zext i1 %5 to i32, !dbg !50, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %6, metadata !51, metadata !DIExpression()), !dbg !48, !verifier.code !41
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !52, !verifier.code !41
  %8 = load i8*, i8** %7, align 8, !dbg !52, !verifier.code !41
  %9 = icmp ne i8* %8, null, !dbg !53, !verifier.code !41
  %10 = xor i1 %9, true, !dbg !53, !verifier.code !41
  %11 = zext i1 %10 to i32, !dbg !53, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %11, metadata !54, metadata !DIExpression()), !dbg !48, !verifier.code !41
  %12 = icmp ne i32 %6, %11, !dbg !55, !verifier.code !41
  br i1 %12, label %13, label %15, !dbg !57, !verifier.code !41

13:                                               ; preds = %1
  %14 = bitcast [2 x i8*]* %0 to i8*, !dbg !58, !verifier.code !41
  call void @free(i8* %14) #7, !dbg !59, !verifier.code !41
  br label %15, !dbg !59, !verifier.code !41

15:                                               ; preds = %13, %1
  ret i32 %6, !dbg !60, !verifier.code !41
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal [2 x i8*]* @create_item(i32 %0, [2 x i8*]** %1) #0 !dbg !61 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !65, metadata !DIExpression()), !dbg !66, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]** %1, metadata !67, metadata !DIExpression()), !dbg !66, !verifier.code !41
  %3 = call noalias i8* @malloc(i64 280) #7, !dbg !68, !verifier.code !41
  %4 = bitcast i8* %3 to %struct.anon*, !dbg !68, !verifier.code !41
  call void @llvm.dbg.value(metadata %struct.anon* %4, metadata !69, metadata !DIExpression()), !dbg !66, !verifier.code !41
  %5 = icmp ne %struct.anon* %4, null, !dbg !80, !verifier.code !41
  br i1 %5, label %7, label %6, !dbg !82, !verifier.code !41

6:                                                ; preds = %2
  call void @abort() #6, !dbg !83, !verifier.code !41
  unreachable, !dbg !83, !verifier.code !41

7:                                                ; preds = %2
  br label %NodeBlock, !verifier.code !41

NodeBlock:                                        ; preds = %7
  %Pivot = icmp slt i32 %0, 1, !verifier.code !41
  br i1 %Pivot, label %LeafBlock, label %LeafBlock1, !verifier.code !41

LeafBlock1:                                       ; preds = %NodeBlock
  %SwitchLeaf2 = icmp eq i32 %0, 1, !verifier.code !41
  br i1 %SwitchLeaf2, label %9, label %NewDefault, !verifier.code !41

LeafBlock:                                        ; preds = %NodeBlock
  %SwitchLeaf = icmp eq i32 %0, 0, !verifier.code !41
  br i1 %SwitchLeaf, label %8, label %NewDefault, !verifier.code !41

8:                                                ; preds = %LeafBlock
  call void @llvm.dbg.value(metadata i32 1, metadata !84, metadata !DIExpression()), !dbg !66, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 0, metadata !86, metadata !DIExpression()), !dbg !66, !verifier.code !41
  br label %10, !dbg !87, !verifier.code !41

9:                                                ; preds = %LeafBlock1
  call void @llvm.dbg.value(metadata i32 0, metadata !84, metadata !DIExpression()), !dbg !66, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 1, metadata !86, metadata !DIExpression()), !dbg !66, !verifier.code !41
  br label %10, !dbg !89, !verifier.code !41

NewDefault:                                       ; preds = %LeafBlock1, %LeafBlock
  br label %10, !verifier.code !41

10:                                               ; preds = %NewDefault, %9, %8
  %.04 = phi i32 [ 0, %8 ], [ undef, %NewDefault ], [ 1, %9 ], !verifier.code !41
  %.0 = phi i32 [ 1, %8 ], [ undef, %NewDefault ], [ 0, %9 ], !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %.0, metadata !84, metadata !DIExpression()), !dbg !66, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %.04, metadata !86, metadata !DIExpression()), !dbg !66, !verifier.code !41
  br label %11, !dbg !90, !verifier.code !41

11:                                               ; preds = %25, %10
  %.03 = phi [2 x i8*]** [ %1, %10 ], [ %29, %25 ], !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]** %.03, metadata !67, metadata !DIExpression()), !dbg !66, !verifier.code !41
  %12 = load [2 x i8*]*, [2 x i8*]** %.03, align 8, !dbg !91, !verifier.code !41
  %13 = icmp ne [2 x i8*]* %12, null, !dbg !92, !verifier.code !41
  br i1 %13, label %14, label %23, !dbg !93, !verifier.code !41

14:                                               ; preds = %11
  %15 = load [2 x i8*]*, [2 x i8*]** %.03, align 8, !dbg !94, !verifier.code !41
  %16 = zext i32 %.0 to i64, !dbg !95, !verifier.code !41
  %17 = getelementptr inbounds [2 x i8*], [2 x i8*]* %15, i64 0, i64 %16, !dbg !95, !verifier.code !41
  %18 = load i8*, i8** %17, align 8, !dbg !95, !verifier.code !41
  %19 = icmp ne i8* %18, null, !dbg !95, !verifier.code !41
  br i1 %19, label %20, label %23, !dbg !96, !verifier.code !41

20:                                               ; preds = %14
  %21 = call i32 @__VERIFIER_nondet_int(), !dbg !97, !verifier.code !98
  %22 = icmp ne i32 %21, 0, !dbg !96, !verifier.code !41
  br label %23, !verifier.code !41

23:                                               ; preds = %20, %14, %11
  %24 = phi i1 [ false, %14 ], [ false, %11 ], [ %22, %20 ], !dbg !66, !verifier.code !41
  br i1 %24, label %25, label %30, !dbg !90, !verifier.code !41

25:                                               ; preds = %23
  %26 = load [2 x i8*]*, [2 x i8*]** %.03, align 8, !dbg !99, !verifier.code !41
  %27 = zext i32 %.0 to i64, !dbg !100, !verifier.code !41
  %28 = getelementptr inbounds [2 x i8*], [2 x i8*]* %26, i64 0, i64 %27, !dbg !100, !verifier.code !41
  %29 = bitcast i8** %28 to [2 x i8*]**, !dbg !101, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]** %29, metadata !67, metadata !DIExpression()), !dbg !66, !verifier.code !41
  br label %11, !dbg !90, !llvm.loop !102, !verifier.code !41

30:                                               ; preds = %23
  %.03.lcssa = phi [2 x i8*]** [ %.03, %23 ], !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]** %.03.lcssa, metadata !67, metadata !DIExpression()), !dbg !66, !verifier.code !41
  %31 = load [2 x i8*]*, [2 x i8*]** %.03.lcssa, align 8, !dbg !104, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %31, metadata !105, metadata !DIExpression()), !dbg !66, !verifier.code !41
  %32 = bitcast [2 x i8*]* %31 to i8*, !dbg !106, !verifier.code !41
  %33 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !107, !verifier.code !41
  %34 = zext i32 %.0 to i64, !dbg !108, !verifier.code !41
  %35 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, i64 %34
  store i8* %32, i8** %35, align 8, !dbg !109, !verifier.code !41
  %36 = icmp ne [2 x i8*]* %31, null, !dbg !110, !verifier.code !41
  br i1 %36, label %37, label %41, !dbg !110, !verifier.code !41

37:                                               ; preds = %30
  %38 = zext i32 %.04 to i64, !dbg !111, !verifier.code !41
  %39 = getelementptr inbounds [2 x i8*], [2 x i8*]* %31, i64 0, i64 %38, !dbg !111, !verifier.code !41
  %40 = load i8*, i8** %39, align 8, !dbg !111, !verifier.code !41
  br label %42, !dbg !110, !verifier.code !41

41:                                               ; preds = %30
  br label %42, !dbg !110, !verifier.code !41

42:                                               ; preds = %41, %37
  %43 = phi i8* [ %40, %37 ], [ null, %41 ], !dbg !110, !verifier.code !41
  %44 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !112, !verifier.code !41
  %45 = zext i32 %.04 to i64, !dbg !113, !verifier.code !41
  %46 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, i64 %45
  store i8* %43, i8** %46, align 8, !dbg !114, !verifier.code !41
  %47 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 1, !dbg !115, !verifier.code !41
  %48 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 1, i64 0
  store i8 0, i8* %48, align 8, !dbg !116, !verifier.code !41
  %49 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !117, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %49, metadata !118, metadata !DIExpression()), !dbg !66, !verifier.code !41
  %50 = icmp ne [2 x i8*]* %31, null, !dbg !119, !verifier.code !41
  br i1 %50, label %51, label %55, !dbg !121, !verifier.code !41

51:                                               ; preds = %42
  %52 = bitcast [2 x i8*]* %49 to i8*, !dbg !122, !verifier.code !41
  %53 = zext i32 %.04 to i64, !dbg !123, !verifier.code !41
  %54 = getelementptr inbounds [2 x i8*], [2 x i8*]* %31, i64 0, i64 %53, !dbg !123, !verifier.code !41
  store i8* %52, i8** %54, align 8, !dbg !124, !verifier.code !41
  br label %55, !dbg !123, !verifier.code !41

55:                                               ; preds = %51, %42
  store [2 x i8*]* %49, [2 x i8*]** %.03.lcssa, align 8, !dbg !125, !verifier.code !41
  ret [2 x i8*]* %49, !dbg !126, !verifier.code !41
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @append_one([2 x i8*]* %0, i32 %1) #0 !dbg !127 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !130, metadata !DIExpression()), !dbg !131, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %1, metadata !132, metadata !DIExpression()), !dbg !131, !verifier.code !41
  %3 = zext i32 %1 to i64, !dbg !133, !verifier.code !41
  %4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %3, !dbg !133, !verifier.code !41
  %5 = bitcast i8** %4 to [2 x i8*]**, !dbg !134, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]** %5, metadata !135, metadata !DIExpression()), !dbg !131, !verifier.code !41
  %6 = call [2 x i8*]* @create_item(i32 %1, [2 x i8*]** %5), !dbg !136, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %6, metadata !137, metadata !DIExpression()), !dbg !131, !verifier.code !41
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %6, i64 0, i64 0, !dbg !138, !verifier.code !41
  %8 = load i8*, i8** %7, align 8, !dbg !138, !verifier.code !41
  %9 = icmp eq i8* null, %8, !dbg !140, !verifier.code !41
  br i1 %9, label %10, label %13, !dbg !141, !verifier.code !41

10:                                               ; preds = %2
  %11 = bitcast [2 x i8*]* %6 to i8*, !dbg !142, !verifier.code !41
  %12 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !143, !verifier.code !41
  store i8* %11, i8** %12, align 8, !dbg !144, !verifier.code !41
  br label %13, !dbg !143, !verifier.code !41

13:                                               ; preds = %10, %2
  %14 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !145, !verifier.code !41
  %15 = load i8*, i8** %14, align 8, !dbg !145, !verifier.code !41
  %16 = icmp eq i8* null, %15, !dbg !147, !verifier.code !41
  br i1 %16, label %17, label %20, !dbg !148, !verifier.code !41

17:                                               ; preds = %13
  %18 = bitcast [2 x i8*]* %6 to i8*, !dbg !149, !verifier.code !41
  %19 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !150, !verifier.code !41
  store i8* %18, i8** %19, align 8, !dbg !151, !verifier.code !41
  br label %20, !dbg !150, !verifier.code !41

20:                                               ; preds = %17, %13
  ret void, !dbg !152, !verifier.code !41
}

; Function Attrs: noinline nounwind uwtable
define internal void @remove_one([2 x i8*]* %0, i32 %1) #0 !dbg !153 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !154, metadata !DIExpression()), !dbg !155, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %1, metadata !156, metadata !DIExpression()), !dbg !155, !verifier.code !41
  %3 = call i32 @is_empty([2 x i8*]* %0), !dbg !157, !verifier.code !41
  %4 = icmp ne i32 %3, 0, !dbg !157, !verifier.code !41
  br i1 %4, label %5, label %6, !dbg !159, !verifier.code !41

5:                                                ; preds = %2
  br label %38, !dbg !160, !verifier.code !41

6:                                                ; preds = %2
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !161, !verifier.code !41
  %8 = load i8*, i8** %7, align 8, !dbg !161, !verifier.code !41
  %9 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !163, !verifier.code !41
  %10 = load i8*, i8** %9, align 8, !dbg !163, !verifier.code !41
  %11 = icmp eq i8* %8, %10, !dbg !164, !verifier.code !41
  br i1 %11, label %12, label %17, !dbg !165, !verifier.code !41

12:                                               ; preds = %6
  %13 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !166, !verifier.code !41
  %14 = load i8*, i8** %13, align 8, !dbg !166, !verifier.code !41
  call void @free(i8* %14) #7, !dbg !168, !verifier.code !41
  %15 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !169, !verifier.code !41
  %16 = bitcast i8** %15 to i8*, !dbg !169, !verifier.code !41
  call void @llvm.memset.p0i8.i64(i8* align 8 %16, i8 0, i64 16, i1 false), !dbg !169, !verifier.code !41
  br label %38, !dbg !170, !verifier.code !41

17:                                               ; preds = %6
  %18 = icmp eq i32 0, %1, !dbg !171, !verifier.code !41
  %19 = zext i1 %18 to i64, !dbg !172, !verifier.code !41
  %20 = select i1 %18, i32 1, i32 0, !dbg !172, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %20, metadata !173, metadata !DIExpression()), !dbg !155, !verifier.code !41
  %21 = icmp eq i32 1, %1, !dbg !175, !verifier.code !41
  %22 = zext i1 %21 to i64, !dbg !176, !verifier.code !41
  %23 = select i1 %21, i32 1, i32 0, !dbg !176, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %23, metadata !177, metadata !DIExpression()), !dbg !155, !verifier.code !41
  %24 = zext i32 %1 to i64, !dbg !178, !verifier.code !41
  %25 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %24, !dbg !178, !verifier.code !41
  %26 = load i8*, i8** %25, align 8, !dbg !178, !verifier.code !41
  %27 = bitcast i8* %26 to [2 x i8*]*, !dbg !178, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %27, metadata !179, metadata !DIExpression()), !dbg !155, !verifier.code !41
  %28 = zext i32 %20 to i64, !dbg !180, !verifier.code !41
  %29 = getelementptr inbounds [2 x i8*], [2 x i8*]* %27, i64 0, i64 %28, !dbg !180, !verifier.code !41
  %30 = load i8*, i8** %29, align 8, !dbg !180, !verifier.code !41
  %31 = bitcast i8* %30 to [2 x i8*]*, !dbg !180, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %31, metadata !181, metadata !DIExpression()), !dbg !155, !verifier.code !41
  %32 = zext i32 %23 to i64, !dbg !182, !verifier.code !41
  %33 = getelementptr inbounds [2 x i8*], [2 x i8*]* %31, i64 0, i64 %32, !dbg !182, !verifier.code !41
  store i8* null, i8** %33, align 8, !dbg !183, !verifier.code !41
  %34 = bitcast [2 x i8*]* %31 to i8*, !dbg !184, !verifier.code !41
  %35 = zext i32 %1 to i64, !dbg !185, !verifier.code !41
  %36 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %35, !dbg !185, !verifier.code !41
  store i8* %34, i8** %36, align 8, !dbg !186, !verifier.code !41
  %37 = bitcast [2 x i8*]* %27 to i8*, !dbg !187, !verifier.code !41
  call void @free(i8* %37) #7, !dbg !188, !verifier.code !41
  br label %38, !dbg !189, !verifier.code !41

38:                                               ; preds = %17, %12, %5
  ret void, !dbg !189, !verifier.code !41
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: noinline nounwind uwtable
define internal i32 @rand_end_point() #0 !dbg !190 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !193, !verifier.code !98
  %2 = icmp ne i32 %1, 0, !dbg !193, !verifier.code !41
  br i1 %2, label %3, label %4, !dbg !195, !verifier.code !41

3:                                                ; preds = %0
  br label %5, !dbg !196, !verifier.code !41

4:                                                ; preds = %0
  br label %5, !dbg !197, !verifier.code !41

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ 0, %3 ], [ 1, %4 ], !dbg !198, !verifier.code !41
  ret i32 %.0, !dbg !199, !verifier.code !41
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !200, !verifier.code !98
  %2 = icmp ne i32 %1, 0, !dbg !201, !verifier.code !41
  br i1 %2, label %.lr.ph11, label %20, !dbg !201, !verifier.code !41

.lr.ph11:                                         ; preds = %0
  br label %3, !dbg !201, !verifier.code !41

3:                                                ; preds = %.lr.ph11, %17
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !202, !verifier.code !98
  %5 = icmp ne i32 %4, 0, !dbg !204, !verifier.code !41
  br i1 %5, label %.lr.ph5, label %10, !dbg !204, !verifier.code !41

.lr.ph5:                                          ; preds = %3
  br label %6, !dbg !204, !verifier.code !41

6:                                                ; preds = %.lr.ph5, %6
  %7 = call i32 @rand_end_point(), !dbg !205, !verifier.code !41
  call void @append_one([2 x i8*]* @main.list, i32 %7), !dbg !206, !verifier.code !41
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !202, !verifier.code !98
  %9 = icmp ne i32 %8, 0, !dbg !204, !verifier.code !41
  br i1 %9, label %6, label %._crit_edge6, !dbg !204, !llvm.loop !207, !verifier.code !41

._crit_edge6:                                     ; preds = %6
  br label %10, !dbg !204, !verifier.code !41

10:                                               ; preds = %._crit_edge6, %3
  %11 = call i32 @__VERIFIER_nondet_int(), !dbg !209, !verifier.code !98
  %12 = icmp ne i32 %11, 0, !dbg !210, !verifier.code !41
  br i1 %12, label %.lr.ph8, label %17, !dbg !210, !verifier.code !41

.lr.ph8:                                          ; preds = %10
  br label %13, !dbg !210, !verifier.code !41

13:                                               ; preds = %.lr.ph8, %13
  %14 = call i32 @rand_end_point(), !dbg !211, !verifier.code !41
  call void @remove_one([2 x i8*]* @main.list, i32 %14), !dbg !212, !verifier.code !41
  %15 = call i32 @__VERIFIER_nondet_int(), !dbg !209, !verifier.code !98
  %16 = icmp ne i32 %15, 0, !dbg !210, !verifier.code !41
  br i1 %16, label %13, label %._crit_edge9, !dbg !210, !llvm.loop !213, !verifier.code !41

._crit_edge9:                                     ; preds = %13
  br label %17, !dbg !210, !verifier.code !41

17:                                               ; preds = %._crit_edge9, %10
  %18 = call i32 @__VERIFIER_nondet_int(), !dbg !200, !verifier.code !98
  %19 = icmp ne i32 %18, 0, !dbg !201, !verifier.code !41
  br i1 %19, label %3, label %._crit_edge12, !dbg !201, !llvm.loop !215, !verifier.code !41

._crit_edge12:                                    ; preds = %17
  br label %20, !dbg !201, !verifier.code !41

20:                                               ; preds = %._crit_edge12, %0
  %21 = call i32 @__VERIFIER_nondet_int(), !dbg !217, !verifier.code !98
  %22 = icmp ne i32 %21, 0, !dbg !217, !verifier.code !41
  br i1 %22, label %23, label %24, !dbg !219, !verifier.code !41

23:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i32 0, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 1, metadata !222, metadata !DIExpression()), !dbg !221, !verifier.code !41
  br label %25, !dbg !223, !verifier.code !41

24:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i32 1, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 0, metadata !222, metadata !DIExpression()), !dbg !221, !verifier.code !41
  br label %25, !verifier.code !41

25:                                               ; preds = %24, %23
  %.02 = phi i32 [ 1, %23 ], [ 0, %24 ], !dbg !225, !verifier.code !41
  %.01 = phi i32 [ 0, %23 ], [ 1, %24 ], !dbg !225, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %.01, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !41
  call void @llvm.dbg.value(metadata i32 %.02, metadata !222, metadata !DIExpression()), !dbg !221, !verifier.code !41
  %26 = zext i32 %.01 to i64, !dbg !226, !verifier.code !41
  %27 = getelementptr inbounds [2 x i8*], [2 x i8*]* @main.list, i64 0, i64 %26, !dbg !226, !verifier.code !41
  %28 = load i8*, i8** %27, align 8, !dbg !226, !verifier.code !41
  %29 = bitcast i8* %28 to [2 x i8*]*, !dbg !226, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %29, metadata !227, metadata !DIExpression()), !dbg !221, !verifier.code !41
  %30 = icmp ne [2 x i8*]* %29, null, !dbg !228, !verifier.code !41
  br i1 %30, label %.lr.ph, label %38, !dbg !228, !verifier.code !41

.lr.ph:                                           ; preds = %25
  br label %31, !dbg !228, !verifier.code !41

31:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi [2 x i8*]* [ %29, %.lr.ph ], [ %35, %forwarder ], !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %.03, metadata !227, metadata !DIExpression()), !dbg !221, !verifier.code !41
  %32 = zext i32 %.02 to i64, !dbg !229, !verifier.code !41
  %33 = getelementptr inbounds [2 x i8*], [2 x i8*]* %.03, i64 0, i64 %32, !dbg !229, !verifier.code !41
  %34 = load i8*, i8** %33, align 8, !dbg !229, !verifier.code !41
  %35 = bitcast i8* %34 to [2 x i8*]*, !dbg !229, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %35, metadata !231, metadata !DIExpression()), !dbg !232, !verifier.code !41
  %36 = bitcast [2 x i8*]* %.03 to i8*, !dbg !233, !verifier.code !41
  call void @free(i8* %36) #7, !dbg !234, !verifier.code !41
  call void @llvm.dbg.value(metadata [2 x i8*]* %35, metadata !227, metadata !DIExpression()), !dbg !221, !verifier.code !41
  %37 = icmp ne [2 x i8*]* %35, null, !dbg !228, !verifier.code !41
  br i1 %37, label %forwarder, label %._crit_edge, !dbg !228, !llvm.loop !235, !verifier.code !41

._crit_edge:                                      ; preds = %31
  br label %38, !dbg !228, !verifier.code !41

38:                                               ; preds = %._crit_edge, %25
  ret i32 0, !dbg !237, !verifier.code !41

forwarder:                                        ; preds = %31
  br label %31, !verifier.code !41
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  store i8* null, i8** getelementptr inbounds ([2 x i8*], [2 x i8*]* @main.list, i32 0, i64 0)
  store i8* null, i8** getelementptr inbounds ([2 x i8*], [2 x i8*]* @main.list, i32 0, i64 1)
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind willreturn }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!31}
!llvm.module.flags = !{!32, !33, !34}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 124, type: !30, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 122, type: !4, scopeLine: 123, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!3 = !DIFile(filename: "../svcomp/memsafety//test-0217.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !8, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, retainedTypes: !19, globals: !28, splitDebugInlining: false, nameTableKind: None)
!8 = !DIFile(filename: "../svcomp/memsafety/test-0217.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !{!10, !15}
!10 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 12, baseType: !11, size: 32, elements: !12)
!11 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!12 = !{!13, !14}
!13 = !DIEnumerator(name: "LIST_BEG", value: 0, isUnsigned: true)
!14 = !DIEnumerator(name: "LIST_END", value: 1, isUnsigned: true)
!15 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 19, baseType: !11, size: 32, elements: !16)
!16 = !{!17, !18}
!17 = !DIEnumerator(name: "ITEM_PREV", value: 0, isUnsigned: true)
!18 = !DIEnumerator(name: "ITEM_NEXT", value: 1, isUnsigned: true)
!19 = !{!20, !25}
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "item_p", file: !3, line: 18, baseType: !22)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "item_t", file: !3, line: 17, baseType: !24)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 128, elements: !26)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!26 = !{!27}
!27 = !DISubrange(count: 2)
!28 = !{!0}
!29 = !{}
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "list_t", file: !3, line: 10, baseType: !24)
!31 = !{!"clang version 10.0.0-4ubuntu1 "}
!32 = !{i32 7, !"Dwarf Version", i32 4}
!33 = !{i32 2, !"Debug Info Version", i32 3}
!34 = !{i32 1, !"wchar_size", i32 4}
!35 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !36, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!36 = !DISubroutineType(types: !37)
!37 = !{null}
!38 = !DILocation(line: 3, column: 22, scope: !39)
!39 = distinct !DILexicalBlock(scope: !40, file: !3, line: 3, column: 22)
!40 = distinct !DILexicalBlock(scope: !35, file: !3, line: 3, column: 22)
!41 = !{i1 false}
!42 = distinct !DISubprogram(name: "is_empty", scope: !3, file: !3, line: 29, type: !43, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!43 = !DISubroutineType(types: !44)
!44 = !{!6, !45}
!45 = !DIDerivedType(tag: DW_TAG_typedef, name: "list_p", file: !3, line: 11, baseType: !46)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!47 = !DILocalVariable(name: "list", arg: 1, scope: !42, file: !3, line: 29, type: !45)
!48 = !DILocation(line: 0, scope: !42)
!49 = !DILocation(line: 31, column: 19, scope: !42)
!50 = !DILocation(line: 31, column: 18, scope: !42)
!51 = !DILocalVariable(name: "no_beg", scope: !42, file: !3, line: 31, type: !6)
!52 = !DILocation(line: 32, column: 19, scope: !42)
!53 = !DILocation(line: 32, column: 18, scope: !42)
!54 = !DILocalVariable(name: "no_end", scope: !42, file: !3, line: 32, type: !6)
!55 = !DILocation(line: 34, column: 16, scope: !56)
!56 = distinct !DILexicalBlock(scope: !42, file: !3, line: 34, column: 9)
!57 = !DILocation(line: 34, column: 9, scope: !42)
!58 = !DILocation(line: 36, column: 14, scope: !56)
!59 = !DILocation(line: 36, column: 9, scope: !56)
!60 = !DILocation(line: 38, column: 5, scope: !42)
!61 = distinct !DISubprogram(name: "create_item", scope: !3, file: !3, line: 41, type: !62, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!62 = !DISubroutineType(types: !63)
!63 = !{!21, !64, !20}
!64 = !DIDerivedType(tag: DW_TAG_typedef, name: "end_point_t", file: !3, line: 15, baseType: !10)
!65 = !DILocalVariable(name: "at", arg: 1, scope: !61, file: !3, line: 41, type: !64)
!66 = !DILocation(line: 0, scope: !61)
!67 = !DILocalVariable(name: "cursor", arg: 2, scope: !61, file: !3, line: 41, type: !20)
!68 = !DILocation(line: 43, column: 24, scope: !61)
!69 = !DILocalVariable(name: "item", scope: !61, file: !3, line: 43, type: !70)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "user_item_p", file: !3, line: 27, baseType: !71)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 24, size: 2240, elements: !73)
!73 = !{!74, !75}
!74 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !72, file: !3, line: 25, baseType: !23, size: 128)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "text", scope: !72, file: !3, line: 26, baseType: !76, size: 2056, offset: 128)
!76 = !DICompositeType(tag: DW_TAG_array_type, baseType: !77, size: 2056, elements: !78)
!77 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!78 = !{!79}
!79 = !DISubrange(count: 257)
!80 = !DILocation(line: 44, column: 10, scope: !81)
!81 = distinct !DILexicalBlock(scope: !61, file: !3, line: 44, column: 9)
!82 = !DILocation(line: 44, column: 9, scope: !61)
!83 = !DILocation(line: 45, column: 9, scope: !81)
!84 = !DILocalVariable(name: "link_field", scope: !61, file: !3, line: 47, type: !85)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "direction_t", file: !3, line: 22, baseType: !15)
!86 = !DILocalVariable(name: "term_field", scope: !61, file: !3, line: 47, type: !85)
!87 = !DILocation(line: 53, column: 13, scope: !88)
!88 = distinct !DILexicalBlock(scope: !61, file: !3, line: 49, column: 17)
!89 = !DILocation(line: 58, column: 13, scope: !88)
!90 = !DILocation(line: 62, column: 5, scope: !61)
!91 = !DILocation(line: 62, column: 13, scope: !61)
!92 = !DILocation(line: 62, column: 12, scope: !61)
!93 = !DILocation(line: 62, column: 22, scope: !61)
!94 = !DILocation(line: 62, column: 27, scope: !61)
!95 = !DILocation(line: 62, column: 25, scope: !61)
!96 = !DILocation(line: 62, column: 48, scope: !61)
!97 = !DILocation(line: 62, column: 51, scope: !61)
!98 = !{i1 true}
!99 = !DILocation(line: 63, column: 32, scope: !61)
!100 = !DILocation(line: 63, column: 30, scope: !61)
!101 = !DILocation(line: 63, column: 18, scope: !61)
!102 = distinct !{!102, !90, !103}
!103 = !DILocation(line: 63, column: 51, scope: !61)
!104 = !DILocation(line: 65, column: 19, scope: !61)
!105 = !DILocalVariable(name: "link", scope: !61, file: !3, line: 65, type: !21)
!106 = !DILocation(line: 66, column: 30, scope: !61)
!107 = !DILocation(line: 66, column: 11, scope: !61)
!108 = !DILocation(line: 66, column: 5, scope: !61)
!109 = !DILocation(line: 66, column: 28, scope: !61)
!110 = !DILocation(line: 67, column: 30, scope: !61)
!111 = !DILocation(line: 67, column: 37, scope: !61)
!112 = !DILocation(line: 67, column: 11, scope: !61)
!113 = !DILocation(line: 67, column: 5, scope: !61)
!114 = !DILocation(line: 67, column: 28, scope: !61)
!115 = !DILocation(line: 68, column: 11, scope: !61)
!116 = !DILocation(line: 68, column: 19, scope: !61)
!117 = !DILocation(line: 70, column: 26, scope: !61)
!118 = !DILocalVariable(name: "head", scope: !61, file: !3, line: 70, type: !21)
!119 = !DILocation(line: 72, column: 9, scope: !120)
!120 = distinct !DILexicalBlock(scope: !61, file: !3, line: 72, column: 9)
!121 = !DILocation(line: 72, column: 9, scope: !61)
!122 = !DILocation(line: 73, column: 31, scope: !120)
!123 = !DILocation(line: 73, column: 9, scope: !120)
!124 = !DILocation(line: 73, column: 29, scope: !120)
!125 = !DILocation(line: 75, column: 13, scope: !61)
!126 = !DILocation(line: 76, column: 5, scope: !61)
!127 = distinct !DISubprogram(name: "append_one", scope: !3, file: !3, line: 79, type: !128, scopeLine: 80, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!128 = !DISubroutineType(types: !129)
!129 = !{null, !45, !64}
!130 = !DILocalVariable(name: "list", arg: 1, scope: !127, file: !3, line: 79, type: !45)
!131 = !DILocation(line: 0, scope: !127)
!132 = !DILocalVariable(name: "to", arg: 2, scope: !127, file: !3, line: 79, type: !64)
!133 = !DILocation(line: 81, column: 34, scope: !127)
!134 = !DILocation(line: 81, column: 22, scope: !127)
!135 = !DILocalVariable(name: "cursor", scope: !127, file: !3, line: 81, type: !20)
!136 = !DILocation(line: 82, column: 19, scope: !127)
!137 = !DILocalVariable(name: "item", scope: !127, file: !3, line: 82, type: !21)
!138 = !DILocation(line: 84, column: 17, scope: !139)
!139 = distinct !DILexicalBlock(scope: !127, file: !3, line: 84, column: 9)
!140 = !DILocation(line: 84, column: 14, scope: !139)
!141 = !DILocation(line: 84, column: 9, scope: !127)
!142 = !DILocation(line: 85, column: 29, scope: !139)
!143 = !DILocation(line: 85, column: 9, scope: !139)
!144 = !DILocation(line: 85, column: 27, scope: !139)
!145 = !DILocation(line: 87, column: 17, scope: !146)
!146 = distinct !DILexicalBlock(scope: !127, file: !3, line: 87, column: 9)
!147 = !DILocation(line: 87, column: 14, scope: !146)
!148 = !DILocation(line: 87, column: 9, scope: !127)
!149 = !DILocation(line: 88, column: 29, scope: !146)
!150 = !DILocation(line: 88, column: 9, scope: !146)
!151 = !DILocation(line: 88, column: 27, scope: !146)
!152 = !DILocation(line: 89, column: 1, scope: !127)
!153 = distinct !DISubprogram(name: "remove_one", scope: !3, file: !3, line: 91, type: !128, scopeLine: 92, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!154 = !DILocalVariable(name: "list", arg: 1, scope: !153, file: !3, line: 91, type: !45)
!155 = !DILocation(line: 0, scope: !153)
!156 = !DILocalVariable(name: "from", arg: 2, scope: !153, file: !3, line: 91, type: !64)
!157 = !DILocation(line: 93, column: 9, scope: !158)
!158 = distinct !DILexicalBlock(scope: !153, file: !3, line: 93, column: 9)
!159 = !DILocation(line: 93, column: 9, scope: !153)
!160 = !DILocation(line: 95, column: 9, scope: !158)
!161 = !DILocation(line: 97, column: 9, scope: !162)
!162 = distinct !DILexicalBlock(scope: !153, file: !3, line: 97, column: 9)
!163 = !DILocation(line: 97, column: 30, scope: !162)
!164 = !DILocation(line: 97, column: 27, scope: !162)
!165 = !DILocation(line: 97, column: 9, scope: !153)
!166 = !DILocation(line: 98, column: 14, scope: !167)
!167 = distinct !DILexicalBlock(scope: !162, file: !3, line: 97, column: 49)
!168 = !DILocation(line: 98, column: 9, scope: !167)
!169 = !DILocation(line: 99, column: 9, scope: !167)
!170 = !DILocation(line: 100, column: 9, scope: !167)
!171 = !DILocation(line: 103, column: 46, scope: !153)
!172 = !DILocation(line: 103, column: 36, scope: !153)
!173 = !DILocalVariable(name: "next_field", scope: !153, file: !3, line: 103, type: !174)
!174 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !85)
!175 = !DILocation(line: 104, column: 46, scope: !153)
!176 = !DILocation(line: 104, column: 36, scope: !153)
!177 = !DILocalVariable(name: "term_field", scope: !153, file: !3, line: 104, type: !174)
!178 = !DILocation(line: 106, column: 19, scope: !153)
!179 = !DILocalVariable(name: "item", scope: !153, file: !3, line: 106, type: !21)
!180 = !DILocation(line: 107, column: 19, scope: !153)
!181 = !DILocalVariable(name: "next", scope: !153, file: !3, line: 107, type: !21)
!182 = !DILocation(line: 108, column: 5, scope: !153)
!183 = !DILocation(line: 108, column: 25, scope: !153)
!184 = !DILocation(line: 109, column: 21, scope: !153)
!185 = !DILocation(line: 109, column: 5, scope: !153)
!186 = !DILocation(line: 109, column: 19, scope: !153)
!187 = !DILocation(line: 111, column: 10, scope: !153)
!188 = !DILocation(line: 111, column: 5, scope: !153)
!189 = !DILocation(line: 112, column: 1, scope: !153)
!190 = distinct !DISubprogram(name: "rand_end_point", scope: !3, file: !3, line: 114, type: !191, scopeLine: 115, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !29)
!191 = !DISubroutineType(types: !192)
!192 = !{!64}
!193 = !DILocation(line: 116, column: 9, scope: !194)
!194 = distinct !DILexicalBlock(scope: !190, file: !3, line: 116, column: 9)
!195 = !DILocation(line: 116, column: 9, scope: !190)
!196 = !DILocation(line: 117, column: 9, scope: !194)
!197 = !DILocation(line: 119, column: 9, scope: !194)
!198 = !DILocation(line: 0, scope: !194)
!199 = !DILocation(line: 120, column: 1, scope: !190)
!200 = !DILocation(line: 126, column: 12, scope: !2)
!201 = !DILocation(line: 126, column: 5, scope: !2)
!202 = !DILocation(line: 127, column: 16, scope: !203)
!203 = distinct !DILexicalBlock(scope: !2, file: !3, line: 126, column: 37)
!204 = !DILocation(line: 127, column: 9, scope: !203)
!205 = !DILocation(line: 128, column: 31, scope: !203)
!206 = !DILocation(line: 128, column: 13, scope: !203)
!207 = distinct !{!207, !204, !208}
!208 = !DILocation(line: 128, column: 47, scope: !203)
!209 = !DILocation(line: 130, column: 16, scope: !203)
!210 = !DILocation(line: 130, column: 9, scope: !203)
!211 = !DILocation(line: 131, column: 31, scope: !203)
!212 = !DILocation(line: 131, column: 13, scope: !203)
!213 = distinct !{!213, !210, !214}
!214 = !DILocation(line: 131, column: 47, scope: !203)
!215 = distinct !{!215, !201, !216}
!216 = !DILocation(line: 132, column: 5, scope: !2)
!217 = !DILocation(line: 137, column: 9, scope: !218)
!218 = distinct !DILexicalBlock(scope: !2, file: !3, line: 137, column: 9)
!219 = !DILocation(line: 137, column: 9, scope: !2)
!220 = !DILocalVariable(name: "end_point", scope: !2, file: !3, line: 134, type: !64)
!221 = !DILocation(line: 0, scope: !2)
!222 = !DILocalVariable(name: "direction", scope: !2, file: !3, line: 135, type: !85)
!223 = !DILocation(line: 141, column: 5, scope: !224)
!224 = distinct !DILexicalBlock(scope: !218, file: !3, line: 137, column: 34)
!225 = !DILocation(line: 0, scope: !218)
!226 = !DILocation(line: 149, column: 21, scope: !2)
!227 = !DILocalVariable(name: "cursor", scope: !2, file: !3, line: 149, type: !21)
!228 = !DILocation(line: 150, column: 5, scope: !2)
!229 = !DILocation(line: 151, column: 23, scope: !230)
!230 = distinct !DILexicalBlock(scope: !2, file: !3, line: 150, column: 20)
!231 = !DILocalVariable(name: "next", scope: !230, file: !3, line: 151, type: !21)
!232 = !DILocation(line: 0, scope: !230)
!233 = !DILocation(line: 152, column: 14, scope: !230)
!234 = !DILocation(line: 152, column: 9, scope: !230)
!235 = distinct !{!235, !228, !236}
!236 = !DILocation(line: 154, column: 5, scope: !2)
!237 = !DILocation(line: 156, column: 5, scope: !2)
