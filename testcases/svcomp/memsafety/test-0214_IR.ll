; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-vfe1l_r_.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.anon = type { [2 x i8*], [257 x i8] }

@main.list = internal global [2 x i8*] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal i32 @is_empty([2 x i8*]* %0) #0 !dbg !30 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !37
  %2 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !38, !verifier.code !37
  %3 = load i8*, i8** %2, align 8, !dbg !38, !verifier.code !37
  %4 = icmp ne i8* %3, null, !dbg !39, !verifier.code !37
  %5 = xor i1 %4, true, !dbg !39, !verifier.code !37
  %6 = zext i1 %5 to i32, !dbg !39, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %6, metadata !40, metadata !DIExpression()), !dbg !36, !verifier.code !37
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !41, !verifier.code !37
  %8 = load i8*, i8** %7, align 8, !dbg !41, !verifier.code !37
  %9 = icmp ne i8* %8, null, !dbg !42, !verifier.code !37
  %10 = xor i1 %9, true, !dbg !42, !verifier.code !37
  %11 = zext i1 %10 to i32, !dbg !42, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %11, metadata !43, metadata !DIExpression()), !dbg !36, !verifier.code !37
  %12 = icmp ne i32 %6, %11, !dbg !44, !verifier.code !37
  br i1 %12, label %13, label %15, !dbg !46, !verifier.code !37

13:                                               ; preds = %1
  %14 = bitcast [2 x i8*]* %0 to i8*, !dbg !47, !verifier.code !37
  call void @free(i8* %14) #6, !dbg !48, !verifier.code !37
  br label %15, !dbg !48, !verifier.code !37

15:                                               ; preds = %13, %1
  ret i32 %6, !dbg !49, !verifier.code !37
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal [2 x i8*]* @create_item(i32 %0, [2 x i8*]* %1) #0 !dbg !50 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !57, metadata !DIExpression()), !dbg !58, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %1, metadata !59, metadata !DIExpression()), !dbg !58, !verifier.code !37
  %3 = call noalias i8* @malloc(i64 280) #6, !dbg !60, !verifier.code !37
  %4 = bitcast i8* %3 to %struct.anon*, !dbg !60, !verifier.code !37
  call void @llvm.dbg.value(metadata %struct.anon* %4, metadata !61, metadata !DIExpression()), !dbg !58, !verifier.code !37
  %5 = icmp ne %struct.anon* %4, null, !dbg !72, !verifier.code !37
  br i1 %5, label %7, label %6, !dbg !74, !verifier.code !37

6:                                                ; preds = %2
  call void @abort() #7, !dbg !75, !verifier.code !37
  unreachable, !dbg !75, !verifier.code !37

7:                                                ; preds = %2
  br label %NodeBlock, !verifier.code !37

NodeBlock:                                        ; preds = %7
  %Pivot = icmp slt i32 %0, 1, !verifier.code !37
  br i1 %Pivot, label %LeafBlock, label %LeafBlock1, !verifier.code !37

LeafBlock1:                                       ; preds = %NodeBlock
  %SwitchLeaf2 = icmp eq i32 %0, 1, !verifier.code !37
  br i1 %SwitchLeaf2, label %9, label %NewDefault, !verifier.code !37

LeafBlock:                                        ; preds = %NodeBlock
  %SwitchLeaf = icmp eq i32 %0, 0, !verifier.code !37
  br i1 %SwitchLeaf, label %8, label %NewDefault, !verifier.code !37

8:                                                ; preds = %LeafBlock
  call void @llvm.dbg.value(metadata i32 1, metadata !76, metadata !DIExpression()), !dbg !58, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 0, metadata !78, metadata !DIExpression()), !dbg !58, !verifier.code !37
  br label %10, !dbg !79, !verifier.code !37

9:                                                ; preds = %LeafBlock1
  call void @llvm.dbg.value(metadata i32 0, metadata !76, metadata !DIExpression()), !dbg !58, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 1, metadata !78, metadata !DIExpression()), !dbg !58, !verifier.code !37
  br label %10, !dbg !81, !verifier.code !37

NewDefault:                                       ; preds = %LeafBlock1, %LeafBlock
  br label %10, !verifier.code !37

