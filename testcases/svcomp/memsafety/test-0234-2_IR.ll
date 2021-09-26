; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-m7rnmqix.bc'
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
@.str.1 = private unnamed_addr constant [14 x i8] c"test-0234-2.c\00", align 1
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
  call void @l0_destroy(%struct.L0* %6), !dbg !55, !verifier.code !47
  ret i32 0, !dbg !56, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !57 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !61, metadata !DIExpression()), !dbg !62, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !63, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !63, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !64, metadata !DIExpression()), !dbg !62, !verifier.code !47
  br label %4, !dbg !65, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !66, !verifier.code !47
  call void @l1_insert(%struct.L1** %5), !dbg !67, !verifier.code !47
  br label %6, !dbg !67, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !68, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !67, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !67, !llvm.loop !69, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !71, !verifier.code !47
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !72, !verifier.code !47
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !73, !verifier.code !47
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !74, !verifier.code !47
  ret void, !dbg !75, !verifier.code !47
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0) #0 !dbg !76 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !79, metadata !DIExpression()), !dbg !80, !verifier.code !47
  br label %2, !dbg !81, !verifier.code !47

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L0* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !79, metadata !DIExpression()), !dbg !80, !verifier.code !47
  %3 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !82, !verifier.code !47
  %4 = load %struct.L1*, %struct.L1** %3, align 8, !dbg !82, !verifier.code !47
  call void @l1_destroy(%struct.L1* %4), !dbg !84, !verifier.code !47
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !85, !verifier.code !47
  %6 = load %struct.L0*, %struct.L0** %5, align 8, !dbg !85, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !86, metadata !DIExpression()), !dbg !87, !verifier.code !47
  %7 = bitcast %struct.L0* %.0 to i8*, !dbg !88, !verifier.code !47
  call void @free(i8* %7) #6, !dbg !89, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !79, metadata !DIExpression()), !dbg !80, !verifier.code !47
  br label %8, !dbg !90, !verifier.code !47

8:                                                ; preds = %2
  %9 = icmp ne %struct.L0* %6, null, !dbg !90, !verifier.code !47
  br i1 %9, label %forwarder, label %10, !dbg !90, !llvm.loop !91, !verifier.code !47

10:                                               ; preds = %8
  ret void, !dbg !93, !verifier.code !47

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !47
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0) #0 !dbg !94 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !47
  br label %2, !dbg !99, !verifier.code !47

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L1* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !47
  %3 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !100, !verifier.code !47
  %4 = load %struct.L2*, %struct.L2** %3, align 8, !dbg !100, !verifier.code !47
  call void @l2_destroy(%struct.L2* %4), !dbg !102, !verifier.code !47
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !103, !verifier.code !47
  %6 = load %struct.L1*, %struct.L1** %5, align 8, !dbg !103, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !104, metadata !DIExpression()), !dbg !105, !verifier.code !47
  %7 = bitcast %struct.L1* %.0 to i8*, !dbg !106, !verifier.code !47
  call void @free(i8* %7) #6, !dbg !107, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !47
  br label %8, !dbg !108, !verifier.code !47

8:                                                ; preds = %2
  %9 = icmp ne %struct.L1* %6, null, !dbg !108, !verifier.code !47
  br i1 %9, label %forwarder, label %10, !dbg !108, !llvm.loop !109, !verifier.code !47

10:                                               ; preds = %8
  ret void, !dbg !111, !verifier.code !47

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !47
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 !dbg !112 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !47
  br label %2, !dbg !117, !verifier.code !47

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L2* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !47
  %3 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !118, !verifier.code !47
  %4 = load %struct.L3*, %struct.L3** %3, align 8, !dbg !118, !verifier.code !47
  call void @l3_destroy(%struct.L3* %4), !dbg !120, !verifier.code !47
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !121, !verifier.code !47
  %6 = load %struct.L2*, %struct.L2** %5, align 8, !dbg !121, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !122, metadata !DIExpression()), !dbg !123, !verifier.code !47
  %7 = bitcast %struct.L2* %.0 to i8*, !dbg !124, !verifier.code !47
  call void @free(i8* %7) #6, !dbg !125, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !47
  br label %8, !dbg !126, !verifier.code !47

