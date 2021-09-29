; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-y3g4cb7v.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.DUPFFstruct = type { i32, i32, i32* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"20020406-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !19 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !22, !verifier.code !25
  unreachable, !dbg !22, !verifier.code !25
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal i32 @FFmul(i32 %0, i32 %1) #0 !dbg !26 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !30, metadata !DIExpression()), !dbg !31, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %1, metadata !32, metadata !DIExpression()), !dbg !31, !verifier.code !25
  ret i32 %0, !dbg !33, !verifier.code !25
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @DUPFFdeg(%struct.DUPFFstruct* %0) #0 !dbg !34 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !38, metadata !DIExpression()), !dbg !39, !verifier.code !25
  %2 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %0, i32 0, i32 1, !dbg !40, !verifier.code !25
  %3 = load i32, i32* %2, align 4, !dbg !40, !verifier.code !25
  ret i32 %3, !dbg !41, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.DUPFFstruct* @DUPFFnew(i32 %0) #0 !dbg !42 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !46, metadata !DIExpression()), !dbg !47, !verifier.code !25
  %2 = call noalias i8* @malloc(i32 16) #5, !dbg !48, !verifier.code !25
  %3 = bitcast i8* %2 to %struct.DUPFFstruct*, !dbg !49, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %3, metadata !50, metadata !DIExpression()), !dbg !47, !verifier.code !25
  %4 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !51, !verifier.code !25
  store i32* null, i32** %4, align 8, !dbg !52, !verifier.code !25
  %5 = icmp sge i32 %0, 0, !dbg !53, !verifier.code !25
  br i1 %5, label %6, label %22, !dbg !55, !verifier.code !25

6:                                                ; preds = %1
  %7 = add nsw i32 %0, 1, !dbg !56, !verifier.code !25
  %8 = sext i32 %7 to i64, !dbg !58, !verifier.code !25
  %9 = mul i64 %8, 4, !dbg !59, !verifier.code !25
  %10 = trunc i64 %9 to i32, !dbg !58, !verifier.code !25
  %11 = call noalias i8* @malloc(i32 %10) #5, !dbg !60, !verifier.code !25
  %12 = bitcast i8* %11 to i32*, !dbg !61, !verifier.code !25
  %13 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !62, !verifier.code !25
  store i32* %12, i32** %13, align 8, !dbg !63, !verifier.code !25
  %14 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !64, !verifier.code !25
  %15 = load i32*, i32** %14, align 8, !dbg !64, !verifier.code !25
  %16 = bitcast i32* %15 to i8*, !dbg !65, !verifier.code !25
  %17 = add nsw i32 %0, 1, !dbg !66, !verifier.code !25
  %18 = sext i32 %17 to i64, !dbg !67, !verifier.code !25
  %19 = mul i64 %18, 4, !dbg !68, !verifier.code !25
  %20 = trunc i64 %19 to i32, !dbg !67, !verifier.code !25
  %21 = call i8* @memset(i8* %16, i32 0, i32 %20) #5, !dbg !69, !verifier.code !25
  br label %22, !dbg !70, !verifier.code !25

22:                                               ; preds = %6, %1
  %23 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 0, !dbg !71, !verifier.code !25
  store i32 %0, i32* %23, align 8, !dbg !72, !verifier.code !25
  %24 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 1, !dbg !73, !verifier.code !25
  store i32 -1, i32* %24, align 4, !dbg !74, !verifier.code !25
  ret %struct.DUPFFstruct* %3, !dbg !75, !verifier.code !25
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

; Function Attrs: nounwind
declare dso_local i8* @memset(i8*, i32, i32) #3