10:                                               ; preds = %NewDefault, %9, %8
  %.03 = phi i32 [ 0, %8 ], [ undef, %NewDefault ], [ 1, %9 ], !verifier.code !37
  %.0 = phi i32 [ 1, %8 ], [ undef, %NewDefault ], [ 0, %9 ], !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %.0, metadata !76, metadata !DIExpression()), !dbg !58, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %.03, metadata !78, metadata !DIExpression()), !dbg !58, !verifier.code !37
  %11 = bitcast [2 x i8*]* %1 to i8*, !dbg !82, !verifier.code !37
  %12 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !83, !verifier.code !37
  %13 = zext i32 %.0 to i64, !dbg !84, !verifier.code !37
  %14 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, i64 %13
  store i8* %11, i8** %14, align 8, !dbg !85, !verifier.code !37
  %15 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !86, !verifier.code !37
  %16 = zext i32 %.03 to i64, !dbg !87, !verifier.code !37
  %17 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, i64 %16
  store i8* null, i8** %17, align 8, !dbg !88, !verifier.code !37
  %18 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 1, !dbg !89, !verifier.code !37
  %19 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 1, i64 0
  store i8 0, i8* %19, align 8, !dbg !90, !verifier.code !37
  %20 = getelementptr inbounds %struct.anon, %struct.anon* %4, i32 0, i32 0, !dbg !91, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %20, metadata !92, metadata !DIExpression()), !dbg !58, !verifier.code !37
  %21 = icmp ne [2 x i8*]* %1, null, !dbg !93, !verifier.code !37
  br i1 %21, label %22, label %26, !dbg !95, !verifier.code !37

22:                                               ; preds = %10
  %23 = bitcast [2 x i8*]* %20 to i8*, !dbg !96, !verifier.code !37
  %24 = zext i32 %.03 to i64, !dbg !97, !verifier.code !37
  %25 = getelementptr inbounds [2 x i8*], [2 x i8*]* %1, i64 0, i64 %24, !dbg !97, !verifier.code !37
  store i8* %23, i8** %25, align 8, !dbg !98, !verifier.code !37
  br label %26, !dbg !97, !verifier.code !37

26:                                               ; preds = %22, %10
  ret [2 x i8*]* %20, !dbg !99, !verifier.code !37
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #3

; Function Attrs: noinline nounwind uwtable
define internal void @append_one([2 x i8*]* %0, i32 %1) #0 !dbg !100 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !103, metadata !DIExpression()), !dbg !104, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %1, metadata !105, metadata !DIExpression()), !dbg !104, !verifier.code !37
  %3 = zext i32 %1 to i64, !dbg !106, !verifier.code !37
  %4 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %3, !dbg !106, !verifier.code !37
  %5 = load i8*, i8** %4, align 8, !dbg !106, !verifier.code !37
  %6 = bitcast i8* %5 to [2 x i8*]*, !dbg !106, !verifier.code !37
  %7 = call [2 x i8*]* @create_item(i32 %1, [2 x i8*]* %6), !dbg !107, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %7, metadata !108, metadata !DIExpression()), !dbg !104, !verifier.code !37
  %8 = bitcast [2 x i8*]* %7 to i8*, !dbg !109, !verifier.code !37
  %9 = zext i32 %1 to i64, !dbg !110, !verifier.code !37
  %10 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %9, !dbg !110, !verifier.code !37
  store i8* %8, i8** %10, align 8, !dbg !111, !verifier.code !37
  %11 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !112, !verifier.code !37
  %12 = load i8*, i8** %11, align 8, !dbg !112, !verifier.code !37
  %13 = icmp eq i8* null, %12, !dbg !114, !verifier.code !37
  br i1 %13, label %14, label %17, !dbg !115, !verifier.code !37

14:                                               ; preds = %2
  %15 = bitcast [2 x i8*]* %7 to i8*, !dbg !116, !verifier.code !37
  %16 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !117, !verifier.code !37
  store i8* %15, i8** %16, align 8, !dbg !118, !verifier.code !37
  br label %17, !dbg !117, !verifier.code !37

17:                                               ; preds = %14, %2
  %18 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !119, !verifier.code !37
  %19 = load i8*, i8** %18, align 8, !dbg !119, !verifier.code !37
  %20 = icmp eq i8* null, %19, !dbg !121, !verifier.code !37
  br i1 %20, label %21, label %24, !dbg !122, !verifier.code !37

21:                                               ; preds = %17
  %22 = bitcast [2 x i8*]* %7 to i8*, !dbg !123, !verifier.code !37
  %23 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !124, !verifier.code !37
  store i8* %22, i8** %23, align 8, !dbg !125, !verifier.code !37
  br label %24, !dbg !124, !verifier.code !37

