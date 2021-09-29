; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-2oh5i3in.bc'
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
@.str.1 = private unnamed_addr constant [14 x i8] c"test-0234-1.c\00", align 1
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
  %.0 = phi %struct.L4* [ %0, %1 ], [ %7, %forwarder ], !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !151, metadata !DIExpression()), !dbg !152, !verifier.code !47
  %3 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !154, !verifier.code !47
  %4 = load %struct.L5*, %struct.L5** %3, align 8, !dbg !154, !verifier.code !47
  %5 = bitcast %struct.L5* %4 to i8*, !dbg !156, !verifier.code !47
  call void @free(i8* %5) #6, !dbg !157, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !158, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !158, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !159, metadata !DIExpression()), !dbg !160, !verifier.code !47
  %8 = bitcast %struct.L4* %.0 to i8*, !dbg !161, !verifier.code !47
  call void @free(i8* %8) #6, !dbg !162, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !151, metadata !DIExpression()), !dbg !152, !verifier.code !47
  br label %9, !dbg !163, !verifier.code !47

9:                                                ; preds = %2
  %10 = icmp ne %struct.L4* %7, null, !dbg !163, !verifier.code !47
  br i1 %10, label %forwarder, label %11, !dbg !163, !llvm.loop !164, !verifier.code !47

11:                                               ; preds = %9
  ret void, !dbg !166, !verifier.code !47

forwarder:                                        ; preds = %9
  br label %2, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !167 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !172, metadata !DIExpression()), !dbg !173, !verifier.code !47
  %2 = call i8* @calloc_model(i32 1, i32 %0), !dbg !174, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %2, metadata !175, metadata !DIExpression()), !dbg !173, !verifier.code !47
  %3 = icmp ne i8* %2, null, !dbg !176, !verifier.code !47
  br i1 %3, label %4, label %5, !dbg !178, !verifier.code !47

4:                                                ; preds = %1
  ret i8* %2, !dbg !179, !verifier.code !47

