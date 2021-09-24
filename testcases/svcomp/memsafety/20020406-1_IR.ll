; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-7rz6cfoa.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.DUPFFstruct = type { i32, i32, i32* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [43 x i8] c"../testcases/svcomp/memsafety/20020406-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !19 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([43 x i8], [43 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !22, !verifier.code !25
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
  %2 = call noalias i8* @malloc(i64 16) #6, !dbg !48, !verifier.code !25
  %3 = bitcast i8* %2 to %struct.DUPFFstruct*, !dbg !49, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %3, metadata !50, metadata !DIExpression()), !dbg !47, !verifier.code !25
  %4 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !51, !verifier.code !25
  store i32* null, i32** %4, align 8, !dbg !52, !verifier.code !25
  %5 = icmp sge i32 %0, 0, !dbg !53, !verifier.code !25
  br i1 %5, label %6, label %19, !dbg !55, !verifier.code !25

6:                                                ; preds = %1
  %7 = add nsw i32 %0, 1, !dbg !56, !verifier.code !25
  %8 = sext i32 %7 to i64, !dbg !58, !verifier.code !25
  %9 = mul i64 %8, 4, !dbg !59, !verifier.code !25
  %10 = call noalias i8* @malloc(i64 %9) #6, !dbg !60, !verifier.code !25
  %11 = bitcast i8* %10 to i32*, !dbg !61, !verifier.code !25
  %12 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !62, !verifier.code !25
  store i32* %11, i32** %12, align 8, !dbg !63, !verifier.code !25
  %13 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !64, !verifier.code !25
  %14 = load i32*, i32** %13, align 8, !dbg !64, !verifier.code !25
  %15 = bitcast i32* %14 to i8*, !dbg !65, !verifier.code !25
  %16 = add nsw i32 %0, 1, !dbg !66, !verifier.code !25
  %17 = sext i32 %16 to i64, !dbg !67, !verifier.code !25
  %18 = mul i64 %17, 4, !dbg !68, !verifier.code !25
  call void @llvm.memset.p0i8.i64(i8* align 4 %15, i8 0, i64 %18, i1 false), !dbg !65, !verifier.code !25
  br label %19, !dbg !69, !verifier.code !25

19:                                               ; preds = %6, %1
  %20 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 0, !dbg !70, !verifier.code !25
  store i32 %0, i32* %20, align 8, !dbg !71, !verifier.code !25
  %21 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 1, !dbg !72, !verifier.code !25
  store i32 -1, i32* %21, align 4, !dbg !73, !verifier.code !25
  ret %struct.DUPFFstruct* %3, !dbg !74, !verifier.code !25
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal void @DUPFFfree(%struct.DUPFFstruct* %0) #0 !dbg !75 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !78, metadata !DIExpression()), !dbg !79, !verifier.code !25
  ret void, !dbg !80, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal void @DUPFFswap(%struct.DUPFFstruct* %0, %struct.DUPFFstruct* %1) #0 !dbg !81 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !84, metadata !DIExpression()), !dbg !85, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %1, metadata !86, metadata !DIExpression()), !dbg !85, !verifier.code !25
  ret void, !dbg !87, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %0) #0 !dbg !88 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !25
  ret %struct.DUPFFstruct* %0, !dbg !93, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal void @DUPFFshift_add(%struct.DUPFFstruct* %0, %struct.DUPFFstruct* %1, i32 %2, i32 %3) #0 !dbg !94 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %0, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %1, metadata !99, metadata !DIExpression()), !dbg !98, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %2, metadata !100, metadata !DIExpression()), !dbg !98, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %3, metadata !101, metadata !DIExpression()), !dbg !98, !verifier.code !25
  ret void, !dbg !102, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %0, %struct.DUPFFstruct** %1, %struct.DUPFFstruct* %2, %struct.DUPFFstruct* %3) #0 !dbg !103 {
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct** %0, metadata !107, metadata !DIExpression()), !dbg !108, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct** %1, metadata !109, metadata !DIExpression()), !dbg !108, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %2, metadata !110, metadata !DIExpression()), !dbg !108, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %3, metadata !111, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %5 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %2), !dbg !112, !verifier.code !25
  %6 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %3), !dbg !114, !verifier.code !25
  %7 = icmp slt i32 %5, %6, !dbg !115, !verifier.code !25
  br i1 %7, label %8, label %10, !dbg !116, !verifier.code !25

