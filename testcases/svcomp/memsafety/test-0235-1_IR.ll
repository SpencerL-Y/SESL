; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-fa5q9yqy.bc'
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
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0235-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !42 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !45, !verifier.code !48
  unreachable, !dbg !45, !verifier.code !48
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  br label %1, !dbg !49, !verifier.code !48

1:                                                ; preds = %2, %0
  call void @l0_insert(%struct.L0** @main.list), !dbg !50, !verifier.code !48
  br label %2, !dbg !50, !verifier.code !48

2:                                                ; preds = %1
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !51, !verifier.code !52
  %4 = icmp ne i32 %3, 0, !dbg !50, !verifier.code !48
  br i1 %4, label %1, label %5, !dbg !50, !llvm.loop !53, !verifier.code !48

5:                                                ; preds = %2
  %6 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !55, !verifier.code !48
  call void @l0_destroy(%struct.L0* %6, i32 4), !dbg !56, !verifier.code !48
  %7 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !57, !verifier.code !48
  call void @l0_destroy(%struct.L0* %7, i32 3), !dbg !58, !verifier.code !48
  %8 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !59, !verifier.code !48
  call void @l0_destroy(%struct.L0* %8, i32 2), !dbg !60, !verifier.code !48
  %9 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !61, !verifier.code !48
  call void @l0_destroy(%struct.L0* %9, i32 1), !dbg !62, !verifier.code !48
  %10 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !63, !verifier.code !48
  call void @l0_destroy(%struct.L0* %10, i32 0), !dbg !64, !verifier.code !48
  %11 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !65, !verifier.code !48
  %12 = icmp ne %struct.L0* %11, null, !dbg !66, !verifier.code !48
  %13 = xor i1 %12, true, !dbg !66, !verifier.code !48
  %14 = xor i1 %13, true, !dbg !67, !verifier.code !48
  %15 = zext i1 %14 to i32, !dbg !67, !verifier.code !48
  ret i32 %15, !dbg !68, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !69 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !75, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !75, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !76, metadata !DIExpression()), !dbg !74, !verifier.code !48
  br label %4, !dbg !77, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !78, !verifier.code !48
  call void @l1_insert(%struct.L1** %5), !dbg !79, !verifier.code !48
  br label %6, !dbg !79, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !80, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !79, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !79, !llvm.loop !81, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !83, !verifier.code !48
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !84, !verifier.code !48
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !85, !verifier.code !48
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !86, !verifier.code !48
  ret void, !dbg !87, !verifier.code !48
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0, i32 %1) #0 !dbg !88 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !93, metadata !DIExpression()), !dbg !92, !verifier.code !48
  br label %3, !dbg !94, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L0* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !48
  %4 = icmp slt i32 0, %1, !dbg !95, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !98, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !99, !verifier.code !48
  %7 = load %struct.L1*, %struct.L1** %6, align 8, !dbg !99, !verifier.code !48
  call void @l1_destroy(%struct.L1* %7, i32 %1), !dbg !100, !verifier.code !48
  br label %8, !dbg !100, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !101, !verifier.code !48
  %10 = load %struct.L0*, %struct.L0** %9, align 8, !dbg !101, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !48
  %11 = icmp eq i32 0, %1, !dbg !104, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !106, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L0* %.0 to i8*, !dbg !107, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !108, !verifier.code !48
  br label %14, !dbg !108, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !48
  br label %15, !dbg !109, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L0* %10, null, !dbg !109, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !109, !llvm.loop !110, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !112, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0, i32 %1) #0 !dbg !113 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !118, metadata !DIExpression()), !dbg !117, !verifier.code !48
  br label %3, !dbg !119, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L1* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !48
  %4 = icmp slt i32 1, %1, !dbg !120, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !123, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !124, !verifier.code !48
  %7 = load %struct.L2*, %struct.L2** %6, align 8, !dbg !124, !verifier.code !48
  call void @l2_destroy(%struct.L2* %7, i32 %1), !dbg !125, !verifier.code !48
  br label %8, !dbg !125, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !126, !verifier.code !48
  %10 = load %struct.L1*, %struct.L1** %9, align 8, !dbg !126, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !127, metadata !DIExpression()), !dbg !128, !verifier.code !48
  %11 = icmp eq i32 1, %1, !dbg !129, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !131, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L1* %.0 to i8*, !dbg !132, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !133, !verifier.code !48
  br label %14, !dbg !133, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !48
  br label %15, !dbg !134, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L1* %10, null, !dbg !134, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !134, !llvm.loop !135, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !137, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0, i32 %1) #0 !dbg !138 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !143, metadata !DIExpression()), !dbg !142, !verifier.code !48
  br label %3, !dbg !144, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L2* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !48
  %4 = icmp slt i32 2, %1, !dbg !145, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !148, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !149, !verifier.code !48
  %7 = load %struct.L3*, %struct.L3** %6, align 8, !dbg !149, !verifier.code !48
  call void @l3_destroy(%struct.L3* %7, i32 %1), !dbg !150, !verifier.code !48
  br label %8, !dbg !150, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !151, !verifier.code !48
  %10 = load %struct.L2*, %struct.L2** %9, align 8, !dbg !151, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !152, metadata !DIExpression()), !dbg !153, !verifier.code !48
  %11 = icmp eq i32 2, %1, !dbg !154, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !156, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L2* %.0 to i8*, !dbg !157, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !158, !verifier.code !48
  br label %14, !dbg !158, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !48
  br label %15, !dbg !159, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L2* %10, null, !dbg !159, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !159, !llvm.loop !160, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !162, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0, i32 %1) #0 !dbg !163 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !166, metadata !DIExpression()), !dbg !167, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !168, metadata !DIExpression()), !dbg !167, !verifier.code !48
  br label %3, !dbg !169, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L3* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !166, metadata !DIExpression()), !dbg !167, !verifier.code !48
  %4 = icmp slt i32 3, %1, !dbg !170, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !173, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !174, !verifier.code !48
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !174, !verifier.code !48
  call void @l4_destroy(%struct.L4* %7, i32 %1), !dbg !175, !verifier.code !48
  br label %8, !dbg !175, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !176, !verifier.code !48
  %10 = load %struct.L3*, %struct.L3** %9, align 8, !dbg !176, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !177, metadata !DIExpression()), !dbg !178, !verifier.code !48
  %11 = icmp eq i32 3, %1, !dbg !179, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !181, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L3* %.0 to i8*, !dbg !182, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !183, !verifier.code !48
  br label %14, !dbg !183, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !166, metadata !DIExpression()), !dbg !167, !verifier.code !48
  br label %15, !dbg !184, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L3* %10, null, !dbg !184, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !184, !llvm.loop !185, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !187, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0, i32 %1) #0 !dbg !188 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !191, metadata !DIExpression()), !dbg !192, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !193, metadata !DIExpression()), !dbg !192, !verifier.code !48
  br label %3, !dbg !194, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L4* [ %0, %2 ], [ %11, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !191, metadata !DIExpression()), !dbg !192, !verifier.code !48
  %4 = icmp eq i32 5, %1, !dbg !195, !verifier.code !48
  br i1 %4, label %5, label %9, !dbg !198, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !199, !verifier.code !48
  %7 = load %struct.L5*, %struct.L5** %6, align 8, !dbg !199, !verifier.code !48
  %8 = bitcast %struct.L5* %7 to i8*, !dbg !200, !verifier.code !48
  call void @free(i8* %8) #7, !dbg !201, !verifier.code !48
  br label %9, !dbg !201, !verifier.code !48

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !202, !verifier.code !48
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !202, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !203, metadata !DIExpression()), !dbg !204, !verifier.code !48
  %12 = icmp eq i32 4, %1, !dbg !205, !verifier.code !48
  br i1 %12, label %13, label %15, !dbg !207, !verifier.code !48

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !208, !verifier.code !48
  call void @free(i8* %14) #7, !dbg !209, !verifier.code !48
  br label %15, !dbg !209, !verifier.code !48