24:                                               ; preds = %21, %17
  ret void, !dbg !126, !verifier.code !37
}

; Function Attrs: noinline nounwind uwtable
define internal void @remove_one([2 x i8*]* %0, i32 %1) #0 !dbg !127 {
  call void @llvm.dbg.value(metadata [2 x i8*]* %0, metadata !128, metadata !DIExpression()), !dbg !129, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %1, metadata !130, metadata !DIExpression()), !dbg !129, !verifier.code !37
  %3 = call i32 @is_empty([2 x i8*]* %0), !dbg !131, !verifier.code !37
  %4 = icmp ne i32 %3, 0, !dbg !131, !verifier.code !37
  br i1 %4, label %5, label %6, !dbg !133, !verifier.code !37

5:                                                ; preds = %2
  br label %36, !dbg !134, !verifier.code !37

6:                                                ; preds = %2
  %7 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !135, !verifier.code !37
  %8 = load i8*, i8** %7, align 8, !dbg !135, !verifier.code !37
  %9 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 1, !dbg !137, !verifier.code !37
  %10 = load i8*, i8** %9, align 8, !dbg !137, !verifier.code !37
  %11 = icmp eq i8* %8, %10, !dbg !138, !verifier.code !37
  br i1 %11, label %12, label %17, !dbg !139, !verifier.code !37

12:                                               ; preds = %6
  %13 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !140, !verifier.code !37
  %14 = load i8*, i8** %13, align 8, !dbg !140, !verifier.code !37
  call void @free(i8* %14) #6, !dbg !142, !verifier.code !37
  %15 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 0, !dbg !143, !verifier.code !37
  %16 = bitcast i8** %15 to i8*, !dbg !143, !verifier.code !37
  call void @llvm.memset.p0i8.i64(i8* align 8 %16, i8 0, i64 16, i1 false), !dbg !143, !verifier.code !37
  br label %36, !dbg !144, !verifier.code !37

17:                                               ; preds = %6
  %18 = icmp eq i32 0, %1, !dbg !145, !verifier.code !37
  %19 = select i1 %18, i32 1, i32 0, !dbg !146, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %19, metadata !147, metadata !DIExpression()), !dbg !129, !verifier.code !37
  %20 = icmp eq i32 1, %1, !dbg !149, !verifier.code !37
  %21 = select i1 %20, i32 1, i32 0, !dbg !150, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %21, metadata !151, metadata !DIExpression()), !dbg !129, !verifier.code !37
  %22 = zext i32 %1 to i64, !dbg !152, !verifier.code !37
  %23 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %22, !dbg !152, !verifier.code !37
  %24 = load i8*, i8** %23, align 8, !dbg !152, !verifier.code !37
  %25 = bitcast i8* %24 to [2 x i8*]*, !dbg !152, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %25, metadata !153, metadata !DIExpression()), !dbg !129, !verifier.code !37
  %26 = zext i32 %19 to i64, !dbg !154, !verifier.code !37
  %27 = getelementptr inbounds [2 x i8*], [2 x i8*]* %25, i64 0, i64 %26, !dbg !154, !verifier.code !37
  %28 = load i8*, i8** %27, align 8, !dbg !154, !verifier.code !37
  %29 = bitcast i8* %28 to [2 x i8*]*, !dbg !154, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %29, metadata !155, metadata !DIExpression()), !dbg !129, !verifier.code !37
  %30 = zext i32 %21 to i64, !dbg !156, !verifier.code !37
  %31 = getelementptr inbounds [2 x i8*], [2 x i8*]* %29, i64 0, i64 %30, !dbg !156, !verifier.code !37
  store i8* null, i8** %31, align 8, !dbg !157, !verifier.code !37
  %32 = bitcast [2 x i8*]* %29 to i8*, !dbg !158, !verifier.code !37
  %33 = zext i32 %1 to i64, !dbg !159, !verifier.code !37
  %34 = getelementptr inbounds [2 x i8*], [2 x i8*]* %0, i64 0, i64 %33, !dbg !159, !verifier.code !37
  store i8* %32, i8** %34, align 8, !dbg !160, !verifier.code !37
  %35 = bitcast [2 x i8*]* %25 to i8*, !dbg !161, !verifier.code !37
  call void @free(i8* %35) #6, !dbg !162, !verifier.code !37
  br label %36, !dbg !163, !verifier.code !37

