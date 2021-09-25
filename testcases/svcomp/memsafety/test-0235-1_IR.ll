; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-a3o7vl2w.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.L0 = type { %struct.L0*, %struct.L1* }
%struct.L1 = type { %struct.L2*, %struct.L1* }
%struct.L2 = type { %struct.L2*, %struct.L3* }
%struct.L3 = type { %struct.L4*, %struct.L3* }
%struct.L4 = type { %struct.L4*, %struct.L5* }
%struct.L5 = type opaque

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [44 x i8] c"../testcases/svcomp/memsafety/test-0235-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !41 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !44, !verifier.code !47
  unreachable, !dbg !44, !verifier.code !47
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  br label %1, !dbg !48, !verifier.code !47

1:                                                ; preds = %2, %0
  call void @l0_insert(%struct.L0** @main.list), !dbg !49, !verifier.code !47
  br label %2, !dbg !49, !verifier.code !47

2:                                                ; preds = %1
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !50, !verifier.code !51
  %4 = icmp ne i32 %3, 0, !dbg !49, !verifier.code !47
  br i1 %4, label %1, label %5, !dbg !49, !llvm.loop !52, !verifier.code !47

5:                                                ; preds = %2
  %6 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !54, !verifier.code !47
  call void @l0_destroy(%struct.L0* %6, i32 4), !dbg !55, !verifier.code !47
  %7 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !56, !verifier.code !47
  call void @l0_destroy(%struct.L0* %7, i32 3), !dbg !57, !verifier.code !47
  %8 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !58, !verifier.code !47
  call void @l0_destroy(%struct.L0* %8, i32 2), !dbg !59, !verifier.code !47
  %9 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !60, !verifier.code !47
  call void @l0_destroy(%struct.L0* %9, i32 1), !dbg !61, !verifier.code !47
  %10 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !62, !verifier.code !47
  call void @l0_destroy(%struct.L0* %10, i32 0), !dbg !63, !verifier.code !47
  %11 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !64, !verifier.code !47
  %12 = icmp ne %struct.L0* %11, null, !dbg !65, !verifier.code !47
  %13 = xor i1 %12, true, !dbg !65, !verifier.code !47
  %14 = xor i1 %13, true, !dbg !66, !verifier.code !47
  %15 = zext i1 %14 to i32, !dbg !66, !verifier.code !47
  ret i32 %15, !dbg !67, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !68 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !72, metadata !DIExpression()), !dbg !73, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !74, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !74, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !75, metadata !DIExpression()), !dbg !73, !verifier.code !47
  br label %4, !dbg !76, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !77, !verifier.code !47
  call void @l1_insert(%struct.L1** %5), !dbg !78, !verifier.code !47
  br label %6, !dbg !78, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !79, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !78, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !78, !llvm.loop !80, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !82, !verifier.code !47
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !83, !verifier.code !47
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !84, !verifier.code !47
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !85, !verifier.code !47
  ret void, !dbg !86, !verifier.code !47
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0, i32 %1) #0 !dbg !87 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !92, metadata !DIExpression()), !dbg !91, !verifier.code !47
  br label %3, !dbg !93, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L0* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !47
  %4 = icmp slt i32 0, %1, !dbg !94, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !97, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !98, !verifier.code !47
  %7 = load %struct.L1*, %struct.L1** %6, align 8, !dbg !98, !verifier.code !47
  call void @l1_destroy(%struct.L1* %7, i32 %1), !dbg !99, !verifier.code !47
  br label %8, !dbg !99, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !100, !verifier.code !47
  %10 = load %struct.L0*, %struct.L0** %9, align 8, !dbg !100, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !47
  %11 = icmp eq i32 0, %1, !dbg !103, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !105, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L0* %.0 to i8*, !dbg !106, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !107, !verifier.code !47
  br label %14, !dbg !107, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !90, metadata !DIExpression()), !dbg !91, !verifier.code !47
  br label %15, !dbg !108, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L0* %10, null, !dbg !108, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !108, !llvm.loop !109, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !111, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0, i32 %1) #0 !dbg !112 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !117, metadata !DIExpression()), !dbg !116, !verifier.code !47
  br label %3, !dbg !118, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L1* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !47
  %4 = icmp slt i32 1, %1, !dbg !119, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !122, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !123, !verifier.code !47
  %7 = load %struct.L2*, %struct.L2** %6, align 8, !dbg !123, !verifier.code !47
  call void @l2_destroy(%struct.L2* %7, i32 %1), !dbg !124, !verifier.code !47
  br label %8, !dbg !124, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !125, !verifier.code !47
  %10 = load %struct.L1*, %struct.L1** %9, align 8, !dbg !125, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !126, metadata !DIExpression()), !dbg !127, !verifier.code !47
  %11 = icmp eq i32 1, %1, !dbg !128, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !130, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L1* %.0 to i8*, !dbg !131, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !132, !verifier.code !47
  br label %14, !dbg !132, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !47
  br label %15, !dbg !133, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L1* %10, null, !dbg !133, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !133, !llvm.loop !134, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !136, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0, i32 %1) #0 !dbg !137 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !140, metadata !DIExpression()), !dbg !141, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !142, metadata !DIExpression()), !dbg !141, !verifier.code !47
  br label %3, !dbg !143, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L2* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !140, metadata !DIExpression()), !dbg !141, !verifier.code !47
  %4 = icmp slt i32 2, %1, !dbg !144, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !147, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !148, !verifier.code !47
  %7 = load %struct.L3*, %struct.L3** %6, align 8, !dbg !148, !verifier.code !47
  call void @l3_destroy(%struct.L3* %7, i32 %1), !dbg !149, !verifier.code !47
  br label %8, !dbg !149, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !150, !verifier.code !47
  %10 = load %struct.L2*, %struct.L2** %9, align 8, !dbg !150, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !151, metadata !DIExpression()), !dbg !152, !verifier.code !47
  %11 = icmp eq i32 2, %1, !dbg !153, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !155, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L2* %.0 to i8*, !dbg !156, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !157, !verifier.code !47
  br label %14, !dbg !157, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !140, metadata !DIExpression()), !dbg !141, !verifier.code !47
  br label %15, !dbg !158, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L2* %10, null, !dbg !158, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !158, !llvm.loop !159, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !161, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0, i32 %1) #0 !dbg !162 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !165, metadata !DIExpression()), !dbg !166, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !167, metadata !DIExpression()), !dbg !166, !verifier.code !47
  br label %3, !dbg !168, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L3* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !165, metadata !DIExpression()), !dbg !166, !verifier.code !47
  %4 = icmp slt i32 3, %1, !dbg !169, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !172, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !173, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !173, !verifier.code !47
  call void @l4_destroy(%struct.L4* %7, i32 %1), !dbg !174, !verifier.code !47
  br label %8, !dbg !174, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !175, !verifier.code !47
  %10 = load %struct.L3*, %struct.L3** %9, align 8, !dbg !175, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !176, metadata !DIExpression()), !dbg !177, !verifier.code !47
  %11 = icmp eq i32 3, %1, !dbg !178, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !180, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L3* %.0 to i8*, !dbg !181, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !182, !verifier.code !47
  br label %14, !dbg !182, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !165, metadata !DIExpression()), !dbg !166, !verifier.code !47
  br label %15, !dbg !183, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L3* %10, null, !dbg !183, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !183, !llvm.loop !184, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !186, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0, i32 %1) #0 !dbg !187 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !190, metadata !DIExpression()), !dbg !191, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !192, metadata !DIExpression()), !dbg !191, !verifier.code !47
  br label %3, !dbg !193, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L4* [ %0, %2 ], [ %11, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !190, metadata !DIExpression()), !dbg !191, !verifier.code !47
  %4 = icmp eq i32 5, %1, !dbg !194, !verifier.code !47
  br i1 %4, label %5, label %9, !dbg !197, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !198, !verifier.code !47
  %7 = load %struct.L5*, %struct.L5** %6, align 8, !dbg !198, !verifier.code !47
  %8 = bitcast %struct.L5* %7 to i8*, !dbg !199, !verifier.code !47
  call void @free(i8* %8) #7, !dbg !200, !verifier.code !47
  br label %9, !dbg !200, !verifier.code !47

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !201, !verifier.code !47
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !201, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !202, metadata !DIExpression()), !dbg !203, !verifier.code !47
  %12 = icmp eq i32 4, %1, !dbg !204, !verifier.code !47
  br i1 %12, label %13, label %15, !dbg !206, !verifier.code !47

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !207, !verifier.code !47
  call void @free(i8* %14) #7, !dbg !208, !verifier.code !47
  br label %15, !dbg !208, !verifier.code !47