8:                                                ; preds = %4
  %9 = call %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %1, %struct.DUPFFstruct** %0, %struct.DUPFFstruct* %3, %struct.DUPFFstruct* %2), !dbg !117, !verifier.code !25
  br label %83, !dbg !118, !verifier.code !25

10:                                               ; preds = %4
  %11 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %2), !dbg !119, !verifier.code !25
  %12 = icmp ne i32 %11, 2, !dbg !121, !verifier.code !25
  br i1 %12, label %16, label %13, !dbg !122, !verifier.code !25

13:                                               ; preds = %10
  %14 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %3), !dbg !123, !verifier.code !25
  %15 = icmp ne i32 %14, 1, !dbg !124, !verifier.code !25
  br i1 %15, label %16, label %17, !dbg !125, !verifier.code !25

16:                                               ; preds = %13, %10
  call void @abort() #5, !dbg !126, !verifier.code !25
  unreachable, !dbg !126, !verifier.code !25

17:                                               ; preds = %13
  %18 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %2, i32 0, i32 2, !dbg !127, !verifier.code !25
  %19 = load i32*, i32** %18, align 8, !dbg !127, !verifier.code !25
  %20 = getelementptr inbounds i32, i32* %19, i64 0, !dbg !129, !verifier.code !25
  %21 = load i32, i32* %20, align 4, !dbg !129, !verifier.code !25
  %22 = icmp eq i32 %21, 0, !dbg !130, !verifier.code !25
  br i1 %22, label %23, label %24, !dbg !131, !verifier.code !25

23:                                               ; preds = %17
  br label %83, !dbg !132, !verifier.code !25

24:                                               ; preds = %17
  call void @llvm.dbg.value(metadata i32 2, metadata !133, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %25 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %2), !dbg !134, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %25, metadata !135, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %26 = icmp slt i32 %25, 0, !dbg !136, !verifier.code !25
  br i1 %26, label %27, label %28, !dbg !138, !verifier.code !25

27:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i32 0, metadata !135, metadata !DIExpression()), !dbg !108, !verifier.code !25
  br label %28, !dbg !139, !verifier.code !25

28:                                               ; preds = %27, %24
  %.02 = phi i32 [ 0, %27 ], [ %25, %24 ], !dbg !108, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %.02, metadata !135, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %29 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %3), !dbg !140, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %29, metadata !141, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %30 = icmp slt i32 %29, 0, !dbg !142, !verifier.code !25
  br i1 %30, label %31, label %32, !dbg !144, !verifier.code !25

31:                                               ; preds = %28
  call void @llvm.dbg.value(metadata i32 0, metadata !141, metadata !DIExpression()), !dbg !108, !verifier.code !25
  br label %32, !dbg !145, !verifier.code !25

32:                                               ; preds = %31, %28
  %.01 = phi i32 [ 0, %31 ], [ %29, %28 ], !dbg !108, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %.01, metadata !141, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %33 = call %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %2), !dbg !146, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %33, metadata !147, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %34 = call %struct.DUPFFstruct* @DUPFFcopy(%struct.DUPFFstruct* %3), !dbg !148, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %34, metadata !149, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %35 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.01), !dbg !150, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %35, metadata !151, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %36 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %35, i32 0, i32 2, !dbg !152, !verifier.code !25
  %37 = load i32*, i32** %36, align 8, !dbg !152, !verifier.code !25
  %38 = getelementptr inbounds i32, i32* %37, i64 0, !dbg !153, !verifier.code !25
  store i32 1, i32* %38, align 4, !dbg !154, !verifier.code !25
  %39 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %35, i32 0, i32 1, !dbg !155, !verifier.code !25
  store i32 0, i32* %39, align 4, !dbg !156, !verifier.code !25
  %40 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.02), !dbg !157, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %40, metadata !158, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %41 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.01), !dbg !159, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %41, metadata !160, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %42 = call %struct.DUPFFstruct* @DUPFFnew(i32 %.02), !dbg !161, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %42, metadata !162, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %43 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %42, i32 0, i32 2, !dbg !163, !verifier.code !25
  %44 = load i32*, i32** %43, align 8, !dbg !163, !verifier.code !25
  %45 = getelementptr inbounds i32, i32* %44, i64 0, !dbg !164, !verifier.code !25
  store i32 1, i32* %45, align 4, !dbg !165, !verifier.code !25
  %46 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %42, i32 0, i32 1, !dbg !166, !verifier.code !25
  store i32 0, i32* %46, align 4, !dbg !167, !verifier.code !25
  %47 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !168, !verifier.code !25
  %48 = icmp sgt i32 %47, 0, !dbg !169, !verifier.code !25
  br i1 %48, label %.lr.ph4, label %78, !dbg !170, !verifier.code !25

