; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-5kugq34w.bc'
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
@.str.1 = private unnamed_addr constant [14 x i8] c"test-0235-1.c\00", align 1
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
  call void @free(i8* %13) #6, !dbg !107, !verifier.code !47
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
  call void @free(i8* %13) #6, !dbg !132, !verifier.code !47
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
  call void @free(i8* %13) #6, !dbg !157, !verifier.code !47
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
  call void @free(i8* %13) #6, !dbg !182, !verifier.code !47
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
  call void @free(i8* %8) #6, !dbg !200, !verifier.code !47
  br label %9, !dbg !200, !verifier.code !47

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !201, !verifier.code !47
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !201, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !202, metadata !DIExpression()), !dbg !203, !verifier.code !47
  %12 = icmp eq i32 4, %1, !dbg !204, !verifier.code !47
  br i1 %12, label %13, label %15, !dbg !206, !verifier.code !47

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !207, !verifier.code !47
  call void @free(i8* %14) #6, !dbg !208, !verifier.code !47
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
  %2 = call i8* @calloc_model(i32 1, i32 %0), !dbg !220, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %2, metadata !221, metadata !DIExpression()), !dbg !219, !verifier.code !47
  %3 = icmp ne i8* %2, null, !dbg !222, !verifier.code !47
  br i1 %3, label %4, label %5, !dbg !224, !verifier.code !47

4:                                                ; preds = %1
  ret i8* %2, !dbg !225, !verifier.code !47

