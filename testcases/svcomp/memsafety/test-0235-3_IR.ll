; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-kkadctx4.bc'
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
@.str.1 = private unnamed_addr constant [14 x i8] c"test-0235-3.c\00", align 1
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
  call void @free(i8* %13) #6, !dbg !111, !verifier.code !47
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
  call void @free(i8* %13) #6, !dbg !136, !verifier.code !47
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
  call void @free(i8* %13) #6, !dbg !161, !verifier.code !47
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
  call void @free(i8* %13) #6, !dbg !186, !verifier.code !47
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
  call void @free(i8* %8) #6, !dbg !204, !verifier.code !47
  br label %9, !dbg !204, !verifier.code !47

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !205, !verifier.code !47
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !205, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !206, metadata !DIExpression()), !dbg !207, !verifier.code !47
  %12 = icmp eq i32 4, %1, !dbg !208, !verifier.code !47
  br i1 %12, label %13, label %15, !dbg !210, !verifier.code !47

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !211, !verifier.code !47
  call void @free(i8* %14) #6, !dbg !212, !verifier.code !47
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
  %2 = call i8* @calloc_model(i32 1, i32 %0), !dbg !224, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %2, metadata !225, metadata !DIExpression()), !dbg !223, !verifier.code !47
  %3 = icmp ne i8* %2, null, !dbg !226, !verifier.code !47
  br i1 %3, label %4, label %5, !dbg !228, !verifier.code !47

4:                                                ; preds = %1
  ret i8* %2, !dbg !229, !verifier.code !47