15:                                               ; preds = %13, %9
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !190, metadata !DIExpression()), !dbg !191, !verifier.code !47
  br label %16, !dbg !209, !verifier.code !47

16:                                               ; preds = %15
  %17 = icmp ne %struct.L4* %11, null, !dbg !209, !verifier.code !47
  br i1 %17, label %forwarder, label %18, !dbg !209, !llvm.loop !210, !verifier.code !47

18:                                               ; preds = %16
  ret void, !dbg !212, !verifier.code !47

forwarder:                                        ; preds = %16
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !213 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !218, metadata !DIExpression()), !dbg !219, !verifier.code !47
  %2 = zext i32 %0 to i64, !dbg !220, !verifier.code !47
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !221, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %3, metadata !222, metadata !DIExpression()), !dbg !219, !verifier.code !47
  %4 = icmp ne i8* %3, null, !dbg !223, !verifier.code !47
  br i1 %4, label %5, label %6, !dbg !225, !verifier.code !47

5:                                                ; preds = %1
  ret i8* %3, !dbg !226, !verifier.code !47

6:                                                ; preds = %1
  call void @abort() #6, !dbg !227, !verifier.code !47
  unreachable, !dbg !227, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !228 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !232, metadata !DIExpression()), !dbg !233, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !234, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !234, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !235, metadata !DIExpression()), !dbg !233, !verifier.code !47
  br label %4, !dbg !236, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !237, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !238, !verifier.code !47
  br label %6, !dbg !238, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !239, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !238, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !238, !llvm.loop !240, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !242, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !243, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !244, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !245, !verifier.code !47
  ret void, !dbg !246, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !247 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !251, metadata !DIExpression()), !dbg !252, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !253, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !253, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !254, metadata !DIExpression()), !dbg !252, !verifier.code !47
  br label %4, !dbg !255, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !256, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !257, !verifier.code !47
  br label %6, !dbg !257, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !258, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !257, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !257, !llvm.loop !259, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !261, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !262, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !263, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !264, !verifier.code !47
  ret void, !dbg !265, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !266 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !270, metadata !DIExpression()), !dbg !271, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !272, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !272, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !273, metadata !DIExpression()), !dbg !271, !verifier.code !47
  br label %4, !dbg !274, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !275, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !276, !verifier.code !47
  br label %6, !dbg !276, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !277, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !276, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !276, !llvm.loop !278, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !280, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !281, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !282, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !283, !verifier.code !47
  ret void, !dbg !284, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !285 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !289, metadata !DIExpression()), !dbg !290, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !291, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !291, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !292, metadata !DIExpression()), !dbg !290, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !293, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !293, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !294, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !295, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !296, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !297, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !298, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !299, !verifier.code !47
  ret void, !dbg !300, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !301 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !307, metadata !DIExpression()), !dbg !308, !verifier.code !47
  call void @llvm.dbg.value(metadata i64 %1, metadata !309, metadata !DIExpression()), !dbg !308, !verifier.code !47
  %3 = mul i64 %0, %1, !dbg !310, !verifier.code !47
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !311, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !312, metadata !DIExpression()), !dbg !308, !verifier.code !47
  %5 = mul i64 %0, %1, !dbg !313, !verifier.code !47
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !314, !verifier.code !47
  ret i8* %4, !dbg !315, !verifier.code !47
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #4

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

