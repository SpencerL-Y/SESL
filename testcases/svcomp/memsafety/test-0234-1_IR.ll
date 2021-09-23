; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-tp9y0wks.bc'
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
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0234-1.c\00", align 1
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
  call void @l0_destroy(%struct.L0* %6), !dbg !56, !verifier.code !48
  ret i32 0, !dbg !57, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !58 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !62, metadata !DIExpression()), !dbg !63, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !64, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !64, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !48
  br label %4, !dbg !66, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !67, !verifier.code !48
  call void @l1_insert(%struct.L1** %5), !dbg !68, !verifier.code !48
  br label %6, !dbg !68, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !69, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !68, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !68, !llvm.loop !70, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !72, !verifier.code !48
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !73, !verifier.code !48
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !74, !verifier.code !48
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !75, !verifier.code !48
  ret void, !dbg !76, !verifier.code !48
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0) #0 !dbg !77 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !80, metadata !DIExpression()), !dbg !81, !verifier.code !48
  br label %2, !dbg !82, !verifier.code !48

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L0* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !80, metadata !DIExpression()), !dbg !81, !verifier.code !48
  %3 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !83, !verifier.code !48
  %4 = load %struct.L1*, %struct.L1** %3, align 8, !dbg !83, !verifier.code !48
  call void @l1_destroy(%struct.L1* %4), !dbg !85, !verifier.code !48
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !86, !verifier.code !48
  %6 = load %struct.L0*, %struct.L0** %5, align 8, !dbg !86, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !87, metadata !DIExpression()), !dbg !88, !verifier.code !48
  %7 = bitcast %struct.L0* %.0 to i8*, !dbg !89, !verifier.code !48
  call void @free(i8* %7) #7, !dbg !90, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !80, metadata !DIExpression()), !dbg !81, !verifier.code !48
  br label %8, !dbg !91, !verifier.code !48

8:                                                ; preds = %2
  %9 = icmp ne %struct.L0* %6, null, !dbg !91, !verifier.code !48
  br i1 %9, label %forwarder, label %10, !dbg !91, !llvm.loop !92, !verifier.code !48

10:                                               ; preds = %8
  ret void, !dbg !94, !verifier.code !48

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !48
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0) #0 !dbg !95 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !98, metadata !DIExpression()), !dbg !99, !verifier.code !48
  br label %2, !dbg !100, !verifier.code !48

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L1* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !98, metadata !DIExpression()), !dbg !99, !verifier.code !48
  %3 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !101, !verifier.code !48
  %4 = load %struct.L2*, %struct.L2** %3, align 8, !dbg !101, !verifier.code !48
  call void @l2_destroy(%struct.L2* %4), !dbg !103, !verifier.code !48
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !104, !verifier.code !48
  %6 = load %struct.L1*, %struct.L1** %5, align 8, !dbg !104, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !105, metadata !DIExpression()), !dbg !106, !verifier.code !48
  %7 = bitcast %struct.L1* %.0 to i8*, !dbg !107, !verifier.code !48
  call void @free(i8* %7) #7, !dbg !108, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !98, metadata !DIExpression()), !dbg !99, !verifier.code !48
  br label %8, !dbg !109, !verifier.code !48

8:                                                ; preds = %2
  %9 = icmp ne %struct.L1* %6, null, !dbg !109, !verifier.code !48
  br i1 %9, label %forwarder, label %10, !dbg !109, !llvm.loop !110, !verifier.code !48

10:                                               ; preds = %8
  ret void, !dbg !112, !verifier.code !48

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !48
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 !dbg !113 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !48
  br label %2, !dbg !118, !verifier.code !48

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L2* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !48
  %3 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !119, !verifier.code !48
  %4 = load %struct.L3*, %struct.L3** %3, align 8, !dbg !119, !verifier.code !48
  call void @l3_destroy(%struct.L3* %4), !dbg !121, !verifier.code !48
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !122, !verifier.code !48
  %6 = load %struct.L2*, %struct.L2** %5, align 8, !dbg !122, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !123, metadata !DIExpression()), !dbg !124, !verifier.code !48
  %7 = bitcast %struct.L2* %.0 to i8*, !dbg !125, !verifier.code !48
  call void @free(i8* %7) #7, !dbg !126, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !48
  br label %8, !dbg !127, !verifier.code !48