.lr.ph4:                                          ; preds = %32
  br label %49, !dbg !170, !verifier.code !25

49:                                               ; preds = %.lr.ph4, %75
  %50 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !171, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %50, metadata !173, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %51 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %34, i32 0, i32 2, !dbg !174, !verifier.code !25
  %52 = load i32*, i32** %51, align 8, !dbg !174, !verifier.code !25
  %53 = sext i32 %50 to i64, !dbg !175, !verifier.code !25
  %54 = getelementptr inbounds i32, i32* %52, i64 %53, !dbg !175, !verifier.code !25
  %55 = load i32, i32* %54, align 4, !dbg !175, !verifier.code !25
  %56 = call i32 @FFmul(i32 1, i32 %55), !dbg !176, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %56, metadata !177, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %57 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %33), !dbg !178, !verifier.code !25
  %58 = icmp sge i32 %57, %50, !dbg !179, !verifier.code !25
  br i1 %58, label %.lr.ph, label %75, !dbg !180, !verifier.code !25

.lr.ph:                                           ; preds = %49
  br label %59, !dbg !180, !verifier.code !25

59:                                               ; preds = %.lr.ph, %59
  %60 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %33), !dbg !181, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %60, metadata !183, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %61 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %33, i32 0, i32 2, !dbg !184, !verifier.code !25
  %62 = load i32*, i32** %61, align 8, !dbg !184, !verifier.code !25
  %63 = sext i32 %60 to i64, !dbg !185, !verifier.code !25
  %64 = getelementptr inbounds i32, i32* %62, i64 %63, !dbg !185, !verifier.code !25
  %65 = load i32, i32* %64, align 4, !dbg !185, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %65, metadata !186, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %66 = call i32 @FFmul(i32 %65, i32 %56), !dbg !187, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %66, metadata !188, metadata !DIExpression()), !dbg !108, !verifier.code !25
  %67 = sub nsw i32 %60, %50, !dbg !189, !verifier.code !25
  %68 = sub i32 2, %66, !dbg !190, !verifier.code !25
  call void @DUPFFshift_add(%struct.DUPFFstruct* %33, %struct.DUPFFstruct* %34, i32 %67, i32 %68), !dbg !191, !verifier.code !25
  %69 = sub nsw i32 %60, %50, !dbg !192, !verifier.code !25
  %70 = sub i32 2, %66, !dbg !193, !verifier.code !25
  call void @DUPFFshift_add(%struct.DUPFFstruct* %35, %struct.DUPFFstruct* %41, i32 %69, i32 %70), !dbg !194, !verifier.code !25
  %71 = sub nsw i32 %60, %50, !dbg !195, !verifier.code !25
  %72 = sub i32 2, %66, !dbg !196, !verifier.code !25
  call void @DUPFFshift_add(%struct.DUPFFstruct* %40, %struct.DUPFFstruct* %42, i32 %71, i32 %72), !dbg !197, !verifier.code !25
  %73 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %33), !dbg !178, !verifier.code !25
  %74 = icmp sge i32 %73, %50, !dbg !179, !verifier.code !25
  br i1 %74, label %59, label %._crit_edge, !dbg !180, !llvm.loop !198, !verifier.code !25

._crit_edge:                                      ; preds = %59
  br label %75, !dbg !180, !verifier.code !25

75:                                               ; preds = %._crit_edge, %49
  call void @DUPFFswap(%struct.DUPFFstruct* %33, %struct.DUPFFstruct* %34), !dbg !200, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %35, %struct.DUPFFstruct* %41), !dbg !201, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %40, %struct.DUPFFstruct* %42), !dbg !202, !verifier.code !25
  %76 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !168, !verifier.code !25
  %77 = icmp sgt i32 %76, 0, !dbg !169, !verifier.code !25
  br i1 %77, label %49, label %._crit_edge5, !dbg !170, !llvm.loop !203, !verifier.code !25

