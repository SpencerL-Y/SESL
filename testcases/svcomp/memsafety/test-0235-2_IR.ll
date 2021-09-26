; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-mjzxhh84.bc'
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
@.str.1 = private unnamed_addr constant [14 x i8] c"test-0235-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !41 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !44, !verifier.code !47
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
  call void @l0_destroy(%struct.L0* %6, i32 5), !dbg !55, !verifier.code !47
  %7 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !56, !verifier.code !47
  call void @l0_destroy(%struct.L0* %7, i32 4), !dbg !57, !verifier.code !47
  %8 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !58, !verifier.code !47
  call void @l0_destroy(%struct.L0* %8, i32 3), !dbg !59, !verifier.code !47
  %9 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !60, !verifier.code !47
  call void @l0_destroy(%struct.L0* %9, i32 2), !dbg !61, !verifier.code !47
  %10 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !62, !verifier.code !47
  call void @l0_destroy(%struct.L0* %10, i32 1), !dbg !63, !verifier.code !47
  %11 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !64, !verifier.code !47
  call void @l0_destroy(%struct.L0* %11, i32 0), !dbg !65, !verifier.code !47
  %12 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !66, !verifier.code !47
  %13 = icmp ne %struct.L0* %12, null, !dbg !67, !verifier.code !47
  %14 = xor i1 %13, true, !dbg !67, !verifier.code !47
  %15 = xor i1 %14, true, !dbg !68, !verifier.code !47
  %16 = zext i1 %15 to i32, !dbg !68, !verifier.code !47
  ret i32 %16, !dbg !69, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !70 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !74, metadata !DIExpression()), !dbg !75, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !76, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !76, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !77, metadata !DIExpression()), !dbg !75, !verifier.code !47
  br label %4, !dbg !78, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !79, !verifier.code !47
  call void @l1_insert(%struct.L1** %5), !dbg !80, !verifier.code !47
  br label %6, !dbg !80, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !81, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !80, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !80, !llvm.loop !82, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !84, !verifier.code !47
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !85, !verifier.code !47
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !86, !verifier.code !47
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !87, !verifier.code !47
  ret void, !dbg !88, !verifier.code !47
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0, i32 %1) #0 !dbg !89 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !94, metadata !DIExpression()), !dbg !93, !verifier.code !47
  br label %3, !dbg !95, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L0* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !47
  %4 = icmp slt i32 0, %1, !dbg !96, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !99, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !100, !verifier.code !47
  %7 = load %struct.L1*, %struct.L1** %6, align 8, !dbg !100, !verifier.code !47
  call void @l1_destroy(%struct.L1* %7, i32 %1), !dbg !101, !verifier.code !47
  br label %8, !dbg !101, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !102, !verifier.code !47
  %10 = load %struct.L0*, %struct.L0** %9, align 8, !dbg !102, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !103, metadata !DIExpression()), !dbg !104, !verifier.code !47
  %11 = icmp eq i32 0, %1, !dbg !105, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !107, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L0* %.0 to i8*, !dbg !108, !verifier.code !47
  call void @free(i8* %13) #6, !dbg !109, !verifier.code !47
  br label %14, !dbg !109, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !47
  br label %15, !dbg !110, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L0* %10, null, !dbg !110, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !110, !llvm.loop !111, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !113, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0, i32 %1) #0 !dbg !114 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !119, metadata !DIExpression()), !dbg !118, !verifier.code !47
  br label %3, !dbg !120, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L1* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !47
  %4 = icmp slt i32 1, %1, !dbg !121, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !124, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !125, !verifier.code !47
  %7 = load %struct.L2*, %struct.L2** %6, align 8, !dbg !125, !verifier.code !47
  call void @l2_destroy(%struct.L2* %7, i32 %1), !dbg !126, !verifier.code !47
  br label %8, !dbg !126, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !127, !verifier.code !47
  %10 = load %struct.L1*, %struct.L1** %9, align 8, !dbg !127, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !128, metadata !DIExpression()), !dbg !129, !verifier.code !47
  %11 = icmp eq i32 1, %1, !dbg !130, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !132, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L1* %.0 to i8*, !dbg !133, !verifier.code !47
  call void @free(i8* %13) #6, !dbg !134, !verifier.code !47
  br label %14, !dbg !134, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !47
  br label %15, !dbg !135, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L1* %10, null, !dbg !135, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !135, !llvm.loop !136, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !138, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0, i32 %1) #0 !dbg !139 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !144, metadata !DIExpression()), !dbg !143, !verifier.code !47
  br label %3, !dbg !145, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L2* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !47
  %4 = icmp slt i32 2, %1, !dbg !146, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !149, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !150, !verifier.code !47
  %7 = load %struct.L3*, %struct.L3** %6, align 8, !dbg !150, !verifier.code !47
  call void @l3_destroy(%struct.L3* %7, i32 %1), !dbg !151, !verifier.code !47
  br label %8, !dbg !151, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !152, !verifier.code !47
  %10 = load %struct.L2*, %struct.L2** %9, align 8, !dbg !152, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !153, metadata !DIExpression()), !dbg !154, !verifier.code !47
  %11 = icmp eq i32 2, %1, !dbg !155, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !157, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L2* %.0 to i8*, !dbg !158, !verifier.code !47
  call void @free(i8* %13) #6, !dbg !159, !verifier.code !47
  br label %14, !dbg !159, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !47
  br label %15, !dbg !160, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L2* %10, null, !dbg !160, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !160, !llvm.loop !161, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !163, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0, i32 %1) #0 !dbg !164 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !167, metadata !DIExpression()), !dbg !168, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !169, metadata !DIExpression()), !dbg !168, !verifier.code !47
  br label %3, !dbg !170, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L3* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !167, metadata !DIExpression()), !dbg !168, !verifier.code !47
  %4 = icmp slt i32 3, %1, !dbg !171, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !174, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !175, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !175, !verifier.code !47
  call void @l4_destroy(%struct.L4* %7, i32 %1), !dbg !176, !verifier.code !47
  br label %8, !dbg !176, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !177, !verifier.code !47
  %10 = load %struct.L3*, %struct.L3** %9, align 8, !dbg !177, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !178, metadata !DIExpression()), !dbg !179, !verifier.code !47
  %11 = icmp eq i32 3, %1, !dbg !180, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !182, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L3* %.0 to i8*, !dbg !183, !verifier.code !47
  call void @free(i8* %13) #6, !dbg !184, !verifier.code !47
  br label %14, !dbg !184, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !167, metadata !DIExpression()), !dbg !168, !verifier.code !47
  br label %15, !dbg !185, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L3* %10, null, !dbg !185, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !185, !llvm.loop !186, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !188, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0, i32 %1) #0 !dbg !189 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !192, metadata !DIExpression()), !dbg !193, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !194, metadata !DIExpression()), !dbg !193, !verifier.code !47
  br label %3, !dbg !195, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L4* [ %0, %2 ], [ %11, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !192, metadata !DIExpression()), !dbg !193, !verifier.code !47
  %4 = icmp eq i32 5, %1, !dbg !196, !verifier.code !47
  br i1 %4, label %5, label %9, !dbg !199, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !200, !verifier.code !47
  %7 = load %struct.L5*, %struct.L5** %6, align 8, !dbg !200, !verifier.code !47
  %8 = bitcast %struct.L5* %7 to i8*, !dbg !201, !verifier.code !47
  call void @free(i8* %8) #6, !dbg !202, !verifier.code !47
  br label %9, !dbg !202, !verifier.code !47

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !203, !verifier.code !47
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !203, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !47
  %12 = icmp eq i32 4, %1, !dbg !206, !verifier.code !47
  br i1 %12, label %13, label %15, !dbg !208, !verifier.code !47

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !209, !verifier.code !47
  call void @free(i8* %14) #6, !dbg !210, !verifier.code !47
  br label %15, !dbg !210, !verifier.code !47