15:                                               ; preds = %13, %9
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !191, metadata !DIExpression()), !dbg !192, !verifier.code !48
  br label %16, !dbg !210, !verifier.code !48

16:                                               ; preds = %15
  %17 = icmp ne %struct.L4* %11, null, !dbg !210, !verifier.code !48
  br i1 %17, label %forwarder, label %18, !dbg !210, !llvm.loop !211, !verifier.code !48

18:                                               ; preds = %16
  ret void, !dbg !213, !verifier.code !48

forwarder:                                        ; preds = %16
  br label %3, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !214 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !219, metadata !DIExpression()), !dbg !220, !verifier.code !48
  %2 = zext i32 %0 to i64, !dbg !221, !verifier.code !48
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !222, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %3, metadata !223, metadata !DIExpression()), !dbg !220, !verifier.code !48
  %4 = icmp ne i8* %3, null, !dbg !224, !verifier.code !48
  br i1 %4, label %5, label %6, !dbg !226, !verifier.code !48

5:                                                ; preds = %1
  ret i8* %3, !dbg !227, !verifier.code !48

6:                                                ; preds = %1
  call void @abort() #6, !dbg !228, !verifier.code !48
  unreachable, !dbg !228, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !229 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !233, metadata !DIExpression()), !dbg !234, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !235, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !235, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !236, metadata !DIExpression()), !dbg !234, !verifier.code !48
  br label %4, !dbg !237, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !238, !verifier.code !48
  call void @l2_insert(%struct.L2** %5), !dbg !239, !verifier.code !48
  br label %6, !dbg !239, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !240, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !239, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !239, !llvm.loop !241, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !243, !verifier.code !48
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !244, !verifier.code !48
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !245, !verifier.code !48
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !246, !verifier.code !48
  ret void, !dbg !247, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !248 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !252, metadata !DIExpression()), !dbg !253, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !254, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !254, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !255, metadata !DIExpression()), !dbg !253, !verifier.code !48
  br label %4, !dbg !256, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !257, !verifier.code !48
  call void @l3_insert(%struct.L3** %5), !dbg !258, !verifier.code !48
  br label %6, !dbg !258, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !259, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !258, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !258, !llvm.loop !260, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !262, !verifier.code !48
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !263, !verifier.code !48
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !264, !verifier.code !48
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !265, !verifier.code !48
  ret void, !dbg !266, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !267 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !271, metadata !DIExpression()), !dbg !272, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !273, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !273, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !274, metadata !DIExpression()), !dbg !272, !verifier.code !48
  br label %4, !dbg !275, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !276, !verifier.code !48
  call void @l4_insert(%struct.L4** %5), !dbg !277, !verifier.code !48
  br label %6, !dbg !277, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !278, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !277, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !277, !llvm.loop !279, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !281, !verifier.code !48
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !282, !verifier.code !48
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !283, !verifier.code !48
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !284, !verifier.code !48
  ret void, !dbg !285, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !286 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !290, metadata !DIExpression()), !dbg !291, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !292, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !292, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !293, metadata !DIExpression()), !dbg !291, !verifier.code !48
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !294, !verifier.code !48
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !294, !verifier.code !48
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !295, !verifier.code !48
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !296, !verifier.code !48
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !297, !verifier.code !48
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !298, !verifier.code !48
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !299, !verifier.code !48
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !300, !verifier.code !48
  ret void, !dbg !301, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !302 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !308, metadata !DIExpression()), !dbg !309, !verifier.code !48
  call void @llvm.dbg.value(metadata i64 %1, metadata !310, metadata !DIExpression()), !dbg !309, !verifier.code !48
  %3 = mul i64 %0, %1, !dbg !311, !verifier.code !48
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !312, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %4, metadata !313, metadata !DIExpression()), !dbg !309, !verifier.code !48
  %5 = mul i64 %0, %1, !dbg !314, !verifier.code !48
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !315, !verifier.code !48
  ret i8* %4, !dbg !316, !verifier.code !48
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
!llvm.ident = !{!38}
!llvm.module.flags = !{!39, !40, !41}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 183, type: !11, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 181, type: !4, scopeLine: 182, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!3 = !DIFile(filename: "../svcomp/memsafety//test-0235-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !8, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, globals: !10, splitDebugInlining: false, nameTableKind: None)
!8 = !DIFile(filename: "../svcomp/memsafety/test-0235-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !{}
!10 = !{!0}
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L0", file: !3, line: 35, size: 128, elements: !13)
!13 = !{!14, !15}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !12, file: !3, line: 36, baseType: !11, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !12, file: !3, line: 37, baseType: !16, size: 64, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L1", file: !3, line: 30, size: 128, elements: !18)
!18 = !{!19, !37}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !17, file: !3, line: 31, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L2", file: !3, line: 25, size: 128, elements: !22)
!22 = !{!23, !24}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !21, file: !3, line: 26, baseType: !20, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !21, file: !3, line: 27, baseType: !25, size: 64, offset: 64)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!26 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L3", file: !3, line: 20, size: 128, elements: !27)
!27 = !{!28, !36}
!28 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !26, file: !3, line: 21, baseType: !29, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L4", file: !3, line: 15, size: 128, elements: !31)
!31 = !{!32, !33}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !30, file: !3, line: 16, baseType: !29, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !30, file: !3, line: 17, baseType: !34, size: 64, offset: 64)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!35 = !DICompositeType(tag: DW_TAG_structure_type, name: "L5", file: !3, line: 17, flags: DIFlagFwdDecl)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !26, file: !3, line: 22, baseType: !25, size: 64, offset: 64)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !17, file: !3, line: 32, baseType: !16, size: 64, offset: 64)
!38 = !{!"clang version 10.0.0-4ubuntu1 "}
!39 = !{i32 7, !"Dwarf Version", i32 4}
!40 = !{i32 2, !"Debug Info Version", i32 3}
!41 = !{i32 1, !"wchar_size", i32 4}
!42 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !43, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!43 = !DISubroutineType(types: !44)
!44 = !{null}
!45 = !DILocation(line: 3, column: 22, scope: !46)
!46 = distinct !DILexicalBlock(scope: !47, file: !3, line: 3, column: 22)
!47 = distinct !DILexicalBlock(scope: !42, file: !3, line: 3, column: 22)
!48 = !{i1 false}
!49 = !DILocation(line: 185, column: 5, scope: !2)
!50 = !DILocation(line: 186, column: 9, scope: !2)
!51 = !DILocation(line: 187, column: 12, scope: !2)
!52 = !{i1 true}
!53 = distinct !{!53, !49, !54}
!54 = !DILocation(line: 187, column: 35, scope: !2)
!55 = !DILocation(line: 189, column: 16, scope: !2)
!56 = !DILocation(line: 189, column: 5, scope: !2)
!57 = !DILocation(line: 190, column: 16, scope: !2)
!58 = !DILocation(line: 190, column: 5, scope: !2)
!59 = !DILocation(line: 191, column: 16, scope: !2)
!60 = !DILocation(line: 191, column: 5, scope: !2)
!61 = !DILocation(line: 192, column: 16, scope: !2)
!62 = !DILocation(line: 192, column: 5, scope: !2)
!63 = !DILocation(line: 193, column: 16, scope: !2)
!64 = !DILocation(line: 193, column: 5, scope: !2)
!65 = !DILocation(line: 195, column: 14, scope: !2)
!66 = !DILocation(line: 195, column: 13, scope: !2)
!67 = !DILocation(line: 195, column: 12, scope: !2)
!68 = !DILocation(line: 195, column: 5, scope: !2)
!69 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !70, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!70 = !DISubroutineType(types: !71)
!71 = !{null, !72}
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!73 = !DILocalVariable(name: "list", arg: 1, scope: !69, file: !3, line: 94, type: !72)
!74 = !DILocation(line: 0, scope: !69)
!75 = !DILocation(line: 96, column: 23, scope: !69)
!76 = !DILocalVariable(name: "item", scope: !69, file: !3, line: 96, type: !11)
!77 = !DILocation(line: 98, column: 5, scope: !69)
!78 = !DILocation(line: 99, column: 26, scope: !69)
!79 = !DILocation(line: 99, column: 9, scope: !69)
!80 = !DILocation(line: 100, column: 12, scope: !69)
!81 = distinct !{!81, !77, !82}
!82 = !DILocation(line: 100, column: 35, scope: !69)
!83 = !DILocation(line: 102, column: 18, scope: !69)
!84 = !DILocation(line: 102, column: 11, scope: !69)
!85 = !DILocation(line: 102, column: 16, scope: !69)
!86 = !DILocation(line: 103, column: 11, scope: !69)
!87 = !DILocation(line: 104, column: 1, scope: !69)
!88 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 166, type: !89, scopeLine: 167, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!89 = !DISubroutineType(types: !90)
!90 = !{null, !11, !6}
!91 = !DILocalVariable(name: "list", arg: 1, scope: !88, file: !3, line: 166, type: !11)
!92 = !DILocation(line: 0, scope: !88)
!93 = !DILocalVariable(name: "level", arg: 2, scope: !88, file: !3, line: 166, type: !6)
!94 = !DILocation(line: 168, column: 5, scope: !88)
!95 = !DILocation(line: 169, column: 15, scope: !96)
!96 = distinct !DILexicalBlock(scope: !97, file: !3, line: 169, column: 13)
!97 = distinct !DILexicalBlock(scope: !88, file: !3, line: 168, column: 8)
!98 = !DILocation(line: 169, column: 13, scope: !97)
!99 = !DILocation(line: 170, column: 30, scope: !96)
!100 = !DILocation(line: 170, column: 13, scope: !96)
!101 = !DILocation(line: 172, column: 33, scope: !97)
!102 = !DILocalVariable(name: "next", scope: !97, file: !3, line: 172, type: !11)
!103 = !DILocation(line: 0, scope: !97)
!104 = !DILocation(line: 173, column: 15, scope: !105)
!105 = distinct !DILexicalBlock(scope: !97, file: !3, line: 173, column: 13)
!106 = !DILocation(line: 173, column: 13, scope: !97)
!107 = !DILocation(line: 174, column: 18, scope: !105)
!108 = !DILocation(line: 174, column: 13, scope: !105)
!109 = !DILocation(line: 177, column: 5, scope: !97)
!110 = distinct !{!110, !94, !111}
!111 = !DILocation(line: 178, column: 16, scope: !88)
!112 = !DILocation(line: 179, column: 1, scope: !88)
!113 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 151, type: !114, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!114 = !DISubroutineType(types: !115)
!115 = !{null, !16, !6}
!116 = !DILocalVariable(name: "list", arg: 1, scope: !113, file: !3, line: 151, type: !16)
!117 = !DILocation(line: 0, scope: !113)
!118 = !DILocalVariable(name: "level", arg: 2, scope: !113, file: !3, line: 151, type: !6)
!119 = !DILocation(line: 153, column: 5, scope: !113)
!120 = !DILocation(line: 154, column: 15, scope: !121)
!121 = distinct !DILexicalBlock(scope: !122, file: !3, line: 154, column: 13)
!122 = distinct !DILexicalBlock(scope: !113, file: !3, line: 153, column: 8)
!123 = !DILocation(line: 154, column: 13, scope: !122)
!124 = !DILocation(line: 155, column: 30, scope: !121)
!125 = !DILocation(line: 155, column: 13, scope: !121)
!126 = !DILocation(line: 157, column: 33, scope: !122)
!127 = !DILocalVariable(name: "next", scope: !122, file: !3, line: 157, type: !16)
!128 = !DILocation(line: 0, scope: !122)
!129 = !DILocation(line: 158, column: 15, scope: !130)
!130 = distinct !DILexicalBlock(scope: !122, file: !3, line: 158, column: 13)
!131 = !DILocation(line: 158, column: 13, scope: !122)
!132 = !DILocation(line: 159, column: 18, scope: !130)
!133 = !DILocation(line: 159, column: 13, scope: !130)
!134 = !DILocation(line: 162, column: 5, scope: !122)
!135 = distinct !{!135, !119, !136}
!136 = !DILocation(line: 163, column: 16, scope: !113)
!137 = !DILocation(line: 164, column: 1, scope: !113)
!138 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 136, type: !139, scopeLine: 137, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!139 = !DISubroutineType(types: !140)
!140 = !{null, !20, !6}
!141 = !DILocalVariable(name: "list", arg: 1, scope: !138, file: !3, line: 136, type: !20)
!142 = !DILocation(line: 0, scope: !138)
!143 = !DILocalVariable(name: "level", arg: 2, scope: !138, file: !3, line: 136, type: !6)
!144 = !DILocation(line: 138, column: 5, scope: !138)
!145 = !DILocation(line: 139, column: 15, scope: !146)
!146 = distinct !DILexicalBlock(scope: !147, file: !3, line: 139, column: 13)
!147 = distinct !DILexicalBlock(scope: !138, file: !3, line: 138, column: 8)
!148 = !DILocation(line: 139, column: 13, scope: !147)
!149 = !DILocation(line: 140, column: 30, scope: !146)
!150 = !DILocation(line: 140, column: 13, scope: !146)
!151 = !DILocation(line: 142, column: 33, scope: !147)
!152 = !DILocalVariable(name: "next", scope: !147, file: !3, line: 142, type: !20)
!153 = !DILocation(line: 0, scope: !147)
!154 = !DILocation(line: 143, column: 15, scope: !155)
!155 = distinct !DILexicalBlock(scope: !147, file: !3, line: 143, column: 13)
!156 = !DILocation(line: 143, column: 13, scope: !147)
!157 = !DILocation(line: 144, column: 18, scope: !155)
!158 = !DILocation(line: 144, column: 13, scope: !155)
!159 = !DILocation(line: 147, column: 5, scope: !147)
!160 = distinct !{!160, !144, !161}
!161 = !DILocation(line: 148, column: 16, scope: !138)
!162 = !DILocation(line: 149, column: 1, scope: !138)
!163 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 121, type: !164, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!164 = !DISubroutineType(types: !165)
!165 = !{null, !25, !6}
!166 = !DILocalVariable(name: "list", arg: 1, scope: !163, file: !3, line: 121, type: !25)
!167 = !DILocation(line: 0, scope: !163)
!168 = !DILocalVariable(name: "level", arg: 2, scope: !163, file: !3, line: 121, type: !6)
!169 = !DILocation(line: 123, column: 5, scope: !163)
!170 = !DILocation(line: 124, column: 15, scope: !171)
!171 = distinct !DILexicalBlock(scope: !172, file: !3, line: 124, column: 13)
!172 = distinct !DILexicalBlock(scope: !163, file: !3, line: 123, column: 8)
!173 = !DILocation(line: 124, column: 13, scope: !172)
!174 = !DILocation(line: 125, column: 30, scope: !171)
!175 = !DILocation(line: 125, column: 13, scope: !171)
!176 = !DILocation(line: 127, column: 33, scope: !172)
!177 = !DILocalVariable(name: "next", scope: !172, file: !3, line: 127, type: !25)
!178 = !DILocation(line: 0, scope: !172)
!179 = !DILocation(line: 128, column: 15, scope: !180)
!180 = distinct !DILexicalBlock(scope: !172, file: !3, line: 128, column: 13)
!181 = !DILocation(line: 128, column: 13, scope: !172)
!182 = !DILocation(line: 129, column: 18, scope: !180)
!183 = !DILocation(line: 129, column: 13, scope: !180)
!184 = !DILocation(line: 132, column: 5, scope: !172)
!185 = distinct !{!185, !169, !186}
!186 = !DILocation(line: 133, column: 16, scope: !163)
!187 = !DILocation(line: 134, column: 1, scope: !163)
!188 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !189, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!189 = !DISubroutineType(types: !190)
!190 = !{null, !29, !6}
!191 = !DILocalVariable(name: "list", arg: 1, scope: !188, file: !3, line: 106, type: !29)
!192 = !DILocation(line: 0, scope: !188)
!193 = !DILocalVariable(name: "level", arg: 2, scope: !188, file: !3, line: 106, type: !6)
!194 = !DILocation(line: 108, column: 5, scope: !188)
!195 = !DILocation(line: 109, column: 15, scope: !196)
!196 = distinct !DILexicalBlock(scope: !197, file: !3, line: 109, column: 13)
!197 = distinct !DILexicalBlock(scope: !188, file: !3, line: 108, column: 8)
!198 = !DILocation(line: 109, column: 13, scope: !197)
!199 = !DILocation(line: 110, column: 24, scope: !196)
!200 = !DILocation(line: 110, column: 18, scope: !196)
!201 = !DILocation(line: 110, column: 13, scope: !196)
!202 = !DILocation(line: 112, column: 33, scope: !197)
!203 = !DILocalVariable(name: "next", scope: !197, file: !3, line: 112, type: !29)
!204 = !DILocation(line: 0, scope: !197)
!205 = !DILocation(line: 113, column: 15, scope: !206)
!206 = distinct !DILexicalBlock(scope: !197, file: !3, line: 113, column: 13)
!207 = !DILocation(line: 113, column: 13, scope: !197)
!208 = !DILocation(line: 114, column: 18, scope: !206)
!209 = !DILocation(line: 114, column: 13, scope: !206)
!210 = !DILocation(line: 117, column: 5, scope: !197)
!211 = distinct !{!211, !194, !212}
!212 = !DILocation(line: 118, column: 16, scope: !188)
!213 = !DILocation(line: 119, column: 1, scope: !188)
!214 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !215, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!215 = !DISubroutineType(types: !216)
!216 = !{!217, !218}
!217 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!218 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!219 = !DILocalVariable(name: "size", arg: 1, scope: !214, file: !3, line: 40, type: !218)
!220 = !DILocation(line: 0, scope: !214)
!221 = !DILocation(line: 42, column: 34, scope: !214)
!222 = !DILocation(line: 42, column: 17, scope: !214)
!223 = !DILocalVariable(name: "ptr", scope: !214, file: !3, line: 42, type: !217)
!224 = !DILocation(line: 43, column: 9, scope: !225)
!225 = distinct !DILexicalBlock(scope: !214, file: !3, line: 43, column: 9)
!226 = !DILocation(line: 43, column: 9, scope: !214)
!227 = !DILocation(line: 44, column: 9, scope: !225)
!228 = !DILocation(line: 46, column: 5, scope: !214)
!229 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !230, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!230 = !DISubroutineType(types: !231)
!231 = !{null, !232}
!232 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!233 = !DILocalVariable(name: "list", arg: 1, scope: !229, file: !3, line: 82, type: !232)
!234 = !DILocation(line: 0, scope: !229)
!235 = !DILocation(line: 84, column: 23, scope: !229)
!236 = !DILocalVariable(name: "item", scope: !229, file: !3, line: 84, type: !16)
!237 = !DILocation(line: 86, column: 5, scope: !229)
!238 = !DILocation(line: 87, column: 26, scope: !229)
!239 = !DILocation(line: 87, column: 9, scope: !229)
!240 = !DILocation(line: 88, column: 12, scope: !229)
!241 = distinct !{!241, !237, !242}
!242 = !DILocation(line: 88, column: 35, scope: !229)
!243 = !DILocation(line: 90, column: 18, scope: !229)
!244 = !DILocation(line: 90, column: 11, scope: !229)
!245 = !DILocation(line: 90, column: 16, scope: !229)
!246 = !DILocation(line: 91, column: 11, scope: !229)
!247 = !DILocation(line: 92, column: 1, scope: !229)
!248 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !249, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!249 = !DISubroutineType(types: !250)
!250 = !{null, !251}
!251 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!252 = !DILocalVariable(name: "list", arg: 1, scope: !248, file: !3, line: 70, type: !251)
!253 = !DILocation(line: 0, scope: !248)
!254 = !DILocation(line: 72, column: 23, scope: !248)
!255 = !DILocalVariable(name: "item", scope: !248, file: !3, line: 72, type: !20)
!256 = !DILocation(line: 74, column: 5, scope: !248)
!257 = !DILocation(line: 75, column: 26, scope: !248)
!258 = !DILocation(line: 75, column: 9, scope: !248)
!259 = !DILocation(line: 76, column: 12, scope: !248)
!260 = distinct !{!260, !256, !261}
!261 = !DILocation(line: 76, column: 35, scope: !248)
!262 = !DILocation(line: 78, column: 18, scope: !248)
!263 = !DILocation(line: 78, column: 11, scope: !248)
!264 = !DILocation(line: 78, column: 16, scope: !248)
!265 = !DILocation(line: 79, column: 11, scope: !248)
!266 = !DILocation(line: 80, column: 1, scope: !248)
!267 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !268, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!268 = !DISubroutineType(types: !269)
!269 = !{null, !270}
!270 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!271 = !DILocalVariable(name: "list", arg: 1, scope: !267, file: !3, line: 58, type: !270)
!272 = !DILocation(line: 0, scope: !267)
!273 = !DILocation(line: 60, column: 23, scope: !267)
!274 = !DILocalVariable(name: "item", scope: !267, file: !3, line: 60, type: !25)
!275 = !DILocation(line: 62, column: 5, scope: !267)
!276 = !DILocation(line: 63, column: 26, scope: !267)
!277 = !DILocation(line: 63, column: 9, scope: !267)
!278 = !DILocation(line: 64, column: 12, scope: !267)
!279 = distinct !{!279, !275, !280}
!280 = !DILocation(line: 64, column: 35, scope: !267)
!281 = !DILocation(line: 66, column: 18, scope: !267)
!282 = !DILocation(line: 66, column: 11, scope: !267)
!283 = !DILocation(line: 66, column: 16, scope: !267)
!284 = !DILocation(line: 67, column: 11, scope: !267)
!285 = !DILocation(line: 68, column: 1, scope: !267)
!286 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !287, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!287 = !DISubroutineType(types: !288)
!288 = !{null, !289}
!289 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!290 = !DILocalVariable(name: "list", arg: 1, scope: !286, file: !3, line: 49, type: !289)
!291 = !DILocation(line: 0, scope: !286)
!292 = !DILocation(line: 51, column: 23, scope: !286)
!293 = !DILocalVariable(name: "item", scope: !286, file: !3, line: 51, type: !29)
!294 = !DILocation(line: 52, column: 18, scope: !286)
!295 = !DILocation(line: 52, column: 11, scope: !286)
!296 = !DILocation(line: 52, column: 16, scope: !286)
!297 = !DILocation(line: 54, column: 18, scope: !286)
!298 = !DILocation(line: 54, column: 11, scope: !286)
!299 = !DILocation(line: 54, column: 16, scope: !286)
!300 = !DILocation(line: 55, column: 11, scope: !286)
!301 = !DILocation(line: 56, column: 1, scope: !286)
!302 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !303, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!303 = !DISubroutineType(types: !304)
!304 = !{!217, !305, !305}
!305 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !306, line: 46, baseType: !307)
!306 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!307 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!308 = !DILocalVariable(name: "nmemb", arg: 1, scope: !302, file: !3, line: 8, type: !305)
!309 = !DILocation(line: 0, scope: !302)
!310 = !DILocalVariable(name: "size", arg: 2, scope: !302, file: !3, line: 8, type: !305)
!311 = !DILocation(line: 9, column: 30, scope: !302)
!312 = !DILocation(line: 9, column: 17, scope: !302)
!313 = !DILocalVariable(name: "ptr", scope: !302, file: !3, line: 9, type: !217)
!314 = !DILocation(line: 10, column: 33, scope: !302)
!315 = !DILocation(line: 10, column: 12, scope: !302)
!316 = !DILocation(line: 10, column: 5, scope: !302)