36:                                               ; preds = %17, %12, %5
  ret void, !dbg !163, !verifier.code !37
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal i32 @rand_end_point() #0 !dbg !164 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !167, !verifier.code !169
  %2 = icmp ne i32 %1, 0, !dbg !167, !verifier.code !37
  br i1 %2, label %3, label %4, !dbg !170, !verifier.code !37

3:                                                ; preds = %0
  br label %5, !dbg !171, !verifier.code !37

4:                                                ; preds = %0
  br label %5, !dbg !172, !verifier.code !37

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ 0, %3 ], [ 1, %4 ], !dbg !173, !verifier.code !37
  ret i32 %.0, !dbg !174, !verifier.code !37
}

declare dso_local i32 @__VERIFIER_nondet_int() #5

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !175, !verifier.code !169
  %2 = icmp ne i32 %1, 0, !dbg !176, !verifier.code !37
  br i1 %2, label %.lr.ph11, label %20, !dbg !176, !verifier.code !37

.lr.ph11:                                         ; preds = %0
  br label %3, !dbg !176, !verifier.code !37

3:                                                ; preds = %.lr.ph11, %17
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !177, !verifier.code !169
  %5 = icmp ne i32 %4, 0, !dbg !179, !verifier.code !37
  br i1 %5, label %.lr.ph5, label %10, !dbg !179, !verifier.code !37

.lr.ph5:                                          ; preds = %3
  br label %6, !dbg !179, !verifier.code !37

6:                                                ; preds = %.lr.ph5, %6
  %7 = call i32 @rand_end_point(), !dbg !180, !verifier.code !37
  call void @append_one([2 x i8*]* @main.list, i32 %7), !dbg !181, !verifier.code !37
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !177, !verifier.code !169
  %9 = icmp ne i32 %8, 0, !dbg !179, !verifier.code !37
  br i1 %9, label %6, label %._crit_edge6, !dbg !179, !llvm.loop !182, !verifier.code !37

._crit_edge6:                                     ; preds = %6
  br label %10, !dbg !179, !verifier.code !37

10:                                               ; preds = %._crit_edge6, %3
  %11 = call i32 @__VERIFIER_nondet_int(), !dbg !184, !verifier.code !169
  %12 = icmp ne i32 %11, 0, !dbg !185, !verifier.code !37
  br i1 %12, label %.lr.ph8, label %17, !dbg !185, !verifier.code !37

.lr.ph8:                                          ; preds = %10
  br label %13, !dbg !185, !verifier.code !37

13:                                               ; preds = %.lr.ph8, %13
  %14 = call i32 @rand_end_point(), !dbg !186, !verifier.code !37
  call void @remove_one([2 x i8*]* @main.list, i32 %14), !dbg !187, !verifier.code !37
  %15 = call i32 @__VERIFIER_nondet_int(), !dbg !184, !verifier.code !169
  %16 = icmp ne i32 %15, 0, !dbg !185, !verifier.code !37
  br i1 %16, label %13, label %._crit_edge9, !dbg !185, !llvm.loop !188, !verifier.code !37

._crit_edge9:                                     ; preds = %13
  br label %17, !dbg !185, !verifier.code !37

17:                                               ; preds = %._crit_edge9, %10
  %18 = call i32 @__VERIFIER_nondet_int(), !dbg !175, !verifier.code !169
  %19 = icmp ne i32 %18, 0, !dbg !176, !verifier.code !37
  br i1 %19, label %3, label %._crit_edge12, !dbg !176, !llvm.loop !190, !verifier.code !37

._crit_edge12:                                    ; preds = %17
  br label %20, !dbg !176, !verifier.code !37

20:                                               ; preds = %._crit_edge12, %0
  %21 = call i32 @__VERIFIER_nondet_int(), !dbg !192, !verifier.code !169
  %22 = icmp ne i32 %21, 0, !dbg !192, !verifier.code !37
  br i1 %22, label %23, label %24, !dbg !194, !verifier.code !37

23:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i32 0, metadata !195, metadata !DIExpression()), !dbg !196, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 1, metadata !197, metadata !DIExpression()), !dbg !196, !verifier.code !37
  br label %25, !dbg !198, !verifier.code !37

24:                                               ; preds = %20
  call void @llvm.dbg.value(metadata i32 1, metadata !195, metadata !DIExpression()), !dbg !196, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 0, metadata !197, metadata !DIExpression()), !dbg !196, !verifier.code !37
  br label %25, !verifier.code !37