._crit_edge5:                                     ; preds = %75
  br label %78, !dbg !170, !verifier.code !25

78:                                               ; preds = %._crit_edge5, %32
  %79 = call i32 @DUPFFdeg(%struct.DUPFFstruct* %34), !dbg !205, !verifier.code !25
  %80 = icmp eq i32 %79, 0, !dbg !207, !verifier.code !25
  br i1 %80, label %81, label %82, !dbg !208, !verifier.code !25

81:                                               ; preds = %78
  call void @DUPFFswap(%struct.DUPFFstruct* %33, %struct.DUPFFstruct* %34), !dbg !209, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %35, %struct.DUPFFstruct* %41), !dbg !211, !verifier.code !25
  call void @DUPFFswap(%struct.DUPFFstruct* %40, %struct.DUPFFstruct* %42), !dbg !212, !verifier.code !25
  br label %82, !dbg !213, !verifier.code !25

82:                                               ; preds = %81, %78
  call void @DUPFFfree(%struct.DUPFFstruct* %41), !dbg !214, !verifier.code !25
  call void @DUPFFfree(%struct.DUPFFstruct* %42), !dbg !215, !verifier.code !25
  call void @DUPFFfree(%struct.DUPFFstruct* %34), !dbg !216, !verifier.code !25
  store %struct.DUPFFstruct* %35, %struct.DUPFFstruct** %0, align 8, !dbg !217, !verifier.code !25
  store %struct.DUPFFstruct* %40, %struct.DUPFFstruct** %1, align 8, !dbg !218, !verifier.code !25
  br label %83, !dbg !219, !verifier.code !25