; Function Attrs: noinline nounwind uwtable
define internal void @DUPFFfree(%struct.DUPFFstruct* %0) #0 !dbg !76 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !79, metadata !DIExpression()), !dbg !80, !verifier.code !25
  ret void, !dbg !81, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal void @DUPFFswap(%struct.DUPFFstruct* %0, %struct.DUPFFstruct* %1) #0 !dbg !82 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !85, metadata !DIExpression()), !dbg !86, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %1, metadata !87, metadata !DIExpression()), !dbg !86, !verifier.code !25
  ret void, !dbg !88, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %0) #0 !dbg !89 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !25
  ret %struct.DUPFFstruct* %0, !dbg !94, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal void @DUPFFshift_add(%struct.DUPFFstruct* %0, %struct.DUPFFstruct* %1, i32 %2, i32 %3) #0 !dbg !95 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !98, metadata !DIExpression()), !dbg !99, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %1, metadata !100, metadata !DIExpression()), !dbg !99, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %2, metadata !101, metadata !DIExpression()), !dbg !99, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %3, metadata !102, metadata !DIExpression()), !dbg !99, !verifier.code !25
  ret void, !dbg !103, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %0, %struct.DUPFFstruct** %1, %struct.DUPFFstruct* %2, %struct.DUPFFstruct* %3) #0 !dbg !104 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct** %0, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct** %1, metadata !110, metadata !DIExpression()), !dbg !109, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %2, metadata !111, metadata !DIExpression()), !dbg !109, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %3, metadata !112, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %5 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %2), !dbg !113, !verifier.code !25
  %6 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %3), !dbg !115, !verifier.code !25
  %7 = icmp slt i32 %5, %6, !dbg !116, !verifier.code !25
  br i1 %7, label %8, label %10, !dbg !117, !verifier.code !25

8:                                                ; preds = %4
  %9 = call %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %1, %struct.DUPFFstruct** %0, %struct.DUPFFstruct* %3, %struct.DUPFFstruct* %2), !dbg !118, !verifier.code !25
  br label %83, !dbg !119, !verifier.code !25

10:                                               ; preds = %4
  %11 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %2), !dbg !120, !verifier.code !25
  %12 = icmp ne i32 %11, 2, !dbg !122, !verifier.code !25
  br i1 %12, label %16, label %13, !dbg !123, !verifier.code !25

13:                                               ; preds = %10
  %14 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %3), !dbg !124, !verifier.code !25
  %15 = icmp ne i32 %14, 1, !dbg !125, !verifier.code !25
  br i1 %15, label %16, label %17, !dbg !126, !verifier.code !25

16:                                               ; preds = %13, %10
  call void @abort() #4, !dbg !127, !verifier.code !25
  unreachable, !dbg !127, !verifier.code !25

17:                                               ; preds = %13
  %18 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %2, i32 0, i32 2, !dbg !128, !verifier.code !25
  %19 = load i32*, i32** %18, align 8, !dbg !128, !verifier.code !25
  %20 = getelementptr inbounds i32, i32* %19, i64 0, !dbg !130, !verifier.code !25
  %21 = load i32, i32* %20, align 4, !dbg !130, !verifier.code !25
  %22 = icmp eq i32 %21, 0, !dbg !131, !verifier.code !25
  br i1 %22, label %23, label %24, !dbg !132, !verifier.code !25

23:                                               ; preds = %17
  br label %83, !dbg !133, !verifier.code !25

24:                                               ; preds = %17
  call void @llvm.dbg.value(metadata i32 2, metadata !134, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %25 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %2), !dbg !135, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %25, metadata !136, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %26 = icmp slt i32 %25, 0, !dbg !137, !verifier.code !25
  br i1 %26, label %27, label %28, !dbg !139, !verifier.code !25

27:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i32 0, metadata !136, metadata !DIExpression()), !dbg !109, !verifier.code !25
  br label %28, !dbg !140, !verifier.code !25

28:                                               ; preds = %27, %24
  %.02 = phi i32 [ 0, %27 ], [ %25, %24 ], !dbg !109, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %.02, metadata !136, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %29 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %3), !dbg !141, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %29, metadata !142, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %30 = icmp slt i32 %29, 0, !dbg !143, !verifier.code !25
  br i1 %30, label %31, label %32, !dbg !145, !verifier.code !25

31:                                               ; preds = %28
  call void @llvm.dbg.value(metadata i32 0, metadata !142, metadata !DIExpression()), !dbg !109, !verifier.code !25
  br label %32, !dbg !146, !verifier.code !25

