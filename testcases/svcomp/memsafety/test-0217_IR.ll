; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-klgatgub.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { [2 x i8*], [257 x i8] }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"test-0217.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global [2 x i8*] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !34 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !37, !verifier.code !40
  unreachable, !dbg !37, !verifier.code !40
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal i32 @is_empty([2 x i8*]* %0) #0 !dbg !41 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !46, metadata !DIExpression()), !dbg !47, !verifier.code !40
  %2 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !48, !verifier.code !40
  %3 = load i8*, i8** %2, align 8, !dbg !48, !verifier.code !40
  %4 = icmp ne i8* %3, null, !dbg !49, !verifier.code !40
  %5 = xor i1 %4, true, !dbg !49, !verifier.code !40
  %6 = zext i1 %5 to i32, !dbg !49, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %6, metadata !50, metadata !DIExpression()), !dbg !47, !verifier.code !40
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !51, !verifier.code !40
  %8 = load i8*, i8** %7, align 8, !dbg !51, !verifier.code !40
  %9 = icmp ne i8* %8, null, !dbg !52, !verifier.code !40
  %10 = xor i1 %9, true, !dbg !52, !verifier.code !40
  %11 = zext i1 %10 to i32, !dbg !52, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %11, metadata !53, metadata !DIExpression()), !dbg !47, !verifier.code !40
  %12 = icmp ne i32 %6, %11, !dbg !54, !verifier.code !40
  br i1 %12, label %13, label %15, !dbg !56, !verifier.code !40

13:                                               ; preds = %1
  %14 = bitcast [2 x i8*]* %0 to i8*, !dbg !57, !verifier.code !40
  call void @free(i8* %14) #6, !dbg !58, !verifier.code !40
  br label %15, !dbg !58, !verifier.code !40

15:                                               ; preds = %13, %1
  ret i32 %6, !dbg !59, !verifier.code !40
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal [2 x i8*]* @create_item(i32 %0, [2 x i8*]** %1) #0 !dbg !60 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !64, metadata !DIExpression()), !dbg !65, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]** %1, metadata !66, metadata !DIExpression()), !dbg !65, !verifier.code !40
  %3 = call noalias i8* @malloc(i32 280) #6, !dbg !67, !verifier.code !40
  %4 = bitcast i8* %3 to %struct.anon*, !dbg !67, !verifier.code !40
  call void @llvm.dbg.value(metadata %struct.anon* %4, metadata !68, metadata !DIExpression()), !dbg !65, !verifier.code !40
  %5 = icmp ne %struct.anon* %4, null, !dbg !79, !verifier.code !40
  br i1 %5, label %7, label %6, !dbg !81, !verifier.code !40

6:                                                ; preds = %2
  call void @abort() #5, !dbg !82, !verifier.code !40
  unreachable, !dbg !82, !verifier.code !40

7:                                                ; preds = %2
  br label %NodeBlock, !verifier.code !40

NodeBlock:                                        ; preds = %7
  %Pivot = icmp slt i32 %0, 1, !verifier.code !40
  br i1 %Pivot, label %LeafBlock, label %LeafBlock1, !verifier.code !40

LeafBlock1:                                       ; preds = %NodeBlock
  %SwitchLeaf2 = icmp eq i32 %0, 1, !verifier.code !40
  br i1 %SwitchLeaf2, label %9, label %NewDefault, !verifier.code !40

LeafBlock:                                        ; preds = %NodeBlock
  %SwitchLeaf = icmp eq i32 %0, 0, !verifier.code !40
  br i1 %SwitchLeaf, label %8, label %NewDefault, !verifier.code !40

8:                                                ; preds = %LeafBlock
  call void @llvm.dbg.value(metadata i32 1, metadata !83, metadata !DIExpression()), !dbg !65, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 0, metadata !85, metadata !DIExpression()), !dbg !65, !verifier.code !40
  br label %10, !dbg !86, !verifier.code !40

9:                                                ; preds = %LeafBlock1
  call void @llvm.dbg.value(metadata i32 0, metadata !83, metadata !DIExpression()), !dbg !65, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 1, metadata !85, metadata !DIExpression()), !dbg !65, !verifier.code !40
  br label %10, !dbg !88, !verifier.code !40

NewDefault:                                       ; preds = %LeafBlock1, %LeafBlock
  br label %10, !verifier.code !40

10:                                               ; preds = %NewDefault, %9, %8
  %.04 = phi i32 [ 0, %8 ], [ undef, %NewDefault ], [ 1, %9 ], !verifier.code !40
  %.0 = phi i32 [ 1, %8 ], [ undef, %NewDefault ], [ 0, %9 ], !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %.0, metadata !83, metadata !DIExpression()), !dbg !65, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %.04, metadata !85, metadata !DIExpression()), !dbg !65, !verifier.code !40
  br label %11, !dbg !89, !verifier.code !40

