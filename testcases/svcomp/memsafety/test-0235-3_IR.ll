; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/b-qoo37ywb.bc'
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
@.str.1 = private unnamed_addr constant [31 x i8] c"svcomp/memsafety/test-0235-3.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !41 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !44, !verifier.code !47
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
  call void @l0_destroy(%struct.L0* %10, i32 2), !dbg !63, !verifier.code !47
  %11 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !64, !verifier.code !47
  call void @l0_destroy(%struct.L0* %11, i32 1), !dbg !65, !verifier.code !47
  %12 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !66, !verifier.code !47
  call void @l0_destroy(%struct.L0* %12, i32 0), !dbg !67, !verifier.code !47
  %13 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !68, !verifier.code !47
  %14 = icmp ne %struct.L0* %13, null, !dbg !69, !verifier.code !47
  %15 = xor i1 %14, true, !dbg !69, !verifier.code !47
  %16 = xor i1 %15, true, !dbg !70, !verifier.code !47
  %17 = zext i1 %16 to i32, !dbg !70, !verifier.code !47
  ret i32 %17, !dbg !71, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !72 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !76, metadata !DIExpression()), !dbg !77, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !78, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !78, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !79, metadata !DIExpression()), !dbg !77, !verifier.code !47
  br label %4, !dbg !80, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !81, !verifier.code !47
  call void @l1_insert(%struct.L1** %5), !dbg !82, !verifier.code !47
  br label %6, !dbg !82, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !83, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !82, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !82, !llvm.loop !84, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !86, !verifier.code !47
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !87, !verifier.code !47
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !88, !verifier.code !47
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !89, !verifier.code !47
  ret void, !dbg !90, !verifier.code !47
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0, i32 %1) #0 !dbg !91 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !96, metadata !DIExpression()), !dbg !95, !verifier.code !47
  br label %3, !dbg !97, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L0* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !47
  %4 = icmp slt i32 0, %1, !dbg !98, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !101, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !102, !verifier.code !47
  %7 = load %struct.L1*, %struct.L1** %6, align 8, !dbg !102, !verifier.code !47
  call void @l1_destroy(%struct.L1* %7, i32 %1), !dbg !103, !verifier.code !47
  br label %8, !dbg !103, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !104, !verifier.code !47
  %10 = load %struct.L0*, %struct.L0** %9, align 8, !dbg !104, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !47
  %11 = icmp eq i32 0, %1, !dbg !107, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !109, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L0* %.0 to i8*, !dbg !110, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !111, !verifier.code !47
  br label %14, !dbg !111, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !94, metadata !DIExpression()), !dbg !95, !verifier.code !47
  br label %15, !dbg !112, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L0* %10, null, !dbg !112, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !112, !llvm.loop !113, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !115, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0, i32 %1) #0 !dbg !116 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !119, metadata !DIExpression()), !dbg !120, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !121, metadata !DIExpression()), !dbg !120, !verifier.code !47
  br label %3, !dbg !122, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L1* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !119, metadata !DIExpression()), !dbg !120, !verifier.code !47
  %4 = icmp slt i32 1, %1, !dbg !123, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !126, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !127, !verifier.code !47
  %7 = load %struct.L2*, %struct.L2** %6, align 8, !dbg !127, !verifier.code !47
  call void @l2_destroy(%struct.L2* %7, i32 %1), !dbg !128, !verifier.code !47
  br label %8, !dbg !128, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !129, !verifier.code !47
  %10 = load %struct.L1*, %struct.L1** %9, align 8, !dbg !129, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !130, metadata !DIExpression()), !dbg !131, !verifier.code !47
  %11 = icmp eq i32 1, %1, !dbg !132, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !134, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L1* %.0 to i8*, !dbg !135, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !136, !verifier.code !47
  br label %14, !dbg !136, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !119, metadata !DIExpression()), !dbg !120, !verifier.code !47
  br label %15, !dbg !137, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L1* %10, null, !dbg !137, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !137, !llvm.loop !138, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !140, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0, i32 %1) #0 !dbg !141 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !146, metadata !DIExpression()), !dbg !145, !verifier.code !47
  br label %3, !dbg !147, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L2* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !47
  %4 = icmp slt i32 2, %1, !dbg !148, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !151, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !152, !verifier.code !47
  %7 = load %struct.L3*, %struct.L3** %6, align 8, !dbg !152, !verifier.code !47
  call void @l3_destroy(%struct.L3* %7, i32 %1), !dbg !153, !verifier.code !47
  br label %8, !dbg !153, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !154, !verifier.code !47
  %10 = load %struct.L2*, %struct.L2** %9, align 8, !dbg !154, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !155, metadata !DIExpression()), !dbg !156, !verifier.code !47
  %11 = icmp eq i32 2, %1, !dbg !157, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !159, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L2* %.0 to i8*, !dbg !160, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !161, !verifier.code !47
  br label %14, !dbg !161, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !47
  br label %15, !dbg !162, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L2* %10, null, !dbg !162, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !162, !llvm.loop !163, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !165, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0, i32 %1) #0 !dbg !166 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !169, metadata !DIExpression()), !dbg !170, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !171, metadata !DIExpression()), !dbg !170, !verifier.code !47
  br label %3, !dbg !172, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L3* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !169, metadata !DIExpression()), !dbg !170, !verifier.code !47
  %4 = icmp slt i32 3, %1, !dbg !173, !verifier.code !47
  br i1 %4, label %5, label %8, !dbg !176, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !177, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !177, !verifier.code !47
  call void @l4_destroy(%struct.L4* %7, i32 %1), !dbg !178, !verifier.code !47
  br label %8, !dbg !178, !verifier.code !47

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !179, !verifier.code !47
  %10 = load %struct.L3*, %struct.L3** %9, align 8, !dbg !179, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !180, metadata !DIExpression()), !dbg !181, !verifier.code !47
  %11 = icmp eq i32 3, %1, !dbg !182, !verifier.code !47
  br i1 %11, label %12, label %14, !dbg !184, !verifier.code !47