25:                                               ; preds = %24, %23
  %.02 = phi i32 [ 1, %23 ], [ 0, %24 ], !dbg !200, !verifier.code !37
  %.01 = phi i32 [ 0, %23 ], [ 1, %24 ], !dbg !200, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %.01, metadata !195, metadata !DIExpression()), !dbg !196, !verifier.code !37
  call void @llvm.dbg.value(metadata i32 %.02, metadata !197, metadata !DIExpression()), !dbg !196, !verifier.code !37
  %26 = zext i32 %.01 to i64, !dbg !201, !verifier.code !37
  %27 = getelementptr inbounds [2 x i8*], [2 x i8*]* @main.list, i64 0, i64 %26, !dbg !201, !verifier.code !37
  %28 = load i8*, i8** %27, align 8, !dbg !201, !verifier.code !37
  %29 = bitcast i8* %28 to [2 x i8*]*, !dbg !201, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %29, metadata !202, metadata !DIExpression()), !dbg !196, !verifier.code !37
  %30 = icmp ne [2 x i8*]* %29, null, !dbg !203, !verifier.code !37
  br i1 %30, label %.lr.ph, label %38, !dbg !203, !verifier.code !37

.lr.ph:                                           ; preds = %25
  br label %31, !dbg !203, !verifier.code !37

31:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi [2 x i8*]* [ %29, %.lr.ph ], [ %35, %forwarder ], !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %.03, metadata !202, metadata !DIExpression()), !dbg !196, !verifier.code !37
  %32 = zext i32 %.02 to i64, !dbg !204, !verifier.code !37
  %33 = getelementptr inbounds [2 x i8*], [2 x i8*]* %.03, i64 0, i64 %32, !dbg !204, !verifier.code !37
  %34 = load i8*, i8** %33, align 8, !dbg !204, !verifier.code !37
  %35 = bitcast i8* %34 to [2 x i8*]*, !dbg !204, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %35, metadata !206, metadata !DIExpression()), !dbg !207, !verifier.code !37
  %36 = bitcast [2 x i8*]* %.03 to i8*, !dbg !208, !verifier.code !37
  call void @free(i8* %36) #6, !dbg !209, !verifier.code !37
  call void @llvm.dbg.value(metadata [2 x i8*]* %35, metadata !202, metadata !DIExpression()), !dbg !196, !verifier.code !37
  %37 = icmp ne [2 x i8*]* %35, null, !dbg !203, !verifier.code !37
  br i1 %37, label %forwarder, label %._crit_edge, !dbg !203, !llvm.loop !210, !verifier.code !37

._crit_edge:                                      ; preds = %31
  br label %38, !dbg !203, !verifier.code !37

38:                                               ; preds = %._crit_edge, %25
  ret i32 0, !dbg !212, !verifier.code !37