15:                                               ; preds = %13, %9
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !192, metadata !DIExpression()), !dbg !193, !verifier.code !47
  br label %16, !dbg !211, !verifier.code !47

16:                                               ; preds = %15
  %17 = icmp ne %struct.L4* %11, null, !dbg !211, !verifier.code !47
  br i1 %17, label %forwarder, label %18, !dbg !211, !llvm.loop !212, !verifier.code !47

18:                                               ; preds = %16
  ret void, !dbg !214, !verifier.code !47

forwarder:                                        ; preds = %16
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !215 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !47
  %2 = call i8* @calloc_model(i32 1, i32 %0), !dbg !222, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %2, metadata !223, metadata !DIExpression()), !dbg !221, !verifier.code !47
  %3 = icmp ne i8* %2, null, !dbg !224, !verifier.code !47
  br i1 %3, label %4, label %5, !dbg !226, !verifier.code !47

4:                                                ; preds = %1
  ret i8* %2, !dbg !227, !verifier.code !47

5:                                                ; preds = %1
  call void @abort() #5, !dbg !228, !verifier.code !47
  unreachable, !dbg !228, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !229 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !233, metadata !DIExpression()), !dbg !234, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !235, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !235, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !236, metadata !DIExpression()), !dbg !234, !verifier.code !47
  br label %4, !dbg !237, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !238, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !239, !verifier.code !47
  br label %6, !dbg !239, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !240, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !239, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !239, !llvm.loop !241, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !243, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !244, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !245, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !246, !verifier.code !47
  ret void, !dbg !247, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !248 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !252, metadata !DIExpression()), !dbg !253, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !254, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !254, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !255, metadata !DIExpression()), !dbg !253, !verifier.code !47
  br label %4, !dbg !256, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !257, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !258, !verifier.code !47
  br label %6, !dbg !258, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !259, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !258, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !258, !llvm.loop !260, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !262, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !263, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !264, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !265, !verifier.code !47
  ret void, !dbg !266, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !267 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !271, metadata !DIExpression()), !dbg !272, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !273, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !273, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !274, metadata !DIExpression()), !dbg !272, !verifier.code !47
  br label %4, !dbg !275, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !276, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !277, !verifier.code !47
  br label %6, !dbg !277, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !278, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !277, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !277, !llvm.loop !279, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !281, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !282, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !283, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !284, !verifier.code !47
  ret void, !dbg !285, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !286 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !290, metadata !DIExpression()), !dbg !291, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !292, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !292, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !293, metadata !DIExpression()), !dbg !291, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !294, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !294, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !295, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !296, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !297, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !298, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !299, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !300, !verifier.code !47
  ret void, !dbg !301, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i32 %0, i32 %1) #0 !dbg !302 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !306, metadata !DIExpression()), !dbg !307, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !308, metadata !DIExpression()), !dbg !307, !verifier.code !47
  %3 = mul i32 %0, %1, !dbg !309, !verifier.code !47
  %4 = call noalias i8* @malloc(i32 %3) #6, !dbg !310, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !311, metadata !DIExpression()), !dbg !307, !verifier.code !47
  %5 = mul i32 %0, %1, !dbg !312, !verifier.code !47
  %6 = call i8* @memset(i8* %4, i32 0, i32 %5) #6, !dbg !313, !verifier.code !47
  ret i8* %6, !dbg !314, !verifier.code !47
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #4