12:                                               ; preds = %8
  %13 = bitcast %struct.L3* %.0 to i8*, !dbg !185, !verifier.code !47
  call void @free(i8* %13) #7, !dbg !186, !verifier.code !47
  br label %14, !dbg !186, !verifier.code !47

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !169, metadata !DIExpression()), !dbg !170, !verifier.code !47
  br label %15, !dbg !187, !verifier.code !47

15:                                               ; preds = %14
  %16 = icmp ne %struct.L3* %10, null, !dbg !187, !verifier.code !47
  br i1 %16, label %forwarder, label %17, !dbg !187, !llvm.loop !188, !verifier.code !47

17:                                               ; preds = %15
  ret void, !dbg !190, !verifier.code !47

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0, i32 %1) #0 !dbg !191 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !194, metadata !DIExpression()), !dbg !195, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !196, metadata !DIExpression()), !dbg !195, !verifier.code !47
  br label %3, !dbg !197, !verifier.code !47

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L4* [ %0, %2 ], [ %11, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !194, metadata !DIExpression()), !dbg !195, !verifier.code !47
  %4 = icmp eq i32 5, %1, !dbg !198, !verifier.code !47
  br i1 %4, label %5, label %9, !dbg !201, !verifier.code !47

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !202, !verifier.code !47
  %7 = load %struct.L5*, %struct.L5** %6, align 8, !dbg !202, !verifier.code !47
  %8 = bitcast %struct.L5* %7 to i8*, !dbg !203, !verifier.code !47
  call void @free(i8* %8) #7, !dbg !204, !verifier.code !47
  br label %9, !dbg !204, !verifier.code !47

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !205, !verifier.code !47
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !205, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !206, metadata !DIExpression()), !dbg !207, !verifier.code !47
  %12 = icmp eq i32 4, %1, !dbg !208, !verifier.code !47
  br i1 %12, label %13, label %15, !dbg !210, !verifier.code !47

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !211, !verifier.code !47
  call void @free(i8* %14) #7, !dbg !212, !verifier.code !47
  br label %15, !dbg !212, !verifier.code !47