8:                                                ; preds = %2
  %9 = icmp ne %struct.L2* %6, null, !dbg !126, !verifier.code !47
  br i1 %9, label %forwarder, label %10, !dbg !126, !llvm.loop !127, !verifier.code !47

10:                                               ; preds = %8
  ret void, !dbg !129, !verifier.code !47

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0) #0 !dbg !130 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !133, metadata !DIExpression()), !dbg !134, !verifier.code !47
  br label %2, !dbg !135, !verifier.code !47

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L3* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !133, metadata !DIExpression()), !dbg !134, !verifier.code !47
  %3 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !136, !verifier.code !47
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !136, !verifier.code !47
  call void @l4_destroy(%struct.L4* %4), !dbg !138, !verifier.code !47
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !139, !verifier.code !47
  %6 = load %struct.L3*, %struct.L3** %5, align 8, !dbg !139, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !140, metadata !DIExpression()), !dbg !141, !verifier.code !47
  %7 = bitcast %struct.L3* %.0 to i8*, !dbg !142, !verifier.code !47
  call void @free(i8* %7) #6, !dbg !143, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !133, metadata !DIExpression()), !dbg !134, !verifier.code !47
  br label %8, !dbg !144, !verifier.code !47

8:                                                ; preds = %2
  %9 = icmp ne %struct.L3* %6, null, !dbg !144, !verifier.code !47
  br i1 %9, label %forwarder, label %10, !dbg !144, !llvm.loop !145, !verifier.code !47

10:                                               ; preds = %8
  ret void, !dbg !147, !verifier.code !47

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0) #0 !dbg !148 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !151, metadata !DIExpression()), !dbg !152, !verifier.code !47
  br label %2, !dbg !153, !verifier.code !47

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L4* [ %0, %1 ], [ %4, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !151, metadata !DIExpression()), !dbg !152, !verifier.code !47
  %3 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !154, !verifier.code !47
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !154, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %4, metadata !156, metadata !DIExpression()), !dbg !157, !verifier.code !47
  %5 = bitcast %struct.L4* %.0 to i8*, !dbg !158, !verifier.code !47
  call void @free(i8* %5) #6, !dbg !159, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %4, metadata !151, metadata !DIExpression()), !dbg !152, !verifier.code !47
  br label %6, !dbg !160, !verifier.code !47

6:                                                ; preds = %2
  %7 = icmp ne %struct.L4* %4, null, !dbg !160, !verifier.code !47
  br i1 %7, label %forwarder, label %8, !dbg !160, !llvm.loop !161, !verifier.code !47

8:                                                ; preds = %6
  ret void, !dbg !163, !verifier.code !47

forwarder:                                        ; preds = %6
  br label %2, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !164 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !169, metadata !DIExpression()), !dbg !170, !verifier.code !47
  %2 = call i8* @calloc_model(i32 1, i32 %0), !dbg !171, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %2, metadata !172, metadata !DIExpression()), !dbg !170, !verifier.code !47
  %3 = icmp ne i8* %2, null, !dbg !173, !verifier.code !47
  br i1 %3, label %4, label %5, !dbg !175, !verifier.code !47

4:                                                ; preds = %1
  ret i8* %2, !dbg !176, !verifier.code !47

