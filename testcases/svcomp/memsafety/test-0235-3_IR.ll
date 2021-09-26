; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-1ppysc4g.bc'
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
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0235-3.c\00", align 1
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
  call void @l0_destroy(%struct.L0* %6, i32 5), !dbg !56, !verifier.code !48
  %7 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !57, !verifier.code !48
  call void @l0_destroy(%struct.L0* %7, i32 4), !dbg !58, !verifier.code !48
  %8 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !59, !verifier.code !48
  call void @l0_destroy(%struct.L0* %8, i32 3), !dbg !60, !verifier.code !48
  %9 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !61, !verifier.code !48
  call void @l0_destroy(%struct.L0* %9, i32 2), !dbg !62, !verifier.code !48
  %10 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !63, !verifier.code !48
  call void @l0_destroy(%struct.L0* %10, i32 2), !dbg !64, !verifier.code !48
  %11 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !65, !verifier.code !48
  call void @l0_destroy(%struct.L0* %11, i32 1), !dbg !66, !verifier.code !48
  %12 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !67, !verifier.code !48
  call void @l0_destroy(%struct.L0* %12, i32 0), !dbg !68, !verifier.code !48
  %13 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !69, !verifier.code !48
  %14 = icmp ne %struct.L0* %13, null, !dbg !70, !verifier.code !48
  %15 = xor i1 %14, true, !dbg !70, !verifier.code !48
  %16 = xor i1 %15, true, !dbg !71, !verifier.code !48
  %17 = zext i1 %16 to i32, !dbg !71, !verifier.code !48
  ret i32 %17, !dbg !72, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !73 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !77, metadata !DIExpression()), !dbg !78, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !79, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !79, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !80, metadata !DIExpression()), !dbg !78, !verifier.code !48
  br label %4, !dbg !81, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !82, !verifier.code !48
  call void @l1_insert(%struct.L1** %5), !dbg !83, !verifier.code !48
  br label %6, !dbg !83, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !84, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !83, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !83, !llvm.loop !85, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !87, !verifier.code !48
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !88, !verifier.code !48
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !89, !verifier.code !48
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !90, !verifier.code !48
  ret void, !dbg !91, !verifier.code !48
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0, i32 %1) #0 !dbg !92 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !97, metadata !DIExpression()), !dbg !96, !verifier.code !48
  br label %3, !dbg !98, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L0* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !48
  %4 = icmp slt i32 0, %1, !dbg !99, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !102, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !103, !verifier.code !48
  %7 = load %struct.L1*, %struct.L1** %6, align 8, !dbg !103, !verifier.code !48
  call void @l1_destroy(%struct.L1* %7, i32 %1), !dbg !104, !verifier.code !48
  br label %8, !dbg !104, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !105, !verifier.code !48
  %10 = load %struct.L0*, %struct.L0** %9, align 8, !dbg !105, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !106, metadata !DIExpression()), !dbg !107, !verifier.code !48
  %11 = icmp eq i32 0, %1, !dbg !108, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !110, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L0* %.0 to i8*, !dbg !111, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !112, !verifier.code !48
  br label %14, !dbg !112, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !48
  br label %15, !dbg !113, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L0* %10, null, !dbg !113, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !113, !llvm.loop !114, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !116, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0, i32 %1) #0 !dbg !117 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !122, metadata !DIExpression()), !dbg !121, !verifier.code !48
  br label %3, !dbg !123, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L1* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !48
  %4 = icmp slt i32 1, %1, !dbg !124, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !127, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !128, !verifier.code !48
  %7 = load %struct.L2*, %struct.L2** %6, align 8, !dbg !128, !verifier.code !48
  call void @l2_destroy(%struct.L2* %7, i32 %1), !dbg !129, !verifier.code !48
  br label %8, !dbg !129, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !130, !verifier.code !48
  %10 = load %struct.L1*, %struct.L1** %9, align 8, !dbg !130, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !131, metadata !DIExpression()), !dbg !132, !verifier.code !48
  %11 = icmp eq i32 1, %1, !dbg !133, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !135, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L1* %.0 to i8*, !dbg !136, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !137, !verifier.code !48
  br label %14, !dbg !137, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !48
  br label %15, !dbg !138, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L1* %10, null, !dbg !138, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !138, !llvm.loop !139, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !141, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0, i32 %1) #0 !dbg !142 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !147, metadata !DIExpression()), !dbg !146, !verifier.code !48
  br label %3, !dbg !148, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L2* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !48
  %4 = icmp slt i32 2, %1, !dbg !149, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !152, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !153, !verifier.code !48
  %7 = load %struct.L3*, %struct.L3** %6, align 8, !dbg !153, !verifier.code !48
  call void @l3_destroy(%struct.L3* %7, i32 %1), !dbg !154, !verifier.code !48
  br label %8, !dbg !154, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !155, !verifier.code !48
  %10 = load %struct.L2*, %struct.L2** %9, align 8, !dbg !155, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !156, metadata !DIExpression()), !dbg !157, !verifier.code !48
  %11 = icmp eq i32 2, %1, !dbg !158, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !160, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L2* %.0 to i8*, !dbg !161, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !162, !verifier.code !48
  br label %14, !dbg !162, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !48
  br label %15, !dbg !163, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L2* %10, null, !dbg !163, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !163, !llvm.loop !164, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !166, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0, i32 %1) #0 !dbg !167 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !170, metadata !DIExpression()), !dbg !171, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !172, metadata !DIExpression()), !dbg !171, !verifier.code !48
  br label %3, !dbg !173, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L3* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !170, metadata !DIExpression()), !dbg !171, !verifier.code !48
  %4 = icmp slt i32 3, %1, !dbg !174, !verifier.code !48
  br i1 %4, label %5, label %8, !dbg !177, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !178, !verifier.code !48
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !178, !verifier.code !48
  call void @l4_destroy(%struct.L4* %7, i32 %1), !dbg !179, !verifier.code !48
  br label %8, !dbg !179, !verifier.code !48

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !180, !verifier.code !48
  %10 = load %struct.L3*, %struct.L3** %9, align 8, !dbg !180, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !181, metadata !DIExpression()), !dbg !182, !verifier.code !48
  %11 = icmp eq i32 3, %1, !dbg !183, !verifier.code !48
  br i1 %11, label %12, label %14, !dbg !185, !verifier.code !48