11:                                               ; preds = %25, %10
  %.03 = phi [2 x i8*]** [ %1, %10 ], [ %29, %25 ], !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]** %.03, metadata !66, metadata !DIExpression()), !dbg !65, !verifier.code !40
  %12 = load [2 x i8*]*, [2 x i8*]** %.03, align 8, !dbg !90, !verifier.code !40
  %13 = icmp ne [2 x i8*]* %12, null, !dbg !91, !verifier.code !40
  br i1 %13, label %14, label %23, !dbg !92, !verifier.code !40

14:                                               ; preds = %11
  %15 = load [2 x i8*]*, [2 x i8*]** %.03, align 8, !dbg !93, !verifier.code !40
  %16 = zext i32 %.0 to i64, !dbg !94, !verifier.code !40
  %17 = getelementptr inbounds [2 x i8*], [2 x i8*]* %15, i64 0, i64 %16, !dbg !94, !verifier.code !40
  %18 = load i8*, i8** %17, align 8, !dbg !94, !verifier.code !40
  %19 = icmp ne i8* %18, null, !dbg !94, !verifier.code !40
  br i1 %19, label %20, label %23, !dbg !95, !verifier.code !40

20:                                               ; preds = %14
  %21 = call i32 @__VERIFIER_nondet_int(), !dbg !96, !verifier.code !97
  %22 = icmp ne i32 %21, 0, !dbg !95, !verifier.code !40
  br label %23, !verifier.code !40

23:                                               ; preds = %20, %14, %11
  %24 = phi i1 [ false, %14 ], [ false, %11 ], [ %22, %20 ], !dbg !65, !verifier.code !40
  br i1 %24, label %25, label %30, !dbg !89, !verifier.code !40

25:                                               ; preds = %23
  %26 = load [2 x i8*]*, [2 x i8*]** %.03, align 8, !dbg !98, !verifier.code !40
  %27 = zext i32 %.0 to i64, !dbg !99, !verifier.code !40
  %28 = getelementptr inbounds [2 x i8*], [2 x i8*]* %26, i64 0, i64 %27, !dbg !99, !verifier.code !40
  %29 = bitcast i8** %28 to [2 x i8*]**, !dbg !100, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]** %29, metadata !66, metadata !DIExpression()), !dbg !65, !verifier.code !40
  br label %11, !dbg !89, !llvm.loop !101, !verifier.code !40

30:                                               ; preds = %23
  %.03.lcssa = phi [2 x i8*]** [ %.03, %23 ], !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]** %.03.lcssa, metadata !66, metadata !DIExpression()), !dbg !65, !verifier.code !40
  %31 = load [2 x i8*]*, [2 x i8*]** %.03.lcssa, align 8, !dbg !103, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %31, metadata !104, metadata !DIExpression()), !dbg !65, !verifier.code !40
  %32 = bitcast [2 x i8*]* %31 to i8*, !dbg !105, !verifier.code !40
  %33 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !106, !verifier.code !40
  %34 = zext i32 %.0 to i64, !dbg !107, !verifier.code !40
  %35 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, i64 %34
  store i8* %32, i8** %35, align 8, !dbg !108, !verifier.code !40
  %36 = icmp ne [2 x i8*]* %31, null, !dbg !109, !verifier.code !40
  br i1 %36, label %37, label %41, !dbg !109, !verifier.code !40

37:                                               ; preds = %30
  %38 = zext i32 %.04 to i64, !dbg !110, !verifier.code !40
  %39 = getelementptr inbounds [2 x i8*], [2 x i8*]* %31, i64 0, i64 %38, !dbg !110, !verifier.code !40
  %40 = load i8*, i8** %39, align 8, !dbg !110, !verifier.code !40
  br label %42, !dbg !109, !verifier.code !40

41:                                               ; preds = %30
  br label %42, !dbg !109, !verifier.code !40

42:                                               ; preds = %41, %37
  %43 = phi i8* [ %40, %37 ], [ null, %41 ], !dbg !109, !verifier.code !40
  %44 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !111, !verifier.code !40
  %45 = zext i32 %.04 to i64, !dbg !112, !verifier.code !40
  %46 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, i64 %45
  store i8* %43, i8** %46, align 8, !dbg !113, !verifier.code !40
  %47 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 1, !dbg !114, !verifier.code !40
  %48 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 1, i64 0
  store i8 0, i8* %48, align 8, !dbg !115, !verifier.code !40
  %49 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !116, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %49, metadata !117, metadata !DIExpression()), !dbg !65, !verifier.code !40
  %50 = icmp ne [2 x i8*]* %31, null, !dbg !118, !verifier.code !40
  br i1 %50, label %51, label %55, !dbg !120, !verifier.code !40

51:                                               ; preds = %42
  %52 = bitcast [2 x i8*]* %49 to i8*, !dbg !121, !verifier.code !40
  %53 = zext i32 %.04 to i64, !dbg !122, !verifier.code !40
  %54 = getelementptr inbounds [2 x i8*], [2 x i8*]* %31, i64 0, i64 %53, !dbg !122, !verifier.code !40
  store i8* %52, i8** %54, align 8, !dbg !123, !verifier.code !40
  br label %55, !dbg !122, !verifier.code !40