5:                                                ; preds = %1
  call void @abort() #5, !dbg !226, !verifier.code !47
  unreachable, !dbg !226, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !227 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !231, metadata !DIExpression()), !dbg !232, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !233, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !233, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !234, metadata !DIExpression()), !dbg !232, !verifier.code !47
  br label %4, !dbg !235, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !236, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !237, !verifier.code !47
  br label %6, !dbg !237, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !238, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !237, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !237, !llvm.loop !239, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !241, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !242, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !243, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !244, !verifier.code !47
  ret void, !dbg !245, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !246 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !250, metadata !DIExpression()), !dbg !251, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !252, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !252, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !253, metadata !DIExpression()), !dbg !251, !verifier.code !47
  br label %4, !dbg !254, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !255, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !256, !verifier.code !47
  br label %6, !dbg !256, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !257, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !256, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !256, !llvm.loop !258, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !260, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !261, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !262, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !263, !verifier.code !47
  ret void, !dbg !264, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !265 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !269, metadata !DIExpression()), !dbg !270, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !271, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !271, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !272, metadata !DIExpression()), !dbg !270, !verifier.code !47
  br label %4, !dbg !273, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !274, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !275, !verifier.code !47
  br label %6, !dbg !275, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !276, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !275, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !275, !llvm.loop !277, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !279, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !280, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !281, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !282, !verifier.code !47
  ret void, !dbg !283, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !284 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !288, metadata !DIExpression()), !dbg !289, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !290, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !290, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !291, metadata !DIExpression()), !dbg !289, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !292, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !292, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !293, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !294, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !295, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !296, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !297, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !298, !verifier.code !47
  ret void, !dbg !299, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i32 %0, i32 %1) #0 !dbg !300 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !304, metadata !DIExpression()), !dbg !305, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !306, metadata !DIExpression()), !dbg !305, !verifier.code !47
  %3 = mul i32 %0, %1, !dbg !307, !verifier.code !47
  %4 = call noalias i8* @malloc(i32 %3) #6, !dbg !308, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !309, metadata !DIExpression()), !dbg !305, !verifier.code !47
  %5 = mul i32 %0, %1, !dbg !310, !verifier.code !47
  %6 = call i8* @memset(i8* %4, i32 0, i32 %5) #6, !dbg !311, !verifier.code !47
  ret i8* %6, !dbg !312, !verifier.code !47
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
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0235-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!64 = !DILocation(line: 786, column: 14, scope: !2)
!65 = !DILocation(line: 786, column: 13, scope: !2)
!66 = !DILocation(line: 786, column: 12, scope: !2)
!67 = !DILocation(line: 786, column: 5, scope: !2)
!68 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 706, type: !69, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!69 = !DISubroutineType(types: !70)
!70 = !{null, !71}
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!72 = !DILocalVariable(name: "list", arg: 1, scope: !68, file: !3, line: 706, type: !71)
!73 = !DILocation(line: 0, scope: !68)
!74 = !DILocation(line: 708, column: 23, scope: !68)
!75 = !DILocalVariable(name: "item", scope: !68, file: !3, line: 708, type: !10)
!76 = !DILocation(line: 709, column: 5, scope: !68)
!77 = !DILocation(line: 710, column: 26, scope: !68)
!78 = !DILocation(line: 710, column: 9, scope: !68)
!79 = !DILocation(line: 711, column: 12, scope: !68)
!80 = distinct !{!80, !76, !81}
!81 = !DILocation(line: 711, column: 35, scope: !68)
!82 = !DILocation(line: 712, column: 18, scope: !68)
!83 = !DILocation(line: 712, column: 11, scope: !68)
!84 = !DILocation(line: 712, column: 16, scope: !68)
!85 = !DILocation(line: 713, column: 11, scope: !68)
!86 = !DILocation(line: 714, column: 1, scope: !68)
!87 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 763, type: !88, scopeLine: 764, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!88 = !DISubroutineType(types: !89)
!89 = !{null, !10, !6}
!90 = !DILocalVariable(name: "list", arg: 1, scope: !87, file: !3, line: 763, type: !10)
!91 = !DILocation(line: 0, scope: !87)
!92 = !DILocalVariable(name: "level", arg: 2, scope: !87, file: !3, line: 763, type: !6)
!93 = !DILocation(line: 765, column: 5, scope: !87)
!94 = !DILocation(line: 766, column: 15, scope: !95)
!95 = distinct !DILexicalBlock(scope: !96, file: !3, line: 766, column: 13)
!96 = distinct !DILexicalBlock(scope: !87, file: !3, line: 765, column: 8)
!97 = !DILocation(line: 766, column: 13, scope: !96)
!98 = !DILocation(line: 767, column: 30, scope: !95)
!99 = !DILocation(line: 767, column: 13, scope: !95)
!100 = !DILocation(line: 768, column: 33, scope: !96)
!101 = !DILocalVariable(name: "next", scope: !96, file: !3, line: 768, type: !10)
!102 = !DILocation(line: 0, scope: !96)
!103 = !DILocation(line: 769, column: 15, scope: !104)
!104 = distinct !DILexicalBlock(scope: !96, file: !3, line: 769, column: 13)
!105 = !DILocation(line: 769, column: 13, scope: !96)
!106 = !DILocation(line: 770, column: 18, scope: !104)
!107 = !DILocation(line: 770, column: 13, scope: !104)
!108 = !DILocation(line: 772, column: 5, scope: !96)
!109 = distinct !{!109, !93, !110}
!110 = !DILocation(line: 773, column: 16, scope: !87)
!111 = !DILocation(line: 774, column: 1, scope: !87)
!112 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 751, type: !113, scopeLine: 752, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!113 = !DISubroutineType(types: !114)
!114 = !{null, !15, !6}
!115 = !DILocalVariable(name: "list", arg: 1, scope: !112, file: !3, line: 751, type: !15)
!116 = !DILocation(line: 0, scope: !112)
!117 = !DILocalVariable(name: "level", arg: 2, scope: !112, file: !3, line: 751, type: !6)
!118 = !DILocation(line: 753, column: 5, scope: !112)
!119 = !DILocation(line: 754, column: 15, scope: !120)
!120 = distinct !DILexicalBlock(scope: !121, file: !3, line: 754, column: 13)
!121 = distinct !DILexicalBlock(scope: !112, file: !3, line: 753, column: 8)
!122 = !DILocation(line: 754, column: 13, scope: !121)
!123 = !DILocation(line: 755, column: 30, scope: !120)
!124 = !DILocation(line: 755, column: 13, scope: !120)
!125 = !DILocation(line: 756, column: 33, scope: !121)
!126 = !DILocalVariable(name: "next", scope: !121, file: !3, line: 756, type: !15)
!127 = !DILocation(line: 0, scope: !121)
!128 = !DILocation(line: 757, column: 15, scope: !129)
!129 = distinct !DILexicalBlock(scope: !121, file: !3, line: 757, column: 13)
!130 = !DILocation(line: 757, column: 13, scope: !121)
!131 = !DILocation(line: 758, column: 18, scope: !129)
!132 = !DILocation(line: 758, column: 13, scope: !129)
!133 = !DILocation(line: 760, column: 5, scope: !121)
!134 = distinct !{!134, !118, !135}
!135 = !DILocation(line: 761, column: 16, scope: !112)
!136 = !DILocation(line: 762, column: 1, scope: !112)
!137 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 739, type: !138, scopeLine: 740, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!138 = !DISubroutineType(types: !139)
!139 = !{null, !19, !6}
!140 = !DILocalVariable(name: "list", arg: 1, scope: !137, file: !3, line: 739, type: !19)
!141 = !DILocation(line: 0, scope: !137)
!142 = !DILocalVariable(name: "level", arg: 2, scope: !137, file: !3, line: 739, type: !6)
!143 = !DILocation(line: 741, column: 5, scope: !137)
!144 = !DILocation(line: 742, column: 15, scope: !145)
!145 = distinct !DILexicalBlock(scope: !146, file: !3, line: 742, column: 13)
!146 = distinct !DILexicalBlock(scope: !137, file: !3, line: 741, column: 8)
!147 = !DILocation(line: 742, column: 13, scope: !146)
!148 = !DILocation(line: 743, column: 30, scope: !145)
!149 = !DILocation(line: 743, column: 13, scope: !145)
!150 = !DILocation(line: 744, column: 33, scope: !146)
!151 = !DILocalVariable(name: "next", scope: !146, file: !3, line: 744, type: !19)
!152 = !DILocation(line: 0, scope: !146)
!153 = !DILocation(line: 745, column: 15, scope: !154)
!154 = distinct !DILexicalBlock(scope: !146, file: !3, line: 745, column: 13)
!155 = !DILocation(line: 745, column: 13, scope: !146)
!156 = !DILocation(line: 746, column: 18, scope: !154)
!157 = !DILocation(line: 746, column: 13, scope: !154)
!158 = !DILocation(line: 748, column: 5, scope: !146)
!159 = distinct !{!159, !143, !160}
!160 = !DILocation(line: 749, column: 16, scope: !137)
!161 = !DILocation(line: 750, column: 1, scope: !137)
!162 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 727, type: !163, scopeLine: 728, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!163 = !DISubroutineType(types: !164)
!164 = !{null, !24, !6}
!165 = !DILocalVariable(name: "list", arg: 1, scope: !162, file: !3, line: 727, type: !24)
!166 = !DILocation(line: 0, scope: !162)
!167 = !DILocalVariable(name: "level", arg: 2, scope: !162, file: !3, line: 727, type: !6)
!168 = !DILocation(line: 729, column: 5, scope: !162)
!169 = !DILocation(line: 730, column: 15, scope: !170)
!170 = distinct !DILexicalBlock(scope: !171, file: !3, line: 730, column: 13)
!171 = distinct !DILexicalBlock(scope: !162, file: !3, line: 729, column: 8)
!172 = !DILocation(line: 730, column: 13, scope: !171)
!173 = !DILocation(line: 731, column: 30, scope: !170)
!174 = !DILocation(line: 731, column: 13, scope: !170)
!175 = !DILocation(line: 732, column: 33, scope: !171)
!176 = !DILocalVariable(name: "next", scope: !171, file: !3, line: 732, type: !24)
!177 = !DILocation(line: 0, scope: !171)
!178 = !DILocation(line: 733, column: 15, scope: !179)
!179 = distinct !DILexicalBlock(scope: !171, file: !3, line: 733, column: 13)
!180 = !DILocation(line: 733, column: 13, scope: !171)
!181 = !DILocation(line: 734, column: 18, scope: !179)
!182 = !DILocation(line: 734, column: 13, scope: !179)
!183 = !DILocation(line: 736, column: 5, scope: !171)
!184 = distinct !{!184, !168, !185}
!185 = !DILocation(line: 737, column: 16, scope: !162)
!186 = !DILocation(line: 738, column: 1, scope: !162)
!187 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 715, type: !188, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!188 = !DISubroutineType(types: !189)
!189 = !{null, !28, !6}
!190 = !DILocalVariable(name: "list", arg: 1, scope: !187, file: !3, line: 715, type: !28)
!191 = !DILocation(line: 0, scope: !187)
!192 = !DILocalVariable(name: "level", arg: 2, scope: !187, file: !3, line: 715, type: !6)
!193 = !DILocation(line: 717, column: 5, scope: !187)
!194 = !DILocation(line: 718, column: 15, scope: !195)
!195 = distinct !DILexicalBlock(scope: !196, file: !3, line: 718, column: 13)
!196 = distinct !DILexicalBlock(scope: !187, file: !3, line: 717, column: 8)
!197 = !DILocation(line: 718, column: 13, scope: !196)
!198 = !DILocation(line: 719, column: 24, scope: !195)
!199 = !DILocation(line: 719, column: 18, scope: !195)
!200 = !DILocation(line: 719, column: 13, scope: !195)
!201 = !DILocation(line: 720, column: 33, scope: !196)
!202 = !DILocalVariable(name: "next", scope: !196, file: !3, line: 720, type: !28)
!203 = !DILocation(line: 0, scope: !196)
!204 = !DILocation(line: 721, column: 15, scope: !205)
!205 = distinct !DILexicalBlock(scope: !196, file: !3, line: 721, column: 13)
!206 = !DILocation(line: 721, column: 13, scope: !196)
!207 = !DILocation(line: 722, column: 18, scope: !205)
!208 = !DILocation(line: 722, column: 13, scope: !205)
!209 = !DILocation(line: 724, column: 5, scope: !196)
!210 = distinct !{!210, !193, !211}
!211 = !DILocation(line: 725, column: 16, scope: !187)
!212 = !DILocation(line: 726, column: 1, scope: !187)
!213 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 665, type: !214, scopeLine: 666, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!214 = !DISubroutineType(types: !215)
!215 = !{!216, !217}
!216 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!217 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!218 = !DILocalVariable(name: "size", arg: 1, scope: !213, file: !3, line: 665, type: !217)
!219 = !DILocation(line: 0, scope: !213)
!220 = !DILocation(line: 667, column: 17, scope: !213)
!221 = !DILocalVariable(name: "ptr", scope: !213, file: !3, line: 667, type: !216)
!222 = !DILocation(line: 668, column: 9, scope: !223)
!223 = distinct !DILexicalBlock(scope: !213, file: !3, line: 668, column: 9)
!224 = !DILocation(line: 668, column: 9, scope: !213)
!225 = !DILocation(line: 669, column: 9, scope: !223)
!226 = !DILocation(line: 670, column: 5, scope: !213)
!227 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 697, type: !228, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!228 = !DISubroutineType(types: !229)
!229 = !{null, !230}
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!231 = !DILocalVariable(name: "list", arg: 1, scope: !227, file: !3, line: 697, type: !230)
!232 = !DILocation(line: 0, scope: !227)
!233 = !DILocation(line: 699, column: 23, scope: !227)
!234 = !DILocalVariable(name: "item", scope: !227, file: !3, line: 699, type: !15)
!235 = !DILocation(line: 700, column: 5, scope: !227)
!236 = !DILocation(line: 701, column: 26, scope: !227)
!237 = !DILocation(line: 701, column: 9, scope: !227)
!238 = !DILocation(line: 702, column: 12, scope: !227)
!239 = distinct !{!239, !235, !240}
!240 = !DILocation(line: 702, column: 35, scope: !227)
!241 = !DILocation(line: 703, column: 18, scope: !227)
!242 = !DILocation(line: 703, column: 11, scope: !227)
!243 = !DILocation(line: 703, column: 16, scope: !227)
!244 = !DILocation(line: 704, column: 11, scope: !227)
!245 = !DILocation(line: 705, column: 1, scope: !227)
!246 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 688, type: !247, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!247 = !DISubroutineType(types: !248)
!248 = !{null, !249}
!249 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!250 = !DILocalVariable(name: "list", arg: 1, scope: !246, file: !3, line: 688, type: !249)
!251 = !DILocation(line: 0, scope: !246)
!252 = !DILocation(line: 690, column: 23, scope: !246)
!253 = !DILocalVariable(name: "item", scope: !246, file: !3, line: 690, type: !19)
!254 = !DILocation(line: 691, column: 5, scope: !246)
!255 = !DILocation(line: 692, column: 26, scope: !246)
!256 = !DILocation(line: 692, column: 9, scope: !246)
!257 = !DILocation(line: 693, column: 12, scope: !246)
!258 = distinct !{!258, !254, !259}
!259 = !DILocation(line: 693, column: 35, scope: !246)
!260 = !DILocation(line: 694, column: 18, scope: !246)
!261 = !DILocation(line: 694, column: 11, scope: !246)
!262 = !DILocation(line: 694, column: 16, scope: !246)
!263 = !DILocation(line: 695, column: 11, scope: !246)
!264 = !DILocation(line: 696, column: 1, scope: !246)
!265 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 679, type: !266, scopeLine: 680, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!266 = !DISubroutineType(types: !267)
!267 = !{null, !268}
!268 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!269 = !DILocalVariable(name: "list", arg: 1, scope: !265, file: !3, line: 679, type: !268)
!270 = !DILocation(line: 0, scope: !265)
!271 = !DILocation(line: 681, column: 23, scope: !265)
!272 = !DILocalVariable(name: "item", scope: !265, file: !3, line: 681, type: !24)
!273 = !DILocation(line: 682, column: 5, scope: !265)
!274 = !DILocation(line: 683, column: 26, scope: !265)
!275 = !DILocation(line: 683, column: 9, scope: !265)
!276 = !DILocation(line: 684, column: 12, scope: !265)
!277 = distinct !{!277, !273, !278}
!278 = !DILocation(line: 684, column: 35, scope: !265)
!279 = !DILocation(line: 685, column: 18, scope: !265)
!280 = !DILocation(line: 685, column: 11, scope: !265)
!281 = !DILocation(line: 685, column: 16, scope: !265)
!282 = !DILocation(line: 686, column: 11, scope: !265)
!283 = !DILocation(line: 687, column: 1, scope: !265)
!284 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 672, type: !285, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!285 = !DISubroutineType(types: !286)
!286 = !{null, !287}
!287 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!288 = !DILocalVariable(name: "list", arg: 1, scope: !284, file: !3, line: 672, type: !287)
!289 = !DILocation(line: 0, scope: !284)
!290 = !DILocation(line: 674, column: 23, scope: !284)
!291 = !DILocalVariable(name: "item", scope: !284, file: !3, line: 674, type: !28)
!292 = !DILocation(line: 675, column: 18, scope: !284)
!293 = !DILocation(line: 675, column: 11, scope: !284)
!294 = !DILocation(line: 675, column: 16, scope: !284)
!295 = !DILocation(line: 676, column: 18, scope: !284)
!296 = !DILocation(line: 676, column: 11, scope: !284)
!297 = !DILocation(line: 676, column: 16, scope: !284)
!298 = !DILocation(line: 677, column: 11, scope: !284)
!299 = !DILocation(line: 678, column: 1, scope: !284)
!300 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 640, type: !301, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!301 = !DISubroutineType(types: !302)
!302 = !{!216, !303, !303}
!303 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 13, baseType: !217)
!304 = !DILocalVariable(name: "nmemb", arg: 1, scope: !300, file: !3, line: 640, type: !303)
!305 = !DILocation(line: 0, scope: !300)
!306 = !DILocalVariable(name: "size", arg: 2, scope: !300, file: !3, line: 640, type: !303)
!307 = !DILocation(line: 641, column: 30, scope: !300)
!308 = !DILocation(line: 641, column: 17, scope: !300)
!309 = !DILocalVariable(name: "ptr", scope: !300, file: !3, line: 641, type: !216)
!310 = !DILocation(line: 642, column: 33, scope: !300)
!311 = !DILocation(line: 642, column: 12, scope: !300)
!312 = !DILocation(line: 642, column: 5, scope: !300)