8:                                                ; preds = %2
  %9 = icmp ne %struct.L2* %6, null, !dbg !127, !verifier.code !48
  br i1 %9, label %forwarder, label %10, !dbg !127, !llvm.loop !128, !verifier.code !48

10:                                               ; preds = %8
  ret void, !dbg !130, !verifier.code !48

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0) #0 !dbg !131 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !48
  br label %2, !dbg !136, !verifier.code !48

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L3* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !48
  %3 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !137, !verifier.code !48
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !137, !verifier.code !48
  call void @l4_destroy(%struct.L4* %4), !dbg !139, !verifier.code !48
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !140, !verifier.code !48
  %6 = load %struct.L3*, %struct.L3** %5, align 8, !dbg !140, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !48
  %7 = bitcast %struct.L3* %.0 to i8*, !dbg !143, !verifier.code !48
  call void @free(i8* %7) #7, !dbg !144, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !48
  br label %8, !dbg !145, !verifier.code !48

8:                                                ; preds = %2
  %9 = icmp ne %struct.L3* %6, null, !dbg !145, !verifier.code !48
  br i1 %9, label %forwarder, label %10, !dbg !145, !llvm.loop !146, !verifier.code !48

10:                                               ; preds = %8
  ret void, !dbg !148, !verifier.code !48

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0) #0 !dbg !149 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !152, metadata !DIExpression()), !dbg !153, !verifier.code !48
  br label %2, !dbg !154, !verifier.code !48

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L4* [ %0, %1 ], [ %7, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !152, metadata !DIExpression()), !dbg !153, !verifier.code !48
  %3 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !155, !verifier.code !48
  %4 = load %struct.L5*, %struct.L5** %3, align 8, !dbg !155, !verifier.code !48
  %5 = bitcast %struct.L5* %4 to i8*, !dbg !157, !verifier.code !48
  call void @free(i8* %5) #7, !dbg !158, !verifier.code !48
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !159, !verifier.code !48
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !159, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !160, metadata !DIExpression()), !dbg !161, !verifier.code !48
  %8 = bitcast %struct.L4* %.0 to i8*, !dbg !162, !verifier.code !48
  call void @free(i8* %8) #7, !dbg !163, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !152, metadata !DIExpression()), !dbg !153, !verifier.code !48
  br label %9, !dbg !164, !verifier.code !48

9:                                                ; preds = %2
  %10 = icmp ne %struct.L4* %7, null, !dbg !164, !verifier.code !48
  br i1 %10, label %forwarder, label %11, !dbg !164, !llvm.loop !165, !verifier.code !48

11:                                               ; preds = %9
  ret void, !dbg !167, !verifier.code !48

forwarder:                                        ; preds = %9
  br label %2, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !168 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !173, metadata !DIExpression()), !dbg !174, !verifier.code !48
  %2 = zext i32 %0 to i64, !dbg !175, !verifier.code !48
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !176, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %3, metadata !177, metadata !DIExpression()), !dbg !174, !verifier.code !48
  %4 = icmp ne i8* %3, null, !dbg !178, !verifier.code !48
  br i1 %4, label %5, label %6, !dbg !180, !verifier.code !48

5:                                                ; preds = %1
  ret i8* %3, !dbg !181, !verifier.code !48