12:                                               ; preds = %8
  %13 = bitcast %struct.L3* %.0 to i8*, !dbg !186, !verifier.code !48
  call void @free(i8* %13) #7, !dbg !187, !verifier.code !48
  br label %14, !dbg !187, !verifier.code !48

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !170, metadata !DIExpression()), !dbg !171, !verifier.code !48
  br label %15, !dbg !188, !verifier.code !48

15:                                               ; preds = %14
  %16 = icmp ne %struct.L3* %10, null, !dbg !188, !verifier.code !48
  br i1 %16, label %forwarder, label %17, !dbg !188, !llvm.loop !189, !verifier.code !48

17:                                               ; preds = %15
  ret void, !dbg !191, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0, i32 %1) #0 !dbg !192 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !195, metadata !DIExpression()), !dbg !196, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !197, metadata !DIExpression()), !dbg !196, !verifier.code !48
  br label %3, !dbg !198, !verifier.code !48

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L4* [ %0, %2 ], [ %11, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !195, metadata !DIExpression()), !dbg !196, !verifier.code !48
  %4 = icmp eq i32 5, %1, !dbg !199, !verifier.code !48
  br i1 %4, label %5, label %9, !dbg !202, !verifier.code !48

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !203, !verifier.code !48
  %7 = load %struct.L5*, %struct.L5** %6, align 8, !dbg !203, !verifier.code !48
  %8 = bitcast %struct.L5* %7 to i8*, !dbg !204, !verifier.code !48
  call void @free(i8* %8) #7, !dbg !205, !verifier.code !48
  br label %9, !dbg !205, !verifier.code !48

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !206, !verifier.code !48
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !206, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !207, metadata !DIExpression()), !dbg !208, !verifier.code !48
  %12 = icmp eq i32 4, %1, !dbg !209, !verifier.code !48
  br i1 %12, label %13, label %15, !dbg !211, !verifier.code !48

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !212, !verifier.code !48
  call void @free(i8* %14) #7, !dbg !213, !verifier.code !48
  br label %15, !dbg !213, !verifier.code !48