define void @__SMACK_static_init() {
entry:
  store %struct.L0* null, %struct.L0** @main.list
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable willreturn }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind willreturn }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!37}
!llvm.module.flags = !{!38, !39, !40}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 183, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 181, type: !4, scopeLine: 182, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0235-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, globals: !9, splitDebugInlining: false, nameTableKind: None)
!8 = !{}
!9 = !{!0}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L0", file: !3, line: 35, size: 128, elements: !12)
!12 = !{!13, !14}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !11, file: !3, line: 36, baseType: !10, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !11, file: !3, line: 37, baseType: !15, size: 64, offset: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L1", file: !3, line: 30, size: 128, elements: !17)
!17 = !{!18, !36}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !16, file: !3, line: 31, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L2", file: !3, line: 25, size: 128, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !20, file: !3, line: 26, baseType: !19, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !20, file: !3, line: 27, baseType: !24, size: 64, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L3", file: !3, line: 20, size: 128, elements: !26)
!26 = !{!27, !35}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !25, file: !3, line: 21, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L4", file: !3, line: 15, size: 128, elements: !30)
!30 = !{!31, !32}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !29, file: !3, line: 16, baseType: !28, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !29, file: !3, line: 17, baseType: !33, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DICompositeType(tag: DW_TAG_structure_type, name: "L5", file: !3, line: 17, flags: DIFlagFwdDecl)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !25, file: !3, line: 22, baseType: !24, size: 64, offset: 64)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !16, file: !3, line: 32, baseType: !15, size: 64, offset: 64)
!37 = !{!"clang version 10.0.0-4ubuntu1 "}
!38 = !{i32 7, !"Dwarf Version", i32 4}
!39 = !{i32 2, !"Debug Info Version", i32 3}
!40 = !{i32 1, !"wchar_size", i32 4}
!41 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !42, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!42 = !DISubroutineType(types: !43)
!43 = !{null}
!44 = !DILocation(line: 3, column: 22, scope: !45)
!45 = distinct !DILexicalBlock(scope: !46, file: !3, line: 3, column: 22)
!46 = distinct !DILexicalBlock(scope: !41, file: !3, line: 3, column: 22)
!47 = !{i1 false}
!48 = !DILocation(line: 185, column: 5, scope: !2)
!49 = !DILocation(line: 186, column: 9, scope: !2)
!50 = !DILocation(line: 187, column: 12, scope: !2)
!51 = !{i1 true}
!52 = distinct !{!52, !48, !53}
!53 = !DILocation(line: 187, column: 35, scope: !2)
!54 = !DILocation(line: 189, column: 16, scope: !2)
!55 = !DILocation(line: 189, column: 5, scope: !2)
!56 = !DILocation(line: 190, column: 16, scope: !2)
!57 = !DILocation(line: 190, column: 5, scope: !2)
!58 = !DILocation(line: 191, column: 16, scope: !2)
!59 = !DILocation(line: 191, column: 5, scope: !2)
!60 = !DILocation(line: 192, column: 16, scope: !2)
!61 = !DILocation(line: 192, column: 5, scope: !2)
!62 = !DILocation(line: 193, column: 16, scope: !2)
!63 = !DILocation(line: 193, column: 5, scope: !2)
!64 = !DILocation(line: 195, column: 14, scope: !2)
!65 = !DILocation(line: 195, column: 13, scope: !2)
!66 = !DILocation(line: 195, column: 12, scope: !2)
!67 = !DILocation(line: 195, column: 5, scope: !2)
!68 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !69, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!69 = !DISubroutineType(types: !70)
!70 = !{null, !71}
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!72 = !DILocalVariable(name: "list", arg: 1, scope: !68, file: !3, line: 94, type: !71)
!73 = !DILocation(line: 0, scope: !68)
!74 = !DILocation(line: 96, column: 23, scope: !68)
!75 = !DILocalVariable(name: "item", scope: !68, file: !3, line: 96, type: !10)
!76 = !DILocation(line: 98, column: 5, scope: !68)
!77 = !DILocation(line: 99, column: 26, scope: !68)
!78 = !DILocation(line: 99, column: 9, scope: !68)
!79 = !DILocation(line: 100, column: 12, scope: !68)
!80 = distinct !{!80, !76, !81}
!81 = !DILocation(line: 100, column: 35, scope: !68)
!82 = !DILocation(line: 102, column: 18, scope: !68)
!83 = !DILocation(line: 102, column: 11, scope: !68)
!84 = !DILocation(line: 102, column: 16, scope: !68)
!85 = !DILocation(line: 103, column: 11, scope: !68)
!86 = !DILocation(line: 104, column: 1, scope: !68)
!87 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 166, type: !88, scopeLine: 167, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !10, !6}
!90 = !DILocalVariable(name: "list", arg: 1, scope: !87, file: !3, line: 166, type: !10)
!91 = !DILocation(line: 0, scope: !87)
!92 = !DILocalVariable(name: "level", arg: 2, scope: !87, file: !3, line: 166, type: !6)
!93 = !DILocation(line: 168, column: 5, scope: !87)
!94 = !DILocation(line: 169, column: 15, scope: !95)
!95 = distinct !DILexicalBlock(scope: !96, file: !3, line: 169, column: 13)
!96 = distinct !DILexicalBlock(scope: !87, file: !3, line: 168, column: 8)
!97 = !DILocation(line: 169, column: 13, scope: !96)
!98 = !DILocation(line: 170, column: 30, scope: !95)
!99 = !DILocation(line: 170, column: 13, scope: !95)
!100 = !DILocation(line: 172, column: 33, scope: !96)
!101 = !DILocalVariable(name: "next", scope: !96, file: !3, line: 172, type: !10)
!102 = !DILocation(line: 0, scope: !96)
!103 = !DILocation(line: 173, column: 15, scope: !104)
!104 = distinct !DILexicalBlock(scope: !96, file: !3, line: 173, column: 13)
!105 = !DILocation(line: 173, column: 13, scope: !96)
!106 = !DILocation(line: 174, column: 18, scope: !104)
!107 = !DILocation(line: 174, column: 13, scope: !104)
!108 = !DILocation(line: 177, column: 5, scope: !96)
!109 = distinct !{!109, !93, !110}
!110 = !DILocation(line: 178, column: 16, scope: !87)
!111 = !DILocation(line: 179, column: 1, scope: !87)
!112 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 151, type: !113, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!113 = !DISubroutineType(types: !114)
!114 = !{null, !15, !6}
!115 = !DILocalVariable(name: "list", arg: 1, scope: !112, file: !3, line: 151, type: !15)
!116 = !DILocation(line: 0, scope: !112)
!117 = !DILocalVariable(name: "level", arg: 2, scope: !112, file: !3, line: 151, type: !6)
!118 = !DILocation(line: 153, column: 5, scope: !112)
!119 = !DILocation(line: 154, column: 15, scope: !120)
!120 = distinct !DILexicalBlock(scope: !121, file: !3, line: 154, column: 13)
!121 = distinct !DILexicalBlock(scope: !112, file: !3, line: 153, column: 8)
!122 = !DILocation(line: 154, column: 13, scope: !121)
!123 = !DILocation(line: 155, column: 30, scope: !120)
!124 = !DILocation(line: 155, column: 13, scope: !120)
!125 = !DILocation(line: 157, column: 33, scope: !121)
!126 = !DILocalVariable(name: "next", scope: !121, file: !3, line: 157, type: !15)
!127 = !DILocation(line: 0, scope: !121)
!128 = !DILocation(line: 158, column: 15, scope: !129)
!129 = distinct !DILexicalBlock(scope: !121, file: !3, line: 158, column: 13)
!130 = !DILocation(line: 158, column: 13, scope: !121)
!131 = !DILocation(line: 159, column: 18, scope: !129)
!132 = !DILocation(line: 159, column: 13, scope: !129)
!133 = !DILocation(line: 162, column: 5, scope: !121)
!134 = distinct !{!134, !118, !135}
!135 = !DILocation(line: 163, column: 16, scope: !112)
!136 = !DILocation(line: 164, column: 1, scope: !112)
!137 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 136, type: !138, scopeLine: 137, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!138 = !DISubroutineType(types: !139)
!139 = !{null, !19, !6}
!140 = !DILocalVariable(name: "list", arg: 1, scope: !137, file: !3, line: 136, type: !19)
!141 = !DILocation(line: 0, scope: !137)
!142 = !DILocalVariable(name: "level", arg: 2, scope: !137, file: !3, line: 136, type: !6)
!143 = !DILocation(line: 138, column: 5, scope: !137)
!144 = !DILocation(line: 139, column: 15, scope: !145)
!145 = distinct !DILexicalBlock(scope: !146, file: !3, line: 139, column: 13)
!146 = distinct !DILexicalBlock(scope: !137, file: !3, line: 138, column: 8)
!147 = !DILocation(line: 139, column: 13, scope: !146)
!148 = !DILocation(line: 140, column: 30, scope: !145)
!149 = !DILocation(line: 140, column: 13, scope: !145)
!150 = !DILocation(line: 142, column: 33, scope: !146)
!151 = !DILocalVariable(name: "next", scope: !146, file: !3, line: 142, type: !19)
!152 = !DILocation(line: 0, scope: !146)
!153 = !DILocation(line: 143, column: 15, scope: !154)
!154 = distinct !DILexicalBlock(scope: !146, file: !3, line: 143, column: 13)
!155 = !DILocation(line: 143, column: 13, scope: !146)
!156 = !DILocation(line: 144, column: 18, scope: !154)
!157 = !DILocation(line: 144, column: 13, scope: !154)
!158 = !DILocation(line: 147, column: 5, scope: !146)
!159 = distinct !{!159, !143, !160}
!160 = !DILocation(line: 148, column: 16, scope: !137)
!161 = !DILocation(line: 149, column: 1, scope: !137)
!162 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 121, type: !163, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!163 = !DISubroutineType(types: !164)
!164 = !{null, !24, !6}
!165 = !DILocalVariable(name: "list", arg: 1, scope: !162, file: !3, line: 121, type: !24)
!166 = !DILocation(line: 0, scope: !162)
!167 = !DILocalVariable(name: "level", arg: 2, scope: !162, file: !3, line: 121, type: !6)
!168 = !DILocation(line: 123, column: 5, scope: !162)
!169 = !DILocation(line: 124, column: 15, scope: !170)
!170 = distinct !DILexicalBlock(scope: !171, file: !3, line: 124, column: 13)
!171 = distinct !DILexicalBlock(scope: !162, file: !3, line: 123, column: 8)
!172 = !DILocation(line: 124, column: 13, scope: !171)
!173 = !DILocation(line: 125, column: 30, scope: !170)
!174 = !DILocation(line: 125, column: 13, scope: !170)
!175 = !DILocation(line: 127, column: 33, scope: !171)
!176 = !DILocalVariable(name: "next", scope: !171, file: !3, line: 127, type: !24)
!177 = !DILocation(line: 0, scope: !171)
!178 = !DILocation(line: 128, column: 15, scope: !179)
!179 = distinct !DILexicalBlock(scope: !171, file: !3, line: 128, column: 13)
!180 = !DILocation(line: 128, column: 13, scope: !171)
!181 = !DILocation(line: 129, column: 18, scope: !179)
!182 = !DILocation(line: 129, column: 13, scope: !179)
!183 = !DILocation(line: 132, column: 5, scope: !171)
!184 = distinct !{!184, !168, !185}
!185 = !DILocation(line: 133, column: 16, scope: !162)
!186 = !DILocation(line: 134, column: 1, scope: !162)
!187 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !188, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!188 = !DISubroutineType(types: !189)
!189 = !{null, !28, !6}
!190 = !DILocalVariable(name: "list", arg: 1, scope: !187, file: !3, line: 106, type: !28)
!191 = !DILocation(line: 0, scope: !187)
!192 = !DILocalVariable(name: "level", arg: 2, scope: !187, file: !3, line: 106, type: !6)
!193 = !DILocation(line: 108, column: 5, scope: !187)
!194 = !DILocation(line: 109, column: 15, scope: !195)
!195 = distinct !DILexicalBlock(scope: !196, file: !3, line: 109, column: 13)
!196 = distinct !DILexicalBlock(scope: !187, file: !3, line: 108, column: 8)
!197 = !DILocation(line: 109, column: 13, scope: !196)
!198 = !DILocation(line: 110, column: 24, scope: !195)
!199 = !DILocation(line: 110, column: 18, scope: !195)
!200 = !DILocation(line: 110, column: 13, scope: !195)
!201 = !DILocation(line: 112, column: 33, scope: !196)
!202 = !DILocalVariable(name: "next", scope: !196, file: !3, line: 112, type: !28)
!203 = !DILocation(line: 0, scope: !196)
!204 = !DILocation(line: 113, column: 15, scope: !205)
!205 = distinct !DILexicalBlock(scope: !196, file: !3, line: 113, column: 13)
!206 = !DILocation(line: 113, column: 13, scope: !196)
!207 = !DILocation(line: 114, column: 18, scope: !205)
!208 = !DILocation(line: 114, column: 13, scope: !205)
!209 = !DILocation(line: 117, column: 5, scope: !196)
!210 = distinct !{!210, !193, !211}
!211 = !DILocation(line: 118, column: 16, scope: !187)
!212 = !DILocation(line: 119, column: 1, scope: !187)
!213 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !214, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!214 = !DISubroutineType(types: !215)
!215 = !{!216, !217}
!216 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!217 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!218 = !DILocalVariable(name: "size", arg: 1, scope: !213, file: !3, line: 40, type: !217)
!219 = !DILocation(line: 0, scope: !213)
!220 = !DILocation(line: 42, column: 34, scope: !213)
!221 = !DILocation(line: 42, column: 17, scope: !213)
!222 = !DILocalVariable(name: "ptr", scope: !213, file: !3, line: 42, type: !216)
!223 = !DILocation(line: 43, column: 9, scope: !224)
!224 = distinct !DILexicalBlock(scope: !213, file: !3, line: 43, column: 9)
!225 = !DILocation(line: 43, column: 9, scope: !213)
!226 = !DILocation(line: 44, column: 9, scope: !224)
!227 = !DILocation(line: 46, column: 5, scope: !213)
!228 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !229, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!229 = !DISubroutineType(types: !230)
!230 = !{null, !231}
!231 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!232 = !DILocalVariable(name: "list", arg: 1, scope: !228, file: !3, line: 82, type: !231)
!233 = !DILocation(line: 0, scope: !228)
!234 = !DILocation(line: 84, column: 23, scope: !228)
!235 = !DILocalVariable(name: "item", scope: !228, file: !3, line: 84, type: !15)
!236 = !DILocation(line: 86, column: 5, scope: !228)
!237 = !DILocation(line: 87, column: 26, scope: !228)
!238 = !DILocation(line: 87, column: 9, scope: !228)
!239 = !DILocation(line: 88, column: 12, scope: !228)
!240 = distinct !{!240, !236, !241}
!241 = !DILocation(line: 88, column: 35, scope: !228)
!242 = !DILocation(line: 90, column: 18, scope: !228)
!243 = !DILocation(line: 90, column: 11, scope: !228)
!244 = !DILocation(line: 90, column: 16, scope: !228)
!245 = !DILocation(line: 91, column: 11, scope: !228)
!246 = !DILocation(line: 92, column: 1, scope: !228)
!247 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !248, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!248 = !DISubroutineType(types: !249)
!249 = !{null, !250}
!250 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!251 = !DILocalVariable(name: "list", arg: 1, scope: !247, file: !3, line: 70, type: !250)
!252 = !DILocation(line: 0, scope: !247)
!253 = !DILocation(line: 72, column: 23, scope: !247)
!254 = !DILocalVariable(name: "item", scope: !247, file: !3, line: 72, type: !19)
!255 = !DILocation(line: 74, column: 5, scope: !247)
!256 = !DILocation(line: 75, column: 26, scope: !247)
!257 = !DILocation(line: 75, column: 9, scope: !247)
!258 = !DILocation(line: 76, column: 12, scope: !247)
!259 = distinct !{!259, !255, !260}
!260 = !DILocation(line: 76, column: 35, scope: !247)
!261 = !DILocation(line: 78, column: 18, scope: !247)
!262 = !DILocation(line: 78, column: 11, scope: !247)
!263 = !DILocation(line: 78, column: 16, scope: !247)
!264 = !DILocation(line: 79, column: 11, scope: !247)
!265 = !DILocation(line: 80, column: 1, scope: !247)
!266 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !267, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!267 = !DISubroutineType(types: !268)
!268 = !{null, !269}
!269 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!270 = !DILocalVariable(name: "list", arg: 1, scope: !266, file: !3, line: 58, type: !269)
!271 = !DILocation(line: 0, scope: !266)
!272 = !DILocation(line: 60, column: 23, scope: !266)
!273 = !DILocalVariable(name: "item", scope: !266, file: !3, line: 60, type: !24)
!274 = !DILocation(line: 62, column: 5, scope: !266)
!275 = !DILocation(line: 63, column: 26, scope: !266)
!276 = !DILocation(line: 63, column: 9, scope: !266)
!277 = !DILocation(line: 64, column: 12, scope: !266)
!278 = distinct !{!278, !274, !279}
!279 = !DILocation(line: 64, column: 35, scope: !266)
!280 = !DILocation(line: 66, column: 18, scope: !266)
!281 = !DILocation(line: 66, column: 11, scope: !266)
!282 = !DILocation(line: 66, column: 16, scope: !266)
!283 = !DILocation(line: 67, column: 11, scope: !266)
!284 = !DILocation(line: 68, column: 1, scope: !266)
!285 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !286, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!286 = !DISubroutineType(types: !287)
!287 = !{null, !288}
!288 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!289 = !DILocalVariable(name: "list", arg: 1, scope: !285, file: !3, line: 49, type: !288)
!290 = !DILocation(line: 0, scope: !285)
!291 = !DILocation(line: 51, column: 23, scope: !285)
!292 = !DILocalVariable(name: "item", scope: !285, file: !3, line: 51, type: !28)
!293 = !DILocation(line: 52, column: 18, scope: !285)
!294 = !DILocation(line: 52, column: 11, scope: !285)
!295 = !DILocation(line: 52, column: 16, scope: !285)
!296 = !DILocation(line: 54, column: 18, scope: !285)
!297 = !DILocation(line: 54, column: 11, scope: !285)
!298 = !DILocation(line: 54, column: 16, scope: !285)
!299 = !DILocation(line: 55, column: 11, scope: !285)
!300 = !DILocation(line: 56, column: 1, scope: !285)
!301 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !302, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!302 = !DISubroutineType(types: !303)
!303 = !{!216, !304, !304}
!304 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !305, line: 46, baseType: !306)
!305 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!306 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!307 = !DILocalVariable(name: "nmemb", arg: 1, scope: !301, file: !3, line: 8, type: !304)
!308 = !DILocation(line: 0, scope: !301)
!309 = !DILocalVariable(name: "size", arg: 2, scope: !301, file: !3, line: 8, type: !304)
!310 = !DILocation(line: 9, column: 30, scope: !301)
!311 = !DILocation(line: 9, column: 17, scope: !301)
!312 = !DILocalVariable(name: "ptr", scope: !301, file: !3, line: 9, type: !216)
!313 = !DILocation(line: 10, column: 33, scope: !301)
!314 = !DILocation(line: 10, column: 12, scope: !301)
!315 = !DILocation(line: 10, column: 5, scope: !301)