32:                                               ; preds = %31, %28
  %.01 = phi i32 [ 0, %31 ], [ %29, %28 ], !dbg !109, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %.01, metadata !142, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %33 = call %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %2), !dbg !147, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %33, metadata !148, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %34 = call %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %3), !dbg !149, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %34, metadata !150, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %35 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.01), !dbg !151, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %35, metadata !152, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %36 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %35, i32 0, i32 2, !dbg !153, !verifier.code !25
  %37 = load i32*, i32** %36, align 8, !dbg !153, !verifier.code !25
  %38 = getelementptr inbounds i32, i32* %37, i64 0, !dbg !154, !verifier.code !25
  store i32 1, i32* %38, align 4, !dbg !155, !verifier.code !25
  %39 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %35, i32 0, i32 1, !dbg !156, !verifier.code !25
  store i32 0, i32* %39, align 4, !dbg !157, !verifier.code !25
  %40 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.02), !dbg !158, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %40, metadata !159, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %41 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.01), !dbg !160, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %41, metadata !161, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %42 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.02), !dbg !162, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %42, metadata !163, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %43 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %42, i32 0, i32 2, !dbg !164, !verifier.code !25
  %44 = load i32*, i32** %43, align 8, !dbg !164, !verifier.code !25
  %45 = getelementptr inbounds i32, i32* %44, i64 0, !dbg !165, !verifier.code !25
  store i32 1, i32* %45, align 4, !dbg !166, !verifier.code !25
  %46 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %42, i32 0, i32 1, !dbg !167, !verifier.code !25
  store i32 0, i32* %46, align 4, !dbg !168, !verifier.code !25
  %47 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !169, !verifier.code !25
  %48 = icmp sgt i32 %47, 0, !dbg !170, !verifier.code !25
  br i1 %48, label %.lr.ph4, label %78, !dbg !171, !verifier.code !25

.lr.ph4:                                          ; preds = %32
  br label %49, !dbg !171, !verifier.code !25

49:                                               ; preds = %.lr.ph4, %75
  %50 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !172, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %50, metadata !174, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %51 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %34, i32 0, i32 2, !dbg !175, !verifier.code !25
  %52 = load i32*, i32** %51, align 8, !dbg !175, !verifier.code !25
  %53 = sext i32 %50 to i64, !dbg !176, !verifier.code !25
  %54 = getelementptr inbounds i32, i32* %52, i64 %53, !dbg !176, !verifier.code !25
  %55 = load i32, i32* %54, align 4, !dbg !176, !verifier.code !25
  %56 = call i32 @FFmul(i32 1, i32 %55), !dbg !177, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %56, metadata !178, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %57 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %33), !dbg !179, !verifier.code !25
  %58 = icmp sge i32 %57, %50, !dbg !180, !verifier.code !25
  br i1 %58, label %.lr.ph, label %75, !dbg !181, !verifier.code !25

.lr.ph:                                           ; preds = %49
  br label %59, !dbg !181, !verifier.code !25

59:                                               ; preds = %.lr.ph, %59
  %60 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %33), !dbg !182, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %60, metadata !184, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %61 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %33, i32 0, i32 2, !dbg !185, !verifier.code !25
  %62 = load i32*, i32** %61, align 8, !dbg !185, !verifier.code !25
  %63 = sext i32 %60 to i64, !dbg !186, !verifier.code !25
  %64 = getelementptr inbounds i32, i32* %62, i64 %63, !dbg !186, !verifier.code !25
  %65 = load i32, i32* %64, align 4, !dbg !186, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %65, metadata !187, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %66 = call i32 @FFmul(i32 %65, i32 %56), !dbg !188, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %66, metadata !189, metadata !DIExpression()), !dbg !109, !verifier.code !25
  %67 = sub nsw i32 %60, %50, !dbg !190, !verifier.code !25
  %68 = sub i32 2, %66, !dbg !191, !verifier.code !25
  call void @DUPFFshift_add(%struct.DUPFFstruct* %33, %struct.DUPFFstruct* %34, i32 %67, i32 %68), !dbg !192, !verifier.code !25
  %69 = sub nsw i32 %60, %50, !dbg !193, !verifier.code !25
  %70 = sub i32 2, %66, !dbg !194, !verifier.code !25
  call void @DUPFFshift_add(%struct.DUPFFstruct* %35, %struct.DUPFFstruct* %41, i32 %69, i32 %70), !dbg !195, !verifier.code !25
  %71 = sub nsw i32 %60, %50, !dbg !196, !verifier.code !25
  %72 = sub i32 2, %66, !dbg !197, !verifier.code !25
  call void @DUPFFshift_add(%struct.DUPFFstruct* %40, %struct.DUPFFstruct* %42, i32 %71, i32 %72), !dbg !198, !verifier.code !25
  %73 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %33), !dbg !179, !verifier.code !25
  %74 = icmp sge i32 %73, %50, !dbg !180, !verifier.code !25
  br i1 %74, label %59, label %._crit_edge, !dbg !181, !llvm.loop !199, !verifier.code !25

._crit_edge:                                      ; preds = %59
  br label %75, !dbg !181, !verifier.code !25