55:                                               ; preds = %51, %42
  store [2 x i8*]* %49, [2 x i8*]** %.03.lcssa, align 8, !dbg !124, !verifier.code !40
  ret [2 x i8*]* %49, !dbg !125, !verifier.code !40
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @append_one([2 x i8*]* %0, i32 %1) #0 !dbg !126 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %1, metadata !131, metadata !DIExpression()), !dbg !130, !verifier.code !40
  %3 = zext i32 %1 to i64, !dbg !132, !verifier.code !40
  %4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %3, !dbg !132, !verifier.code !40
  %5 = bitcast i8** %4 to [2 x i8*]**, !dbg !133, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]** %5, metadata !134, metadata !DIExpression()), !dbg !130, !verifier.code !40
  %6 = call [2 x i8*]* @create_item(i32 %1, [2 x i8*]** %5), !dbg !135, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %6, metadata !136, metadata !DIExpression()), !dbg !130, !verifier.code !40
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %6, i64 0, i64 0, !dbg !137, !verifier.code !40
  %8 = load i8*, i8** %7, align 8, !dbg !137, !verifier.code !40
  %9 = icmp eq i8* null, %8, !dbg !139, !verifier.code !40
  br i1 %9, label %10, label %13, !dbg !140, !verifier.code !40

10:                                               ; preds = %2
  %11 = bitcast [2 x i8*]* %6 to i8*, !dbg !141, !verifier.code !40
  %12 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !142, !verifier.code !40
  store i8* %11, i8** %12, align 8, !dbg !143, !verifier.code !40
  br label %13, !dbg !142, !verifier.code !40

13:                                               ; preds = %10, %2
  %14 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !144, !verifier.code !40
  %15 = load i8*, i8** %14, align 8, !dbg !144, !verifier.code !40
  %16 = icmp eq i8* null, %15, !dbg !146, !verifier.code !40
  br i1 %16, label %17, label %20, !dbg !147, !verifier.code !40

17:                                               ; preds = %13
  %18 = bitcast [2 x i8*]* %6 to i8*, !dbg !148, !verifier.code !40
  %19 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !149, !verifier.code !40
  store i8* %18, i8** %19, align 8, !dbg !150, !verifier.code !40
  br label %20, !dbg !149, !verifier.code !40

20:                                               ; preds = %17, %13
  ret void, !dbg !151, !verifier.code !40
}

; Function Attrs: noinline nounwind uwtable
define internal void @remove_one([2 x i8*]* %0, i32 %1) #0 !dbg !152 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !153, metadata !DIExpression()), !dbg !154, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %1, metadata !155, metadata !DIExpression()), !dbg !154, !verifier.code !40
  %3 = call i32 @is_empty([2 x i8*]* %0), !dbg !156, !verifier.code !40
  %4 = icmp ne i32 %3, 0, !dbg !156, !verifier.code !40
  br i1 %4, label %5, label %6, !dbg !158, !verifier.code !40

5:                                                ; preds = %2
  br label %39, !dbg !159, !verifier.code !40

6:                                                ; preds = %2
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !160, !verifier.code !40
  %8 = load i8*, i8** %7, align 8, !dbg !160, !verifier.code !40
  %9 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !162, !verifier.code !40
  %10 = load i8*, i8** %9, align 8, !dbg !162, !verifier.code !40
  %11 = icmp eq i8* %8, %10, !dbg !163, !verifier.code !40
  br i1 %11, label %12, label %18, !dbg !164, !verifier.code !40

12:                                               ; preds = %6
  %13 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !165, !verifier.code !40
  %14 = load i8*, i8** %13, align 8, !dbg !165, !verifier.code !40
  call void @free(i8* %14) #6, !dbg !167, !verifier.code !40
  %15 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !168, !verifier.code !40
  %16 = bitcast i8** %15 to i8*, !dbg !168, !verifier.code !40
  %17 = call i8* @memset(i8* %16, i32 0, i32 16) #6, !dbg !169, !verifier.code !40
  br label %39, !dbg !170, !verifier.code !40