; Function Attrs: nounwind
declare dso_local i8* @memset(i8*, i32, i32) #4

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
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!37}
!llvm.module.flags = !{!38, !39, !40}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 777, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 775, type: !4, scopeLine: 776, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0235-2.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, globals: !9, splitDebugInlining: false, nameTableKind: None)
!8 = !{}
!9 = !{!0}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L0", file: !3, line: 661, size: 128, elements: !12)
!12 = !{!13, !14}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !11, file: !3, line: 662, baseType: !10, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !11, file: !3, line: 663, baseType: !15, size: 64, offset: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L1", file: !3, line: 657, size: 128, elements: !17)
!17 = !{!18, !36}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !16, file: !3, line: 658, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L2", file: !3, line: 653, size: 128, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !20, file: !3, line: 654, baseType: !19, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !20, file: !3, line: 655, baseType: !24, size: 64, offset: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L3", file: !3, line: 649, size: 128, elements: !26)
!26 = !{!27, !35}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !25, file: !3, line: 650, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L4", file: !3, line: 645, size: 128, elements: !30)
!30 = !{!31, !32}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !29, file: !3, line: 646, baseType: !28, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !29, file: !3, line: 647, baseType: !33, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = !DICompositeType(tag: DW_TAG_structure_type, name: "L5", file: !3, line: 647, flags: DIFlagFwdDecl)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !25, file: !3, line: 651, baseType: !24, size: 64, offset: 64)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !16, file: !3, line: 659, baseType: !15, size: 64, offset: 64)
!37 = !{!"clang version 10.0.0-4ubuntu1 "}
!38 = !{i32 7, !"Dwarf Version", i32 4}
!39 = !{i32 2, !"Debug Info Version", i32 3}
!40 = !{i32 1, !"wchar_size", i32 4}
!41 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 12, type: !42, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!42 = !DISubroutineType(types: !43)
!43 = !{null}
!44 = !DILocation(line: 12, column: 83, scope: !45)
!45 = distinct !DILexicalBlock(scope: !46, file: !3, line: 12, column: 73)
!46 = distinct !DILexicalBlock(scope: !41, file: !3, line: 12, column: 67)
!47 = !{i1 false}
!48 = !DILocation(line: 778, column: 5, scope: !2)
!49 = !DILocation(line: 779, column: 9, scope: !2)
!50 = !DILocation(line: 780, column: 12, scope: !2)
!51 = !{i1 true}
!52 = distinct !{!52, !48, !53}
!53 = !DILocation(line: 780, column: 35, scope: !2)
!54 = !DILocation(line: 781, column: 16, scope: !2)
!55 = !DILocation(line: 781, column: 5, scope: !2)
!56 = !DILocation(line: 782, column: 16, scope: !2)
!57 = !DILocation(line: 782, column: 5, scope: !2)
!58 = !DILocation(line: 783, column: 16, scope: !2)
!59 = !DILocation(line: 783, column: 5, scope: !2)
!60 = !DILocation(line: 784, column: 16, scope: !2)
!61 = !DILocation(line: 784, column: 5, scope: !2)
!62 = !DILocation(line: 785, column: 16, scope: !2)
!63 = !DILocation(line: 785, column: 5, scope: !2)
!64 = !DILocation(line: 786, column: 16, scope: !2)
!65 = !DILocation(line: 786, column: 5, scope: !2)
!66 = !DILocation(line: 787, column: 14, scope: !2)
!67 = !DILocation(line: 787, column: 13, scope: !2)
!68 = !DILocation(line: 787, column: 12, scope: !2)
!69 = !DILocation(line: 787, column: 5, scope: !2)
!70 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 706, type: !71, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !73}
!73 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!74 = !DILocalVariable(name: "list", arg: 1, scope: !70, file: !3, line: 706, type: !73)
!75 = !DILocation(line: 0, scope: !70)
!76 = !DILocation(line: 708, column: 23, scope: !70)
!77 = !DILocalVariable(name: "item", scope: !70, file: !3, line: 708, type: !10)
!78 = !DILocation(line: 709, column: 5, scope: !70)
!79 = !DILocation(line: 710, column: 26, scope: !70)
!80 = !DILocation(line: 710, column: 9, scope: !70)
!81 = !DILocation(line: 711, column: 12, scope: !70)
!82 = distinct !{!82, !78, !83}
!83 = !DILocation(line: 711, column: 35, scope: !70)
!84 = !DILocation(line: 712, column: 18, scope: !70)
!85 = !DILocation(line: 712, column: 11, scope: !70)
!86 = !DILocation(line: 712, column: 16, scope: !70)
!87 = !DILocation(line: 713, column: 11, scope: !70)
!88 = !DILocation(line: 714, column: 1, scope: !70)
!89 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 763, type: !90, scopeLine: 764, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!90 = !DISubroutineType(types: !91)
!91 = !{null, !10, !6}
!92 = !DILocalVariable(name: "list", arg: 1, scope: !89, file: !3, line: 763, type: !10)
!93 = !DILocation(line: 0, scope: !89)
!94 = !DILocalVariable(name: "level", arg: 2, scope: !89, file: !3, line: 763, type: !6)
!95 = !DILocation(line: 765, column: 5, scope: !89)
!96 = !DILocation(line: 766, column: 15, scope: !97)
!97 = distinct !DILexicalBlock(scope: !98, file: !3, line: 766, column: 13)
!98 = distinct !DILexicalBlock(scope: !89, file: !3, line: 765, column: 8)
!99 = !DILocation(line: 766, column: 13, scope: !98)
!100 = !DILocation(line: 767, column: 30, scope: !97)
!101 = !DILocation(line: 767, column: 13, scope: !97)
!102 = !DILocation(line: 768, column: 33, scope: !98)
!103 = !DILocalVariable(name: "next", scope: !98, file: !3, line: 768, type: !10)
!104 = !DILocation(line: 0, scope: !98)
!105 = !DILocation(line: 769, column: 15, scope: !106)
!106 = distinct !DILexicalBlock(scope: !98, file: !3, line: 769, column: 13)
!107 = !DILocation(line: 769, column: 13, scope: !98)
!108 = !DILocation(line: 770, column: 18, scope: !106)
!109 = !DILocation(line: 770, column: 13, scope: !106)
!110 = !DILocation(line: 772, column: 5, scope: !98)
!111 = distinct !{!111, !95, !112}
!112 = !DILocation(line: 773, column: 16, scope: !89)
!113 = !DILocation(line: 774, column: 1, scope: !89)
!114 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 751, type: !115, scopeLine: 752, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!115 = !DISubroutineType(types: !116)
!116 = !{null, !15, !6}
!117 = !DILocalVariable(name: "list", arg: 1, scope: !114, file: !3, line: 751, type: !15)
!118 = !DILocation(line: 0, scope: !114)
!119 = !DILocalVariable(name: "level", arg: 2, scope: !114, file: !3, line: 751, type: !6)
!120 = !DILocation(line: 753, column: 5, scope: !114)
!121 = !DILocation(line: 754, column: 15, scope: !122)
!122 = distinct !DILexicalBlock(scope: !123, file: !3, line: 754, column: 13)
!123 = distinct !DILexicalBlock(scope: !114, file: !3, line: 753, column: 8)
!124 = !DILocation(line: 754, column: 13, scope: !123)
!125 = !DILocation(line: 755, column: 30, scope: !122)
!126 = !DILocation(line: 755, column: 13, scope: !122)
!127 = !DILocation(line: 756, column: 33, scope: !123)
!128 = !DILocalVariable(name: "next", scope: !123, file: !3, line: 756, type: !15)
!129 = !DILocation(line: 0, scope: !123)
!130 = !DILocation(line: 757, column: 15, scope: !131)
!131 = distinct !DILexicalBlock(scope: !123, file: !3, line: 757, column: 13)
!132 = !DILocation(line: 757, column: 13, scope: !123)
!133 = !DILocation(line: 758, column: 18, scope: !131)
!134 = !DILocation(line: 758, column: 13, scope: !131)
!135 = !DILocation(line: 760, column: 5, scope: !123)
!136 = distinct !{!136, !120, !137}
!137 = !DILocation(line: 761, column: 16, scope: !114)
!138 = !DILocation(line: 762, column: 1, scope: !114)
!139 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 739, type: !140, scopeLine: 740, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!140 = !DISubroutineType(types: !141)
!141 = !{null, !19, !6}
!142 = !DILocalVariable(name: "list", arg: 1, scope: !139, file: !3, line: 739, type: !19)
!143 = !DILocation(line: 0, scope: !139)
!144 = !DILocalVariable(name: "level", arg: 2, scope: !139, file: !3, line: 739, type: !6)
!145 = !DILocation(line: 741, column: 5, scope: !139)
!146 = !DILocation(line: 742, column: 15, scope: !147)
!147 = distinct !DILexicalBlock(scope: !148, file: !3, line: 742, column: 13)
!148 = distinct !DILexicalBlock(scope: !139, file: !3, line: 741, column: 8)
!149 = !DILocation(line: 742, column: 13, scope: !148)
!150 = !DILocation(line: 743, column: 30, scope: !147)
!151 = !DILocation(line: 743, column: 13, scope: !147)
!152 = !DILocation(line: 744, column: 33, scope: !148)
!153 = !DILocalVariable(name: "next", scope: !148, file: !3, line: 744, type: !19)
!154 = !DILocation(line: 0, scope: !148)
!155 = !DILocation(line: 745, column: 15, scope: !156)
!156 = distinct !DILexicalBlock(scope: !148, file: !3, line: 745, column: 13)
!157 = !DILocation(line: 745, column: 13, scope: !148)
!158 = !DILocation(line: 746, column: 18, scope: !156)
!159 = !DILocation(line: 746, column: 13, scope: !156)
!160 = !DILocation(line: 748, column: 5, scope: !148)
!161 = distinct !{!161, !145, !162}
!162 = !DILocation(line: 749, column: 16, scope: !139)
!163 = !DILocation(line: 750, column: 1, scope: !139)
!164 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 727, type: !165, scopeLine: 728, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!165 = !DISubroutineType(types: !166)
!166 = !{null, !24, !6}
!167 = !DILocalVariable(name: "list", arg: 1, scope: !164, file: !3, line: 727, type: !24)
!168 = !DILocation(line: 0, scope: !164)
!169 = !DILocalVariable(name: "level", arg: 2, scope: !164, file: !3, line: 727, type: !6)
!170 = !DILocation(line: 729, column: 5, scope: !164)
!171 = !DILocation(line: 730, column: 15, scope: !172)
!172 = distinct !DILexicalBlock(scope: !173, file: !3, line: 730, column: 13)
!173 = distinct !DILexicalBlock(scope: !164, file: !3, line: 729, column: 8)
!174 = !DILocation(line: 730, column: 13, scope: !173)
!175 = !DILocation(line: 731, column: 30, scope: !172)
!176 = !DILocation(line: 731, column: 13, scope: !172)
!177 = !DILocation(line: 732, column: 33, scope: !173)
!178 = !DILocalVariable(name: "next", scope: !173, file: !3, line: 732, type: !24)
!179 = !DILocation(line: 0, scope: !173)
!180 = !DILocation(line: 733, column: 15, scope: !181)
!181 = distinct !DILexicalBlock(scope: !173, file: !3, line: 733, column: 13)
!182 = !DILocation(line: 733, column: 13, scope: !173)
!183 = !DILocation(line: 734, column: 18, scope: !181)
!184 = !DILocation(line: 734, column: 13, scope: !181)
!185 = !DILocation(line: 736, column: 5, scope: !173)
!186 = distinct !{!186, !170, !187}
!187 = !DILocation(line: 737, column: 16, scope: !164)
!188 = !DILocation(line: 738, column: 1, scope: !164)
!189 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 715, type: !190, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!190 = !DISubroutineType(types: !191)
!191 = !{null, !28, !6}
!192 = !DILocalVariable(name: "list", arg: 1, scope: !189, file: !3, line: 715, type: !28)
!193 = !DILocation(line: 0, scope: !189)
!194 = !DILocalVariable(name: "level", arg: 2, scope: !189, file: !3, line: 715, type: !6)
!195 = !DILocation(line: 717, column: 5, scope: !189)
!196 = !DILocation(line: 718, column: 15, scope: !197)
!197 = distinct !DILexicalBlock(scope: !198, file: !3, line: 718, column: 13)
!198 = distinct !DILexicalBlock(scope: !189, file: !3, line: 717, column: 8)
!199 = !DILocation(line: 718, column: 13, scope: !198)
!200 = !DILocation(line: 719, column: 24, scope: !197)
!201 = !DILocation(line: 719, column: 18, scope: !197)
!202 = !DILocation(line: 719, column: 13, scope: !197)
!203 = !DILocation(line: 720, column: 33, scope: !198)
!204 = !DILocalVariable(name: "next", scope: !198, file: !3, line: 720, type: !28)
!205 = !DILocation(line: 0, scope: !198)
!206 = !DILocation(line: 721, column: 15, scope: !207)
!207 = distinct !DILexicalBlock(scope: !198, file: !3, line: 721, column: 13)
!208 = !DILocation(line: 721, column: 13, scope: !198)
!209 = !DILocation(line: 722, column: 18, scope: !207)
!210 = !DILocation(line: 722, column: 13, scope: !207)
!211 = !DILocation(line: 724, column: 5, scope: !198)
!212 = distinct !{!212, !195, !213}
!213 = !DILocation(line: 725, column: 16, scope: !189)
!214 = !DILocation(line: 726, column: 1, scope: !189)
!215 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 665, type: !216, scopeLine: 666, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!216 = !DISubroutineType(types: !217)
!217 = !{!218, !219}
!218 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!219 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!220 = !DILocalVariable(name: "size", arg: 1, scope: !215, file: !3, line: 665, type: !219)
!221 = !DILocation(line: 0, scope: !215)
!222 = !DILocation(line: 667, column: 17, scope: !215)
!223 = !DILocalVariable(name: "ptr", scope: !215, file: !3, line: 667, type: !218)
!224 = !DILocation(line: 668, column: 9, scope: !225)
!225 = distinct !DILexicalBlock(scope: !215, file: !3, line: 668, column: 9)
!226 = !DILocation(line: 668, column: 9, scope: !215)
!227 = !DILocation(line: 669, column: 9, scope: !225)
!228 = !DILocation(line: 670, column: 5, scope: !215)
!229 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 697, type: !230, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!230 = !DISubroutineType(types: !231)
!231 = !{null, !232}
!232 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!233 = !DILocalVariable(name: "list", arg: 1, scope: !229, file: !3, line: 697, type: !232)
!234 = !DILocation(line: 0, scope: !229)
!235 = !DILocation(line: 699, column: 23, scope: !229)
!236 = !DILocalVariable(name: "item", scope: !229, file: !3, line: 699, type: !15)
!237 = !DILocation(line: 700, column: 5, scope: !229)
!238 = !DILocation(line: 701, column: 26, scope: !229)
!239 = !DILocation(line: 701, column: 9, scope: !229)
!240 = !DILocation(line: 702, column: 12, scope: !229)
!241 = distinct !{!241, !237, !242}
!242 = !DILocation(line: 702, column: 35, scope: !229)
!243 = !DILocation(line: 703, column: 18, scope: !229)
!244 = !DILocation(line: 703, column: 11, scope: !229)
!245 = !DILocation(line: 703, column: 16, scope: !229)
!246 = !DILocation(line: 704, column: 11, scope: !229)
!247 = !DILocation(line: 705, column: 1, scope: !229)
!248 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 688, type: !249, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!249 = !DISubroutineType(types: !250)
!250 = !{null, !251}
!251 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!252 = !DILocalVariable(name: "list", arg: 1, scope: !248, file: !3, line: 688, type: !251)
!253 = !DILocation(line: 0, scope: !248)
!254 = !DILocation(line: 690, column: 23, scope: !248)
!255 = !DILocalVariable(name: "item", scope: !248, file: !3, line: 690, type: !19)
!256 = !DILocation(line: 691, column: 5, scope: !248)
!257 = !DILocation(line: 692, column: 26, scope: !248)
!258 = !DILocation(line: 692, column: 9, scope: !248)
!259 = !DILocation(line: 693, column: 12, scope: !248)
!260 = distinct !{!260, !256, !261}
!261 = !DILocation(line: 693, column: 35, scope: !248)
!262 = !DILocation(line: 694, column: 18, scope: !248)
!263 = !DILocation(line: 694, column: 11, scope: !248)
!264 = !DILocation(line: 694, column: 16, scope: !248)
!265 = !DILocation(line: 695, column: 11, scope: !248)
!266 = !DILocation(line: 696, column: 1, scope: !248)
!267 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 679, type: !268, scopeLine: 680, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!268 = !DISubroutineType(types: !269)
!269 = !{null, !270}
!270 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!271 = !DILocalVariable(name: "list", arg: 1, scope: !267, file: !3, line: 679, type: !270)
!272 = !DILocation(line: 0, scope: !267)
!273 = !DILocation(line: 681, column: 23, scope: !267)
!274 = !DILocalVariable(name: "item", scope: !267, file: !3, line: 681, type: !24)
!275 = !DILocation(line: 682, column: 5, scope: !267)
!276 = !DILocation(line: 683, column: 26, scope: !267)
!277 = !DILocation(line: 683, column: 9, scope: !267)
!278 = !DILocation(line: 684, column: 12, scope: !267)
!279 = distinct !{!279, !275, !280}
!280 = !DILocation(line: 684, column: 35, scope: !267)
!281 = !DILocation(line: 685, column: 18, scope: !267)
!282 = !DILocation(line: 685, column: 11, scope: !267)
!283 = !DILocation(line: 685, column: 16, scope: !267)
!284 = !DILocation(line: 686, column: 11, scope: !267)
!285 = !DILocation(line: 687, column: 1, scope: !267)
!286 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 672, type: !287, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!287 = !DISubroutineType(types: !288)
!288 = !{null, !289}
!289 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!290 = !DILocalVariable(name: "list", arg: 1, scope: !286, file: !3, line: 672, type: !289)
!291 = !DILocation(line: 0, scope: !286)
!292 = !DILocation(line: 674, column: 23, scope: !286)
!293 = !DILocalVariable(name: "item", scope: !286, file: !3, line: 674, type: !28)
!294 = !DILocation(line: 675, column: 18, scope: !286)
!295 = !DILocation(line: 675, column: 11, scope: !286)
!296 = !DILocation(line: 675, column: 16, scope: !286)
!297 = !DILocation(line: 676, column: 18, scope: !286)
!298 = !DILocation(line: 676, column: 11, scope: !286)
!299 = !DILocation(line: 676, column: 16, scope: !286)
!300 = !DILocation(line: 677, column: 11, scope: !286)
!301 = !DILocation(line: 678, column: 1, scope: !286)
!302 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 640, type: !303, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!303 = !DISubroutineType(types: !304)
!304 = !{!218, !305, !305}
!305 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 13, baseType: !219)
!306 = !DILocalVariable(name: "nmemb", arg: 1, scope: !302, file: !3, line: 640, type: !305)
!307 = !DILocation(line: 0, scope: !302)
!308 = !DILocalVariable(name: "size", arg: 2, scope: !302, file: !3, line: 640, type: !305)
!309 = !DILocation(line: 641, column: 30, scope: !302)
!310 = !DILocation(line: 641, column: 17, scope: !302)
!311 = !DILocalVariable(name: "ptr", scope: !302, file: !3, line: 641, type: !218)
!312 = !DILocation(line: 642, column: 33, scope: !302)
!313 = !DILocation(line: 642, column: 12, scope: !302)
!314 = !DILocation(line: 642, column: 5, scope: !302)