5:                                                ; preds = %1
  call void @abort() #5, !dbg !180, !verifier.code !47
  unreachable, !dbg !180, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !181 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !185, metadata !DIExpression()), !dbg !186, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !187, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !187, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !188, metadata !DIExpression()), !dbg !186, !verifier.code !47
  br label %4, !dbg !189, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !190, !verifier.code !47
  call void @l2_insert(%struct.L2** %5), !dbg !191, !verifier.code !47
  br label %6, !dbg !191, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !192, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !191, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !191, !llvm.loop !193, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !195, !verifier.code !47
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !196, !verifier.code !47
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !197, !verifier.code !47
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !198, !verifier.code !47
  ret void, !dbg !199, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !200 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !206, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !206, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !207, metadata !DIExpression()), !dbg !205, !verifier.code !47
  br label %4, !dbg !208, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !209, !verifier.code !47
  call void @l3_insert(%struct.L3** %5), !dbg !210, !verifier.code !47
  br label %6, !dbg !210, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !211, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !210, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !210, !llvm.loop !212, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !214, !verifier.code !47
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !215, !verifier.code !47
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !216, !verifier.code !47
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !217, !verifier.code !47
  ret void, !dbg !218, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !219 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !223, metadata !DIExpression()), !dbg !224, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !225, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !225, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !226, metadata !DIExpression()), !dbg !224, !verifier.code !47
  br label %4, !dbg !227, !verifier.code !47

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !228, !verifier.code !47
  call void @l4_insert(%struct.L4** %5), !dbg !229, !verifier.code !47
  br label %6, !dbg !229, !verifier.code !47

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !230, !verifier.code !51
  %8 = icmp ne i32 %7, 0, !dbg !229, !verifier.code !47
  br i1 %8, label %4, label %9, !dbg !229, !llvm.loop !231, !verifier.code !47

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !233, !verifier.code !47
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !234, !verifier.code !47
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !235, !verifier.code !47
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !236, !verifier.code !47
  ret void, !dbg !237, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !238 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !242, metadata !DIExpression()), !dbg !243, !verifier.code !47
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !244, !verifier.code !47
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !244, !verifier.code !47
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !245, metadata !DIExpression()), !dbg !243, !verifier.code !47
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !246, !verifier.code !47
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !246, !verifier.code !47
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !247, !verifier.code !47
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !248, !verifier.code !47
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !249, !verifier.code !47
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !250, !verifier.code !47
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !251, !verifier.code !47
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !252, !verifier.code !47
  ret void, !dbg !253, !verifier.code !47
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i32 %0, i32 %1) #0 !dbg !254 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !258, metadata !DIExpression()), !dbg !259, !verifier.code !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !260, metadata !DIExpression()), !dbg !259, !verifier.code !47
  %3 = mul i32 %0, %1, !dbg !261, !verifier.code !47
  %4 = call noalias i8* @malloc(i32 %3) #6, !dbg !262, !verifier.code !47
  call void @llvm.dbg.value(metadata i8* %4, metadata !263, metadata !DIExpression()), !dbg !259, !verifier.code !47
  %5 = mul i32 %0, %1, !dbg !264, !verifier.code !47
  %6 = call i8* @memset(i8* %4, i32 0, i32 %5) #6, !dbg !265, !verifier.code !47
  ret i8* %6, !dbg !266, !verifier.code !47
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
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 767, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 765, type: !4, scopeLine: 766, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0234-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!48 = !DILocation(line: 768, column: 5, scope: !2)
!49 = !DILocation(line: 769, column: 9, scope: !2)
!50 = !DILocation(line: 770, column: 12, scope: !2)
!51 = !{i1 true}
!52 = distinct !{!52, !48, !53}
!53 = !DILocation(line: 770, column: 35, scope: !2)
!54 = !DILocation(line: 771, column: 16, scope: !2)
!55 = !DILocation(line: 771, column: 5, scope: !2)
!56 = !DILocation(line: 772, column: 1, scope: !2)
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
!76 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 755, type: !77, scopeLine: 756, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!77 = !DISubroutineType(types: !78)
!78 = !{null, !10}
!79 = !DILocalVariable(name: "list", arg: 1, scope: !76, file: !3, line: 755, type: !10)
!80 = !DILocation(line: 0, scope: !76)
!81 = !DILocation(line: 757, column: 5, scope: !76)
!82 = !DILocation(line: 758, column: 26, scope: !83)
!83 = distinct !DILexicalBlock(scope: !76, file: !3, line: 757, column: 8)
!84 = !DILocation(line: 758, column: 9, scope: !83)
!85 = !DILocation(line: 759, column: 33, scope: !83)
!86 = !DILocalVariable(name: "next", scope: !83, file: !3, line: 759, type: !10)
!87 = !DILocation(line: 0, scope: !83)
!88 = !DILocation(line: 760, column: 14, scope: !83)
!89 = !DILocation(line: 760, column: 9, scope: !83)
!90 = !DILocation(line: 762, column: 5, scope: !83)
!91 = distinct !{!91, !81, !92}
!92 = !DILocation(line: 763, column: 16, scope: !76)
!93 = !DILocation(line: 764, column: 1, scope: !76)
!94 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 745, type: !95, scopeLine: 746, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!95 = !DISubroutineType(types: !96)
!96 = !{null, !15}
!97 = !DILocalVariable(name: "list", arg: 1, scope: !94, file: !3, line: 745, type: !15)
!98 = !DILocation(line: 0, scope: !94)
!99 = !DILocation(line: 747, column: 5, scope: !94)
!100 = !DILocation(line: 748, column: 26, scope: !101)
!101 = distinct !DILexicalBlock(scope: !94, file: !3, line: 747, column: 8)
!102 = !DILocation(line: 748, column: 9, scope: !101)
!103 = !DILocation(line: 749, column: 33, scope: !101)
!104 = !DILocalVariable(name: "next", scope: !101, file: !3, line: 749, type: !15)
!105 = !DILocation(line: 0, scope: !101)
!106 = !DILocation(line: 750, column: 14, scope: !101)
!107 = !DILocation(line: 750, column: 9, scope: !101)
!108 = !DILocation(line: 752, column: 5, scope: !101)
!109 = distinct !{!109, !99, !110}
!110 = !DILocation(line: 753, column: 16, scope: !94)
!111 = !DILocation(line: 754, column: 1, scope: !94)
!112 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 735, type: !113, scopeLine: 736, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!113 = !DISubroutineType(types: !114)
!114 = !{null, !19}
!115 = !DILocalVariable(name: "list", arg: 1, scope: !112, file: !3, line: 735, type: !19)
!116 = !DILocation(line: 0, scope: !112)
!117 = !DILocation(line: 737, column: 5, scope: !112)
!118 = !DILocation(line: 738, column: 26, scope: !119)
!119 = distinct !DILexicalBlock(scope: !112, file: !3, line: 737, column: 8)
!120 = !DILocation(line: 738, column: 9, scope: !119)
!121 = !DILocation(line: 739, column: 33, scope: !119)
!122 = !DILocalVariable(name: "next", scope: !119, file: !3, line: 739, type: !19)
!123 = !DILocation(line: 0, scope: !119)
!124 = !DILocation(line: 740, column: 14, scope: !119)
!125 = !DILocation(line: 740, column: 9, scope: !119)
!126 = !DILocation(line: 742, column: 5, scope: !119)
!127 = distinct !{!127, !117, !128}
!128 = !DILocation(line: 743, column: 16, scope: !112)
!129 = !DILocation(line: 744, column: 1, scope: !112)
!130 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 725, type: !131, scopeLine: 726, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!131 = !DISubroutineType(types: !132)
!132 = !{null, !24}
!133 = !DILocalVariable(name: "list", arg: 1, scope: !130, file: !3, line: 725, type: !24)
!134 = !DILocation(line: 0, scope: !130)
!135 = !DILocation(line: 727, column: 5, scope: !130)
!136 = !DILocation(line: 728, column: 26, scope: !137)
!137 = distinct !DILexicalBlock(scope: !130, file: !3, line: 727, column: 8)
!138 = !DILocation(line: 728, column: 9, scope: !137)
!139 = !DILocation(line: 729, column: 33, scope: !137)
!140 = !DILocalVariable(name: "next", scope: !137, file: !3, line: 729, type: !24)
!141 = !DILocation(line: 0, scope: !137)
!142 = !DILocation(line: 730, column: 14, scope: !137)
!143 = !DILocation(line: 730, column: 9, scope: !137)
!144 = !DILocation(line: 732, column: 5, scope: !137)
!145 = distinct !{!145, !135, !146}
!146 = !DILocation(line: 733, column: 16, scope: !130)
!147 = !DILocation(line: 734, column: 1, scope: !130)
!148 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 715, type: !149, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!149 = !DISubroutineType(types: !150)
!150 = !{null, !28}
!151 = !DILocalVariable(name: "list", arg: 1, scope: !148, file: !3, line: 715, type: !28)
!152 = !DILocation(line: 0, scope: !148)
!153 = !DILocation(line: 717, column: 5, scope: !148)
!154 = !DILocation(line: 718, column: 20, scope: !155)
!155 = distinct !DILexicalBlock(scope: !148, file: !3, line: 717, column: 8)
!156 = !DILocation(line: 718, column: 14, scope: !155)
!157 = !DILocation(line: 718, column: 9, scope: !155)
!158 = !DILocation(line: 719, column: 33, scope: !155)
!159 = !DILocalVariable(name: "next", scope: !155, file: !3, line: 719, type: !28)
!160 = !DILocation(line: 0, scope: !155)
!161 = !DILocation(line: 720, column: 14, scope: !155)
!162 = !DILocation(line: 720, column: 9, scope: !155)
!163 = !DILocation(line: 722, column: 5, scope: !155)
!164 = distinct !{!164, !153, !165}
!165 = !DILocation(line: 723, column: 16, scope: !148)
!166 = !DILocation(line: 724, column: 1, scope: !148)
!167 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 665, type: !168, scopeLine: 666, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!168 = !DISubroutineType(types: !169)
!169 = !{!170, !171}
!170 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!171 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!172 = !DILocalVariable(name: "size", arg: 1, scope: !167, file: !3, line: 665, type: !171)
!173 = !DILocation(line: 0, scope: !167)
!174 = !DILocation(line: 667, column: 17, scope: !167)
!175 = !DILocalVariable(name: "ptr", scope: !167, file: !3, line: 667, type: !170)
!176 = !DILocation(line: 668, column: 9, scope: !177)
!177 = distinct !DILexicalBlock(scope: !167, file: !3, line: 668, column: 9)
!178 = !DILocation(line: 668, column: 9, scope: !167)
!179 = !DILocation(line: 669, column: 9, scope: !177)
!180 = !DILocation(line: 670, column: 5, scope: !167)
!181 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 697, type: !182, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!182 = !DISubroutineType(types: !183)
!183 = !{null, !184}
!184 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!185 = !DILocalVariable(name: "list", arg: 1, scope: !181, file: !3, line: 697, type: !184)
!186 = !DILocation(line: 0, scope: !181)
!187 = !DILocation(line: 699, column: 23, scope: !181)
!188 = !DILocalVariable(name: "item", scope: !181, file: !3, line: 699, type: !15)
!189 = !DILocation(line: 700, column: 5, scope: !181)
!190 = !DILocation(line: 701, column: 26, scope: !181)
!191 = !DILocation(line: 701, column: 9, scope: !181)
!192 = !DILocation(line: 702, column: 12, scope: !181)
!193 = distinct !{!193, !189, !194}
!194 = !DILocation(line: 702, column: 35, scope: !181)
!195 = !DILocation(line: 703, column: 18, scope: !181)
!196 = !DILocation(line: 703, column: 11, scope: !181)
!197 = !DILocation(line: 703, column: 16, scope: !181)
!198 = !DILocation(line: 704, column: 11, scope: !181)
!199 = !DILocation(line: 705, column: 1, scope: !181)
!200 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 688, type: !201, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!201 = !DISubroutineType(types: !202)
!202 = !{null, !203}
!203 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!204 = !DILocalVariable(name: "list", arg: 1, scope: !200, file: !3, line: 688, type: !203)
!205 = !DILocation(line: 0, scope: !200)
!206 = !DILocation(line: 690, column: 23, scope: !200)
!207 = !DILocalVariable(name: "item", scope: !200, file: !3, line: 690, type: !19)
!208 = !DILocation(line: 691, column: 5, scope: !200)
!209 = !DILocation(line: 692, column: 26, scope: !200)
!210 = !DILocation(line: 692, column: 9, scope: !200)
!211 = !DILocation(line: 693, column: 12, scope: !200)
!212 = distinct !{!212, !208, !213}
!213 = !DILocation(line: 693, column: 35, scope: !200)
!214 = !DILocation(line: 694, column: 18, scope: !200)
!215 = !DILocation(line: 694, column: 11, scope: !200)
!216 = !DILocation(line: 694, column: 16, scope: !200)
!217 = !DILocation(line: 695, column: 11, scope: !200)
!218 = !DILocation(line: 696, column: 1, scope: !200)
!219 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 679, type: !220, scopeLine: 680, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!220 = !DISubroutineType(types: !221)
!221 = !{null, !222}
!222 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!223 = !DILocalVariable(name: "list", arg: 1, scope: !219, file: !3, line: 679, type: !222)
!224 = !DILocation(line: 0, scope: !219)
!225 = !DILocation(line: 681, column: 23, scope: !219)
!226 = !DILocalVariable(name: "item", scope: !219, file: !3, line: 681, type: !24)
!227 = !DILocation(line: 682, column: 5, scope: !219)
!228 = !DILocation(line: 683, column: 26, scope: !219)
!229 = !DILocation(line: 683, column: 9, scope: !219)
!230 = !DILocation(line: 684, column: 12, scope: !219)
!231 = distinct !{!231, !227, !232}
!232 = !DILocation(line: 684, column: 35, scope: !219)
!233 = !DILocation(line: 685, column: 18, scope: !219)
!234 = !DILocation(line: 685, column: 11, scope: !219)
!235 = !DILocation(line: 685, column: 16, scope: !219)
!236 = !DILocation(line: 686, column: 11, scope: !219)
!237 = !DILocation(line: 687, column: 1, scope: !219)
!238 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 672, type: !239, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!239 = !DISubroutineType(types: !240)
!240 = !{null, !241}
!241 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!242 = !DILocalVariable(name: "list", arg: 1, scope: !238, file: !3, line: 672, type: !241)
!243 = !DILocation(line: 0, scope: !238)
!244 = !DILocation(line: 674, column: 23, scope: !238)
!245 = !DILocalVariable(name: "item", scope: !238, file: !3, line: 674, type: !28)
!246 = !DILocation(line: 675, column: 18, scope: !238)
!247 = !DILocation(line: 675, column: 11, scope: !238)
!248 = !DILocation(line: 675, column: 16, scope: !238)
!249 = !DILocation(line: 676, column: 18, scope: !238)
!250 = !DILocation(line: 676, column: 11, scope: !238)
!251 = !DILocation(line: 676, column: 16, scope: !238)
!252 = !DILocation(line: 677, column: 11, scope: !238)
!253 = !DILocation(line: 678, column: 1, scope: !238)
!254 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 640, type: !255, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!255 = !DISubroutineType(types: !256)
!256 = !{!170, !257, !257}
!257 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 13, baseType: !171)
!258 = !DILocalVariable(name: "nmemb", arg: 1, scope: !254, file: !3, line: 640, type: !257)
!259 = !DILocation(line: 0, scope: !254)
!260 = !DILocalVariable(name: "size", arg: 2, scope: !254, file: !3, line: 640, type: !257)
!261 = !DILocation(line: 641, column: 30, scope: !254)
!262 = !DILocation(line: 641, column: 17, scope: !254)
!263 = !DILocalVariable(name: "ptr", scope: !254, file: !3, line: 641, type: !170)
!264 = !DILocation(line: 642, column: 33, scope: !254)
!265 = !DILocation(line: 642, column: 12, scope: !254)
!266 = !DILocation(line: 642, column: 5, scope: !254)