18:                                               ; preds = %6
  %19 = icmp eq i32 0, %1, !dbg !171, !verifier.code !40
  %20 = zext i1 %19 to i64, !dbg !172, !verifier.code !40
  %21 = select i1 %19, i32 1, i32 0, !dbg !172, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %21, metadata !173, metadata !DIExpression()), !dbg !154, !verifier.code !40
  %22 = icmp eq i32 1, %1, !dbg !175, !verifier.code !40
  %23 = zext i1 %22 to i64, !dbg !176, !verifier.code !40
  %24 = select i1 %22, i32 1, i32 0, !dbg !176, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %24, metadata !177, metadata !DIExpression()), !dbg !154, !verifier.code !40
  %25 = zext i32 %1 to i64, !dbg !178, !verifier.code !40
  %26 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %25, !dbg !178, !verifier.code !40
  %27 = load i8*, i8** %26, align 8, !dbg !178, !verifier.code !40
  %28 = bitcast i8* %27 to [2 x i8*]*, !dbg !178, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %28, metadata !179, metadata !DIExpression()), !dbg !154, !verifier.code !40
  %29 = zext i32 %21 to i64, !dbg !180, !verifier.code !40
  %30 = getelementptr inbounds [2 x i8*], [2 x i8*]* %28, i64 0, i64 %29, !dbg !180, !verifier.code !40
  %31 = load i8*, i8** %30, align 8, !dbg !180, !verifier.code !40
  %32 = bitcast i8* %31 to [2 x i8*]*, !dbg !180, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %32, metadata !181, metadata !DIExpression()), !dbg !154, !verifier.code !40
  %33 = zext i32 %24 to i64, !dbg !182, !verifier.code !40
  %34 = getelementptr inbounds [2 x i8*], [2 x i8*]* %32, i64 0, i64 %33, !dbg !182, !verifier.code !40
  store i8* null, i8** %34, align 8, !dbg !183, !verifier.code !40
  %35 = bitcast [2 x i8*]* %32 to i8*, !dbg !184, !verifier.code !40
  %36 = zext i32 %1 to i64, !dbg !185, !verifier.code !40
  %37 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %36, !dbg !185, !verifier.code !40
  store i8* %35, i8** %37, align 8, !dbg !186, !verifier.code !40
  %38 = bitcast [2 x i8*]* %28 to i8*, !dbg !187, !verifier.code !40
  call void @free(i8* %38) #6, !dbg !188, !verifier.code !40
  br label %39, !dbg !189, !verifier.code !40

39:                                               ; preds = %18, %12, %5
  ret void, !dbg !189, !verifier.code !40
}

; Function Attrs: nounwind
declare dso_local i8* @memset(i8*, i32, i32) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @rand_end_point() #0 !dbg !190 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !193, !verifier.code !97
  %2 = icmp ne i32 %1, 0, !dbg !193, !verifier.code !40
  br i1 %2, label %3, label %4, !dbg !195, !verifier.code !40

3:                                                ; preds = %0
  br label %5, !dbg !196, !verifier.code !40

4:                                                ; preds = %0
  br label %5, !dbg !197, !verifier.code !40

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ 0, %3 ], [ 1, %4 ], !dbg !198, !verifier.code !40
  ret i32 %.0, !dbg !199, !verifier.code !40
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !200, !verifier.code !97
  %2 = icmp ne i32 %1, 0, !dbg !201, !verifier.code !40
  br i1 %2, label %.lr.ph11, label %20, !dbg !201, !verifier.code !40

.lr.ph11:                                         ; preds = %0
  br label %3, !dbg !201, !verifier.code !40

3:                                                ; preds = %.lr.ph11, %17
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !202, !verifier.code !97
  %5 = icmp ne i32 %4, 0, !dbg !204, !verifier.code !40
  br i1 %5, label %.lr.ph5, label %10, !dbg !204, !verifier.code !40

.lr.ph5:                                          ; preds = %3
  br label %6, !dbg !204, !verifier.code !40

6:                                                ; preds = %.lr.ph5, %6
  %7 = call i32 @rand_end_point(), !dbg !205, !verifier.code !40
  call void @append_one([2 x i8*]* @main.list, i32 %7), !dbg !206, !verifier.code !40
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !202, !verifier.code !97
  %9 = icmp ne i32 %8, 0, !dbg !204, !verifier.code !40
  br i1 %9, label %6, label %._crit_edge6, !dbg !204, !llvm.loop !207, !verifier.code !40

._crit_edge6:                                     ; preds = %6
  br label %10, !dbg !204, !verifier.code !40

10:                                               ; preds = %._crit_edge6, %3
  %11 = call i32 @__VERIFIER_nondet_int(), !dbg !209, !verifier.code !97
  %12 = icmp ne i32 %11, 0, !dbg !210, !verifier.code !40
  br i1 %12, label %.lr.ph8, label %17, !dbg !210, !verifier.code !40

.lr.ph8:                                          ; preds = %10
  br label %13, !dbg !210, !verifier.code !40

13:                                               ; preds = %.lr.ph8, %13
  %14 = call i32 @rand_end_point(), !dbg !211, !verifier.code !40
  call void @remove_one([2 x i8*]* @main.list, i32 %14), !dbg !212, !verifier.code !40
  %15 = call i32 @__VERIFIER_nondet_int(), !dbg !209, !verifier.code !97
  %16 = icmp ne i32 %15, 0, !dbg !210, !verifier.code !40
  br i1 %16, label %13, label %._crit_edge9, !dbg !210, !llvm.loop !213, !verifier.code !40

._crit_edge9:                                     ; preds = %13
  br label %17, !dbg !210, !verifier.code !40

17:                                               ; preds = %._crit_edge9, %10
  %18 = call i32 @__VERIFIER_nondet_int(), !dbg !200, !verifier.code !97
  %19 = icmp ne i32 %18, 0, !dbg !201, !verifier.code !40
  br i1 %19, label %3, label %._crit_edge12, !dbg !201, !llvm.loop !215, !verifier.code !40