6:                                                ; preds = %1
  call void @abort() #6, !dbg !182, !verifier.code !48
  unreachable, !dbg !182, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !183 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !187, metadata !DIExpression()), !dbg !188, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !189, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !189, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !190, metadata !DIExpression()), !dbg !188, !verifier.code !48
  br label %4, !dbg !191, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !192, !verifier.code !48
  call void @l2_insert(%struct.L2** %5), !dbg !193, !verifier.code !48
  br label %6, !dbg !193, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !194, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !193, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !193, !llvm.loop !195, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !197, !verifier.code !48
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !198, !verifier.code !48
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !199, !verifier.code !48
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !200, !verifier.code !48
  ret void, !dbg !201, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !202 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !206, metadata !DIExpression()), !dbg !207, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !208, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !208, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !209, metadata !DIExpression()), !dbg !207, !verifier.code !48
  br label %4, !dbg !210, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !211, !verifier.code !48
  call void @l3_insert(%struct.L3** %5), !dbg !212, !verifier.code !48
  br label %6, !dbg !212, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !213, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !212, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !212, !llvm.loop !214, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !216, !verifier.code !48
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !217, !verifier.code !48
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !218, !verifier.code !48
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !219, !verifier.code !48
  ret void, !dbg !220, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !221 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !225, metadata !DIExpression()), !dbg !226, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !227, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !227, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !228, metadata !DIExpression()), !dbg !226, !verifier.code !48
  br label %4, !dbg !229, !verifier.code !48

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !230, !verifier.code !48
  call void @l4_insert(%struct.L4** %5), !dbg !231, !verifier.code !48
  br label %6, !dbg !231, !verifier.code !48

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !232, !verifier.code !52
  %8 = icmp ne i32 %7, 0, !dbg !231, !verifier.code !48
  br i1 %8, label %4, label %9, !dbg !231, !llvm.loop !233, !verifier.code !48

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !235, !verifier.code !48
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !236, !verifier.code !48
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !237, !verifier.code !48
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !238, !verifier.code !48
  ret void, !dbg !239, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !240 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !244, metadata !DIExpression()), !dbg !245, !verifier.code !48
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !246, !verifier.code !48
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !246, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !247, metadata !DIExpression()), !dbg !245, !verifier.code !48
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !248, !verifier.code !48
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !248, !verifier.code !48
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !249, !verifier.code !48
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !250, !verifier.code !48
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !251, !verifier.code !48
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !252, !verifier.code !48
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !253, !verifier.code !48
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !254, !verifier.code !48
  ret void, !dbg !255, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !256 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !262, metadata !DIExpression()), !dbg !263, !verifier.code !48
  call void @llvm.dbg.value(metadata i64 %1, metadata !264, metadata !DIExpression()), !dbg !263, !verifier.code !48
  %3 = mul i64 %0, %1, !dbg !265, !verifier.code !48
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !266, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %4, metadata !267, metadata !DIExpression()), !dbg !263, !verifier.code !48
  %5 = mul i64 %0, %1, !dbg !268, !verifier.code !48
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !269, !verifier.code !48
  ret i8* %4, !dbg !270, !verifier.code !48
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
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 168, type: !11, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 166, type: !4, scopeLine: 167, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!3 = !DIFile(filename: "../svcomp/memsafety//test-0234-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !8, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, globals: !10, splitDebugInlining: false, nameTableKind: None)
!8 = !DIFile(filename: "../svcomp/memsafety/test-0234-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
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
!49 = !DILocation(line: 170, column: 5, scope: !2)
!50 = !DILocation(line: 171, column: 9, scope: !2)
!51 = !DILocation(line: 172, column: 12, scope: !2)
!52 = !{i1 true}
!53 = distinct !{!53, !49, !54}
!54 = !DILocation(line: 172, column: 35, scope: !2)
!55 = !DILocation(line: 174, column: 16, scope: !2)
!56 = !DILocation(line: 174, column: 5, scope: !2)
!57 = !DILocation(line: 175, column: 1, scope: !2)
!58 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !59, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!59 = !DISubroutineType(types: !60)
!60 = !{null, !61}
!61 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!62 = !DILocalVariable(name: "list", arg: 1, scope: !58, file: !3, line: 94, type: !61)
!63 = !DILocation(line: 0, scope: !58)
!64 = !DILocation(line: 96, column: 23, scope: !58)
!65 = !DILocalVariable(name: "item", scope: !58, file: !3, line: 96, type: !11)
!66 = !DILocation(line: 98, column: 5, scope: !58)
!67 = !DILocation(line: 99, column: 26, scope: !58)
!68 = !DILocation(line: 99, column: 9, scope: !58)
!69 = !DILocation(line: 100, column: 12, scope: !58)
!70 = distinct !{!70, !66, !71}
!71 = !DILocation(line: 100, column: 35, scope: !58)
!72 = !DILocation(line: 102, column: 18, scope: !58)
!73 = !DILocation(line: 102, column: 11, scope: !58)
!74 = !DILocation(line: 102, column: 16, scope: !58)
!75 = !DILocation(line: 103, column: 11, scope: !58)
!76 = !DILocation(line: 104, column: 1, scope: !58)
!77 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 154, type: !78, scopeLine: 155, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!78 = !DISubroutineType(types: !79)
!79 = !{null, !11}
!80 = !DILocalVariable(name: "list", arg: 1, scope: !77, file: !3, line: 154, type: !11)
!81 = !DILocation(line: 0, scope: !77)
!82 = !DILocation(line: 156, column: 5, scope: !77)
!83 = !DILocation(line: 157, column: 26, scope: !84)
!84 = distinct !DILexicalBlock(scope: !77, file: !3, line: 156, column: 8)
!85 = !DILocation(line: 157, column: 9, scope: !84)
!86 = !DILocation(line: 159, column: 33, scope: !84)
!87 = !DILocalVariable(name: "next", scope: !84, file: !3, line: 159, type: !11)
!88 = !DILocation(line: 0, scope: !84)
!89 = !DILocation(line: 160, column: 14, scope: !84)
!90 = !DILocation(line: 160, column: 9, scope: !84)
!91 = !DILocation(line: 162, column: 5, scope: !84)
!92 = distinct !{!92, !82, !93}
!93 = !DILocation(line: 163, column: 16, scope: !77)
!94 = !DILocation(line: 164, column: 1, scope: !77)
!95 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 142, type: !96, scopeLine: 143, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!96 = !DISubroutineType(types: !97)
!97 = !{null, !16}
!98 = !DILocalVariable(name: "list", arg: 1, scope: !95, file: !3, line: 142, type: !16)
!99 = !DILocation(line: 0, scope: !95)
!100 = !DILocation(line: 144, column: 5, scope: !95)
!101 = !DILocation(line: 145, column: 26, scope: !102)
!102 = distinct !DILexicalBlock(scope: !95, file: !3, line: 144, column: 8)
!103 = !DILocation(line: 145, column: 9, scope: !102)
!104 = !DILocation(line: 147, column: 33, scope: !102)
!105 = !DILocalVariable(name: "next", scope: !102, file: !3, line: 147, type: !16)
!106 = !DILocation(line: 0, scope: !102)
!107 = !DILocation(line: 148, column: 14, scope: !102)
!108 = !DILocation(line: 148, column: 9, scope: !102)
!109 = !DILocation(line: 150, column: 5, scope: !102)
!110 = distinct !{!110, !100, !111}
!111 = !DILocation(line: 151, column: 16, scope: !95)
!112 = !DILocation(line: 152, column: 1, scope: !95)
!113 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 130, type: !114, scopeLine: 131, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!114 = !DISubroutineType(types: !115)
!115 = !{null, !20}
!116 = !DILocalVariable(name: "list", arg: 1, scope: !113, file: !3, line: 130, type: !20)
!117 = !DILocation(line: 0, scope: !113)
!118 = !DILocation(line: 132, column: 5, scope: !113)
!119 = !DILocation(line: 133, column: 26, scope: !120)
!120 = distinct !DILexicalBlock(scope: !113, file: !3, line: 132, column: 8)
!121 = !DILocation(line: 133, column: 9, scope: !120)
!122 = !DILocation(line: 135, column: 33, scope: !120)
!123 = !DILocalVariable(name: "next", scope: !120, file: !3, line: 135, type: !20)
!124 = !DILocation(line: 0, scope: !120)
!125 = !DILocation(line: 136, column: 14, scope: !120)
!126 = !DILocation(line: 136, column: 9, scope: !120)
!127 = !DILocation(line: 138, column: 5, scope: !120)
!128 = distinct !{!128, !118, !129}
!129 = !DILocation(line: 139, column: 16, scope: !113)
!130 = !DILocation(line: 140, column: 1, scope: !113)
!131 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 118, type: !132, scopeLine: 119, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!132 = !DISubroutineType(types: !133)
!133 = !{null, !25}
!134 = !DILocalVariable(name: "list", arg: 1, scope: !131, file: !3, line: 118, type: !25)
!135 = !DILocation(line: 0, scope: !131)
!136 = !DILocation(line: 120, column: 5, scope: !131)
!137 = !DILocation(line: 121, column: 26, scope: !138)
!138 = distinct !DILexicalBlock(scope: !131, file: !3, line: 120, column: 8)
!139 = !DILocation(line: 121, column: 9, scope: !138)
!140 = !DILocation(line: 123, column: 33, scope: !138)
!141 = !DILocalVariable(name: "next", scope: !138, file: !3, line: 123, type: !25)
!142 = !DILocation(line: 0, scope: !138)
!143 = !DILocation(line: 124, column: 14, scope: !138)
!144 = !DILocation(line: 124, column: 9, scope: !138)
!145 = !DILocation(line: 126, column: 5, scope: !138)
!146 = distinct !{!146, !136, !147}
!147 = !DILocation(line: 127, column: 16, scope: !131)
!148 = !DILocation(line: 128, column: 1, scope: !131)
!149 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !150, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!150 = !DISubroutineType(types: !151)
!151 = !{null, !29}
!152 = !DILocalVariable(name: "list", arg: 1, scope: !149, file: !3, line: 106, type: !29)
!153 = !DILocation(line: 0, scope: !149)
!154 = !DILocation(line: 108, column: 5, scope: !149)
!155 = !DILocation(line: 109, column: 20, scope: !156)
!156 = distinct !DILexicalBlock(scope: !149, file: !3, line: 108, column: 8)
!157 = !DILocation(line: 109, column: 14, scope: !156)
!158 = !DILocation(line: 109, column: 9, scope: !156)
!159 = !DILocation(line: 111, column: 33, scope: !156)
!160 = !DILocalVariable(name: "next", scope: !156, file: !3, line: 111, type: !29)
!161 = !DILocation(line: 0, scope: !156)
!162 = !DILocation(line: 112, column: 14, scope: !156)
!163 = !DILocation(line: 112, column: 9, scope: !156)
!164 = !DILocation(line: 114, column: 5, scope: !156)
!165 = distinct !{!165, !154, !166}
!166 = !DILocation(line: 115, column: 16, scope: !149)
!167 = !DILocation(line: 116, column: 1, scope: !149)
!168 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !169, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!169 = !DISubroutineType(types: !170)
!170 = !{!171, !172}
!171 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!172 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!173 = !DILocalVariable(name: "size", arg: 1, scope: !168, file: !3, line: 40, type: !172)
!174 = !DILocation(line: 0, scope: !168)
!175 = !DILocation(line: 42, column: 34, scope: !168)
!176 = !DILocation(line: 42, column: 17, scope: !168)
!177 = !DILocalVariable(name: "ptr", scope: !168, file: !3, line: 42, type: !171)
!178 = !DILocation(line: 43, column: 9, scope: !179)
!179 = distinct !DILexicalBlock(scope: !168, file: !3, line: 43, column: 9)
!180 = !DILocation(line: 43, column: 9, scope: !168)
!181 = !DILocation(line: 44, column: 9, scope: !179)
!182 = !DILocation(line: 46, column: 5, scope: !168)
!183 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !184, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!184 = !DISubroutineType(types: !185)
!185 = !{null, !186}
!186 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!187 = !DILocalVariable(name: "list", arg: 1, scope: !183, file: !3, line: 82, type: !186)
!188 = !DILocation(line: 0, scope: !183)
!189 = !DILocation(line: 84, column: 23, scope: !183)
!190 = !DILocalVariable(name: "item", scope: !183, file: !3, line: 84, type: !16)
!191 = !DILocation(line: 86, column: 5, scope: !183)
!192 = !DILocation(line: 87, column: 26, scope: !183)
!193 = !DILocation(line: 87, column: 9, scope: !183)
!194 = !DILocation(line: 88, column: 12, scope: !183)
!195 = distinct !{!195, !191, !196}
!196 = !DILocation(line: 88, column: 35, scope: !183)
!197 = !DILocation(line: 90, column: 18, scope: !183)
!198 = !DILocation(line: 90, column: 11, scope: !183)
!199 = !DILocation(line: 90, column: 16, scope: !183)
!200 = !DILocation(line: 91, column: 11, scope: !183)
!201 = !DILocation(line: 92, column: 1, scope: !183)
!202 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !203, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!203 = !DISubroutineType(types: !204)
!204 = !{null, !205}
!205 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!206 = !DILocalVariable(name: "list", arg: 1, scope: !202, file: !3, line: 70, type: !205)
!207 = !DILocation(line: 0, scope: !202)
!208 = !DILocation(line: 72, column: 23, scope: !202)
!209 = !DILocalVariable(name: "item", scope: !202, file: !3, line: 72, type: !20)
!210 = !DILocation(line: 74, column: 5, scope: !202)
!211 = !DILocation(line: 75, column: 26, scope: !202)
!212 = !DILocation(line: 75, column: 9, scope: !202)
!213 = !DILocation(line: 76, column: 12, scope: !202)
!214 = distinct !{!214, !210, !215}
!215 = !DILocation(line: 76, column: 35, scope: !202)
!216 = !DILocation(line: 78, column: 18, scope: !202)
!217 = !DILocation(line: 78, column: 11, scope: !202)
!218 = !DILocation(line: 78, column: 16, scope: !202)
!219 = !DILocation(line: 79, column: 11, scope: !202)
!220 = !DILocation(line: 80, column: 1, scope: !202)
!221 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !222, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!222 = !DISubroutineType(types: !223)
!223 = !{null, !224}
!224 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!225 = !DILocalVariable(name: "list", arg: 1, scope: !221, file: !3, line: 58, type: !224)
!226 = !DILocation(line: 0, scope: !221)
!227 = !DILocation(line: 60, column: 23, scope: !221)
!228 = !DILocalVariable(name: "item", scope: !221, file: !3, line: 60, type: !25)
!229 = !DILocation(line: 62, column: 5, scope: !221)
!230 = !DILocation(line: 63, column: 26, scope: !221)
!231 = !DILocation(line: 63, column: 9, scope: !221)
!232 = !DILocation(line: 64, column: 12, scope: !221)
!233 = distinct !{!233, !229, !234}
!234 = !DILocation(line: 64, column: 35, scope: !221)
!235 = !DILocation(line: 66, column: 18, scope: !221)
!236 = !DILocation(line: 66, column: 11, scope: !221)
!237 = !DILocation(line: 66, column: 16, scope: !221)
!238 = !DILocation(line: 67, column: 11, scope: !221)
!239 = !DILocation(line: 68, column: 1, scope: !221)
!240 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !241, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!241 = !DISubroutineType(types: !242)
!242 = !{null, !243}
!243 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!244 = !DILocalVariable(name: "list", arg: 1, scope: !240, file: !3, line: 49, type: !243)
!245 = !DILocation(line: 0, scope: !240)
!246 = !DILocation(line: 51, column: 23, scope: !240)
!247 = !DILocalVariable(name: "item", scope: !240, file: !3, line: 51, type: !29)
!248 = !DILocation(line: 52, column: 18, scope: !240)
!249 = !DILocation(line: 52, column: 11, scope: !240)
!250 = !DILocation(line: 52, column: 16, scope: !240)
!251 = !DILocation(line: 54, column: 18, scope: !240)
!252 = !DILocation(line: 54, column: 11, scope: !240)
!253 = !DILocation(line: 54, column: 16, scope: !240)
!254 = !DILocation(line: 55, column: 11, scope: !240)
!255 = !DILocation(line: 56, column: 1, scope: !240)
!256 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !257, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !9)
!257 = !DISubroutineType(types: !258)
!258 = !{!171, !259, !259}
!259 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !260, line: 46, baseType: !261)
!260 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!261 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!262 = !DILocalVariable(name: "nmemb", arg: 1, scope: !256, file: !3, line: 8, type: !259)
!263 = !DILocation(line: 0, scope: !256)
!264 = !DILocalVariable(name: "size", arg: 2, scope: !256, file: !3, line: 8, type: !259)
!265 = !DILocation(line: 9, column: 30, scope: !256)
!266 = !DILocation(line: 9, column: 17, scope: !256)
!267 = !DILocalVariable(name: "ptr", scope: !256, file: !3, line: 9, type: !171)
!268 = !DILocation(line: 10, column: 33, scope: !256)
!269 = !DILocation(line: 10, column: 12, scope: !256)
!270 = !DILocation(line: 10, column: 5, scope: !256)