75:                                               ; preds = %._crit_edge, %49
  call void @DUPFFswap(%struct.DUPFFstruct* %33, %struct.DUPFFstruct* %34), !dbg !201, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %35, %struct.DUPFFstruct* %41), !dbg !202, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %40, %struct.DUPFFstruct* %42), !dbg !203, !verifier.code !25
  %76 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !169, !verifier.code !25
  %77 = icmp sgt i32 %76, 0, !dbg !170, !verifier.code !25
  br i1 %77, label %49, label %._crit_edge5, !dbg !171, !llvm.loop !204, !verifier.code !25

._crit_edge5:                                     ; preds = %75
  br label %78, !dbg !171, !verifier.code !25

78:                                               ; preds = %._crit_edge5, %32
  %79 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !206, !verifier.code !25
  %80 = icmp eq i32 %79, 0, !dbg !208, !verifier.code !25
  br i1 %80, label %81, label %82, !dbg !209, !verifier.code !25

81:                                               ; preds = %78
  call void @DUPFFswap(%struct.DUPFFstruct* %33, %struct.DUPFFstruct* %34), !dbg !210, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %35, %struct.DUPFFstruct* %41), !dbg !212, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %40, %struct.DUPFFstruct* %42), !dbg !213, !verifier.code !25
  br label %82, !dbg !214, !verifier.code !25

82:                                               ; preds = %81, %78
  call void @DUPFFfree(%struct.DUPFFstruct* %41), !dbg !215, !verifier.code !25
  call void @DUPFFfree(%struct.DUPFFstruct* %42), !dbg !216, !verifier.code !25
  call void @DUPFFfree(%struct.DUPFFstruct* %34), !dbg !217, !verifier.code !25
  store %struct.DUPFFstruct* %35, %struct.DUPFFstruct** %0, align 8, !dbg !218, !verifier.code !25
  store %struct.DUPFFstruct* %40, %struct.DUPFFstruct** %1, align 8, !dbg !219, !verifier.code !25
  br label %83, !dbg !220, !verifier.code !25