5:                                                ; preds = %1
  call void @abort() #5, !dbg !177, !verifier.code !47
  unreachable, !dbg !177, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !178 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !182, metadata !DIExpression()), !dbg !183, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !184, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !184, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !185, metadata !DIExpression()), !dbg !183, !verifier.code !47
  br label %4, !dbg !186, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !187, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !188, !verifier.code !47
  br label %6, !dbg !188, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !189, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !188, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !188, !llvm.loop !190, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !192, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !193, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !194, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !195, !verifier.code !47
  ret void, !dbg !196, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !197 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !201, metadata !DIExpression()), !dbg !202, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !203, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !203, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !204, metadata !DIExpression()), !dbg !202, !verifier.code !47
  br label %4, !dbg !205, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !206, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !207, !verifier.code !47
  br label %6, !dbg !207, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !208, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !207, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !207, !llvm.loop !209, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !211, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !212, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !213, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !214, !verifier.code !47
  ret void, !dbg !215, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !216 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !222, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !222, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !223, metadata !DIExpression()), !dbg !221, !verifier.code !47
  br label %4, !dbg !224, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !225, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !226, !verifier.code !47
  br label %6, !dbg !226, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !227, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !226, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !226, !llvm.loop !228, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !230, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !231, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !232, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !233, !verifier.code !47
  ret void, !dbg !234, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !235 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !239, metadata !DIExpression()), !dbg !240, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !241, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !241, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !242, metadata !DIExpression()), !dbg !240, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !243, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !243, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !244, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !245, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !246, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !247, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !248, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !249, !verifier.code !47
  ret void, !dbg !250, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i32 %0, i32 %1) #0 !dbg !251 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !255, metadata !DIExpression()), !dbg !256, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !257, metadata !DIExpression()), !dbg !256, !verifier.code !47
  %3 = mul i32 %0, %1, !dbg !258, !verifier.code !47
  %4 = call noalias i8* @malloc(i32 %3) #6, !dbg !259, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !260, metadata !DIExpression()), !dbg !256, !verifier.code !47
  %5 = mul i32 %0, %1, !dbg !261, !verifier.code !47
  %6 = call i8* @memset(i8* %4, i32 0, i32 %5) #6, !dbg !262, !verifier.code !47
  ret i8* %6, !dbg !263, !verifier.code !47
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
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 766, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 764, type: !4, scopeLine: 765, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0234-2.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!48 = !DILocation(line: 767, column: 5, scope: !2)
!49 = !DILocation(line: 768, column: 9, scope: !2)
!50 = !DILocation(line: 769, column: 12, scope: !2)
!51 = !{i1 true}
!52 = distinct !{!52, !48, !53}
!53 = !DILocation(line: 769, column: 35, scope: !2)
!54 = !DILocation(line: 770, column: 16, scope: !2)
!55 = !DILocation(line: 770, column: 5, scope: !2)
!56 = !DILocation(line: 771, column: 1, scope: !2)
!57 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 706, type: !58, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!58 = !DISubroutineType(types: !59)
!59 = !{null, !60}
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!61 = !DILocalVariable(name: "list", arg: 1, scope: !57, file: !3, line: 706, type: !60)
!62 = !DILocation(line: 0, scope: !57)
!63 = !DILocation(line: 708, column: 23, scope: !57)
!64 = !DILocalVariable(name: "item", scope: !57, file: !3, line: 708, type: !10)
!65 = !DILocation(line: 709, column: 5, scope: !57)
!66 = !DILocation(line: 710, column: 26, scope: !57)
!67 = !DILocation(line: 710, column: 9, scope: !57)
!68 = !DILocation(line: 711, column: 12, scope: !57)
!69 = distinct !{!69, !65, !70}
!70 = !DILocation(line: 711, column: 35, scope: !57)
!71 = !DILocation(line: 712, column: 18, scope: !57)
!72 = !DILocation(line: 712, column: 11, scope: !57)
!73 = !DILocation(line: 712, column: 16, scope: !57)
!74 = !DILocation(line: 713, column: 11, scope: !57)
!75 = !DILocation(line: 714, column: 1, scope: !57)
!76 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 754, type: !77, scopeLine: 755, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!77 = !DISubroutineType(types: !78)
!78 = !{null, !10}
!79 = !DILocalVariable(name: "list", arg: 1, scope: !76, file: !3, line: 754, type: !10)
!80 = !DILocation(line: 0, scope: !76)
!81 = !DILocation(line: 756, column: 5, scope: !76)
!82 = !DILocation(line: 757, column: 26, scope: !83)
!83 = distinct !DILexicalBlock(scope: !76, file: !3, line: 756, column: 8)
!84 = !DILocation(line: 757, column: 9, scope: !83)
!85 = !DILocation(line: 758, column: 33, scope: !83)
!86 = !DILocalVariable(name: "next", scope: !83, file: !3, line: 758, type: !10)
!87 = !DILocation(line: 0, scope: !83)
!88 = !DILocation(line: 759, column: 14, scope: !83)
!89 = !DILocation(line: 759, column: 9, scope: !83)
!90 = !DILocation(line: 761, column: 5, scope: !83)
!91 = distinct !{!91, !81, !92}
!92 = !DILocation(line: 762, column: 16, scope: !76)
!93 = !DILocation(line: 763, column: 1, scope: !76)
!94 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 744, type: !95, scopeLine: 745, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!95 = !DISubroutineType(types: !96)
!96 = !{null, !15}
!97 = !DILocalVariable(name: "list", arg: 1, scope: !94, file: !3, line: 744, type: !15)
!98 = !DILocation(line: 0, scope: !94)
!99 = !DILocation(line: 746, column: 5, scope: !94)
!100 = !DILocation(line: 747, column: 26, scope: !101)
!101 = distinct !DILexicalBlock(scope: !94, file: !3, line: 746, column: 8)
!102 = !DILocation(line: 747, column: 9, scope: !101)
!103 = !DILocation(line: 748, column: 33, scope: !101)
!104 = !DILocalVariable(name: "next", scope: !101, file: !3, line: 748, type: !15)
!105 = !DILocation(line: 0, scope: !101)
!106 = !DILocation(line: 749, column: 14, scope: !101)
!107 = !DILocation(line: 749, column: 9, scope: !101)
!108 = !DILocation(line: 751, column: 5, scope: !101)
!109 = distinct !{!109, !99, !110}
!110 = !DILocation(line: 752, column: 16, scope: !94)
!111 = !DILocation(line: 753, column: 1, scope: !94)
!112 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 734, type: !113, scopeLine: 735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!113 = !DISubroutineType(types: !114)
!114 = !{null, !19}
!115 = !DILocalVariable(name: "list", arg: 1, scope: !112, file: !3, line: 734, type: !19)
!116 = !DILocation(line: 0, scope: !112)
!117 = !DILocation(line: 736, column: 5, scope: !112)
!118 = !DILocation(line: 737, column: 26, scope: !119)
!119 = distinct !DILexicalBlock(scope: !112, file: !3, line: 736, column: 8)
!120 = !DILocation(line: 737, column: 9, scope: !119)
!121 = !DILocation(line: 738, column: 33, scope: !119)
!122 = !DILocalVariable(name: "next", scope: !119, file: !3, line: 738, type: !19)
!123 = !DILocation(line: 0, scope: !119)
!124 = !DILocation(line: 739, column: 14, scope: !119)
!125 = !DILocation(line: 739, column: 9, scope: !119)
!126 = !DILocation(line: 741, column: 5, scope: !119)
!127 = distinct !{!127, !117, !128}
!128 = !DILocation(line: 742, column: 16, scope: !112)
!129 = !DILocation(line: 743, column: 1, scope: !112)
!130 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 724, type: !131, scopeLine: 725, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!131 = !DISubroutineType(types: !132)
!132 = !{null, !24}
!133 = !DILocalVariable(name: "list", arg: 1, scope: !130, file: !3, line: 724, type: !24)
!134 = !DILocation(line: 0, scope: !130)
!135 = !DILocation(line: 726, column: 5, scope: !130)
!136 = !DILocation(line: 727, column: 26, scope: !137)
!137 = distinct !DILexicalBlock(scope: !130, file: !3, line: 726, column: 8)
!138 = !DILocation(line: 727, column: 9, scope: !137)
!139 = !DILocation(line: 728, column: 33, scope: !137)
!140 = !DILocalVariable(name: "next", scope: !137, file: !3, line: 728, type: !24)
!141 = !DILocation(line: 0, scope: !137)
!142 = !DILocation(line: 729, column: 14, scope: !137)
!143 = !DILocation(line: 729, column: 9, scope: !137)
!144 = !DILocation(line: 731, column: 5, scope: !137)
!145 = distinct !{!145, !135, !146}
!146 = !DILocation(line: 732, column: 16, scope: !130)
!147 = !DILocation(line: 733, column: 1, scope: !130)
!148 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 715, type: !149, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!149 = !DISubroutineType(types: !150)
!150 = !{null, !28}
!151 = !DILocalVariable(name: "list", arg: 1, scope: !148, file: !3, line: 715, type: !28)
!152 = !DILocation(line: 0, scope: !148)
!153 = !DILocation(line: 717, column: 5, scope: !148)
!154 = !DILocation(line: 718, column: 33, scope: !155)
!155 = distinct !DILexicalBlock(scope: !148, file: !3, line: 717, column: 8)
!156 = !DILocalVariable(name: "next", scope: !155, file: !3, line: 718, type: !28)
!157 = !DILocation(line: 0, scope: !155)
!158 = !DILocation(line: 719, column: 14, scope: !155)
!159 = !DILocation(line: 719, column: 9, scope: !155)
!160 = !DILocation(line: 721, column: 5, scope: !155)
!161 = distinct !{!161, !153, !162}
!162 = !DILocation(line: 722, column: 16, scope: !148)
!163 = !DILocation(line: 723, column: 1, scope: !148)
!164 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 665, type: !165, scopeLine: 666, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!165 = !DISubroutineType(types: !166)
!166 = !{!167, !168}
!167 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!168 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!169 = !DILocalVariable(name: "size", arg: 1, scope: !164, file: !3, line: 665, type: !168)
!170 = !DILocation(line: 0, scope: !164)
!171 = !DILocation(line: 667, column: 17, scope: !164)
!172 = !DILocalVariable(name: "ptr", scope: !164, file: !3, line: 667, type: !167)
!173 = !DILocation(line: 668, column: 9, scope: !174)
!174 = distinct !DILexicalBlock(scope: !164, file: !3, line: 668, column: 9)
!175 = !DILocation(line: 668, column: 9, scope: !164)
!176 = !DILocation(line: 669, column: 9, scope: !174)
!177 = !DILocation(line: 670, column: 5, scope: !164)
!178 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 697, type: !179, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!179 = !DISubroutineType(types: !180)
!180 = !{null, !181}
!181 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!182 = !DILocalVariable(name: "list", arg: 1, scope: !178, file: !3, line: 697, type: !181)
!183 = !DILocation(line: 0, scope: !178)
!184 = !DILocation(line: 699, column: 23, scope: !178)
!185 = !DILocalVariable(name: "item", scope: !178, file: !3, line: 699, type: !15)
!186 = !DILocation(line: 700, column: 5, scope: !178)
!187 = !DILocation(line: 701, column: 26, scope: !178)
!188 = !DILocation(line: 701, column: 9, scope: !178)
!189 = !DILocation(line: 702, column: 12, scope: !178)
!190 = distinct !{!190, !186, !191}
!191 = !DILocation(line: 702, column: 35, scope: !178)
!192 = !DILocation(line: 703, column: 18, scope: !178)
!193 = !DILocation(line: 703, column: 11, scope: !178)
!194 = !DILocation(line: 703, column: 16, scope: !178)
!195 = !DILocation(line: 704, column: 11, scope: !178)
!196 = !DILocation(line: 705, column: 1, scope: !178)
!197 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 688, type: !198, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!198 = !DISubroutineType(types: !199)
!199 = !{null, !200}
!200 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!201 = !DILocalVariable(name: "list", arg: 1, scope: !197, file: !3, line: 688, type: !200)
!202 = !DILocation(line: 0, scope: !197)
!203 = !DILocation(line: 690, column: 23, scope: !197)
!204 = !DILocalVariable(name: "item", scope: !197, file: !3, line: 690, type: !19)
!205 = !DILocation(line: 691, column: 5, scope: !197)
!206 = !DILocation(line: 692, column: 26, scope: !197)
!207 = !DILocation(line: 692, column: 9, scope: !197)
!208 = !DILocation(line: 693, column: 12, scope: !197)
!209 = distinct !{!209, !205, !210}
!210 = !DILocation(line: 693, column: 35, scope: !197)
!211 = !DILocation(line: 694, column: 18, scope: !197)
!212 = !DILocation(line: 694, column: 11, scope: !197)
!213 = !DILocation(line: 694, column: 16, scope: !197)
!214 = !DILocation(line: 695, column: 11, scope: !197)
!215 = !DILocation(line: 696, column: 1, scope: !197)
!216 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 679, type: !217, scopeLine: 680, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!217 = !DISubroutineType(types: !218)
!218 = !{null, !219}
!219 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!220 = !DILocalVariable(name: "list", arg: 1, scope: !216, file: !3, line: 679, type: !219)
!221 = !DILocation(line: 0, scope: !216)
!222 = !DILocation(line: 681, column: 23, scope: !216)
!223 = !DILocalVariable(name: "item", scope: !216, file: !3, line: 681, type: !24)
!224 = !DILocation(line: 682, column: 5, scope: !216)
!225 = !DILocation(line: 683, column: 26, scope: !216)
!226 = !DILocation(line: 683, column: 9, scope: !216)
!227 = !DILocation(line: 684, column: 12, scope: !216)
!228 = distinct !{!228, !224, !229}
!229 = !DILocation(line: 684, column: 35, scope: !216)
!230 = !DILocation(line: 685, column: 18, scope: !216)
!231 = !DILocation(line: 685, column: 11, scope: !216)
!232 = !DILocation(line: 685, column: 16, scope: !216)
!233 = !DILocation(line: 686, column: 11, scope: !216)
!234 = !DILocation(line: 687, column: 1, scope: !216)
!235 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 672, type: !236, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!236 = !DISubroutineType(types: !237)
!237 = !{null, !238}
!238 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!239 = !DILocalVariable(name: "list", arg: 1, scope: !235, file: !3, line: 672, type: !238)
!240 = !DILocation(line: 0, scope: !235)
!241 = !DILocation(line: 674, column: 23, scope: !235)
!242 = !DILocalVariable(name: "item", scope: !235, file: !3, line: 674, type: !28)
!243 = !DILocation(line: 675, column: 18, scope: !235)
!244 = !DILocation(line: 675, column: 11, scope: !235)
!245 = !DILocation(line: 675, column: 16, scope: !235)
!246 = !DILocation(line: 676, column: 18, scope: !235)
!247 = !DILocation(line: 676, column: 11, scope: !235)
!248 = !DILocation(line: 676, column: 16, scope: !235)
!249 = !DILocation(line: 677, column: 11, scope: !235)
!250 = !DILocation(line: 678, column: 1, scope: !235)
!251 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 640, type: !252, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!252 = !DISubroutineType(types: !253)
!253 = !{!167, !254, !254}
!254 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 13, baseType: !168)
!255 = !DILocalVariable(name: "nmemb", arg: 1, scope: !251, file: !3, line: 640, type: !254)
!256 = !DILocation(line: 0, scope: !251)
!257 = !DILocalVariable(name: "size", arg: 2, scope: !251, file: !3, line: 640, type: !254)
!258 = !DILocation(line: 641, column: 30, scope: !251)
!259 = !DILocation(line: 641, column: 17, scope: !251)
!260 = !DILocalVariable(name: "ptr", scope: !251, file: !3, line: 641, type: !167)
!261 = !DILocation(line: 642, column: 33, scope: !251)
!262 = !DILocation(line: 642, column: 12, scope: !251)
!263 = !DILocation(line: 642, column: 5, scope: !251)