._crit_edge12:                                    ; preds = %17
  br label %20, !dbg !201, !verifier.code !40

20:                                               ; preds = %._crit_edge12, %0
  %21 = call i32 @__VERIFIER_nondet_int(), !dbg !217, !verifier.code !97
  %22 = icmp ne i32 %21, 0, !dbg !217, !verifier.code !40
  br i1 %22, label %23, label %24, !dbg !219, !verifier.code !40

23:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i32 0, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 1, metadata !222, metadata !DIExpression()), !dbg !221, !verifier.code !40
  br label %25, !dbg !223, !verifier.code !40

24:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i32 1, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 0, metadata !222, metadata !DIExpression()), !dbg !221, !verifier.code !40
  br label %25, !verifier.code !40

25:                                               ; preds = %24, %23
  %.02 = phi i32 [ 1, %23 ], [ 0, %24 ], !dbg !225, !verifier.code !40
  %.01 = phi i32 [ 0, %23 ], [ 1, %24 ], !dbg !225, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %.01, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !40
  call void @llvm.dbg.value(metadata i32 %.02, metadata !222, metadata !DIExpression()), !dbg !221, !verifier.code !40
  %26 = zext i32 %.01 to i64, !dbg !226, !verifier.code !40
  %27 = getelementptr inbounds [2 x i8*], [2 x i8*]* @main.list, i64 0, i64 %26, !dbg !226, !verifier.code !40
  %28 = load i8*, i8** %27, align 8, !dbg !226, !verifier.code !40
  %29 = bitcast i8* %28 to [2 x i8*]*, !dbg !226, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %29, metadata !227, metadata !DIExpression()), !dbg !221, !verifier.code !40
  %30 = icmp ne [2 x i8*]* %29, null, !dbg !228, !verifier.code !40
  br i1 %30, label %.lr.ph, label %38, !dbg !228, !verifier.code !40

.lr.ph:                                           ; preds = %25
  br label %31, !dbg !228, !verifier.code !40

31:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi [2 x i8*]* [ %29, %.lr.ph ], [ %35, %forwarder ], !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %.03, metadata !227, metadata !DIExpression()), !dbg !221, !verifier.code !40
  %32 = zext i32 %.02 to i64, !dbg !229, !verifier.code !40
  %33 = getelementptr inbounds [2 x i8*], [2 x i8*]* %.03, i64 0, i64 %32, !dbg !229, !verifier.code !40
  %34 = load i8*, i8** %33, align 8, !dbg !229, !verifier.code !40
  %35 = bitcast i8* %34 to [2 x i8*]*, !dbg !229, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %35, metadata !231, metadata !DIExpression()), !dbg !232, !verifier.code !40
  %36 = bitcast [2 x i8*]* %.03 to i8*, !dbg !233, !verifier.code !40
  call void @free(i8* %36) #6, !dbg !234, !verifier.code !40
  call void @llvm.dbg.value(metadata [2 x i8*]* %35, metadata !227, metadata !DIExpression()), !dbg !221, !verifier.code !40
  %37 = icmp ne [2 x i8*]* %35, null, !dbg !228, !verifier.code !40
  br i1 %37, label %forwarder, label %._crit_edge, !dbg !228, !llvm.loop !235, !verifier.code !40

._crit_edge:                                      ; preds = %31
  br label %38, !dbg !228, !verifier.code !40

38:                                               ; preds = %._crit_edge, %25
  ret i32 0, !dbg !237, !verifier.code !40