5:                                                ; preds = %1
  call void @abort() #5, !dbg !230, !verifier.code !47
  unreachable, !dbg !230, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !231 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !235, metadata !DIExpression()), !dbg !236, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !237, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !237, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !238, metadata !DIExpression()), !dbg !236, !verifier.code !47
  br label %4, !dbg !239, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !240, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !241, !verifier.code !47
  br label %6, !dbg !241, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !242, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !241, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !241, !llvm.loop !243, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !245, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !246, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !247, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !248, !verifier.code !47
  ret void, !dbg !249, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !250 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !254, metadata !DIExpression()), !dbg !255, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !256, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !256, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !257, metadata !DIExpression()), !dbg !255, !verifier.code !47
  br label %4, !dbg !258, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !259, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !260, !verifier.code !47
  br label %6, !dbg !260, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !261, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !260, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !260, !llvm.loop !262, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !264, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !265, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !266, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !267, !verifier.code !47
  ret void, !dbg !268, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !269 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !273, metadata !DIExpression()), !dbg !274, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !275, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !275, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !276, metadata !DIExpression()), !dbg !274, !verifier.code !47
  br label %4, !dbg !277, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !278, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !279, !verifier.code !47
  br label %6, !dbg !279, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !280, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !279, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !279, !llvm.loop !281, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !283, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !284, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !285, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !286, !verifier.code !47
  ret void, !dbg !287, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !288 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !292, metadata !DIExpression()), !dbg !293, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !294, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !294, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !295, metadata !DIExpression()), !dbg !293, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !296, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !296, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !297, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !298, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !299, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !300, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !301, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !302, !verifier.code !47
  ret void, !dbg !303, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i32 %0, i32 %1) #0 !dbg !304 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !308, metadata !DIExpression()), !dbg !309, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !310, metadata !DIExpression()), !dbg !309, !verifier.code !47
  %3 = mul i32 %0, %1, !dbg !311, !verifier.code !47
  %4 = call noalias i8* @malloc(i32 %3) #6, !dbg !312, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !313, metadata !DIExpression()), !dbg !309, !verifier.code !47
  %5 = mul i32 %0, %1, !dbg !314, !verifier.code !47
  %6 = call i8* @memset(i8* %4, i32 0, i32 %5) #6, !dbg !315, !verifier.code !47
  ret i8* %6, !dbg !316, !verifier.code !47
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
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0235-3.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!66 = !DILocation(line: 787, column: 16, scope: !2)
!67 = !DILocation(line: 787, column: 5, scope: !2)
!68 = !DILocation(line: 788, column: 14, scope: !2)
!69 = !DILocation(line: 788, column: 13, scope: !2)
!70 = !DILocation(line: 788, column: 12, scope: !2)
!71 = !DILocation(line: 788, column: 5, scope: !2)
!72 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 706, type: !73, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!73 = !DISubroutineType(types: !74)
!74 = !{null, !75}
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!76 = !DILocalVariable(name: "list", arg: 1, scope: !72, file: !3, line: 706, type: !75)
!77 = !DILocation(line: 0, scope: !72)
!78 = !DILocation(line: 708, column: 23, scope: !72)
!79 = !DILocalVariable(name: "item", scope: !72, file: !3, line: 708, type: !10)
!80 = !DILocation(line: 709, column: 5, scope: !72)
!81 = !DILocation(line: 710, column: 26, scope: !72)
!82 = !DILocation(line: 710, column: 9, scope: !72)
!83 = !DILocation(line: 711, column: 12, scope: !72)
!84 = distinct !{!84, !80, !85}
!85 = !DILocation(line: 711, column: 35, scope: !72)
!86 = !DILocation(line: 712, column: 18, scope: !72)
!87 = !DILocation(line: 712, column: 11, scope: !72)
!88 = !DILocation(line: 712, column: 16, scope: !72)
!89 = !DILocation(line: 713, column: 11, scope: !72)
!90 = !DILocation(line: 714, column: 1, scope: !72)
!91 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 763, type: !92, scopeLine: 764, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!92 = !DISubroutineType(types: !93)
!93 = !{null, !10, !6}
!94 = !DILocalVariable(name: "list", arg: 1, scope: !91, file: !3, line: 763, type: !10)
!95 = !DILocation(line: 0, scope: !91)
!96 = !DILocalVariable(name: "level", arg: 2, scope: !91, file: !3, line: 763, type: !6)
!97 = !DILocation(line: 765, column: 5, scope: !91)
!98 = !DILocation(line: 766, column: 15, scope: !99)
!99 = distinct !DILexicalBlock(scope: !100, file: !3, line: 766, column: 13)
!100 = distinct !DILexicalBlock(scope: !91, file: !3, line: 765, column: 8)
!101 = !DILocation(line: 766, column: 13, scope: !100)
!102 = !DILocation(line: 767, column: 30, scope: !99)
!103 = !DILocation(line: 767, column: 13, scope: !99)
!104 = !DILocation(line: 768, column: 33, scope: !100)
!105 = !DILocalVariable(name: "next", scope: !100, file: !3, line: 768, type: !10)
!106 = !DILocation(line: 0, scope: !100)
!107 = !DILocation(line: 769, column: 15, scope: !108)
!108 = distinct !DILexicalBlock(scope: !100, file: !3, line: 769, column: 13)
!109 = !DILocation(line: 769, column: 13, scope: !100)
!110 = !DILocation(line: 770, column: 18, scope: !108)
!111 = !DILocation(line: 770, column: 13, scope: !108)
!112 = !DILocation(line: 772, column: 5, scope: !100)
!113 = distinct !{!113, !97, !114}
!114 = !DILocation(line: 773, column: 16, scope: !91)
!115 = !DILocation(line: 774, column: 1, scope: !91)
!116 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 751, type: !117, scopeLine: 752, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!117 = !DISubroutineType(types: !118)
!118 = !{null, !15, !6}
!119 = !DILocalVariable(name: "list", arg: 1, scope: !116, file: !3, line: 751, type: !15)
!120 = !DILocation(line: 0, scope: !116)
!121 = !DILocalVariable(name: "level", arg: 2, scope: !116, file: !3, line: 751, type: !6)
!122 = !DILocation(line: 753, column: 5, scope: !116)
!123 = !DILocation(line: 754, column: 15, scope: !124)
!124 = distinct !DILexicalBlock(scope: !125, file: !3, line: 754, column: 13)
!125 = distinct !DILexicalBlock(scope: !116, file: !3, line: 753, column: 8)
!126 = !DILocation(line: 754, column: 13, scope: !125)
!127 = !DILocation(line: 755, column: 30, scope: !124)
!128 = !DILocation(line: 755, column: 13, scope: !124)
!129 = !DILocation(line: 756, column: 33, scope: !125)
!130 = !DILocalVariable(name: "next", scope: !125, file: !3, line: 756, type: !15)
!131 = !DILocation(line: 0, scope: !125)
!132 = !DILocation(line: 757, column: 15, scope: !133)
!133 = distinct !DILexicalBlock(scope: !125, file: !3, line: 757, column: 13)
!134 = !DILocation(line: 757, column: 13, scope: !125)
!135 = !DILocation(line: 758, column: 18, scope: !133)
!136 = !DILocation(line: 758, column: 13, scope: !133)
!137 = !DILocation(line: 760, column: 5, scope: !125)
!138 = distinct !{!138, !122, !139}
!139 = !DILocation(line: 761, column: 16, scope: !116)
!140 = !DILocation(line: 762, column: 1, scope: !116)
!141 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 739, type: !142, scopeLine: 740, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!142 = !DISubroutineType(types: !143)
!143 = !{null, !19, !6}
!144 = !DILocalVariable(name: "list", arg: 1, scope: !141, file: !3, line: 739, type: !19)
!145 = !DILocation(line: 0, scope: !141)
!146 = !DILocalVariable(name: "level", arg: 2, scope: !141, file: !3, line: 739, type: !6)
!147 = !DILocation(line: 741, column: 5, scope: !141)
!148 = !DILocation(line: 742, column: 15, scope: !149)
!149 = distinct !DILexicalBlock(scope: !150, file: !3, line: 742, column: 13)
!150 = distinct !DILexicalBlock(scope: !141, file: !3, line: 741, column: 8)
!151 = !DILocation(line: 742, column: 13, scope: !150)
!152 = !DILocation(line: 743, column: 30, scope: !149)
!153 = !DILocation(line: 743, column: 13, scope: !149)
!154 = !DILocation(line: 744, column: 33, scope: !150)
!155 = !DILocalVariable(name: "next", scope: !150, file: !3, line: 744, type: !19)
!156 = !DILocation(line: 0, scope: !150)
!157 = !DILocation(line: 745, column: 15, scope: !158)
!158 = distinct !DILexicalBlock(scope: !150, file: !3, line: 745, column: 13)
!159 = !DILocation(line: 745, column: 13, scope: !150)
!160 = !DILocation(line: 746, column: 18, scope: !158)
!161 = !DILocation(line: 746, column: 13, scope: !158)
!162 = !DILocation(line: 748, column: 5, scope: !150)
!163 = distinct !{!163, !147, !164}
!164 = !DILocation(line: 749, column: 16, scope: !141)
!165 = !DILocation(line: 750, column: 1, scope: !141)
!166 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 727, type: !167, scopeLine: 728, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!167 = !DISubroutineType(types: !168)
!168 = !{null, !24, !6}
!169 = !DILocalVariable(name: "list", arg: 1, scope: !166, file: !3, line: 727, type: !24)
!170 = !DILocation(line: 0, scope: !166)
!171 = !DILocalVariable(name: "level", arg: 2, scope: !166, file: !3, line: 727, type: !6)
!172 = !DILocation(line: 729, column: 5, scope: !166)
!173 = !DILocation(line: 730, column: 15, scope: !174)
!174 = distinct !DILexicalBlock(scope: !175, file: !3, line: 730, column: 13)
!175 = distinct !DILexicalBlock(scope: !166, file: !3, line: 729, column: 8)
!176 = !DILocation(line: 730, column: 13, scope: !175)
!177 = !DILocation(line: 731, column: 30, scope: !174)
!178 = !DILocation(line: 731, column: 13, scope: !174)
!179 = !DILocation(line: 732, column: 33, scope: !175)
!180 = !DILocalVariable(name: "next", scope: !175, file: !3, line: 732, type: !24)
!181 = !DILocation(line: 0, scope: !175)
!182 = !DILocation(line: 733, column: 15, scope: !183)
!183 = distinct !DILexicalBlock(scope: !175, file: !3, line: 733, column: 13)
!184 = !DILocation(line: 733, column: 13, scope: !175)
!185 = !DILocation(line: 734, column: 18, scope: !183)
!186 = !DILocation(line: 734, column: 13, scope: !183)
!187 = !DILocation(line: 736, column: 5, scope: !175)
!188 = distinct !{!188, !172, !189}
!189 = !DILocation(line: 737, column: 16, scope: !166)
!190 = !DILocation(line: 738, column: 1, scope: !166)
!191 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 715, type: !192, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!192 = !DISubroutineType(types: !193)
!193 = !{null, !28, !6}
!194 = !DILocalVariable(name: "list", arg: 1, scope: !191, file: !3, line: 715, type: !28)
!195 = !DILocation(line: 0, scope: !191)
!196 = !DILocalVariable(name: "level", arg: 2, scope: !191, file: !3, line: 715, type: !6)
!197 = !DILocation(line: 717, column: 5, scope: !191)
!198 = !DILocation(line: 718, column: 15, scope: !199)
!199 = distinct !DILexicalBlock(scope: !200, file: !3, line: 718, column: 13)
!200 = distinct !DILexicalBlock(scope: !191, file: !3, line: 717, column: 8)
!201 = !DILocation(line: 718, column: 13, scope: !200)
!202 = !DILocation(line: 719, column: 24, scope: !199)
!203 = !DILocation(line: 719, column: 18, scope: !199)
!204 = !DILocation(line: 719, column: 13, scope: !199)
!205 = !DILocation(line: 720, column: 33, scope: !200)
!206 = !DILocalVariable(name: "next", scope: !200, file: !3, line: 720, type: !28)
!207 = !DILocation(line: 0, scope: !200)
!208 = !DILocation(line: 721, column: 15, scope: !209)
!209 = distinct !DILexicalBlock(scope: !200, file: !3, line: 721, column: 13)
!210 = !DILocation(line: 721, column: 13, scope: !200)
!211 = !DILocation(line: 722, column: 18, scope: !209)
!212 = !DILocation(line: 722, column: 13, scope: !209)
!213 = !DILocation(line: 724, column: 5, scope: !200)
!214 = distinct !{!214, !197, !215}
!215 = !DILocation(line: 725, column: 16, scope: !191)
!216 = !DILocation(line: 726, column: 1, scope: !191)
!217 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 665, type: !218, scopeLine: 666, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!218 = !DISubroutineType(types: !219)
!219 = !{!220, !221}
!220 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!221 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!222 = !DILocalVariable(name: "size", arg: 1, scope: !217, file: !3, line: 665, type: !221)
!223 = !DILocation(line: 0, scope: !217)
!224 = !DILocation(line: 667, column: 17, scope: !217)
!225 = !DILocalVariable(name: "ptr", scope: !217, file: !3, line: 667, type: !220)
!226 = !DILocation(line: 668, column: 9, scope: !227)
!227 = distinct !DILexicalBlock(scope: !217, file: !3, line: 668, column: 9)
!228 = !DILocation(line: 668, column: 9, scope: !217)
!229 = !DILocation(line: 669, column: 9, scope: !227)
!230 = !DILocation(line: 670, column: 5, scope: !217)
!231 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 697, type: !232, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!232 = !DISubroutineType(types: !233)
!233 = !{null, !234}
!234 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!235 = !DILocalVariable(name: "list", arg: 1, scope: !231, file: !3, line: 697, type: !234)
!236 = !DILocation(line: 0, scope: !231)
!237 = !DILocation(line: 699, column: 23, scope: !231)
!238 = !DILocalVariable(name: "item", scope: !231, file: !3, line: 699, type: !15)
!239 = !DILocation(line: 700, column: 5, scope: !231)
!240 = !DILocation(line: 701, column: 26, scope: !231)
!241 = !DILocation(line: 701, column: 9, scope: !231)
!242 = !DILocation(line: 702, column: 12, scope: !231)
!243 = distinct !{!243, !239, !244}
!244 = !DILocation(line: 702, column: 35, scope: !231)
!245 = !DILocation(line: 703, column: 18, scope: !231)
!246 = !DILocation(line: 703, column: 11, scope: !231)
!247 = !DILocation(line: 703, column: 16, scope: !231)
!248 = !DILocation(line: 704, column: 11, scope: !231)
!249 = !DILocation(line: 705, column: 1, scope: !231)
!250 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 688, type: !251, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!251 = !DISubroutineType(types: !252)
!252 = !{null, !253}
!253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!254 = !DILocalVariable(name: "list", arg: 1, scope: !250, file: !3, line: 688, type: !253)
!255 = !DILocation(line: 0, scope: !250)
!256 = !DILocation(line: 690, column: 23, scope: !250)
!257 = !DILocalVariable(name: "item", scope: !250, file: !3, line: 690, type: !19)
!258 = !DILocation(line: 691, column: 5, scope: !250)
!259 = !DILocation(line: 692, column: 26, scope: !250)
!260 = !DILocation(line: 692, column: 9, scope: !250)
!261 = !DILocation(line: 693, column: 12, scope: !250)
!262 = distinct !{!262, !258, !263}
!263 = !DILocation(line: 693, column: 35, scope: !250)
!264 = !DILocation(line: 694, column: 18, scope: !250)
!265 = !DILocation(line: 694, column: 11, scope: !250)
!266 = !DILocation(line: 694, column: 16, scope: !250)
!267 = !DILocation(line: 695, column: 11, scope: !250)
!268 = !DILocation(line: 696, column: 1, scope: !250)
!269 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 679, type: !270, scopeLine: 680, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!270 = !DISubroutineType(types: !271)
!271 = !{null, !272}
!272 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!273 = !DILocalVariable(name: "list", arg: 1, scope: !269, file: !3, line: 679, type: !272)
!274 = !DILocation(line: 0, scope: !269)
!275 = !DILocation(line: 681, column: 23, scope: !269)
!276 = !DILocalVariable(name: "item", scope: !269, file: !3, line: 681, type: !24)
!277 = !DILocation(line: 682, column: 5, scope: !269)
!278 = !DILocation(line: 683, column: 26, scope: !269)
!279 = !DILocation(line: 683, column: 9, scope: !269)
!280 = !DILocation(line: 684, column: 12, scope: !269)
!281 = distinct !{!281, !277, !282}
!282 = !DILocation(line: 684, column: 35, scope: !269)
!283 = !DILocation(line: 685, column: 18, scope: !269)
!284 = !DILocation(line: 685, column: 11, scope: !269)
!285 = !DILocation(line: 685, column: 16, scope: !269)
!286 = !DILocation(line: 686, column: 11, scope: !269)
!287 = !DILocation(line: 687, column: 1, scope: !269)
!288 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 672, type: !289, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!289 = !DISubroutineType(types: !290)
!290 = !{null, !291}
!291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!292 = !DILocalVariable(name: "list", arg: 1, scope: !288, file: !3, line: 672, type: !291)
!293 = !DILocation(line: 0, scope: !288)
!294 = !DILocation(line: 674, column: 23, scope: !288)
!295 = !DILocalVariable(name: "item", scope: !288, file: !3, line: 674, type: !28)
!296 = !DILocation(line: 675, column: 18, scope: !288)
!297 = !DILocation(line: 675, column: 11, scope: !288)
!298 = !DILocation(line: 675, column: 16, scope: !288)
!299 = !DILocation(line: 676, column: 18, scope: !288)
!300 = !DILocation(line: 676, column: 11, scope: !288)
!301 = !DILocation(line: 676, column: 16, scope: !288)
!302 = !DILocation(line: 677, column: 11, scope: !288)
!303 = !DILocation(line: 678, column: 1, scope: !288)
!304 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 640, type: !305, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!305 = !DISubroutineType(types: !306)
!306 = !{!220, !307, !307}
!307 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 13, baseType: !221)
!308 = !DILocalVariable(name: "nmemb", arg: 1, scope: !304, file: !3, line: 640, type: !307)
!309 = !DILocation(line: 0, scope: !304)
!310 = !DILocalVariable(name: "size", arg: 2, scope: !304, file: !3, line: 640, type: !307)
!311 = !DILocation(line: 641, column: 30, scope: !304)
!312 = !DILocation(line: 641, column: 17, scope: !304)
!313 = !DILocalVariable(name: "ptr", scope: !304, file: !3, line: 641, type: !220)
!314 = !DILocation(line: 642, column: 33, scope: !304)
!315 = !DILocation(line: 642, column: 12, scope: !304)
!316 = !DILocation(line: 642, column: 5, scope: !304)