15:                                               ; preds = %13, %9
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !195, metadata !DIExpression()), !dbg !196, !verifier.code !48
  br label %16, !dbg !214, !verifier.code !48

16:                                               ; preds = %15
  %17 = icmp ne %struct.L4* %11, null, !dbg !214, !verifier.code !48
  br i1 %17, label %forwarder, label %18, !dbg !214, !llvm.loop !215, !verifier.code !48

18:                                               ; preds = %16
  ret void, !dbg !217, !verifier.code !48

forwarder:                                        ; preds = %16
  br label %3, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !218 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !223, metadata !DIExpression()), !dbg !224, !verifier.code !48
  %2 = zext i32 %0 to i64, !dbg !225, !verifier.code !48
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !226, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %3, metadata !227, metadata !DIExpression()), !dbg !224, !verifier.code !48
  %4 = icmp ne i8* %3, null, !dbg !228, !verifier.code !48
  br i1 %4, label %5, label %6, !dbg !230, !verifier.code !48

5:                                                ; preds = %1
  ret i8* %3, !dbg !231, !verifier.code !48

6:                                                ; preds = %1
  call void @abort() #6, !dbg !232, !verifier.code !48
  unreachable, !dbg !232, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !233 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !237, metadata !DIExpression()), !dbg !238, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !239, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !239, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !240, metadata !DIExpression()), !dbg !238, !verifier.code !48
  br label %4, !dbg !241, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !242, !verifier.code !48
  call void @l2_insert(%struct.L2** %5), !dbg !243, !verifier.code !48
  br label %6, !dbg !243, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !244, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !243, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !243, !llvm.loop !245, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !247, !verifier.code !48
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !248, !verifier.code !48
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !249, !verifier.code !48
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !250, !verifier.code !48
  ret void, !dbg !251, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !252 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !256, metadata !DIExpression()), !dbg !257, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !258, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !258, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !259, metadata !DIExpression()), !dbg !257, !verifier.code !48
  br label %4, !dbg !260, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !261, !verifier.code !48
  call void @l3_insert(%struct.L3** %5), !dbg !262, !verifier.code !48
  br label %6, !dbg !262, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !263, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !262, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !262, !llvm.loop !264, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !266, !verifier.code !48
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !267, !verifier.code !48
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !268, !verifier.code !48
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !269, !verifier.code !48
  ret void, !dbg !270, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !271 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !275, metadata !DIExpression()), !dbg !276, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !277, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !277, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !278, metadata !DIExpression()), !dbg !276, !verifier.code !48
  br label %4, !dbg !279, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !280, !verifier.code !48
  call void @l4_insert(%struct.L4** %5), !dbg !281, !verifier.code !48
  br label %6, !dbg !281, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !282, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !281, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !281, !llvm.loop !283, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !285, !verifier.code !48
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !286, !verifier.code !48
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !287, !verifier.code !48
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !288, !verifier.code !48
  ret void, !dbg !289, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !290 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !294, metadata !DIExpression()), !dbg !295, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !296, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !296, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !297, metadata !DIExpression()), !dbg !295, !verifier.code !48
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !298, !verifier.code !48
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !298, !verifier.code !48
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !299, !verifier.code !48
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !300, !verifier.code !48
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !301, !verifier.code !48
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !302, !verifier.code !48
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !303, !verifier.code !48
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !304, !verifier.code !48
  ret void, !dbg !305, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !306 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !312, metadata !DIExpression()), !dbg !313, !verifier.code !48
  call void @llvm.dbg.value(metadata i64 %1, metadata !314, metadata !DIExpression()), !dbg !313, !verifier.code !48
  %3 = mul i64 %0, %1, !dbg !315, !verifier.code !48
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !316, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %4, metadata !317, metadata !DIExpression()), !dbg !313, !verifier.code !48
  %5 = mul i64 %0, %1, !dbg !318, !verifier.code !48
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !319, !verifier.code !48
  ret i8* %4, !dbg !320, !verifier.code !48
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
!3 = !DIFile(filename: "../svcomp/memsafety//test-0235-3.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !8, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, globals: !10, splitDebugInlining: false, nameTableKind: None)
!8 = !DIFile(filename: "../svcomp/memsafety/test-0235-3.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
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
!65 = !DILocation(line: 194, column: 16, scope: !2)
!66 = !DILocation(line: 194, column: 5, scope: !2)
!67 = !DILocation(line: 195, column: 16, scope: !2)
!68 = !DILocation(line: 195, column: 5, scope: !2)
!69 = !DILocation(line: 197, column: 14, scope: !2)
!70 = !DILocation(line: 197, column: 13, scope: !2)
!71 = !DILocation(line: 197, column: 12, scope: !2)
!72 = !DILocation(line: 197, column: 5, scope: !2)
!73 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !74, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!74 = !DISubroutineType(types: !75)
!75 = !{null, !76}
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!77 = !DILocalVariable(name: "list", arg: 1, scope: !73, file: !3, line: 94, type: !76)
!78 = !DILocation(line: 0, scope: !73)
!79 = !DILocation(line: 96, column: 23, scope: !73)
!80 = !DILocalVariable(name: "item", scope: !73, file: !3, line: 96, type: !11)
!81 = !DILocation(line: 98, column: 5, scope: !73)
!82 = !DILocation(line: 99, column: 26, scope: !73)
!83 = !DILocation(line: 99, column: 9, scope: !73)
!84 = !DILocation(line: 100, column: 12, scope: !73)
!85 = distinct !{!85, !81, !86}
!86 = !DILocation(line: 100, column: 35, scope: !73)
!87 = !DILocation(line: 102, column: 18, scope: !73)
!88 = !DILocation(line: 102, column: 11, scope: !73)
!89 = !DILocation(line: 102, column: 16, scope: !73)
!90 = !DILocation(line: 103, column: 11, scope: !73)
!91 = !DILocation(line: 104, column: 1, scope: !73)
!92 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 166, type: !93, scopeLine: 167, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!93 = !DISubroutineType(types: !94)
!94 = !{null, !11, !6}
!95 = !DILocalVariable(name: "list", arg: 1, scope: !92, file: !3, line: 166, type: !11)
!96 = !DILocation(line: 0, scope: !92)
!97 = !DILocalVariable(name: "level", arg: 2, scope: !92, file: !3, line: 166, type: !6)
!98 = !DILocation(line: 168, column: 5, scope: !92)
!99 = !DILocation(line: 169, column: 15, scope: !100)
!100 = distinct !DILexicalBlock(scope: !101, file: !3, line: 169, column: 13)
!101 = distinct !DILexicalBlock(scope: !92, file: !3, line: 168, column: 8)
!102 = !DILocation(line: 169, column: 13, scope: !101)
!103 = !DILocation(line: 170, column: 30, scope: !100)
!104 = !DILocation(line: 170, column: 13, scope: !100)
!105 = !DILocation(line: 172, column: 33, scope: !101)
!106 = !DILocalVariable(name: "next", scope: !101, file: !3, line: 172, type: !11)
!107 = !DILocation(line: 0, scope: !101)
!108 = !DILocation(line: 173, column: 15, scope: !109)
!109 = distinct !DILexicalBlock(scope: !101, file: !3, line: 173, column: 13)
!110 = !DILocation(line: 173, column: 13, scope: !101)
!111 = !DILocation(line: 174, column: 18, scope: !109)
!112 = !DILocation(line: 174, column: 13, scope: !109)
!113 = !DILocation(line: 177, column: 5, scope: !101)
!114 = distinct !{!114, !98, !115}
!115 = !DILocation(line: 178, column: 16, scope: !92)
!116 = !DILocation(line: 179, column: 1, scope: !92)
!117 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 151, type: !118, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!118 = !DISubroutineType(types: !119)
!119 = !{null, !16, !6}
!120 = !DILocalVariable(name: "list", arg: 1, scope: !117, file: !3, line: 151, type: !16)
!121 = !DILocation(line: 0, scope: !117)
!122 = !DILocalVariable(name: "level", arg: 2, scope: !117, file: !3, line: 151, type: !6)
!123 = !DILocation(line: 153, column: 5, scope: !117)
!124 = !DILocation(line: 154, column: 15, scope: !125)
!125 = distinct !DILexicalBlock(scope: !126, file: !3, line: 154, column: 13)
!126 = distinct !DILexicalBlock(scope: !117, file: !3, line: 153, column: 8)
!127 = !DILocation(line: 154, column: 13, scope: !126)
!128 = !DILocation(line: 155, column: 30, scope: !125)
!129 = !DILocation(line: 155, column: 13, scope: !125)
!130 = !DILocation(line: 157, column: 33, scope: !126)
!131 = !DILocalVariable(name: "next", scope: !126, file: !3, line: 157, type: !16)
!132 = !DILocation(line: 0, scope: !126)
!133 = !DILocation(line: 158, column: 15, scope: !134)
!134 = distinct !DILexicalBlock(scope: !126, file: !3, line: 158, column: 13)
!135 = !DILocation(line: 158, column: 13, scope: !126)
!136 = !DILocation(line: 159, column: 18, scope: !134)
!137 = !DILocation(line: 159, column: 13, scope: !134)
!138 = !DILocation(line: 162, column: 5, scope: !126)
!139 = distinct !{!139, !123, !140}
!140 = !DILocation(line: 163, column: 16, scope: !117)
!141 = !DILocation(line: 164, column: 1, scope: !117)
!142 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 136, type: !143, scopeLine: 137, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!143 = !DISubroutineType(types: !144)
!144 = !{null, !20, !6}
!145 = !DILocalVariable(name: "list", arg: 1, scope: !142, file: !3, line: 136, type: !20)
!146 = !DILocation(line: 0, scope: !142)
!147 = !DILocalVariable(name: "level", arg: 2, scope: !142, file: !3, line: 136, type: !6)
!148 = !DILocation(line: 138, column: 5, scope: !142)
!149 = !DILocation(line: 139, column: 15, scope: !150)
!150 = distinct !DILexicalBlock(scope: !151, file: !3, line: 139, column: 13)
!151 = distinct !DILexicalBlock(scope: !142, file: !3, line: 138, column: 8)
!152 = !DILocation(line: 139, column: 13, scope: !151)
!153 = !DILocation(line: 140, column: 30, scope: !150)
!154 = !DILocation(line: 140, column: 13, scope: !150)
!155 = !DILocation(line: 142, column: 33, scope: !151)
!156 = !DILocalVariable(name: "next", scope: !151, file: !3, line: 142, type: !20)
!157 = !DILocation(line: 0, scope: !151)
!158 = !DILocation(line: 143, column: 15, scope: !159)
!159 = distinct !DILexicalBlock(scope: !151, file: !3, line: 143, column: 13)
!160 = !DILocation(line: 143, column: 13, scope: !151)
!161 = !DILocation(line: 144, column: 18, scope: !159)
!162 = !DILocation(line: 144, column: 13, scope: !159)
!163 = !DILocation(line: 147, column: 5, scope: !151)
!164 = distinct !{!164, !148, !165}
!165 = !DILocation(line: 148, column: 16, scope: !142)
!166 = !DILocation(line: 149, column: 1, scope: !142)
!167 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 121, type: !168, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!168 = !DISubroutineType(types: !169)
!169 = !{null, !25, !6}
!170 = !DILocalVariable(name: "list", arg: 1, scope: !167, file: !3, line: 121, type: !25)
!171 = !DILocation(line: 0, scope: !167)
!172 = !DILocalVariable(name: "level", arg: 2, scope: !167, file: !3, line: 121, type: !6)
!173 = !DILocation(line: 123, column: 5, scope: !167)
!174 = !DILocation(line: 124, column: 15, scope: !175)
!175 = distinct !DILexicalBlock(scope: !176, file: !3, line: 124, column: 13)
!176 = distinct !DILexicalBlock(scope: !167, file: !3, line: 123, column: 8)
!177 = !DILocation(line: 124, column: 13, scope: !176)
!178 = !DILocation(line: 125, column: 30, scope: !175)
!179 = !DILocation(line: 125, column: 13, scope: !175)
!180 = !DILocation(line: 127, column: 33, scope: !176)
!181 = !DILocalVariable(name: "next", scope: !176, file: !3, line: 127, type: !25)
!182 = !DILocation(line: 0, scope: !176)
!183 = !DILocation(line: 128, column: 15, scope: !184)
!184 = distinct !DILexicalBlock(scope: !176, file: !3, line: 128, column: 13)
!185 = !DILocation(line: 128, column: 13, scope: !176)
!186 = !DILocation(line: 129, column: 18, scope: !184)
!187 = !DILocation(line: 129, column: 13, scope: !184)
!188 = !DILocation(line: 132, column: 5, scope: !176)
!189 = distinct !{!189, !173, !190}
!190 = !DILocation(line: 133, column: 16, scope: !167)
!191 = !DILocation(line: 134, column: 1, scope: !167)
!192 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !193, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!193 = !DISubroutineType(types: !194)
!194 = !{null, !29, !6}
!195 = !DILocalVariable(name: "list", arg: 1, scope: !192, file: !3, line: 106, type: !29)
!196 = !DILocation(line: 0, scope: !192)
!197 = !DILocalVariable(name: "level", arg: 2, scope: !192, file: !3, line: 106, type: !6)
!198 = !DILocation(line: 108, column: 5, scope: !192)
!199 = !DILocation(line: 109, column: 15, scope: !200)
!200 = distinct !DILexicalBlock(scope: !201, file: !3, line: 109, column: 13)
!201 = distinct !DILexicalBlock(scope: !192, file: !3, line: 108, column: 8)
!202 = !DILocation(line: 109, column: 13, scope: !201)
!203 = !DILocation(line: 110, column: 24, scope: !200)
!204 = !DILocation(line: 110, column: 18, scope: !200)
!205 = !DILocation(line: 110, column: 13, scope: !200)
!206 = !DILocation(line: 112, column: 33, scope: !201)
!207 = !DILocalVariable(name: "next", scope: !201, file: !3, line: 112, type: !29)
!208 = !DILocation(line: 0, scope: !201)
!209 = !DILocation(line: 113, column: 15, scope: !210)
!210 = distinct !DILexicalBlock(scope: !201, file: !3, line: 113, column: 13)
!211 = !DILocation(line: 113, column: 13, scope: !201)
!212 = !DILocation(line: 114, column: 18, scope: !210)
!213 = !DILocation(line: 114, column: 13, scope: !210)
!214 = !DILocation(line: 117, column: 5, scope: !201)
!215 = distinct !{!215, !198, !216}
!216 = !DILocation(line: 118, column: 16, scope: !192)
!217 = !DILocation(line: 119, column: 1, scope: !192)
!218 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !219, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!219 = !DISubroutineType(types: !220)
!220 = !{!221, !222}
!221 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!222 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!223 = !DILocalVariable(name: "size", arg: 1, scope: !218, file: !3, line: 40, type: !222)
!224 = !DILocation(line: 0, scope: !218)
!225 = !DILocation(line: 42, column: 34, scope: !218)
!226 = !DILocation(line: 42, column: 17, scope: !218)
!227 = !DILocalVariable(name: "ptr", scope: !218, file: !3, line: 42, type: !221)
!228 = !DILocation(line: 43, column: 9, scope: !229)
!229 = distinct !DILexicalBlock(scope: !218, file: !3, line: 43, column: 9)
!230 = !DILocation(line: 43, column: 9, scope: !218)
!231 = !DILocation(line: 44, column: 9, scope: !229)
!232 = !DILocation(line: 46, column: 5, scope: !218)
!233 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !234, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!234 = !DISubroutineType(types: !235)
!235 = !{null, !236}
!236 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!237 = !DILocalVariable(name: "list", arg: 1, scope: !233, file: !3, line: 82, type: !236)
!238 = !DILocation(line: 0, scope: !233)
!239 = !DILocation(line: 84, column: 23, scope: !233)
!240 = !DILocalVariable(name: "item", scope: !233, file: !3, line: 84, type: !16)
!241 = !DILocation(line: 86, column: 5, scope: !233)
!242 = !DILocation(line: 87, column: 26, scope: !233)
!243 = !DILocation(line: 87, column: 9, scope: !233)
!244 = !DILocation(line: 88, column: 12, scope: !233)
!245 = distinct !{!245, !241, !246}
!246 = !DILocation(line: 88, column: 35, scope: !233)
!247 = !DILocation(line: 90, column: 18, scope: !233)
!248 = !DILocation(line: 90, column: 11, scope: !233)
!249 = !DILocation(line: 90, column: 16, scope: !233)
!250 = !DILocation(line: 91, column: 11, scope: !233)
!251 = !DILocation(line: 92, column: 1, scope: !233)
!252 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !253, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!253 = !DISubroutineType(types: !254)
!254 = !{null, !255}
!255 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!256 = !DILocalVariable(name: "list", arg: 1, scope: !252, file: !3, line: 70, type: !255)
!257 = !DILocation(line: 0, scope: !252)
!258 = !DILocation(line: 72, column: 23, scope: !252)
!259 = !DILocalVariable(name: "item", scope: !252, file: !3, line: 72, type: !20)
!260 = !DILocation(line: 74, column: 5, scope: !252)
!261 = !DILocation(line: 75, column: 26, scope: !252)
!262 = !DILocation(line: 75, column: 9, scope: !252)
!263 = !DILocation(line: 76, column: 12, scope: !252)
!264 = distinct !{!264, !260, !265}
!265 = !DILocation(line: 76, column: 35, scope: !252)
!266 = !DILocation(line: 78, column: 18, scope: !252)
!267 = !DILocation(line: 78, column: 11, scope: !252)
!268 = !DILocation(line: 78, column: 16, scope: !252)
!269 = !DILocation(line: 79, column: 11, scope: !252)
!270 = !DILocation(line: 80, column: 1, scope: !252)
!271 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !272, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!272 = !DISubroutineType(types: !273)
!273 = !{null, !274}
!274 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!275 = !DILocalVariable(name: "list", arg: 1, scope: !271, file: !3, line: 58, type: !274)
!276 = !DILocation(line: 0, scope: !271)
!277 = !DILocation(line: 60, column: 23, scope: !271)
!278 = !DILocalVariable(name: "item", scope: !271, file: !3, line: 60, type: !25)
!279 = !DILocation(line: 62, column: 5, scope: !271)
!280 = !DILocation(line: 63, column: 26, scope: !271)
!281 = !DILocation(line: 63, column: 9, scope: !271)
!282 = !DILocation(line: 64, column: 12, scope: !271)
!283 = distinct !{!283, !279, !284}
!284 = !DILocation(line: 64, column: 35, scope: !271)
!285 = !DILocation(line: 66, column: 18, scope: !271)
!286 = !DILocation(line: 66, column: 11, scope: !271)
!287 = !DILocation(line: 66, column: 16, scope: !271)
!288 = !DILocation(line: 67, column: 11, scope: !271)
!289 = !DILocation(line: 68, column: 1, scope: !271)
!290 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !291, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!291 = !DISubroutineType(types: !292)
!292 = !{null, !293}
!293 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!294 = !DILocalVariable(name: "list", arg: 1, scope: !290, file: !3, line: 49, type: !293)
!295 = !DILocation(line: 0, scope: !290)
!296 = !DILocation(line: 51, column: 23, scope: !290)
!297 = !DILocalVariable(name: "item", scope: !290, file: !3, line: 51, type: !29)
!298 = !DILocation(line: 52, column: 18, scope: !290)
!299 = !DILocation(line: 52, column: 11, scope: !290)
!300 = !DILocation(line: 52, column: 16, scope: !290)
!301 = !DILocation(line: 54, column: 18, scope: !290)
!302 = !DILocation(line: 54, column: 11, scope: !290)
!303 = !DILocation(line: 54, column: 16, scope: !290)
!304 = !DILocation(line: 55, column: 11, scope: !290)
!305 = !DILocation(line: 56, column: 1, scope: !290)
!306 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !307, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!307 = !DISubroutineType(types: !308)
!308 = !{!221, !309, !309}
!309 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !310, line: 46, baseType: !311)
!310 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!311 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!312 = !DILocalVariable(name: "nmemb", arg: 1, scope: !306, file: !3, line: 8, type: !309)
!313 = !DILocation(line: 0, scope: !306)
!314 = !DILocalVariable(name: "size", arg: 2, scope: !306, file: !3, line: 8, type: !309)
!315 = !DILocation(line: 9, column: 30, scope: !306)
!316 = !DILocation(line: 9, column: 17, scope: !306)
!317 = !DILocalVariable(name: "ptr", scope: !306, file: !3, line: 9, type: !221)
!318 = !DILocation(line: 10, column: 33, scope: !306)
!319 = !DILocation(line: 10, column: 12, scope: !306)
!320 = !DILocation(line: 10, column: 5, scope: !306)