forwarder:                                        ; preds = %31
  br label %31, !verifier.code !40
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
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!30}
!llvm.module.flags = !{!31, !32, !33}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 728, type: !29, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 726, type: !4, scopeLine: 727, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0217.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, retainedTypes: !18, globals: !27, splitDebugInlining: false, nameTableKind: None)
!8 = !{!9, !14}
!9 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 643, baseType: !10, size: 32, elements: !11)
!10 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!11 = !{!12, !13}
!12 = !DIEnumerator(name: "LIST_BEG", value: 0, isUnsigned: true)
!13 = !DIEnumerator(name: "LIST_END", value: 1, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 649, baseType: !10, size: 32, elements: !15)
!15 = !{!16, !17}
!16 = !DIEnumerator(name: "ITEM_PREV", value: 0, isUnsigned: true)
!17 = !DIEnumerator(name: "ITEM_NEXT", value: 1, isUnsigned: true)
!18 = !{!19, !24}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "item_p", file: !3, line: 648, baseType: !21)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "item_t", file: !3, line: 647, baseType: !23)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 128, elements: !25)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!25 = !{!26}
!26 = !DISubrange(count: 2)
!27 = !{!0}
!28 = !{}
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "list_t", file: !3, line: 641, baseType: !23)
!30 = !{!"clang version 10.0.0-4ubuntu1 "}
!31 = !{i32 7, !"Dwarf Version", i32 4}
!32 = !{i32 2, !"Debug Info Version", i32 3}
!33 = !{i32 1, !"wchar_size", i32 4}
!34 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 12, type: !35, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!35 = !DISubroutineType(types: !36)
!36 = !{null}
!37 = !DILocation(line: 12, column: 83, scope: !38)
!38 = distinct !DILexicalBlock(scope: !39, file: !3, line: 12, column: 73)
!39 = distinct !DILexicalBlock(scope: !34, file: !3, line: 12, column: 67)
!40 = !{i1 false}
!41 = distinct !DISubprogram(name: "is_empty", scope: !3, file: !3, line: 657, type: !42, scopeLine: 658, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!42 = !DISubroutineType(types: !43)
!43 = !{!6, !44}
!44 = !DIDerivedType(tag: DW_TAG_typedef, name: "list_p", file: !3, line: 642, baseType: !45)
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!46 = !DILocalVariable(name: "list", arg: 1, scope: !41, file: !3, line: 657, type: !44)
!47 = !DILocation(line: 0, scope: !41)
!48 = !DILocation(line: 659, column: 19, scope: !41)
!49 = !DILocation(line: 659, column: 18, scope: !41)
!50 = !DILocalVariable(name: "no_beg", scope: !41, file: !3, line: 659, type: !6)
!51 = !DILocation(line: 660, column: 19, scope: !41)
!52 = !DILocation(line: 660, column: 18, scope: !41)
!53 = !DILocalVariable(name: "no_end", scope: !41, file: !3, line: 660, type: !6)
!54 = !DILocation(line: 661, column: 16, scope: !55)
!55 = distinct !DILexicalBlock(scope: !41, file: !3, line: 661, column: 9)
!56 = !DILocation(line: 661, column: 9, scope: !41)
!57 = !DILocation(line: 662, column: 14, scope: !55)
!58 = !DILocation(line: 662, column: 9, scope: !55)
!59 = !DILocation(line: 663, column: 5, scope: !41)
!60 = distinct !DISubprogram(name: "create_item", scope: !3, file: !3, line: 665, type: !61, scopeLine: 666, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!61 = !DISubroutineType(types: !62)
!62 = !{!20, !63, !19}
!63 = !DIDerivedType(tag: DW_TAG_typedef, name: "end_point_t", file: !3, line: 646, baseType: !9)
!64 = !DILocalVariable(name: "at", arg: 1, scope: !60, file: !3, line: 665, type: !63)
!65 = !DILocation(line: 0, scope: !60)
!66 = !DILocalVariable(name: "cursor", arg: 2, scope: !60, file: !3, line: 665, type: !19)
!67 = !DILocation(line: 667, column: 24, scope: !60)
!68 = !DILocalVariable(name: "item", scope: !60, file: !3, line: 667, type: !69)
!69 = !DIDerivedType(tag: DW_TAG_typedef, name: "user_item_p", file: !3, line: 656, baseType: !70)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 653, size: 2240, elements: !72)
!72 = !{!73, !74}
!73 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !71, file: !3, line: 654, baseType: !22, size: 128)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "text", scope: !71, file: !3, line: 655, baseType: !75, size: 2056, offset: 128)
!75 = !DICompositeType(tag: DW_TAG_array_type, baseType: !76, size: 2056, elements: !77)
!76 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!77 = !{!78}
!78 = !DISubrange(count: 257)
!79 = !DILocation(line: 668, column: 10, scope: !80)
!80 = distinct !DILexicalBlock(scope: !60, file: !3, line: 668, column: 9)
!81 = !DILocation(line: 668, column: 9, scope: !60)
!82 = !DILocation(line: 669, column: 9, scope: !80)
!83 = !DILocalVariable(name: "link_field", scope: !60, file: !3, line: 670, type: !84)
!84 = !DIDerivedType(tag: DW_TAG_typedef, name: "direction_t", file: !3, line: 652, baseType: !14)
!85 = !DILocalVariable(name: "term_field", scope: !60, file: !3, line: 670, type: !84)
!86 = !DILocation(line: 675, column: 13, scope: !87)
!87 = distinct !DILexicalBlock(scope: !60, file: !3, line: 671, column: 17)
!88 = !DILocation(line: 679, column: 13, scope: !87)
!89 = !DILocation(line: 681, column: 5, scope: !60)
!90 = !DILocation(line: 681, column: 13, scope: !60)
!91 = !DILocation(line: 681, column: 12, scope: !60)
!92 = !DILocation(line: 681, column: 22, scope: !60)
!93 = !DILocation(line: 681, column: 27, scope: !60)
!94 = !DILocation(line: 681, column: 25, scope: !60)
!95 = !DILocation(line: 681, column: 48, scope: !60)
!96 = !DILocation(line: 681, column: 51, scope: !60)
!97 = !{i1 true}
!98 = !DILocation(line: 682, column: 32, scope: !60)
!99 = !DILocation(line: 682, column: 30, scope: !60)
!100 = !DILocation(line: 682, column: 18, scope: !60)
!101 = distinct !{!101, !89, !102}
!102 = !DILocation(line: 682, column: 51, scope: !60)
!103 = !DILocation(line: 683, column: 19, scope: !60)
!104 = !DILocalVariable(name: "link", scope: !60, file: !3, line: 683, type: !20)
!105 = !DILocation(line: 684, column: 30, scope: !60)
!106 = !DILocation(line: 684, column: 11, scope: !60)
!107 = !DILocation(line: 684, column: 5, scope: !60)
!108 = !DILocation(line: 684, column: 28, scope: !60)
!109 = !DILocation(line: 685, column: 30, scope: !60)
!110 = !DILocation(line: 685, column: 37, scope: !60)
!111 = !DILocation(line: 685, column: 11, scope: !60)
!112 = !DILocation(line: 685, column: 5, scope: !60)
!113 = !DILocation(line: 685, column: 28, scope: !60)
!114 = !DILocation(line: 686, column: 11, scope: !60)
!115 = !DILocation(line: 686, column: 19, scope: !60)
!116 = !DILocation(line: 687, column: 26, scope: !60)
!117 = !DILocalVariable(name: "head", scope: !60, file: !3, line: 687, type: !20)
!118 = !DILocation(line: 688, column: 9, scope: !119)
!119 = distinct !DILexicalBlock(scope: !60, file: !3, line: 688, column: 9)
!120 = !DILocation(line: 688, column: 9, scope: !60)
!121 = !DILocation(line: 689, column: 31, scope: !119)
!122 = !DILocation(line: 689, column: 9, scope: !119)
!123 = !DILocation(line: 689, column: 29, scope: !119)
!124 = !DILocation(line: 690, column: 13, scope: !60)
!125 = !DILocation(line: 691, column: 5, scope: !60)
!126 = distinct !DISubprogram(name: "append_one", scope: !3, file: !3, line: 693, type: !127, scopeLine: 694, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!127 = !DISubroutineType(types: !128)
!128 = !{null, !44, !63}
!129 = !DILocalVariable(name: "list", arg: 1, scope: !126, file: !3, line: 693, type: !44)
!130 = !DILocation(line: 0, scope: !126)
!131 = !DILocalVariable(name: "to", arg: 2, scope: !126, file: !3, line: 693, type: !63)
!132 = !DILocation(line: 695, column: 34, scope: !126)
!133 = !DILocation(line: 695, column: 22, scope: !126)
!134 = !DILocalVariable(name: "cursor", scope: !126, file: !3, line: 695, type: !19)
!135 = !DILocation(line: 696, column: 19, scope: !126)
!136 = !DILocalVariable(name: "item", scope: !126, file: !3, line: 696, type: !20)
!137 = !DILocation(line: 697, column: 24, scope: !138)
!138 = distinct !DILexicalBlock(scope: !126, file: !3, line: 697, column: 9)
!139 = !DILocation(line: 697, column: 21, scope: !138)
!140 = !DILocation(line: 697, column: 9, scope: !126)
!141 = !DILocation(line: 698, column: 29, scope: !138)
!142 = !DILocation(line: 698, column: 9, scope: !138)
!143 = !DILocation(line: 698, column: 27, scope: !138)
!144 = !DILocation(line: 699, column: 24, scope: !145)
!145 = distinct !DILexicalBlock(scope: !126, file: !3, line: 699, column: 9)
!146 = !DILocation(line: 699, column: 21, scope: !145)
!147 = !DILocation(line: 699, column: 9, scope: !126)
!148 = !DILocation(line: 700, column: 29, scope: !145)
!149 = !DILocation(line: 700, column: 9, scope: !145)
!150 = !DILocation(line: 700, column: 27, scope: !145)
!151 = !DILocation(line: 701, column: 1, scope: !126)
!152 = distinct !DISubprogram(name: "remove_one", scope: !3, file: !3, line: 702, type: !127, scopeLine: 703, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!153 = !DILocalVariable(name: "list", arg: 1, scope: !152, file: !3, line: 702, type: !44)
!154 = !DILocation(line: 0, scope: !152)
!155 = !DILocalVariable(name: "from", arg: 2, scope: !152, file: !3, line: 702, type: !63)
!156 = !DILocation(line: 704, column: 9, scope: !157)
!157 = distinct !DILexicalBlock(scope: !152, file: !3, line: 704, column: 9)
!158 = !DILocation(line: 704, column: 9, scope: !152)
!159 = !DILocation(line: 705, column: 9, scope: !157)
!160 = !DILocation(line: 706, column: 9, scope: !161)
!161 = distinct !DILexicalBlock(scope: !152, file: !3, line: 706, column: 9)
!162 = !DILocation(line: 706, column: 30, scope: !161)
!163 = !DILocation(line: 706, column: 27, scope: !161)
!164 = !DILocation(line: 706, column: 9, scope: !152)
!165 = !DILocation(line: 707, column: 14, scope: !166)
!166 = distinct !DILexicalBlock(scope: !161, file: !3, line: 706, column: 49)
!167 = !DILocation(line: 707, column: 9, scope: !166)
!168 = !DILocation(line: 708, column: 16, scope: !166)
!169 = !DILocation(line: 708, column: 9, scope: !166)
!170 = !DILocation(line: 709, column: 9, scope: !166)
!171 = !DILocation(line: 711, column: 46, scope: !152)
!172 = !DILocation(line: 711, column: 36, scope: !152)
!173 = !DILocalVariable(name: "next_field", scope: !152, file: !3, line: 711, type: !174)
!174 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !84)
!175 = !DILocation(line: 712, column: 46, scope: !152)
!176 = !DILocation(line: 712, column: 36, scope: !152)
!177 = !DILocalVariable(name: "term_field", scope: !152, file: !3, line: 712, type: !174)
!178 = !DILocation(line: 713, column: 19, scope: !152)
!179 = !DILocalVariable(name: "item", scope: !152, file: !3, line: 713, type: !20)
!180 = !DILocation(line: 714, column: 19, scope: !152)
!181 = !DILocalVariable(name: "next", scope: !152, file: !3, line: 714, type: !20)
!182 = !DILocation(line: 715, column: 5, scope: !152)
!183 = !DILocation(line: 715, column: 25, scope: !152)
!184 = !DILocation(line: 716, column: 21, scope: !152)
!185 = !DILocation(line: 716, column: 5, scope: !152)
!186 = !DILocation(line: 716, column: 19, scope: !152)
!187 = !DILocation(line: 717, column: 10, scope: !152)
!188 = !DILocation(line: 717, column: 5, scope: !152)
!189 = !DILocation(line: 718, column: 1, scope: !152)
!190 = distinct !DISubprogram(name: "rand_end_point", scope: !3, file: !3, line: 719, type: !191, scopeLine: 720, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !28)
!191 = !DISubroutineType(types: !192)
!192 = !{!63}
!193 = !DILocation(line: 721, column: 9, scope: !194)
!194 = distinct !DILexicalBlock(scope: !190, file: !3, line: 721, column: 9)
!195 = !DILocation(line: 721, column: 9, scope: !190)
!196 = !DILocation(line: 722, column: 9, scope: !194)
!197 = !DILocation(line: 724, column: 9, scope: !194)
!198 = !DILocation(line: 0, scope: !194)
!199 = !DILocation(line: 725, column: 1, scope: !190)
!200 = !DILocation(line: 729, column: 12, scope: !2)
!201 = !DILocation(line: 729, column: 5, scope: !2)
!202 = !DILocation(line: 730, column: 16, scope: !203)
!203 = distinct !DILexicalBlock(scope: !2, file: !3, line: 729, column: 37)
!204 = !DILocation(line: 730, column: 9, scope: !203)
!205 = !DILocation(line: 731, column: 31, scope: !203)
!206 = !DILocation(line: 731, column: 13, scope: !203)
!207 = distinct !{!207, !204, !208}
!208 = !DILocation(line: 731, column: 47, scope: !203)
!209 = !DILocation(line: 732, column: 16, scope: !203)
!210 = !DILocation(line: 732, column: 9, scope: !203)
!211 = !DILocation(line: 733, column: 31, scope: !203)
!212 = !DILocation(line: 733, column: 13, scope: !203)
!213 = distinct !{!213, !210, !214}
!214 = !DILocation(line: 733, column: 47, scope: !203)
!215 = distinct !{!215, !201, !216}
!216 = !DILocation(line: 734, column: 5, scope: !2)
!217 = !DILocation(line: 737, column: 9, scope: !218)
!218 = distinct !DILexicalBlock(scope: !2, file: !3, line: 737, column: 9)
!219 = !DILocation(line: 737, column: 9, scope: !2)
!220 = !DILocalVariable(name: "end_point", scope: !2, file: !3, line: 735, type: !63)
!221 = !DILocation(line: 0, scope: !2)
!222 = !DILocalVariable(name: "direction", scope: !2, file: !3, line: 736, type: !84)
!223 = !DILocation(line: 740, column: 5, scope: !224)
!224 = distinct !DILexicalBlock(scope: !218, file: !3, line: 737, column: 34)
!225 = !DILocation(line: 0, scope: !218)
!226 = !DILocation(line: 745, column: 21, scope: !2)
!227 = !DILocalVariable(name: "cursor", scope: !2, file: !3, line: 745, type: !20)
!228 = !DILocation(line: 746, column: 5, scope: !2)
!229 = !DILocation(line: 747, column: 23, scope: !230)
!230 = distinct !DILexicalBlock(scope: !2, file: !3, line: 746, column: 20)
!231 = !DILocalVariable(name: "next", scope: !230, file: !3, line: 747, type: !20)
!232 = !DILocation(line: 0, scope: !230)
!233 = !DILocation(line: 748, column: 14, scope: !230)
!234 = !DILocation(line: 748, column: 9, scope: !230)
!235 = distinct !{!235, !228, !236}
!236 = !DILocation(line: 750, column: 5, scope: !2)
!237 = !DILocation(line: 751, column: 5, scope: !2)