15:                                               ; preds = %13, %9
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !194, metadata !DIExpression()), !dbg !195, !verifier.code !47
  br label %16, !dbg !213, !verifier.code !47

16:                                               ; preds = %15
  %17 = icmp ne %struct.L4* %11, null, !dbg !213, !verifier.code !47
  br i1 %17, label %forwarder, label %18, !dbg !213, !llvm.loop !214, !verifier.code !47

18:                                               ; preds = %16
  ret void, !dbg !216, !verifier.code !47

forwarder:                                        ; preds = %16
  br label %3, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !217 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !222, metadata !DIExpression()), !dbg !223, !verifier.code !47
  %2 = zext i32 %0 to i64, !dbg !224, !verifier.code !47
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !225, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %3, metadata !226, metadata !DIExpression()), !dbg !223, !verifier.code !47
  %4 = icmp ne i8* %3, null, !dbg !227, !verifier.code !47
  br i1 %4, label %5, label %6, !dbg !229, !verifier.code !47

5:                                                ; preds = %1
  ret i8* %3, !dbg !230, !verifier.code !47

6:                                                ; preds = %1
  call void @abort() #6, !dbg !231, !verifier.code !47
  unreachable, !dbg !231, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !232 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !236, metadata !DIExpression()), !dbg !237, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !238, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !238, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !239, metadata !DIExpression()), !dbg !237, !verifier.code !47
  br label %4, !dbg !240, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !241, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !242, !verifier.code !47
  br label %6, !dbg !242, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !243, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !242, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !242, !llvm.loop !244, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !246, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !247, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !248, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !249, !verifier.code !47
  ret void, !dbg !250, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !251 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !255, metadata !DIExpression()), !dbg !256, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !257, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !257, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !258, metadata !DIExpression()), !dbg !256, !verifier.code !47
  br label %4, !dbg !259, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !260, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !261, !verifier.code !47
  br label %6, !dbg !261, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !262, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !261, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !261, !llvm.loop !263, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !265, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !266, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !267, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !268, !verifier.code !47
  ret void, !dbg !269, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !270 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !274, metadata !DIExpression()), !dbg !275, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !276, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !276, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !277, metadata !DIExpression()), !dbg !275, !verifier.code !47
  br label %4, !dbg !278, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !279, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !280, !verifier.code !47
  br label %6, !dbg !280, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !281, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !280, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !280, !llvm.loop !282, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !284, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !285, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !286, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !287, !verifier.code !47
  ret void, !dbg !288, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !289 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !293, metadata !DIExpression()), !dbg !294, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !295, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !295, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !296, metadata !DIExpression()), !dbg !294, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !297, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !297, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !298, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !299, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !300, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !301, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !302, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !303, !verifier.code !47
  ret void, !dbg !304, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !305 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !311, metadata !DIExpression()), !dbg !312, !verifier.code !47
  call void @llvm.dbg.value(metadata i64 %1, metadata !313, metadata !DIExpression()), !dbg !312, !verifier.code !47
  %3 = mul i64 %0, %1, !dbg !314, !verifier.code !47
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !315, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !316, metadata !DIExpression()), !dbg !312, !verifier.code !47
  %5 = mul i64 %0, %1, !dbg !317, !verifier.code !47
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !318, !verifier.code !47
  ret i8* %4, !dbg !319, !verifier.code !47
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
!3 = !DIFile(filename: "svcomp/memsafety/test-0235-3.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases")
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
!64 = !DILocation(line: 194, column: 16, scope: !2)
!65 = !DILocation(line: 194, column: 5, scope: !2)
!66 = !DILocation(line: 195, column: 16, scope: !2)
!67 = !DILocation(line: 195, column: 5, scope: !2)
!68 = !DILocation(line: 197, column: 14, scope: !2)
!69 = !DILocation(line: 197, column: 13, scope: !2)
!70 = !DILocation(line: 197, column: 12, scope: !2)
!71 = !DILocation(line: 197, column: 5, scope: !2)
!72 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !73, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !75}
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!76 = !DILocalVariable(name: "list", arg: 1, scope: !72, file: !3, line: 94, type: !75)
!77 = !DILocation(line: 0, scope: !72)
!78 = !DILocation(line: 96, column: 23, scope: !72)
!79 = !DILocalVariable(name: "item", scope: !72, file: !3, line: 96, type: !10)
!80 = !DILocation(line: 98, column: 5, scope: !72)
!81 = !DILocation(line: 99, column: 26, scope: !72)
!82 = !DILocation(line: 99, column: 9, scope: !72)
!83 = !DILocation(line: 100, column: 12, scope: !72)
!84 = distinct !{!84, !80, !85}
!85 = !DILocation(line: 100, column: 35, scope: !72)
!86 = !DILocation(line: 102, column: 18, scope: !72)
!87 = !DILocation(line: 102, column: 11, scope: !72)
!88 = !DILocation(line: 102, column: 16, scope: !72)
!89 = !DILocation(line: 103, column: 11, scope: !72)
!90 = !DILocation(line: 104, column: 1, scope: !72)
!91 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 166, type: !92, scopeLine: 167, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!92 = !DISubroutineType(types: !93)
!93 = !{null, !10, !6}
!94 = !DILocalVariable(name: "list", arg: 1, scope: !91, file: !3, line: 166, type: !10)
!95 = !DILocation(line: 0, scope: !91)
!96 = !DILocalVariable(name: "level", arg: 2, scope: !91, file: !3, line: 166, type: !6)
!97 = !DILocation(line: 168, column: 5, scope: !91)
!98 = !DILocation(line: 169, column: 15, scope: !99)
!99 = distinct !DILexicalBlock(scope: !100, file: !3, line: 169, column: 13)
!100 = distinct !DILexicalBlock(scope: !91, file: !3, line: 168, column: 8)
!101 = !DILocation(line: 169, column: 13, scope: !100)
!102 = !DILocation(line: 170, column: 30, scope: !99)
!103 = !DILocation(line: 170, column: 13, scope: !99)
!104 = !DILocation(line: 172, column: 33, scope: !100)
!105 = !DILocalVariable(name: "next", scope: !100, file: !3, line: 172, type: !10)
!106 = !DILocation(line: 0, scope: !100)
!107 = !DILocation(line: 173, column: 15, scope: !108)
!108 = distinct !DILexicalBlock(scope: !100, file: !3, line: 173, column: 13)
!109 = !DILocation(line: 173, column: 13, scope: !100)
!110 = !DILocation(line: 174, column: 18, scope: !108)
!111 = !DILocation(line: 174, column: 13, scope: !108)
!112 = !DILocation(line: 177, column: 5, scope: !100)
!113 = distinct !{!113, !97, !114}
!114 = !DILocation(line: 178, column: 16, scope: !91)
!115 = !DILocation(line: 179, column: 1, scope: !91)
!116 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 151, type: !117, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!117 = !DISubroutineType(types: !118)
!118 = !{null, !15, !6}
!119 = !DILocalVariable(name: "list", arg: 1, scope: !116, file: !3, line: 151, type: !15)
!120 = !DILocation(line: 0, scope: !116)
!121 = !DILocalVariable(name: "level", arg: 2, scope: !116, file: !3, line: 151, type: !6)
!122 = !DILocation(line: 153, column: 5, scope: !116)
!123 = !DILocation(line: 154, column: 15, scope: !124)
!124 = distinct !DILexicalBlock(scope: !125, file: !3, line: 154, column: 13)
!125 = distinct !DILexicalBlock(scope: !116, file: !3, line: 153, column: 8)
!126 = !DILocation(line: 154, column: 13, scope: !125)
!127 = !DILocation(line: 155, column: 30, scope: !124)
!128 = !DILocation(line: 155, column: 13, scope: !124)
!129 = !DILocation(line: 157, column: 33, scope: !125)
!130 = !DILocalVariable(name: "next", scope: !125, file: !3, line: 157, type: !15)
!131 = !DILocation(line: 0, scope: !125)
!132 = !DILocation(line: 158, column: 15, scope: !133)
!133 = distinct !DILexicalBlock(scope: !125, file: !3, line: 158, column: 13)
!134 = !DILocation(line: 158, column: 13, scope: !125)
!135 = !DILocation(line: 159, column: 18, scope: !133)
!136 = !DILocation(line: 159, column: 13, scope: !133)
!137 = !DILocation(line: 162, column: 5, scope: !125)
!138 = distinct !{!138, !122, !139}
!139 = !DILocation(line: 163, column: 16, scope: !116)
!140 = !DILocation(line: 164, column: 1, scope: !116)
!141 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 136, type: !142, scopeLine: 137, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!142 = !DISubroutineType(types: !143)
!143 = !{null, !19, !6}
!144 = !DILocalVariable(name: "list", arg: 1, scope: !141, file: !3, line: 136, type: !19)
!145 = !DILocation(line: 0, scope: !141)
!146 = !DILocalVariable(name: "level", arg: 2, scope: !141, file: !3, line: 136, type: !6)
!147 = !DILocation(line: 138, column: 5, scope: !141)
!148 = !DILocation(line: 139, column: 15, scope: !149)
!149 = distinct !DILexicalBlock(scope: !150, file: !3, line: 139, column: 13)
!150 = distinct !DILexicalBlock(scope: !141, file: !3, line: 138, column: 8)
!151 = !DILocation(line: 139, column: 13, scope: !150)
!152 = !DILocation(line: 140, column: 30, scope: !149)
!153 = !DILocation(line: 140, column: 13, scope: !149)
!154 = !DILocation(line: 142, column: 33, scope: !150)
!155 = !DILocalVariable(name: "next", scope: !150, file: !3, line: 142, type: !19)
!156 = !DILocation(line: 0, scope: !150)
!157 = !DILocation(line: 143, column: 15, scope: !158)
!158 = distinct !DILexicalBlock(scope: !150, file: !3, line: 143, column: 13)
!159 = !DILocation(line: 143, column: 13, scope: !150)
!160 = !DILocation(line: 144, column: 18, scope: !158)
!161 = !DILocation(line: 144, column: 13, scope: !158)
!162 = !DILocation(line: 147, column: 5, scope: !150)
!163 = distinct !{!163, !147, !164}
!164 = !DILocation(line: 148, column: 16, scope: !141)
!165 = !DILocation(line: 149, column: 1, scope: !141)
!166 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 121, type: !167, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!167 = !DISubroutineType(types: !168)
!168 = !{null, !24, !6}
!169 = !DILocalVariable(name: "list", arg: 1, scope: !166, file: !3, line: 121, type: !24)
!170 = !DILocation(line: 0, scope: !166)
!171 = !DILocalVariable(name: "level", arg: 2, scope: !166, file: !3, line: 121, type: !6)
!172 = !DILocation(line: 123, column: 5, scope: !166)
!173 = !DILocation(line: 124, column: 15, scope: !174)
!174 = distinct !DILexicalBlock(scope: !175, file: !3, line: 124, column: 13)
!175 = distinct !DILexicalBlock(scope: !166, file: !3, line: 123, column: 8)
!176 = !DILocation(line: 124, column: 13, scope: !175)
!177 = !DILocation(line: 125, column: 30, scope: !174)
!178 = !DILocation(line: 125, column: 13, scope: !174)
!179 = !DILocation(line: 127, column: 33, scope: !175)
!180 = !DILocalVariable(name: "next", scope: !175, file: !3, line: 127, type: !24)
!181 = !DILocation(line: 0, scope: !175)
!182 = !DILocation(line: 128, column: 15, scope: !183)
!183 = distinct !DILexicalBlock(scope: !175, file: !3, line: 128, column: 13)
!184 = !DILocation(line: 128, column: 13, scope: !175)
!185 = !DILocation(line: 129, column: 18, scope: !183)
!186 = !DILocation(line: 129, column: 13, scope: !183)
!187 = !DILocation(line: 132, column: 5, scope: !175)
!188 = distinct !{!188, !172, !189}
!189 = !DILocation(line: 133, column: 16, scope: !166)
!190 = !DILocation(line: 134, column: 1, scope: !166)
!191 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !192, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!192 = !DISubroutineType(types: !193)
!193 = !{null, !28, !6}
!194 = !DILocalVariable(name: "list", arg: 1, scope: !191, file: !3, line: 106, type: !28)
!195 = !DILocation(line: 0, scope: !191)
!196 = !DILocalVariable(name: "level", arg: 2, scope: !191, file: !3, line: 106, type: !6)
!197 = !DILocation(line: 108, column: 5, scope: !191)
!198 = !DILocation(line: 109, column: 15, scope: !199)
!199 = distinct !DILexicalBlock(scope: !200, file: !3, line: 109, column: 13)
!200 = distinct !DILexicalBlock(scope: !191, file: !3, line: 108, column: 8)
!201 = !DILocation(line: 109, column: 13, scope: !200)
!202 = !DILocation(line: 110, column: 24, scope: !199)
!203 = !DILocation(line: 110, column: 18, scope: !199)
!204 = !DILocation(line: 110, column: 13, scope: !199)
!205 = !DILocation(line: 112, column: 33, scope: !200)
!206 = !DILocalVariable(name: "next", scope: !200, file: !3, line: 112, type: !28)
!207 = !DILocation(line: 0, scope: !200)
!208 = !DILocation(line: 113, column: 15, scope: !209)
!209 = distinct !DILexicalBlock(scope: !200, file: !3, line: 113, column: 13)
!210 = !DILocation(line: 113, column: 13, scope: !200)
!211 = !DILocation(line: 114, column: 18, scope: !209)
!212 = !DILocation(line: 114, column: 13, scope: !209)
!213 = !DILocation(line: 117, column: 5, scope: !200)
!214 = distinct !{!214, !197, !215}
!215 = !DILocation(line: 118, column: 16, scope: !191)
!216 = !DILocation(line: 119, column: 1, scope: !191)
!217 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !218, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!218 = !DISubroutineType(types: !219)
!219 = !{!220, !221}
!220 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!221 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!222 = !DILocalVariable(name: "size", arg: 1, scope: !217, file: !3, line: 40, type: !221)
!223 = !DILocation(line: 0, scope: !217)
!224 = !DILocation(line: 42, column: 34, scope: !217)
!225 = !DILocation(line: 42, column: 17, scope: !217)
!226 = !DILocalVariable(name: "ptr", scope: !217, file: !3, line: 42, type: !220)
!227 = !DILocation(line: 43, column: 9, scope: !228)
!228 = distinct !DILexicalBlock(scope: !217, file: !3, line: 43, column: 9)
!229 = !DILocation(line: 43, column: 9, scope: !217)
!230 = !DILocation(line: 44, column: 9, scope: !228)
!231 = !DILocation(line: 46, column: 5, scope: !217)
!232 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !233, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!233 = !DISubroutineType(types: !234)
!234 = !{null, !235}
!235 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!236 = !DILocalVariable(name: "list", arg: 1, scope: !232, file: !3, line: 82, type: !235)
!237 = !DILocation(line: 0, scope: !232)
!238 = !DILocation(line: 84, column: 23, scope: !232)
!239 = !DILocalVariable(name: "item", scope: !232, file: !3, line: 84, type: !15)
!240 = !DILocation(line: 86, column: 5, scope: !232)
!241 = !DILocation(line: 87, column: 26, scope: !232)
!242 = !DILocation(line: 87, column: 9, scope: !232)
!243 = !DILocation(line: 88, column: 12, scope: !232)
!244 = distinct !{!244, !240, !245}
!245 = !DILocation(line: 88, column: 35, scope: !232)
!246 = !DILocation(line: 90, column: 18, scope: !232)
!247 = !DILocation(line: 90, column: 11, scope: !232)
!248 = !DILocation(line: 90, column: 16, scope: !232)
!249 = !DILocation(line: 91, column: 11, scope: !232)
!250 = !DILocation(line: 92, column: 1, scope: !232)
!251 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !252, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!252 = !DISubroutineType(types: !253)
!253 = !{null, !254}
!254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!255 = !DILocalVariable(name: "list", arg: 1, scope: !251, file: !3, line: 70, type: !254)
!256 = !DILocation(line: 0, scope: !251)
!257 = !DILocation(line: 72, column: 23, scope: !251)
!258 = !DILocalVariable(name: "item", scope: !251, file: !3, line: 72, type: !19)
!259 = !DILocation(line: 74, column: 5, scope: !251)
!260 = !DILocation(line: 75, column: 26, scope: !251)
!261 = !DILocation(line: 75, column: 9, scope: !251)
!262 = !DILocation(line: 76, column: 12, scope: !251)
!263 = distinct !{!263, !259, !264}
!264 = !DILocation(line: 76, column: 35, scope: !251)
!265 = !DILocation(line: 78, column: 18, scope: !251)
!266 = !DILocation(line: 78, column: 11, scope: !251)
!267 = !DILocation(line: 78, column: 16, scope: !251)
!268 = !DILocation(line: 79, column: 11, scope: !251)
!269 = !DILocation(line: 80, column: 1, scope: !251)
!270 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !271, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!271 = !DISubroutineType(types: !272)
!272 = !{null, !273}
!273 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!274 = !DILocalVariable(name: "list", arg: 1, scope: !270, file: !3, line: 58, type: !273)
!275 = !DILocation(line: 0, scope: !270)
!276 = !DILocation(line: 60, column: 23, scope: !270)
!277 = !DILocalVariable(name: "item", scope: !270, file: !3, line: 60, type: !24)
!278 = !DILocation(line: 62, column: 5, scope: !270)
!279 = !DILocation(line: 63, column: 26, scope: !270)
!280 = !DILocation(line: 63, column: 9, scope: !270)
!281 = !DILocation(line: 64, column: 12, scope: !270)
!282 = distinct !{!282, !278, !283}
!283 = !DILocation(line: 64, column: 35, scope: !270)
!284 = !DILocation(line: 66, column: 18, scope: !270)
!285 = !DILocation(line: 66, column: 11, scope: !270)
!286 = !DILocation(line: 66, column: 16, scope: !270)
!287 = !DILocation(line: 67, column: 11, scope: !270)
!288 = !DILocation(line: 68, column: 1, scope: !270)
!289 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !290, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!290 = !DISubroutineType(types: !291)
!291 = !{null, !292}
!292 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!293 = !DILocalVariable(name: "list", arg: 1, scope: !289, file: !3, line: 49, type: !292)
!294 = !DILocation(line: 0, scope: !289)
!295 = !DILocation(line: 51, column: 23, scope: !289)
!296 = !DILocalVariable(name: "item", scope: !289, file: !3, line: 51, type: !28)
!297 = !DILocation(line: 52, column: 18, scope: !289)
!298 = !DILocation(line: 52, column: 11, scope: !289)
!299 = !DILocation(line: 52, column: 16, scope: !289)
!300 = !DILocation(line: 54, column: 18, scope: !289)
!301 = !DILocation(line: 54, column: 11, scope: !289)
!302 = !DILocation(line: 54, column: 16, scope: !289)
!303 = !DILocation(line: 55, column: 11, scope: !289)
!304 = !DILocation(line: 56, column: 1, scope: !289)
!305 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !306, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!306 = !DISubroutineType(types: !307)
!307 = !{!220, !308, !308}
!308 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !309, line: 46, baseType: !310)
!309 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!310 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!311 = !DILocalVariable(name: "nmemb", arg: 1, scope: !305, file: !3, line: 8, type: !308)
!312 = !DILocation(line: 0, scope: !305)
!313 = !DILocalVariable(name: "size", arg: 2, scope: !305, file: !3, line: 8, type: !308)
!314 = !DILocation(line: 9, column: 30, scope: !305)
!315 = !DILocation(line: 9, column: 17, scope: !305)
!316 = !DILocalVariable(name: "ptr", scope: !305, file: !3, line: 9, type: !220)
!317 = !DILocation(line: 10, column: 33, scope: !305)
!318 = !DILocation(line: 10, column: 12, scope: !305)
!319 = !DILocation(line: 10, column: 5, scope: !305)