83:                                               ; preds = %82, %23, %8
  %.0 = phi %struct.DUPFFstruct* [ %9, %8 ], [ %2, %23 ], [ %33, %82 ], !dbg !109, !verifier.code !25
  ret %struct.DUPFFstruct* %.0, !dbg !221, !verifier.code !25
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !222 {
  %1 = alloca %struct.DUPFFstruct*, align 8, !verifier.code !25
  %2 = alloca %struct.DUPFFstruct*, align 8, !verifier.code !25
  call void @llvm.dbg.declare(metadata %struct.DUPFFstruct** %1, metadata !225, metadata !DIExpression()), !dbg !226, !verifier.code !25
  call void @llvm.dbg.declare(metadata %struct.DUPFFstruct** %2, metadata !227, metadata !DIExpression()), !dbg !228, !verifier.code !25
  %3 = call %struct.DUPFFstruct* @DUPFFnew(i32 1), !dbg !229, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %3, metadata !230, metadata !DIExpression()), !dbg !231, !verifier.code !25
  %4 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !232, !verifier.code !25
  %5 = load i32*, i32** %4, align 8, !dbg !232, !verifier.code !25
  %6 = getelementptr inbounds i32, i32* %5, i64 1, !dbg !233, !verifier.code !25
  store i32 1, i32* %6, align 4, !dbg !234, !verifier.code !25
  %7 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 1, !dbg !235, !verifier.code !25
  store i32 1, i32* %7, align 4, !dbg !236, !verifier.code !25
  %8 = call %struct.DUPFFstruct* @DUPFFnew(i32 2), !dbg !237, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %8, metadata !238, metadata !DIExpression()), !dbg !231, !verifier.code !25
  %9 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %8, i32 0, i32 2, !dbg !239, !verifier.code !25
  %10 = load i32*, i32** %9, align 8, !dbg !239, !verifier.code !25
  %11 = getelementptr inbounds i32, i32* %10, i64 2, !dbg !240, !verifier.code !25
  store i32 1, i32* %11, align 4, !dbg !241, !verifier.code !25
  %12 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %8, i32 0, i32 1, !dbg !242, !verifier.code !25
  store i32 2, i32* %12, align 4, !dbg !243, !verifier.code !25
  %13 = call %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %1, %struct.DUPFFstruct** %2, %struct.DUPFFstruct* %3, %struct.DUPFFstruct* %8), !dbg !244, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %13, metadata !245, metadata !DIExpression()), !dbg !231, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %13, metadata !245, metadata !DIExpression()), !dbg !231, !verifier.code !25
  ret i32 0, !dbg !246, !verifier.code !25
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!15}
!llvm.module.flags = !{!16, !17, !18}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/20020406-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !12}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DUPFF", file: !1, line: 887, baseType: !5)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DUPFFstruct", file: !1, line: 881, size: 128, elements: !7)
!7 = !{!8, !10, !11}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "maxdeg", scope: !6, file: !1, line: 883, baseType: !9, size: 32)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "deg", scope: !6, file: !1, line: 884, baseType: !9, size: 32, offset: 32)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "coeffs", scope: !6, file: !1, line: 885, baseType: !12, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "FFelem", file: !1, line: 876, baseType: !14)
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = !{!"clang version 10.0.0-4ubuntu1 "}
!16 = !{i32 7, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = distinct !DISubprogram(name: "reach_error", scope: !1, file: !1, line: 12, type: !20, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{null}
!22 = !DILocation(line: 12, column: 83, scope: !23)
!23 = distinct !DILexicalBlock(scope: !24, file: !1, line: 12, column: 73)
!24 = distinct !DILexicalBlock(scope: !19, file: !1, line: 12, column: 67)
!25 = !{i1 false}
!26 = distinct !DISubprogram(name: "FFmul", scope: !1, file: !1, line: 877, type: !27, scopeLine: 878, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!13, !29, !29}
!29 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!30 = !DILocalVariable(name: "x", arg: 1, scope: !26, file: !1, line: 877, type: !29)
!31 = !DILocation(line: 0, scope: !26)
!32 = !DILocalVariable(name: "y", arg: 2, scope: !26, file: !1, line: 877, type: !29)
!33 = !DILocation(line: 879, column: 3, scope: !26)
!34 = distinct !DISubprogram(name: "DUPFFdeg", scope: !1, file: !1, line: 888, type: !35, scopeLine: 889, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!9, !37}
!37 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!38 = !DILocalVariable(name: "f", arg: 1, scope: !34, file: !1, line: 888, type: !37)
!39 = !DILocation(line: 0, scope: !34)
!40 = !DILocation(line: 890, column: 13, scope: !34)
!41 = !DILocation(line: 890, column: 3, scope: !34)
!42 = distinct !DISubprogram(name: "DUPFFnew", scope: !1, file: !1, line: 892, type: !43, scopeLine: 893, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!4, !45}
!45 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!46 = !DILocalVariable(name: "maxdeg", arg: 1, scope: !42, file: !1, line: 892, type: !45)
!47 = !DILocation(line: 0, scope: !42)
!48 = !DILocation(line: 894, column: 22, scope: !42)
!49 = !DILocation(line: 894, column: 15, scope: !42)
!50 = !DILocalVariable(name: "ans", scope: !42, file: !1, line: 894, type: !4)
!51 = !DILocation(line: 895, column: 8, scope: !42)
!52 = !DILocation(line: 895, column: 15, scope: !42)
!53 = !DILocation(line: 896, column: 14, scope: !54)
!54 = distinct !DILexicalBlock(scope: !42, file: !1, line: 896, column: 7)
!55 = !DILocation(line: 896, column: 7, scope: !42)
!56 = !DILocation(line: 897, column: 42, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 896, column: 20)
!58 = !DILocation(line: 897, column: 35, scope: !57)
!59 = !DILocation(line: 897, column: 45, scope: !57)
!60 = !DILocation(line: 897, column: 28, scope: !57)
!61 = !DILocation(line: 897, column: 19, scope: !57)
!62 = !DILocation(line: 897, column: 10, scope: !57)
!63 = !DILocation(line: 897, column: 17, scope: !57)
!64 = !DILocation(line: 898, column: 17, scope: !57)
!65 = !DILocation(line: 898, column: 12, scope: !57)
!66 = !DILocation(line: 898, column: 35, scope: !57)
!67 = !DILocation(line: 898, column: 28, scope: !57)
!68 = !DILocation(line: 898, column: 38, scope: !57)
!69 = !DILocation(line: 898, column: 5, scope: !57)
!70 = !DILocation(line: 899, column: 3, scope: !57)
!71 = !DILocation(line: 900, column: 8, scope: !42)
!72 = !DILocation(line: 900, column: 15, scope: !42)
!73 = !DILocation(line: 901, column: 8, scope: !42)
!74 = !DILocation(line: 901, column: 12, scope: !42)
!75 = !DILocation(line: 902, column: 3, scope: !42)
!76 = distinct !DISubprogram(name: "DUPFFfree", scope: !1, file: !1, line: 904, type: !77, scopeLine: 905, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!77 = !DISubroutineType(types: !78)
!78 = !{null, !4}
!79 = !DILocalVariable(name: "x", arg: 1, scope: !76, file: !1, line: 904, type: !4)
!80 = !DILocation(line: 0, scope: !76)
!81 = !DILocation(line: 906, column: 1, scope: !76)
!82 = distinct !DISubprogram(name: "DUPFFswap", scope: !1, file: !1, line: 907, type: !83, scopeLine: 908, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!83 = !DISubroutineType(types: !84)
!84 = !{null, !4, !4}
!85 = !DILocalVariable(name: "x", arg: 1, scope: !82, file: !1, line: 907, type: !4)
!86 = !DILocation(line: 0, scope: !82)
!87 = !DILocalVariable(name: "y", arg: 2, scope: !82, file: !1, line: 907, type: !4)
!88 = !DILocation(line: 909, column: 1, scope: !82)
!89 = distinct !DISubprogram(name: "DUPFFcopy", scope: !1, file: !1, line: 910, type: !90, scopeLine: 911, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!90 = !DISubroutineType(types: !91)
!91 = !{!4, !37}
!92 = !DILocalVariable(name: "x", arg: 1, scope: !89, file: !1, line: 910, type: !37)
!93 = !DILocation(line: 0, scope: !89)
!94 = !DILocation(line: 912, column: 3, scope: !89)
!95 = distinct !DISubprogram(name: "DUPFFshift_add", scope: !1, file: !1, line: 914, type: !96, scopeLine: 915, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!96 = !DISubroutineType(types: !97)
!97 = !{null, !4, !37, !9, !29}
!98 = !DILocalVariable(name: "f", arg: 1, scope: !95, file: !1, line: 914, type: !4)
!99 = !DILocation(line: 0, scope: !95)
!100 = !DILocalVariable(name: "g", arg: 2, scope: !95, file: !1, line: 914, type: !37)
!101 = !DILocalVariable(name: "deg", arg: 3, scope: !95, file: !1, line: 914, type: !9)
!102 = !DILocalVariable(name: "coeff", arg: 4, scope: !95, file: !1, line: 914, type: !29)
!103 = !DILocation(line: 916, column: 1, scope: !95)
!104 = distinct !DISubprogram(name: "DUPFFexgcd", scope: !1, file: !1, line: 917, type: !105, scopeLine: 918, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!105 = !DISubroutineType(types: !106)
!106 = !{!4, !107, !107, !37, !37}
!107 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!108 = !DILocalVariable(name: "fcofac", arg: 1, scope: !104, file: !1, line: 917, type: !107)
!109 = !DILocation(line: 0, scope: !104)
!110 = !DILocalVariable(name: "gcofac", arg: 2, scope: !104, file: !1, line: 917, type: !107)
!111 = !DILocalVariable(name: "f", arg: 3, scope: !104, file: !1, line: 917, type: !37)
!112 = !DILocalVariable(name: "g", arg: 4, scope: !104, file: !1, line: 917, type: !37)
!113 = !DILocation(line: 922, column: 7, scope: !114)
!114 = distinct !DILexicalBlock(scope: !104, file: !1, line: 922, column: 7)
!115 = !DILocation(line: 922, column: 21, scope: !114)
!116 = !DILocation(line: 922, column: 19, scope: !114)
!117 = !DILocation(line: 922, column: 7, scope: !104)
!118 = !DILocation(line: 922, column: 41, scope: !114)
!119 = !DILocation(line: 922, column: 34, scope: !114)
!120 = !DILocation(line: 923, column: 7, scope: !121)
!121 = distinct !DILexicalBlock(scope: !104, file: !1, line: 923, column: 7)
!122 = !DILocation(line: 923, column: 19, scope: !121)
!123 = !DILocation(line: 923, column: 24, scope: !121)
!124 = !DILocation(line: 923, column: 27, scope: !121)
!125 = !DILocation(line: 923, column: 39, scope: !121)
!126 = !DILocation(line: 923, column: 7, scope: !104)
!127 = !DILocation(line: 923, column: 45, scope: !121)
!128 = !DILocation(line: 924, column: 10, scope: !129)
!129 = distinct !DILexicalBlock(scope: !104, file: !1, line: 924, column: 7)
!130 = !DILocation(line: 924, column: 7, scope: !129)
!131 = !DILocation(line: 924, column: 20, scope: !129)
!132 = !DILocation(line: 924, column: 7, scope: !104)
!133 = !DILocation(line: 924, column: 26, scope: !129)
!134 = !DILocalVariable(name: "p", scope: !104, file: !1, line: 920, type: !13)
!135 = !DILocation(line: 926, column: 8, scope: !104)
!136 = !DILocalVariable(name: "df", scope: !104, file: !1, line: 921, type: !9)
!137 = !DILocation(line: 926, column: 28, scope: !138)
!138 = distinct !DILexicalBlock(scope: !104, file: !1, line: 926, column: 25)
!139 = !DILocation(line: 926, column: 25, scope: !104)
!140 = !DILocation(line: 926, column: 33, scope: !138)
!141 = !DILocation(line: 927, column: 8, scope: !104)
!142 = !DILocalVariable(name: "dg", scope: !104, file: !1, line: 921, type: !9)
!143 = !DILocation(line: 927, column: 28, scope: !144)
!144 = distinct !DILexicalBlock(scope: !104, file: !1, line: 927, column: 25)
!145 = !DILocation(line: 927, column: 25, scope: !104)
!146 = !DILocation(line: 927, column: 33, scope: !144)
!147 = !DILocation(line: 928, column: 7, scope: !104)
!148 = !DILocalVariable(name: "u", scope: !104, file: !1, line: 919, type: !4)
!149 = !DILocation(line: 929, column: 7, scope: !104)
!150 = !DILocalVariable(name: "v", scope: !104, file: !1, line: 919, type: !4)
!151 = !DILocation(line: 930, column: 8, scope: !104)
!152 = !DILocalVariable(name: "uf", scope: !104, file: !1, line: 919, type: !4)
!153 = !DILocation(line: 930, column: 26, scope: !104)
!154 = !DILocation(line: 930, column: 22, scope: !104)
!155 = !DILocation(line: 930, column: 36, scope: !104)
!156 = !DILocation(line: 930, column: 45, scope: !104)
!157 = !DILocation(line: 930, column: 49, scope: !104)
!158 = !DILocation(line: 931, column: 8, scope: !104)
!159 = !DILocalVariable(name: "ug", scope: !104, file: !1, line: 919, type: !4)
!160 = !DILocation(line: 932, column: 8, scope: !104)
!161 = !DILocalVariable(name: "vf", scope: !104, file: !1, line: 919, type: !4)
!162 = !DILocation(line: 933, column: 8, scope: !104)
!163 = !DILocalVariable(name: "vg", scope: !104, file: !1, line: 919, type: !4)
!164 = !DILocation(line: 933, column: 26, scope: !104)
!165 = !DILocation(line: 933, column: 22, scope: !104)
!166 = !DILocation(line: 933, column: 36, scope: !104)
!167 = !DILocation(line: 933, column: 45, scope: !104)
!168 = !DILocation(line: 933, column: 49, scope: !104)
!169 = !DILocation(line: 934, column: 10, scope: !104)
!170 = !DILocation(line: 934, column: 22, scope: !104)
!171 = !DILocation(line: 934, column: 3, scope: !104)
!172 = !DILocation(line: 936, column: 10, scope: !173)
!173 = distinct !DILexicalBlock(scope: !104, file: !1, line: 935, column: 3)
!174 = !DILocalVariable(name: "dv", scope: !104, file: !1, line: 921, type: !9)
!175 = !DILocation(line: 937, column: 28, scope: !173)
!176 = !DILocation(line: 937, column: 25, scope: !173)
!177 = !DILocation(line: 937, column: 16, scope: !173)
!178 = !DILocalVariable(name: "lcvrecip", scope: !104, file: !1, line: 920, type: !13)
!179 = !DILocation(line: 938, column: 12, scope: !173)
!180 = !DILocation(line: 938, column: 24, scope: !173)
!181 = !DILocation(line: 938, column: 5, scope: !173)
!182 = !DILocation(line: 940, column: 12, scope: !183)
!183 = distinct !DILexicalBlock(scope: !173, file: !1, line: 939, column: 5)
!184 = !DILocalVariable(name: "du", scope: !104, file: !1, line: 921, type: !9)
!185 = !DILocation(line: 941, column: 16, scope: !183)
!186 = !DILocation(line: 941, column: 13, scope: !183)
!187 = !DILocalVariable(name: "lcu", scope: !104, file: !1, line: 920, type: !13)
!188 = !DILocation(line: 942, column: 11, scope: !183)
!189 = !DILocalVariable(name: "q", scope: !104, file: !1, line: 920, type: !13)
!190 = !DILocation(line: 943, column: 30, scope: !183)
!191 = !DILocation(line: 943, column: 36, scope: !183)
!192 = !DILocation(line: 943, column: 7, scope: !183)
!193 = !DILocation(line: 944, column: 32, scope: !183)
!194 = !DILocation(line: 944, column: 38, scope: !183)
!195 = !DILocation(line: 944, column: 7, scope: !183)
!196 = !DILocation(line: 945, column: 32, scope: !183)
!197 = !DILocation(line: 945, column: 38, scope: !183)
!198 = !DILocation(line: 945, column: 7, scope: !183)
!199 = distinct !{!199, !181, !200}
!200 = !DILocation(line: 946, column: 5, scope: !173)
!201 = !DILocation(line: 947, column: 5, scope: !173)
!202 = !DILocation(line: 948, column: 5, scope: !173)
!203 = !DILocation(line: 949, column: 5, scope: !173)
!204 = distinct !{!204, !171, !205}
!205 = !DILocation(line: 950, column: 3, scope: !104)
!206 = !DILocation(line: 951, column: 7, scope: !207)
!207 = distinct !DILexicalBlock(scope: !104, file: !1, line: 951, column: 7)
!208 = !DILocation(line: 951, column: 19, scope: !207)
!209 = !DILocation(line: 951, column: 7, scope: !104)
!210 = !DILocation(line: 953, column: 5, scope: !211)
!211 = distinct !DILexicalBlock(scope: !207, file: !1, line: 952, column: 3)
!212 = !DILocation(line: 954, column: 5, scope: !211)
!213 = !DILocation(line: 955, column: 5, scope: !211)
!214 = !DILocation(line: 956, column: 3, scope: !211)
!215 = !DILocation(line: 957, column: 3, scope: !104)
!216 = !DILocation(line: 958, column: 3, scope: !104)
!217 = !DILocation(line: 959, column: 3, scope: !104)
!218 = !DILocation(line: 960, column: 11, scope: !104)
!219 = !DILocation(line: 961, column: 11, scope: !104)
!220 = !DILocation(line: 962, column: 3, scope: !104)
!221 = !DILocation(line: 963, column: 1, scope: !104)
!222 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 964, type: !223, scopeLine: 965, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!223 = !DISubroutineType(types: !224)
!224 = !{!9}
!225 = !DILocalVariable(name: "cf", scope: !222, file: !1, line: 966, type: !4)
!226 = !DILocation(line: 966, column: 15, scope: !222)
!227 = !DILocalVariable(name: "cg", scope: !222, file: !1, line: 966, type: !4)
!228 = !DILocation(line: 966, column: 19, scope: !222)
!229 = !DILocation(line: 967, column: 7, scope: !222)
!230 = !DILocalVariable(name: "f", scope: !222, file: !1, line: 966, type: !4)
!231 = !DILocation(line: 0, scope: !222)
!232 = !DILocation(line: 967, column: 23, scope: !222)
!233 = !DILocation(line: 967, column: 20, scope: !222)
!234 = !DILocation(line: 967, column: 33, scope: !222)
!235 = !DILocation(line: 967, column: 41, scope: !222)
!236 = !DILocation(line: 967, column: 45, scope: !222)
!237 = !DILocation(line: 968, column: 7, scope: !222)
!238 = !DILocalVariable(name: "g", scope: !222, file: !1, line: 966, type: !4)
!239 = !DILocation(line: 968, column: 23, scope: !222)
!240 = !DILocation(line: 968, column: 20, scope: !222)
!241 = !DILocation(line: 968, column: 33, scope: !222)
!242 = !DILocation(line: 968, column: 41, scope: !222)
!243 = !DILocation(line: 968, column: 45, scope: !222)
!244 = !DILocation(line: 969, column: 7, scope: !222)
!245 = !DILocalVariable(name: "h", scope: !222, file: !1, line: 966, type: !4)
!246 = !DILocation(line: 971, column: 3, scope: !222)