forwarder:                                        ; preds = %31
  br label %31, !verifier.code !37
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  store i8* null, i8** getelementptr inbounds ([2 x i8*], [2 x i8*]* @main.list, i32 0, i64 0)
  store i8* null, i8** getelementptr inbounds ([2 x i8*], [2 x i8*]* @main.list, i32 0, i64 1)
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!26}
!llvm.module.flags = !{!27, !28, !29}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 118, type: !22, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 116, type: !4, scopeLine: 117, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !21)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0214.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, retainedTypes: !18, globals: !20, splitDebugInlining: false, nameTableKind: None)
!8 = !{!9, !14}
!9 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 12, baseType: !10, size: 32, elements: !11)
!10 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!11 = !{!12, !13}
!12 = !DIEnumerator(name: "LIST_BEG", value: 0, isUnsigned: true)
!13 = !DIEnumerator(name: "LIST_END", value: 1, isUnsigned: true)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !3, line: 19, baseType: !10, size: 32, elements: !15)
!15 = !{!16, !17}
!16 = !DIEnumerator(name: "ITEM_PREV", value: 0, isUnsigned: true)
!17 = !DIEnumerator(name: "ITEM_NEXT", value: 1, isUnsigned: true)
!18 = !{!19}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!20 = !{!0}
!21 = !{}
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "list_t", file: !3, line: 10, baseType: !23)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !19, size: 128, elements: !24)
!24 = !{!25}
!25 = !DISubrange(count: 2)
!26 = !{!"clang version 10.0.0-4ubuntu1 "}
!27 = !{i32 7, !"Dwarf Version", i32 4}
!28 = !{i32 2, !"Debug Info Version", i32 3}
!29 = !{i32 1, !"wchar_size", i32 4}
!30 = distinct !DISubprogram(name: "is_empty", scope: !3, file: !3, line: 29, type: !31, scopeLine: 30, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !21)
!31 = !DISubroutineType(types: !32)
!32 = !{!6, !33}
!33 = !DIDerivedType(tag: DW_TAG_typedef, name: "list_p", file: !3, line: 11, baseType: !34)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!35 = !DILocalVariable(name: "list", arg: 1, scope: !30, file: !3, line: 29, type: !33)
!36 = !DILocation(line: 0, scope: !30)
!37 = !{i1 false}
!38 = !DILocation(line: 31, column: 19, scope: !30)
!39 = !DILocation(line: 31, column: 18, scope: !30)
!40 = !DILocalVariable(name: "no_beg", scope: !30, file: !3, line: 31, type: !6)
!41 = !DILocation(line: 32, column: 19, scope: !30)
!42 = !DILocation(line: 32, column: 18, scope: !30)
!43 = !DILocalVariable(name: "no_end", scope: !30, file: !3, line: 32, type: !6)
!44 = !DILocation(line: 34, column: 16, scope: !45)
!45 = distinct !DILexicalBlock(scope: !30, file: !3, line: 34, column: 9)
!46 = !DILocation(line: 34, column: 9, scope: !30)
!47 = !DILocation(line: 36, column: 14, scope: !45)
!48 = !DILocation(line: 36, column: 9, scope: !45)
!49 = !DILocation(line: 38, column: 5, scope: !30)
!50 = distinct !DISubprogram(name: "create_item", scope: !3, file: !3, line: 41, type: !51, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !21)
!51 = !DISubroutineType(types: !52)
!52 = !{!53, !56, !53}
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "item_p", file: !3, line: 18, baseType: !54)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "item_t", file: !3, line: 17, baseType: !23)
!56 = !DIDerivedType(tag: DW_TAG_typedef, name: "end_point_t", file: !3, line: 15, baseType: !9)
!57 = !DILocalVariable(name: "at", arg: 1, scope: !50, file: !3, line: 41, type: !56)
!58 = !DILocation(line: 0, scope: !50)
!59 = !DILocalVariable(name: "link", arg: 2, scope: !50, file: !3, line: 41, type: !53)
!60 = !DILocation(line: 43, column: 24, scope: !50)
!61 = !DILocalVariable(name: "item", scope: !50, file: !3, line: 43, type: !62)
!62 = !DIDerivedType(tag: DW_TAG_typedef, name: "user_item_p", file: !3, line: 27, baseType: !63)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 24, size: 2240, elements: !65)
!65 = !{!66, !67}
!66 = !DIDerivedType(tag: DW_TAG_member, name: "head", scope: !64, file: !3, line: 25, baseType: !55, size: 128)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "text", scope: !64, file: !3, line: 26, baseType: !68, size: 2056, offset: 128)
!68 = !DICompositeType(tag: DW_TAG_array_type, baseType: !69, size: 2056, elements: !70)
!69 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!70 = !{!71}
!71 = !DISubrange(count: 257)
!72 = !DILocation(line: 44, column: 10, scope: !73)
!73 = distinct !DILexicalBlock(scope: !50, file: !3, line: 44, column: 9)
!74 = !DILocation(line: 44, column: 9, scope: !50)
!75 = !DILocation(line: 45, column: 9, scope: !73)
!76 = !DILocalVariable(name: "link_field", scope: !50, file: !3, line: 47, type: !77)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "direction_t", file: !3, line: 22, baseType: !14)
!78 = !DILocalVariable(name: "term_field", scope: !50, file: !3, line: 47, type: !77)
!79 = !DILocation(line: 53, column: 13, scope: !80)
!80 = distinct !DILexicalBlock(scope: !50, file: !3, line: 49, column: 17)
!81 = !DILocation(line: 58, column: 13, scope: !80)
!82 = !DILocation(line: 61, column: 30, scope: !50)
!83 = !DILocation(line: 61, column: 11, scope: !50)
!84 = !DILocation(line: 61, column: 5, scope: !50)
!85 = !DILocation(line: 61, column: 28, scope: !50)
!86 = !DILocation(line: 62, column: 11, scope: !50)
!87 = !DILocation(line: 62, column: 5, scope: !50)
!88 = !DILocation(line: 62, column: 28, scope: !50)
!89 = !DILocation(line: 63, column: 11, scope: !50)
!90 = !DILocation(line: 63, column: 19, scope: !50)
!91 = !DILocation(line: 65, column: 26, scope: !50)
!92 = !DILocalVariable(name: "head", scope: !50, file: !3, line: 65, type: !53)
!93 = !DILocation(line: 67, column: 9, scope: !94)
!94 = distinct !DILexicalBlock(scope: !50, file: !3, line: 67, column: 9)
!95 = !DILocation(line: 67, column: 9, scope: !50)
!96 = !DILocation(line: 68, column: 31, scope: !94)
!97 = !DILocation(line: 68, column: 9, scope: !94)
!98 = !DILocation(line: 68, column: 29, scope: !94)
!99 = !DILocation(line: 70, column: 5, scope: !50)
!100 = distinct !DISubprogram(name: "append_one", scope: !3, file: !3, line: 73, type: !101, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !21)
!101 = !DISubroutineType(types: !102)
!102 = !{null, !33, !56}
!103 = !DILocalVariable(name: "list", arg: 1, scope: !100, file: !3, line: 73, type: !33)
!104 = !DILocation(line: 0, scope: !100)
!105 = !DILocalVariable(name: "to", arg: 2, scope: !100, file: !3, line: 73, type: !56)
!106 = !DILocation(line: 75, column: 35, scope: !100)
!107 = !DILocation(line: 75, column: 19, scope: !100)
!108 = !DILocalVariable(name: "item", scope: !100, file: !3, line: 75, type: !53)
!109 = !DILocation(line: 76, column: 19, scope: !100)
!110 = !DILocation(line: 76, column: 5, scope: !100)
!111 = !DILocation(line: 76, column: 17, scope: !100)
!112 = !DILocation(line: 78, column: 17, scope: !113)
!113 = distinct !DILexicalBlock(scope: !100, file: !3, line: 78, column: 9)
!114 = !DILocation(line: 78, column: 14, scope: !113)
!115 = !DILocation(line: 78, column: 9, scope: !100)
!116 = !DILocation(line: 79, column: 29, scope: !113)
!117 = !DILocation(line: 79, column: 9, scope: !113)
!118 = !DILocation(line: 79, column: 27, scope: !113)
!119 = !DILocation(line: 81, column: 17, scope: !120)
!120 = distinct !DILexicalBlock(scope: !100, file: !3, line: 81, column: 9)
!121 = !DILocation(line: 81, column: 14, scope: !120)
!122 = !DILocation(line: 81, column: 9, scope: !100)
!123 = !DILocation(line: 82, column: 29, scope: !120)
!124 = !DILocation(line: 82, column: 9, scope: !120)
!125 = !DILocation(line: 82, column: 27, scope: !120)
!126 = !DILocation(line: 83, column: 1, scope: !100)
!127 = distinct !DISubprogram(name: "remove_one", scope: !3, file: !3, line: 85, type: !101, scopeLine: 86, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !21)
!128 = !DILocalVariable(name: "list", arg: 1, scope: !127, file: !3, line: 85, type: !33)
!129 = !DILocation(line: 0, scope: !127)
!130 = !DILocalVariable(name: "from", arg: 2, scope: !127, file: !3, line: 85, type: !56)
!131 = !DILocation(line: 87, column: 9, scope: !132)
!132 = distinct !DILexicalBlock(scope: !127, file: !3, line: 87, column: 9)
!133 = !DILocation(line: 87, column: 9, scope: !127)
!134 = !DILocation(line: 89, column: 9, scope: !132)
!135 = !DILocation(line: 91, column: 9, scope: !136)
!136 = distinct !DILexicalBlock(scope: !127, file: !3, line: 91, column: 9)
!137 = !DILocation(line: 91, column: 30, scope: !136)
!138 = !DILocation(line: 91, column: 27, scope: !136)
!139 = !DILocation(line: 91, column: 9, scope: !127)
!140 = !DILocation(line: 92, column: 14, scope: !141)
!141 = distinct !DILexicalBlock(scope: !136, file: !3, line: 91, column: 49)
!142 = !DILocation(line: 92, column: 9, scope: !141)
!143 = !DILocation(line: 93, column: 9, scope: !141)
!144 = !DILocation(line: 94, column: 9, scope: !141)
!145 = !DILocation(line: 97, column: 46, scope: !127)
!146 = !DILocation(line: 97, column: 36, scope: !127)
!147 = !DILocalVariable(name: "next_field", scope: !127, file: !3, line: 97, type: !148)
!148 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !77)
!149 = !DILocation(line: 98, column: 46, scope: !127)
!150 = !DILocation(line: 98, column: 36, scope: !127)
!151 = !DILocalVariable(name: "term_field", scope: !127, file: !3, line: 98, type: !148)
!152 = !DILocation(line: 100, column: 19, scope: !127)
!153 = !DILocalVariable(name: "item", scope: !127, file: !3, line: 100, type: !53)
!154 = !DILocation(line: 101, column: 19, scope: !127)
!155 = !DILocalVariable(name: "next", scope: !127, file: !3, line: 101, type: !53)
!156 = !DILocation(line: 102, column: 5, scope: !127)
!157 = !DILocation(line: 102, column: 25, scope: !127)
!158 = !DILocation(line: 103, column: 21, scope: !127)
!159 = !DILocation(line: 103, column: 5, scope: !127)
!160 = !DILocation(line: 103, column: 19, scope: !127)
!161 = !DILocation(line: 105, column: 10, scope: !127)
!162 = !DILocation(line: 105, column: 5, scope: !127)
!163 = !DILocation(line: 106, column: 1, scope: !127)
!164 = distinct !DISubprogram(name: "rand_end_point", scope: !3, file: !3, line: 108, type: !165, scopeLine: 109, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !21)
!165 = !DISubroutineType(types: !166)
!166 = !{!56}
!167 = !DILocation(line: 110, column: 9, scope: !168)
!168 = distinct !DILexicalBlock(scope: !164, file: !3, line: 110, column: 9)
!169 = !{i1 true}
!170 = !DILocation(line: 110, column: 9, scope: !164)
!171 = !DILocation(line: 111, column: 9, scope: !168)
!172 = !DILocation(line: 113, column: 9, scope: !168)
!173 = !DILocation(line: 0, scope: !168)
!174 = !DILocation(line: 114, column: 1, scope: !164)
!175 = !DILocation(line: 120, column: 12, scope: !2)
!176 = !DILocation(line: 120, column: 5, scope: !2)
!177 = !DILocation(line: 121, column: 16, scope: !178)
!178 = distinct !DILexicalBlock(scope: !2, file: !3, line: 120, column: 37)
!179 = !DILocation(line: 121, column: 9, scope: !178)
!180 = !DILocation(line: 122, column: 31, scope: !178)
!181 = !DILocation(line: 122, column: 13, scope: !178)
!182 = distinct !{!182, !179, !183}
!183 = !DILocation(line: 122, column: 47, scope: !178)
!184 = !DILocation(line: 124, column: 16, scope: !178)
!185 = !DILocation(line: 124, column: 9, scope: !178)
!186 = !DILocation(line: 125, column: 31, scope: !178)
!187 = !DILocation(line: 125, column: 13, scope: !178)
!188 = distinct !{!188, !185, !189}
!189 = !DILocation(line: 125, column: 47, scope: !178)
!190 = distinct !{!190, !176, !191}
!191 = !DILocation(line: 126, column: 5, scope: !2)
!192 = !DILocation(line: 131, column: 9, scope: !193)
!193 = distinct !DILexicalBlock(scope: !2, file: !3, line: 131, column: 9)
!194 = !DILocation(line: 131, column: 9, scope: !2)
!195 = !DILocalVariable(name: "end_point", scope: !2, file: !3, line: 128, type: !56)
!196 = !DILocation(line: 0, scope: !2)
!197 = !DILocalVariable(name: "direction", scope: !2, file: !3, line: 129, type: !77)
!198 = !DILocation(line: 135, column: 5, scope: !199)
!199 = distinct !DILexicalBlock(scope: !193, file: !3, line: 131, column: 34)
!200 = !DILocation(line: 0, scope: !193)
!201 = !DILocation(line: 143, column: 21, scope: !2)
!202 = !DILocalVariable(name: "cursor", scope: !2, file: !3, line: 143, type: !53)
!203 = !DILocation(line: 144, column: 5, scope: !2)
!204 = !DILocation(line: 145, column: 23, scope: !205)
!205 = distinct !DILexicalBlock(scope: !2, file: !3, line: 144, column: 20)
!206 = !DILocalVariable(name: "next", scope: !205, file: !3, line: 145, type: !53)
!207 = !DILocation(line: 0, scope: !205)
!208 = !DILocation(line: 146, column: 14, scope: !205)
!209 = !DILocation(line: 146, column: 9, scope: !205)
!210 = distinct !{!210, !203, !211}
!211 = !DILocation(line: 148, column: 5, scope: !2)
!212 = !DILocation(line: 150, column: 5, scope: !2)