83:                                               ; preds = %82, %23, %8
  %.0 = phi %struct.DUPFFstruct* [ %9, %8 ], [ %2, %23 ], [ %33, %82 ], !dbg !108, !verifier.code !25
  ret %struct.DUPFFstruct* %.0, !dbg !220, !verifier.code !25
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !221 {
  %1 = alloca %struct.DUPFFstruct*, align 8, !verifier.code !25
  %2 = alloca %struct.DUPFFstruct*, align 8, !verifier.code !25
  call void @llvm.dbg.declare(metadata %struct.DUPFFstruct** %1, metadata !224, metadata !DIExpression()), !dbg !225, !verifier.code !25
  call void @llvm.dbg.declare(metadata %struct.DUPFFstruct** %2, metadata !226, metadata !DIExpression()), !dbg !227, !verifier.code !25
  %3 = call %struct.DUPFFstruct* @DUPFFnew(i32 1), !dbg !228, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %3, metadata !229, metadata !DIExpression()), !dbg !230, !verifier.code !25
  %4 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 2, !dbg !231, !verifier.code !25
  %5 = load i32*, i32** %4, align 8, !dbg !231, !verifier.code !25
  %6 = getelementptr inbounds i32, i32* %5, i64 1, !dbg !232, !verifier.code !25
  store i32 1, i32* %6, align 4, !dbg !233, !verifier.code !25
  %7 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %3, i32 0, i32 1, !dbg !234, !verifier.code !25
  store i32 1, i32* %7, align 4, !dbg !235, !verifier.code !25
  %8 = call %struct.DUPFFstruct* @DUPFFnew(i32 2), !dbg !236, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %8, metadata !237, metadata !DIExpression()), !dbg !230, !verifier.code !25
  %9 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %8, i32 0, i32 2, !dbg !238, !verifier.code !25
  %10 = load i32*, i32** %9, align 8, !dbg !238, !verifier.code !25
  %11 = getelementptr inbounds i32, i32* %10, i64 2, !dbg !239, !verifier.code !25
  store i32 1, i32* %11, align 4, !dbg !240, !verifier.code !25
  %12 = getelementptr inbounds %struct.DUPFFstruct, %struct.DUPFFstruct* %8, i32 0, i32 1, !dbg !241, !verifier.code !25
  store i32 2, i32* %12, align 4, !dbg !242, !verifier.code !25
  %13 = call %struct.DUPFFstruct* @DUPFFexgcd(%struct.DUPFFstruct** %1, %struct.DUPFFstruct** %2, %struct.DUPFFstruct* %3, %struct.DUPFFstruct* %8), !dbg !243, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %13, metadata !244, metadata !DIExpression()), !dbg !230, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.DUPFFstruct* %13, metadata !244, metadata !DIExpression()), !dbg !230, !verifier.code !25
  ret i32 0, !dbg !245, !verifier.code !25
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
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!15}
!llvm.module.flags = !{!16, !17, !18}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/20020406-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !12}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "DUPFF", file: !1, line: 28, baseType: !5)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DUPFFstruct", file: !1, line: 21, size: 128, elements: !7)
!7 = !{!8, !10, !11}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "maxdeg", scope: !6, file: !1, line: 23, baseType: !9, size: 32)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "deg", scope: !6, file: !1, line: 24, baseType: !9, size: 32, offset: 32)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "coeffs", scope: !6, file: !1, line: 25, baseType: !12, size: 64, offset: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "FFelem", file: !1, line: 13, baseType: !14)
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = !{!"clang version 10.0.0-4ubuntu1 "}
!16 = !{i32 7, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = distinct !DISubprogram(name: "reach_error", scope: !1, file: !1, line: 3, type: !20, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DISubroutineType(types: !21)
!21 = !{null}
!22 = !DILocation(line: 3, column: 22, scope: !23)
!23 = distinct !DILexicalBlock(scope: !24, file: !1, line: 3, column: 22)
!24 = distinct !DILexicalBlock(scope: !19, file: !1, line: 3, column: 22)
!25 = !{i1 false}
!26 = distinct !DISubprogram(name: "FFmul", scope: !1, file: !1, line: 15, type: !27, scopeLine: 16, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!13, !29, !29}
!29 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!30 = !DILocalVariable(name: "x", arg: 1, scope: !26, file: !1, line: 15, type: !29)
!31 = !DILocation(line: 0, scope: !26)
!32 = !DILocalVariable(name: "y", arg: 2, scope: !26, file: !1, line: 15, type: !29)
!33 = !DILocation(line: 17, column: 3, scope: !26)
!34 = distinct !DISubprogram(name: "DUPFFdeg", scope: !1, file: !1, line: 31, type: !35, scopeLine: 32, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!9, !37}
!37 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
!38 = !DILocalVariable(name: "f", arg: 1, scope: !34, file: !1, line: 31, type: !37)
!39 = !DILocation(line: 0, scope: !34)
!40 = !DILocation(line: 33, column: 13, scope: !34)
!41 = !DILocation(line: 33, column: 3, scope: !34)
!42 = distinct !DISubprogram(name: "DUPFFnew", scope: !1, file: !1, line: 37, type: !43, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!4, !45}
!45 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !9)
!46 = !DILocalVariable(name: "maxdeg", arg: 1, scope: !42, file: !1, line: 37, type: !45)
!47 = !DILocation(line: 0, scope: !42)
!48 = !DILocation(line: 39, column: 22, scope: !42)
!49 = !DILocation(line: 39, column: 15, scope: !42)
!50 = !DILocalVariable(name: "ans", scope: !42, file: !1, line: 39, type: !4)
!51 = !DILocation(line: 40, column: 8, scope: !42)
!52 = !DILocation(line: 40, column: 15, scope: !42)
!53 = !DILocation(line: 41, column: 14, scope: !54)
!54 = distinct !DILexicalBlock(scope: !42, file: !1, line: 41, column: 7)
!55 = !DILocation(line: 41, column: 7, scope: !42)
!56 = !DILocation(line: 42, column: 42, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 41, column: 20)
!58 = !DILocation(line: 42, column: 35, scope: !57)
!59 = !DILocation(line: 42, column: 45, scope: !57)
!60 = !DILocation(line: 42, column: 28, scope: !57)
!61 = !DILocation(line: 42, column: 19, scope: !57)
!62 = !DILocation(line: 42, column: 10, scope: !57)
!63 = !DILocation(line: 42, column: 17, scope: !57)
!64 = !DILocation(line: 43, column: 17, scope: !57)
!65 = !DILocation(line: 43, column: 5, scope: !57)
!66 = !DILocation(line: 43, column: 35, scope: !57)
!67 = !DILocation(line: 43, column: 28, scope: !57)
!68 = !DILocation(line: 43, column: 38, scope: !57)
!69 = !DILocation(line: 44, column: 3, scope: !57)
!70 = !DILocation(line: 45, column: 8, scope: !42)
!71 = !DILocation(line: 45, column: 15, scope: !42)
!72 = !DILocation(line: 46, column: 8, scope: !42)
!73 = !DILocation(line: 46, column: 12, scope: !42)
!74 = !DILocation(line: 47, column: 3, scope: !42)
!75 = distinct !DISubprogram(name: "DUPFFfree", scope: !1, file: !1, line: 50, type: !76, scopeLine: 51, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!76 = !DISubroutineType(types: !77)
!77 = !{null, !4}
!78 = !DILocalVariable(name: "x", arg: 1, scope: !75, file: !1, line: 50, type: !4)
!79 = !DILocation(line: 0, scope: !75)
!80 = !DILocation(line: 52, column: 1, scope: !75)
!81 = distinct !DISubprogram(name: "DUPFFswap", scope: !1, file: !1, line: 54, type: !82, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!82 = !DISubroutineType(types: !83)
!83 = !{null, !4, !4}
!84 = !DILocalVariable(name: "x", arg: 1, scope: !81, file: !1, line: 54, type: !4)
!85 = !DILocation(line: 0, scope: !81)
!86 = !DILocalVariable(name: "y", arg: 2, scope: !81, file: !1, line: 54, type: !4)
!87 = !DILocation(line: 56, column: 1, scope: !81)
!88 = distinct !DISubprogram(name: "DUPFFcopy", scope: !1, file: !1, line: 59, type: !89, scopeLine: 60, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!89 = !DISubroutineType(types: !90)
!90 = !{!4, !37}
!91 = !DILocalVariable(name: "x", arg: 1, scope: !88, file: !1, line: 59, type: !37)
!92 = !DILocation(line: 0, scope: !88)
!93 = !DILocation(line: 61, column: 3, scope: !88)
!94 = distinct !DISubprogram(name: "DUPFFshift_add", scope: !1, file: !1, line: 65, type: !95, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!95 = !DISubroutineType(types: !96)
!96 = !{null, !4, !37, !9, !29}
!97 = !DILocalVariable(name: "f", arg: 1, scope: !94, file: !1, line: 65, type: !4)
!98 = !DILocation(line: 0, scope: !94)
!99 = !DILocalVariable(name: "g", arg: 2, scope: !94, file: !1, line: 65, type: !37)
!100 = !DILocalVariable(name: "deg", arg: 3, scope: !94, file: !1, line: 65, type: !9)
!101 = !DILocalVariable(name: "coeff", arg: 4, scope: !94, file: !1, line: 65, type: !29)
!102 = !DILocation(line: 67, column: 1, scope: !94)
!103 = distinct !DISubprogram(name: "DUPFFexgcd", scope: !1, file: !1, line: 70, type: !104, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!104 = !DISubroutineType(types: !105)
!105 = !{!4, !106, !106, !37, !37}
!106 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!107 = !DILocalVariable(name: "fcofac", arg: 1, scope: !103, file: !1, line: 70, type: !106)
!108 = !DILocation(line: 0, scope: !103)
!109 = !DILocalVariable(name: "gcofac", arg: 2, scope: !103, file: !1, line: 70, type: !106)
!110 = !DILocalVariable(name: "f", arg: 3, scope: !103, file: !1, line: 70, type: !37)
!111 = !DILocalVariable(name: "g", arg: 4, scope: !103, file: !1, line: 70, type: !37)
!112 = !DILocation(line: 76, column: 7, scope: !113)
!113 = distinct !DILexicalBlock(scope: !103, file: !1, line: 76, column: 7)
!114 = !DILocation(line: 76, column: 21, scope: !113)
!115 = !DILocation(line: 76, column: 19, scope: !113)
!116 = !DILocation(line: 76, column: 7, scope: !103)
!117 = !DILocation(line: 76, column: 41, scope: !113)
!118 = !DILocation(line: 76, column: 34, scope: !113)
!119 = !DILocation(line: 77, column: 7, scope: !120)
!120 = distinct !DILexicalBlock(scope: !103, file: !1, line: 77, column: 7)
!121 = !DILocation(line: 77, column: 19, scope: !120)
!122 = !DILocation(line: 77, column: 24, scope: !120)
!123 = !DILocation(line: 77, column: 27, scope: !120)
!124 = !DILocation(line: 77, column: 39, scope: !120)
!125 = !DILocation(line: 77, column: 7, scope: !103)
!126 = !DILocation(line: 77, column: 45, scope: !120)
!127 = !DILocation(line: 78, column: 10, scope: !128)
!128 = distinct !DILexicalBlock(scope: !103, file: !1, line: 78, column: 7)
!129 = !DILocation(line: 78, column: 7, scope: !128)
!130 = !DILocation(line: 78, column: 20, scope: !128)
!131 = !DILocation(line: 78, column: 7, scope: !103)
!132 = !DILocation(line: 78, column: 26, scope: !128)
!133 = !DILocalVariable(name: "p", scope: !103, file: !1, line: 73, type: !13)
!134 = !DILocation(line: 81, column: 8, scope: !103)
!135 = !DILocalVariable(name: "df", scope: !103, file: !1, line: 74, type: !9)
!136 = !DILocation(line: 81, column: 29, scope: !137)
!137 = distinct !DILexicalBlock(scope: !103, file: !1, line: 81, column: 26)
!138 = !DILocation(line: 81, column: 26, scope: !103)
!139 = !DILocation(line: 81, column: 34, scope: !137)
!140 = !DILocation(line: 82, column: 8, scope: !103)
!141 = !DILocalVariable(name: "dg", scope: !103, file: !1, line: 74, type: !9)
!142 = !DILocation(line: 82, column: 29, scope: !143)
!143 = distinct !DILexicalBlock(scope: !103, file: !1, line: 82, column: 26)
!144 = !DILocation(line: 82, column: 26, scope: !103)
!145 = !DILocation(line: 82, column: 34, scope: !143)
!146 = !DILocation(line: 83, column: 7, scope: !103)
!147 = !DILocalVariable(name: "u", scope: !103, file: !1, line: 72, type: !4)
!148 = !DILocation(line: 84, column: 7, scope: !103)
!149 = !DILocalVariable(name: "v", scope: !103, file: !1, line: 72, type: !4)
!150 = !DILocation(line: 86, column: 8, scope: !103)
!151 = !DILocalVariable(name: "uf", scope: !103, file: !1, line: 72, type: !4)
!152 = !DILocation(line: 86, column: 26, scope: !103)
!153 = !DILocation(line: 86, column: 22, scope: !103)
!154 = !DILocation(line: 86, column: 36, scope: !103)
!155 = !DILocation(line: 86, column: 45, scope: !103)
!156 = !DILocation(line: 86, column: 49, scope: !103)
!157 = !DILocation(line: 87, column: 8, scope: !103)
!158 = !DILocalVariable(name: "ug", scope: !103, file: !1, line: 72, type: !4)
!159 = !DILocation(line: 88, column: 8, scope: !103)
!160 = !DILocalVariable(name: "vf", scope: !103, file: !1, line: 72, type: !4)
!161 = !DILocation(line: 89, column: 8, scope: !103)
!162 = !DILocalVariable(name: "vg", scope: !103, file: !1, line: 72, type: !4)
!163 = !DILocation(line: 89, column: 26, scope: !103)
!164 = !DILocation(line: 89, column: 22, scope: !103)
!165 = !DILocation(line: 89, column: 36, scope: !103)
!166 = !DILocation(line: 89, column: 45, scope: !103)
!167 = !DILocation(line: 89, column: 49, scope: !103)
!168 = !DILocation(line: 91, column: 10, scope: !103)
!169 = !DILocation(line: 91, column: 22, scope: !103)
!170 = !DILocation(line: 91, column: 3, scope: !103)
!171 = !DILocation(line: 93, column: 10, scope: !172)
!172 = distinct !DILexicalBlock(scope: !103, file: !1, line: 92, column: 3)
!173 = !DILocalVariable(name: "dv", scope: !103, file: !1, line: 74, type: !9)
!174 = !DILocation(line: 94, column: 28, scope: !172)
!175 = !DILocation(line: 94, column: 25, scope: !172)
!176 = !DILocation(line: 94, column: 16, scope: !172)
!177 = !DILocalVariable(name: "lcvrecip", scope: !103, file: !1, line: 73, type: !13)
!178 = !DILocation(line: 95, column: 12, scope: !172)
!179 = !DILocation(line: 95, column: 24, scope: !172)
!180 = !DILocation(line: 95, column: 5, scope: !172)
!181 = !DILocation(line: 97, column: 12, scope: !182)
!182 = distinct !DILexicalBlock(scope: !172, file: !1, line: 96, column: 5)
!183 = !DILocalVariable(name: "du", scope: !103, file: !1, line: 74, type: !9)
!184 = !DILocation(line: 98, column: 16, scope: !182)
!185 = !DILocation(line: 98, column: 13, scope: !182)
!186 = !DILocalVariable(name: "lcu", scope: !103, file: !1, line: 73, type: !13)
!187 = !DILocation(line: 99, column: 11, scope: !182)
!188 = !DILocalVariable(name: "q", scope: !103, file: !1, line: 73, type: !13)
!189 = !DILocation(line: 100, column: 30, scope: !182)
!190 = !DILocation(line: 100, column: 36, scope: !182)
!191 = !DILocation(line: 100, column: 7, scope: !182)
!192 = !DILocation(line: 101, column: 32, scope: !182)
!193 = !DILocation(line: 101, column: 38, scope: !182)
!194 = !DILocation(line: 101, column: 7, scope: !182)
!195 = !DILocation(line: 102, column: 32, scope: !182)
!196 = !DILocation(line: 102, column: 38, scope: !182)
!197 = !DILocation(line: 102, column: 7, scope: !182)
!198 = distinct !{!198, !180, !199}
!199 = !DILocation(line: 103, column: 5, scope: !172)
!200 = !DILocation(line: 104, column: 5, scope: !172)
!201 = !DILocation(line: 105, column: 5, scope: !172)
!202 = !DILocation(line: 106, column: 5, scope: !172)
!203 = distinct !{!203, !170, !204}
!204 = !DILocation(line: 107, column: 3, scope: !103)
!205 = !DILocation(line: 108, column: 7, scope: !206)
!206 = distinct !DILexicalBlock(scope: !103, file: !1, line: 108, column: 7)
!207 = !DILocation(line: 108, column: 19, scope: !206)
!208 = !DILocation(line: 108, column: 7, scope: !103)
!209 = !DILocation(line: 110, column: 5, scope: !210)
!210 = distinct !DILexicalBlock(scope: !206, file: !1, line: 109, column: 3)
!211 = !DILocation(line: 111, column: 5, scope: !210)
!212 = !DILocation(line: 112, column: 5, scope: !210)
!213 = !DILocation(line: 113, column: 3, scope: !210)
!214 = !DILocation(line: 114, column: 3, scope: !103)
!215 = !DILocation(line: 115, column: 3, scope: !103)
!216 = !DILocation(line: 116, column: 3, scope: !103)
!217 = !DILocation(line: 117, column: 11, scope: !103)
!218 = !DILocation(line: 118, column: 11, scope: !103)
!219 = !DILocation(line: 119, column: 3, scope: !103)
!220 = !DILocation(line: 120, column: 1, scope: !103)
!221 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 124, type: !222, scopeLine: 125, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!222 = !DISubroutineType(types: !223)
!223 = !{!9}
!224 = !DILocalVariable(name: "cf", scope: !221, file: !1, line: 126, type: !4)
!225 = !DILocation(line: 126, column: 15, scope: !221)
!226 = !DILocalVariable(name: "cg", scope: !221, file: !1, line: 126, type: !4)
!227 = !DILocation(line: 126, column: 19, scope: !221)
!228 = !DILocation(line: 127, column: 7, scope: !221)
!229 = !DILocalVariable(name: "f", scope: !221, file: !1, line: 126, type: !4)
!230 = !DILocation(line: 0, scope: !221)
!231 = !DILocation(line: 127, column: 23, scope: !221)
!232 = !DILocation(line: 127, column: 20, scope: !221)
!233 = !DILocation(line: 127, column: 33, scope: !221)
!234 = !DILocation(line: 127, column: 41, scope: !221)
!235 = !DILocation(line: 127, column: 45, scope: !221)
!236 = !DILocation(line: 128, column: 7, scope: !221)
!237 = !DILocalVariable(name: "g", scope: !221, file: !1, line: 126, type: !4)
!238 = !DILocation(line: 128, column: 23, scope: !221)
!239 = !DILocation(line: 128, column: 20, scope: !221)
!240 = !DILocation(line: 128, column: 33, scope: !221)
!241 = !DILocation(line: 128, column: 41, scope: !221)
!242 = !DILocation(line: 128, column: 45, scope: !221)
!243 = !DILocation(line: 130, column: 7, scope: !221)
!244 = !DILocalVariable(name: "h", scope: !221, file: !1, line: 126, type: !4)
!245 = !DILocation(line: 132, column: 3, scope: !221)
