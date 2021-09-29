; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-1qbnz9tj.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.L0 = type { %struct.L0*, %struct.L1* }
%struct.L1 = type { %struct.L2*, %struct.L1*, %struct.L1** }
%struct.L2 = type { %struct.L1**, %struct.L2*, %struct.L3* }
%struct.L3 = type { %struct.L4*, %struct.L3*, %struct.L3** }
%struct.L4 = type { %struct.L3**, %struct.L4*, %struct.L5* }
%struct.L5 = type opaque

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"test-0237.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !50 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !53, !verifier.code !56
  unreachable, !dbg !53, !verifier.code !56
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  br label %1, !dbg !57, !verifier.code !56

1:                                                ; preds = %2, %0
  call void @l0_insert(%struct.L0** @main.list), !dbg !58, !verifier.code !56
  br label %2, !dbg !58, !verifier.code !56

2:                                                ; preds = %1
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !59, !verifier.code !60
  %4 = icmp ne i32 %3, 0, !dbg !58, !verifier.code !56
  br i1 %4, label %1, label %5, !dbg !58, !llvm.loop !61, !verifier.code !56

5:                                                ; preds = %2
  %6 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !63, !verifier.code !56
  call void @l0_destroy(%struct.L0* %6), !dbg !64, !verifier.code !56
  ret i32 0, !dbg !65, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !66 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !70, metadata !DIExpression()), !dbg !71, !verifier.code !56
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !72, !verifier.code !56
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !72, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !73, metadata !DIExpression()), !dbg !71, !verifier.code !56
  br label %4, !dbg !74, !verifier.code !56

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !75, !verifier.code !56
  call void @l1_insert(%struct.L1** %5), !dbg !76, !verifier.code !56
  br label %6, !dbg !76, !verifier.code !56

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !77, !verifier.code !60
  %8 = icmp ne i32 %7, 0, !dbg !76, !verifier.code !56
  br i1 %8, label %4, label %9, !dbg !76, !llvm.loop !78, !verifier.code !56

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !80, !verifier.code !56
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !81, !verifier.code !56
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !82, !verifier.code !56
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !83, !verifier.code !56
  ret void, !dbg !84, !verifier.code !56
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0) #0 !dbg !85 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !56
  br label %2, !dbg !90, !verifier.code !56

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L0* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !56
  %3 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !91, !verifier.code !56
  %4 = load %struct.L1*, %struct.L1** %3, align 8, !dbg !91, !verifier.code !56
  call void @l1_destroy(%struct.L1* %4), !dbg !93, !verifier.code !56
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !94, !verifier.code !56
  %6 = load %struct.L0*, %struct.L0** %5, align 8, !dbg !94, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !56
  %7 = bitcast %struct.L0* %.0 to i8*, !dbg !97, !verifier.code !56
  call void @free(i8* %7) #6, !dbg !98, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !56
  br label %8, !dbg !99, !verifier.code !56

8:                                                ; preds = %2
  %9 = icmp ne %struct.L0* %6, null, !dbg !99, !verifier.code !56
  br i1 %9, label %forwarder, label %10, !dbg !99, !llvm.loop !100, !verifier.code !56

10:                                               ; preds = %8
  ret void, !dbg !102, !verifier.code !56

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !56
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0) #0 !dbg !103 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !106, metadata !DIExpression()), !dbg !107, !verifier.code !56
  br label %2, !dbg !108, !verifier.code !56

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L1* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !106, metadata !DIExpression()), !dbg !107, !verifier.code !56
  %3 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !109, !verifier.code !56
  %4 = load %struct.L2*, %struct.L2** %3, align 8, !dbg !109, !verifier.code !56
  call void @l2_destroy(%struct.L2* %4), !dbg !111, !verifier.code !56
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !112, !verifier.code !56
  %6 = load %struct.L1*, %struct.L1** %5, align 8, !dbg !112, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !113, metadata !DIExpression()), !dbg !114, !verifier.code !56
  %7 = bitcast %struct.L1* %.0 to i8*, !dbg !115, !verifier.code !56
  call void @free(i8* %7) #6, !dbg !116, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !106, metadata !DIExpression()), !dbg !107, !verifier.code !56
  br label %8, !dbg !117, !verifier.code !56

8:                                                ; preds = %2
  %9 = icmp ne %struct.L1* %6, null, !dbg !117, !verifier.code !56
  br i1 %9, label %forwarder, label %10, !dbg !117, !llvm.loop !118, !verifier.code !56

10:                                               ; preds = %8
  ret void, !dbg !120, !verifier.code !56

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !56
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 !dbg !121 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !124, metadata !DIExpression()), !dbg !125, !verifier.code !56
  br label %2, !dbg !126, !verifier.code !56

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L2* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !124, metadata !DIExpression()), !dbg !125, !verifier.code !56
  %3 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 2, !dbg !127, !verifier.code !56
  %4 = load %struct.L3*, %struct.L3** %3, align 8, !dbg !127, !verifier.code !56
  call void @l3_destroy(%struct.L3* %4), !dbg !129, !verifier.code !56
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !130, !verifier.code !56
  %6 = load %struct.L2*, %struct.L2** %5, align 8, !dbg !130, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !131, metadata !DIExpression()), !dbg !132, !verifier.code !56
  %7 = bitcast %struct.L2* %.0 to i8*, !dbg !133, !verifier.code !56
  call void @free(i8* %7) #6, !dbg !134, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !124, metadata !DIExpression()), !dbg !125, !verifier.code !56
  br label %8, !dbg !135, !verifier.code !56

8:                                                ; preds = %2
  %9 = icmp ne %struct.L2* %6, null, !dbg !135, !verifier.code !56
  br i1 %9, label %forwarder, label %10, !dbg !135, !llvm.loop !136, !verifier.code !56

10:                                               ; preds = %8
  ret void, !dbg !138, !verifier.code !56

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0) #0 !dbg !139 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !56
  br label %2, !dbg !144, !verifier.code !56

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L3* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !56
  %3 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !145, !verifier.code !56
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !145, !verifier.code !56
  call void @l4_destroy(%struct.L4* %4), !dbg !147, !verifier.code !56
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !148, !verifier.code !56
  %6 = load %struct.L3*, %struct.L3** %5, align 8, !dbg !148, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !149, metadata !DIExpression()), !dbg !150, !verifier.code !56
  %7 = bitcast %struct.L3* %.0 to i8*, !dbg !151, !verifier.code !56
  call void @free(i8* %7) #6, !dbg !152, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !56
  br label %8, !dbg !153, !verifier.code !56

8:                                                ; preds = %2
  %9 = icmp ne %struct.L3* %6, null, !dbg !153, !verifier.code !56
  br i1 %9, label %forwarder, label %10, !dbg !153, !llvm.loop !154, !verifier.code !56

10:                                               ; preds = %8
  ret void, !dbg !156, !verifier.code !56

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0) #0 !dbg !157 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !160, metadata !DIExpression()), !dbg !161, !verifier.code !56
  br label %2, !dbg !162, !verifier.code !56

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L4* [ %0, %1 ], [ %7, %forwarder ], !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !160, metadata !DIExpression()), !dbg !161, !verifier.code !56
  %3 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 2, !dbg !163, !verifier.code !56
  %4 = load %struct.L5*, %struct.L5** %3, align 8, !dbg !163, !verifier.code !56
  %5 = bitcast %struct.L5* %4 to i8*, !dbg !165, !verifier.code !56
  call void @free(i8* %5) #6, !dbg !166, !verifier.code !56
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !167, !verifier.code !56
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !167, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !168, metadata !DIExpression()), !dbg !169, !verifier.code !56
  %8 = bitcast %struct.L4* %.0 to i8*, !dbg !170, !verifier.code !56
  call void @free(i8* %8) #6, !dbg !171, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !160, metadata !DIExpression()), !dbg !161, !verifier.code !56
  br label %9, !dbg !172, !verifier.code !56

9:                                                ; preds = %2
  %10 = icmp ne %struct.L4* %7, null, !dbg !172, !verifier.code !56
  br i1 %10, label %forwarder, label %11, !dbg !172, !llvm.loop !173, !verifier.code !56

11:                                               ; preds = %9
  ret void, !dbg !175, !verifier.code !56

forwarder:                                        ; preds = %9
  br label %2, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !176 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !180, metadata !DIExpression()), !dbg !181, !verifier.code !56
  %2 = call i8* @calloc_model(i32 1, i32 %0), !dbg !182, !verifier.code !56
  call void @llvm.dbg.value(metadata i8* %2, metadata !183, metadata !DIExpression()), !dbg !181, !verifier.code !56
  %3 = icmp ne i8* %2, null, !dbg !184, !verifier.code !56
  br i1 %3, label %4, label %5, !dbg !186, !verifier.code !56

4:                                                ; preds = %1
  ret i8* %2, !dbg !187, !verifier.code !56

5:                                                ; preds = %1
  call void @abort() #5, !dbg !188, !verifier.code !56
  unreachable, !dbg !188, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !189 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !192, metadata !DIExpression()), !dbg !193, !verifier.code !56
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !194, !verifier.code !56
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !194, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !195, metadata !DIExpression()), !dbg !193, !verifier.code !56
  br label %4, !dbg !196, !verifier.code !56

4:                                                ; preds = %7, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !197, !verifier.code !56
  %6 = bitcast %struct.L1** %0 to i8*, !dbg !198, !verifier.code !56
  call void @l2_insert(%struct.L2** %5, i8* %6), !dbg !199, !verifier.code !56
  br label %7, !dbg !199, !verifier.code !56

7:                                                ; preds = %4
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !200, !verifier.code !60
  %9 = icmp ne i32 %8, 0, !dbg !199, !verifier.code !56
  br i1 %9, label %4, label %10, !dbg !199, !llvm.loop !201, !verifier.code !56

10:                                               ; preds = %7
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 2, !dbg !203, !verifier.code !56
  store %struct.L1** %0, %struct.L1*** %11, align 8, !dbg !204, !verifier.code !56
  %12 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !205, !verifier.code !56
  %13 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !206, !verifier.code !56
  store %struct.L1* %12, %struct.L1** %13, align 8, !dbg !207, !verifier.code !56
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !208, !verifier.code !56
  ret void, !dbg !209, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0, i8* %1) #0 !dbg !210 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !214, metadata !DIExpression()), !dbg !215, !verifier.code !56
  call void @llvm.dbg.value(metadata i8* %1, metadata !216, metadata !DIExpression()), !dbg !215, !verifier.code !56
  %3 = call i8* @zalloc_or_die(i32 24), !dbg !217, !verifier.code !56
  %4 = bitcast i8* %3 to %struct.L2*, !dbg !217, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L2* %4, metadata !218, metadata !DIExpression()), !dbg !215, !verifier.code !56
  br label %5, !dbg !219, !verifier.code !56

5:                                                ; preds = %7, %2
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %4, i32 0, i32 2, !dbg !220, !verifier.code !56
  call void @l3_insert(%struct.L3** %6), !dbg !221, !verifier.code !56
  br label %7, !dbg !221, !verifier.code !56

7:                                                ; preds = %5
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !222, !verifier.code !60
  %9 = icmp ne i32 %8, 0, !dbg !221, !verifier.code !56
  br i1 %9, label %5, label %10, !dbg !221, !llvm.loop !223, !verifier.code !56

10:                                               ; preds = %7
  %11 = bitcast i8* %1 to %struct.L1**, !dbg !225, !verifier.code !56
  %12 = getelementptr inbounds %struct.L2, %struct.L2* %4, i32 0, i32 0, !dbg !226, !verifier.code !56
  store %struct.L1** %11, %struct.L1*** %12, align 8, !dbg !227, !verifier.code !56
  %13 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !228, !verifier.code !56
  %14 = getelementptr inbounds %struct.L2, %struct.L2* %4, i32 0, i32 1, !dbg !229, !verifier.code !56
  store %struct.L2* %13, %struct.L2** %14, align 8, !dbg !230, !verifier.code !56
  store %struct.L2* %4, %struct.L2** %0, align 8, !dbg !231, !verifier.code !56
  ret void, !dbg !232, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !233 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !236, metadata !DIExpression()), !dbg !237, !verifier.code !56
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !238, !verifier.code !56
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !238, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !239, metadata !DIExpression()), !dbg !237, !verifier.code !56
  br label %4, !dbg !240, !verifier.code !56

4:                                                ; preds = %7, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !241, !verifier.code !56
  %6 = bitcast %struct.L3** %0 to i8*, !dbg !242, !verifier.code !56
  call void @l4_insert(%struct.L4** %5, i8* %6), !dbg !243, !verifier.code !56
  br label %7, !dbg !243, !verifier.code !56

7:                                                ; preds = %4
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !244, !verifier.code !60
  %9 = icmp ne i32 %8, 0, !dbg !243, !verifier.code !56
  br i1 %9, label %4, label %10, !dbg !243, !llvm.loop !245, !verifier.code !56

10:                                               ; preds = %7
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 2, !dbg !247, !verifier.code !56
  store %struct.L3** %0, %struct.L3*** %11, align 8, !dbg !248, !verifier.code !56
  %12 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !249, !verifier.code !56
  %13 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !250, !verifier.code !56
  store %struct.L3* %12, %struct.L3** %13, align 8, !dbg !251, !verifier.code !56
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !252, !verifier.code !56
  ret void, !dbg !253, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0, i8* %1) #0 !dbg !254 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !258, metadata !DIExpression()), !dbg !259, !verifier.code !56
  call void @llvm.dbg.value(metadata i8* %1, metadata !260, metadata !DIExpression()), !dbg !259, !verifier.code !56
  %3 = call i8* @zalloc_or_die(i32 24), !dbg !261, !verifier.code !56
  %4 = bitcast i8* %3 to %struct.L4*, !dbg !261, !verifier.code !56
  call void @llvm.dbg.value(metadata %struct.L4* %4, metadata !262, metadata !DIExpression()), !dbg !259, !verifier.code !56
  %5 = call i8* @zalloc_or_die(i32 119), !dbg !263, !verifier.code !56
  %6 = bitcast i8* %5 to %struct.L5*, !dbg !263, !verifier.code !56
  %7 = getelementptr inbounds %struct.L4, %struct.L4* %4, i32 0, i32 2, !dbg !264, !verifier.code !56
  store %struct.L5* %6, %struct.L5** %7, align 8, !dbg !265, !verifier.code !56
  %8 = bitcast %struct.L4* %4 to i8*, !dbg !266, !verifier.code !56
  %9 = getelementptr inbounds %struct.L4, %struct.L4* %4, i32 0, i32 2, !dbg !267, !verifier.code !56
  %10 = load %struct.L5*, %struct.L5** %9, align 8, !dbg !267, !verifier.code !56
  %11 = bitcast %struct.L5* %10 to i8**, !dbg !268, !verifier.code !56
  store i8* %8, i8** %11, align 8, !dbg !269, !verifier.code !56
  %12 = bitcast i8* %1 to %struct.L3**, !dbg !270, !verifier.code !56
  %13 = getelementptr inbounds %struct.L4, %struct.L4* %4, i32 0, i32 0, !dbg !271, !verifier.code !56
  store %struct.L3** %12, %struct.L3*** %13, align 8, !dbg !272, !verifier.code !56
  %14 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !273, !verifier.code !56
  %15 = getelementptr inbounds %struct.L4, %struct.L4* %4, i32 0, i32 1, !dbg !274, !verifier.code !56
  store %struct.L4* %14, %struct.L4** %15, align 8, !dbg !275, !verifier.code !56
  store %struct.L4* %4, %struct.L4** %0, align 8, !dbg !276, !verifier.code !56
  ret void, !dbg !277, !verifier.code !56
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i32 %0, i32 %1) #0 !dbg !278 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !282, metadata !DIExpression()), !dbg !283, !verifier.code !56
  call void @llvm.dbg.value(metadata i32 %1, metadata !284, metadata !DIExpression()), !dbg !283, !verifier.code !56
  %3 = mul i32 %0, %1, !dbg !285, !verifier.code !56
  %4 = call noalias i8* @malloc(i32 %3) #6, !dbg !286, !verifier.code !56
  call void @llvm.dbg.value(metadata i8* %4, metadata !287, metadata !DIExpression()), !dbg !283, !verifier.code !56
  %5 = mul i32 %0, %1, !dbg !288, !verifier.code !56
  %6 = call i8* @memset(i8* %4, i32 0, i32 %5) #6, !dbg !289, !verifier.code !56
  ret i8* %6, !dbg !290, !verifier.code !56
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
!llvm.ident = !{!46}
!llvm.module.flags = !{!47, !48, !49}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 776, type: !13, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 774, type: !4, scopeLine: 775, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0237.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, retainedTypes: !9, globals: !12, splitDebugInlining: false, nameTableKind: None)
!8 = !{}
!9 = !{!10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!12 = !{!0}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L0", file: !3, line: 665, size: 128, elements: !15)
!15 = !{!16, !17}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !3, line: 666, baseType: !13, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !14, file: !3, line: 667, baseType: !18, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L1", file: !3, line: 660, size: 192, elements: !20)
!20 = !{!21, !44, !45}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !19, file: !3, line: 661, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L2", file: !3, line: 655, size: 192, elements: !24)
!24 = !{!25, !27, !28}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !23, file: !3, line: 656, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !23, file: !3, line: 657, baseType: !22, size: 64, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !23, file: !3, line: 658, baseType: !29, size: 64, offset: 128)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L3", file: !3, line: 650, size: 192, elements: !31)
!31 = !{!32, !42, !43}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !30, file: !3, line: 651, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L4", file: !3, line: 645, size: 192, elements: !35)
!35 = !{!36, !38, !39}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !34, file: !3, line: 646, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !34, file: !3, line: 647, baseType: !33, size: 64, offset: 64)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !34, file: !3, line: 648, baseType: !40, size: 64, offset: 128)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = !DICompositeType(tag: DW_TAG_structure_type, name: "L5", file: !3, line: 648, flags: DIFlagFwdDecl)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !30, file: !3, line: 652, baseType: !29, size: 64, offset: 64)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !30, file: !3, line: 653, baseType: !37, size: 64, offset: 128)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !19, file: !3, line: 662, baseType: !18, size: 64, offset: 64)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !19, file: !3, line: 663, baseType: !26, size: 64, offset: 128)
!46 = !{!"clang version 10.0.0-4ubuntu1 "}
!47 = !{i32 7, !"Dwarf Version", i32 4}
!48 = !{i32 2, !"Debug Info Version", i32 3}
!49 = !{i32 1, !"wchar_size", i32 4}
!50 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 12, type: !51, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!51 = !DISubroutineType(types: !52)
!52 = !{null}
!53 = !DILocation(line: 12, column: 83, scope: !54)
!54 = distinct !DILexicalBlock(scope: !55, file: !3, line: 12, column: 73)
!55 = distinct !DILexicalBlock(scope: !50, file: !3, line: 12, column: 67)
!56 = !{i1 false}
!57 = !DILocation(line: 777, column: 5, scope: !2)
!58 = !DILocation(line: 778, column: 9, scope: !2)
!59 = !DILocation(line: 779, column: 12, scope: !2)
!60 = !{i1 true}
!61 = distinct !{!61, !57, !62}
!62 = !DILocation(line: 779, column: 35, scope: !2)
!63 = !DILocation(line: 780, column: 16, scope: !2)
!64 = !DILocation(line: 780, column: 5, scope: !2)
!65 = !DILocation(line: 781, column: 1, scope: !2)
!66 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 715, type: !67, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!67 = !DISubroutineType(types: !68)
!68 = !{null, !69}
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!70 = !DILocalVariable(name: "list", arg: 1, scope: !66, file: !3, line: 715, type: !69)
!71 = !DILocation(line: 0, scope: !66)
!72 = !DILocation(line: 717, column: 23, scope: !66)
!73 = !DILocalVariable(name: "item", scope: !66, file: !3, line: 717, type: !13)
!74 = !DILocation(line: 718, column: 5, scope: !66)
!75 = !DILocation(line: 719, column: 26, scope: !66)
!76 = !DILocation(line: 719, column: 9, scope: !66)
!77 = !DILocation(line: 720, column: 12, scope: !66)
!78 = distinct !{!78, !74, !79}
!79 = !DILocation(line: 720, column: 35, scope: !66)
!80 = !DILocation(line: 721, column: 18, scope: !66)
!81 = !DILocation(line: 721, column: 11, scope: !66)
!82 = !DILocation(line: 721, column: 16, scope: !66)
!83 = !DILocation(line: 722, column: 11, scope: !66)
!84 = !DILocation(line: 723, column: 1, scope: !66)
!85 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 764, type: !86, scopeLine: 765, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !13}
!88 = !DILocalVariable(name: "list", arg: 1, scope: !85, file: !3, line: 764, type: !13)
!89 = !DILocation(line: 0, scope: !85)
!90 = !DILocation(line: 766, column: 5, scope: !85)
!91 = !DILocation(line: 767, column: 26, scope: !92)
!92 = distinct !DILexicalBlock(scope: !85, file: !3, line: 766, column: 8)
!93 = !DILocation(line: 767, column: 9, scope: !92)
!94 = !DILocation(line: 768, column: 33, scope: !92)
!95 = !DILocalVariable(name: "next", scope: !92, file: !3, line: 768, type: !13)
!96 = !DILocation(line: 0, scope: !92)
!97 = !DILocation(line: 769, column: 14, scope: !92)
!98 = !DILocation(line: 769, column: 9, scope: !92)
!99 = !DILocation(line: 771, column: 5, scope: !92)
!100 = distinct !{!100, !90, !101}
!101 = !DILocation(line: 772, column: 16, scope: !85)
!102 = !DILocation(line: 773, column: 1, scope: !85)
!103 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 754, type: !104, scopeLine: 755, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!104 = !DISubroutineType(types: !105)
!105 = !{null, !18}
!106 = !DILocalVariable(name: "list", arg: 1, scope: !103, file: !3, line: 754, type: !18)
!107 = !DILocation(line: 0, scope: !103)
!108 = !DILocation(line: 756, column: 5, scope: !103)
!109 = !DILocation(line: 757, column: 26, scope: !110)
!110 = distinct !DILexicalBlock(scope: !103, file: !3, line: 756, column: 8)
!111 = !DILocation(line: 757, column: 9, scope: !110)
!112 = !DILocation(line: 758, column: 33, scope: !110)
!113 = !DILocalVariable(name: "next", scope: !110, file: !3, line: 758, type: !18)
!114 = !DILocation(line: 0, scope: !110)
!115 = !DILocation(line: 759, column: 14, scope: !110)
!116 = !DILocation(line: 759, column: 9, scope: !110)
!117 = !DILocation(line: 761, column: 5, scope: !110)
!118 = distinct !{!118, !108, !119}
!119 = !DILocation(line: 762, column: 16, scope: !103)
!120 = !DILocation(line: 763, column: 1, scope: !103)
!121 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 744, type: !122, scopeLine: 745, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!122 = !DISubroutineType(types: !123)
!123 = !{null, !22}
!124 = !DILocalVariable(name: "list", arg: 1, scope: !121, file: !3, line: 744, type: !22)
!125 = !DILocation(line: 0, scope: !121)
!126 = !DILocation(line: 746, column: 5, scope: !121)
!127 = !DILocation(line: 747, column: 26, scope: !128)
!128 = distinct !DILexicalBlock(scope: !121, file: !3, line: 746, column: 8)
!129 = !DILocation(line: 747, column: 9, scope: !128)
!130 = !DILocation(line: 748, column: 33, scope: !128)
!131 = !DILocalVariable(name: "next", scope: !128, file: !3, line: 748, type: !22)
!132 = !DILocation(line: 0, scope: !128)
!133 = !DILocation(line: 749, column: 14, scope: !128)
!134 = !DILocation(line: 749, column: 9, scope: !128)
!135 = !DILocation(line: 751, column: 5, scope: !128)
!136 = distinct !{!136, !126, !137}
!137 = !DILocation(line: 752, column: 16, scope: !121)
!138 = !DILocation(line: 753, column: 1, scope: !121)
!139 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 734, type: !140, scopeLine: 735, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!140 = !DISubroutineType(types: !141)
!141 = !{null, !29}
!142 = !DILocalVariable(name: "list", arg: 1, scope: !139, file: !3, line: 734, type: !29)
!143 = !DILocation(line: 0, scope: !139)
!144 = !DILocation(line: 736, column: 5, scope: !139)
!145 = !DILocation(line: 737, column: 26, scope: !146)
!146 = distinct !DILexicalBlock(scope: !139, file: !3, line: 736, column: 8)
!147 = !DILocation(line: 737, column: 9, scope: !146)
!148 = !DILocation(line: 738, column: 33, scope: !146)
!149 = !DILocalVariable(name: "next", scope: !146, file: !3, line: 738, type: !29)
!150 = !DILocation(line: 0, scope: !146)
!151 = !DILocation(line: 739, column: 14, scope: !146)
!152 = !DILocation(line: 739, column: 9, scope: !146)
!153 = !DILocation(line: 741, column: 5, scope: !146)
!154 = distinct !{!154, !144, !155}
!155 = !DILocation(line: 742, column: 16, scope: !139)
!156 = !DILocation(line: 743, column: 1, scope: !139)
!157 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 724, type: !158, scopeLine: 725, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!158 = !DISubroutineType(types: !159)
!159 = !{null, !33}
!160 = !DILocalVariable(name: "list", arg: 1, scope: !157, file: !3, line: 724, type: !33)
!161 = !DILocation(line: 0, scope: !157)
!162 = !DILocation(line: 726, column: 5, scope: !157)
!163 = !DILocation(line: 727, column: 20, scope: !164)
!164 = distinct !DILexicalBlock(scope: !157, file: !3, line: 726, column: 8)
!165 = !DILocation(line: 727, column: 14, scope: !164)
!166 = !DILocation(line: 727, column: 9, scope: !164)
!167 = !DILocation(line: 728, column: 33, scope: !164)
!168 = !DILocalVariable(name: "next", scope: !164, file: !3, line: 728, type: !33)
!169 = !DILocation(line: 0, scope: !164)
!170 = !DILocation(line: 729, column: 14, scope: !164)
!171 = !DILocation(line: 729, column: 9, scope: !164)
!172 = !DILocation(line: 731, column: 5, scope: !164)
!173 = distinct !{!173, !162, !174}
!174 = !DILocation(line: 732, column: 16, scope: !157)
!175 = !DILocation(line: 733, column: 1, scope: !157)
!176 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 669, type: !177, scopeLine: 670, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!177 = !DISubroutineType(types: !178)
!178 = !{!11, !179}
!179 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!180 = !DILocalVariable(name: "size", arg: 1, scope: !176, file: !3, line: 669, type: !179)
!181 = !DILocation(line: 0, scope: !176)
!182 = !DILocation(line: 671, column: 17, scope: !176)
!183 = !DILocalVariable(name: "ptr", scope: !176, file: !3, line: 671, type: !11)
!184 = !DILocation(line: 672, column: 9, scope: !185)
!185 = distinct !DILexicalBlock(scope: !176, file: !3, line: 672, column: 9)
!186 = !DILocation(line: 672, column: 9, scope: !176)
!187 = !DILocation(line: 673, column: 9, scope: !185)
!188 = !DILocation(line: 674, column: 5, scope: !176)
!189 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 705, type: !190, scopeLine: 706, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!190 = !DISubroutineType(types: !191)
!191 = !{null, !26}
!192 = !DILocalVariable(name: "list", arg: 1, scope: !189, file: !3, line: 705, type: !26)
!193 = !DILocation(line: 0, scope: !189)
!194 = !DILocation(line: 707, column: 23, scope: !189)
!195 = !DILocalVariable(name: "item", scope: !189, file: !3, line: 707, type: !18)
!196 = !DILocation(line: 708, column: 5, scope: !189)
!197 = !DILocation(line: 709, column: 26, scope: !189)
!198 = !DILocation(line: 709, column: 32, scope: !189)
!199 = !DILocation(line: 709, column: 9, scope: !189)
!200 = !DILocation(line: 710, column: 12, scope: !189)
!201 = distinct !{!201, !196, !202}
!202 = !DILocation(line: 710, column: 35, scope: !189)
!203 = !DILocation(line: 711, column: 11, scope: !189)
!204 = !DILocation(line: 711, column: 17, scope: !189)
!205 = !DILocation(line: 712, column: 18, scope: !189)
!206 = !DILocation(line: 712, column: 11, scope: !189)
!207 = !DILocation(line: 712, column: 16, scope: !189)
!208 = !DILocation(line: 713, column: 11, scope: !189)
!209 = !DILocation(line: 714, column: 1, scope: !189)
!210 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 695, type: !211, scopeLine: 696, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!211 = !DISubroutineType(types: !212)
!212 = !{null, !213, !11}
!213 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!214 = !DILocalVariable(name: "list", arg: 1, scope: !210, file: !3, line: 695, type: !213)
!215 = !DILocation(line: 0, scope: !210)
!216 = !DILocalVariable(name: "owner", arg: 2, scope: !210, file: !3, line: 695, type: !11)
!217 = !DILocation(line: 697, column: 23, scope: !210)
!218 = !DILocalVariable(name: "item", scope: !210, file: !3, line: 697, type: !22)
!219 = !DILocation(line: 698, column: 5, scope: !210)
!220 = !DILocation(line: 699, column: 26, scope: !210)
!221 = !DILocation(line: 699, column: 9, scope: !210)
!222 = !DILocation(line: 700, column: 12, scope: !210)
!223 = distinct !{!223, !219, !224}
!224 = !DILocation(line: 700, column: 35, scope: !210)
!225 = !DILocation(line: 701, column: 19, scope: !210)
!226 = !DILocation(line: 701, column: 11, scope: !210)
!227 = !DILocation(line: 701, column: 17, scope: !210)
!228 = !DILocation(line: 702, column: 18, scope: !210)
!229 = !DILocation(line: 702, column: 11, scope: !210)
!230 = !DILocation(line: 702, column: 16, scope: !210)
!231 = !DILocation(line: 703, column: 11, scope: !210)
!232 = !DILocation(line: 704, column: 1, scope: !210)
!233 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 685, type: !234, scopeLine: 686, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!234 = !DISubroutineType(types: !235)
!235 = !{null, !37}
!236 = !DILocalVariable(name: "list", arg: 1, scope: !233, file: !3, line: 685, type: !37)
!237 = !DILocation(line: 0, scope: !233)
!238 = !DILocation(line: 687, column: 23, scope: !233)
!239 = !DILocalVariable(name: "item", scope: !233, file: !3, line: 687, type: !29)
!240 = !DILocation(line: 688, column: 5, scope: !233)
!241 = !DILocation(line: 689, column: 26, scope: !233)
!242 = !DILocation(line: 689, column: 32, scope: !233)
!243 = !DILocation(line: 689, column: 9, scope: !233)
!244 = !DILocation(line: 690, column: 12, scope: !233)
!245 = distinct !{!245, !240, !246}
!246 = !DILocation(line: 690, column: 35, scope: !233)
!247 = !DILocation(line: 691, column: 11, scope: !233)
!248 = !DILocation(line: 691, column: 17, scope: !233)
!249 = !DILocation(line: 692, column: 18, scope: !233)
!250 = !DILocation(line: 692, column: 11, scope: !233)
!251 = !DILocation(line: 692, column: 16, scope: !233)
!252 = !DILocation(line: 693, column: 11, scope: !233)
!253 = !DILocation(line: 694, column: 1, scope: !233)
!254 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 676, type: !255, scopeLine: 677, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!255 = !DISubroutineType(types: !256)
!256 = !{null, !257, !11}
!257 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!258 = !DILocalVariable(name: "list", arg: 1, scope: !254, file: !3, line: 676, type: !257)
!259 = !DILocation(line: 0, scope: !254)
!260 = !DILocalVariable(name: "owner", arg: 2, scope: !254, file: !3, line: 676, type: !11)
!261 = !DILocation(line: 678, column: 23, scope: !254)
!262 = !DILocalVariable(name: "item", scope: !254, file: !3, line: 678, type: !33)
!263 = !DILocation(line: 679, column: 18, scope: !254)
!264 = !DILocation(line: 679, column: 11, scope: !254)
!265 = !DILocation(line: 679, column: 16, scope: !254)
!266 = !DILocation(line: 680, column: 30, scope: !254)
!267 = !DILocation(line: 680, column: 22, scope: !254)
!268 = !DILocation(line: 680, column: 5, scope: !254)
!269 = !DILocation(line: 680, column: 28, scope: !254)
!270 = !DILocation(line: 681, column: 19, scope: !254)
!271 = !DILocation(line: 681, column: 11, scope: !254)
!272 = !DILocation(line: 681, column: 17, scope: !254)
!273 = !DILocation(line: 682, column: 18, scope: !254)
!274 = !DILocation(line: 682, column: 11, scope: !254)
!275 = !DILocation(line: 682, column: 16, scope: !254)
!276 = !DILocation(line: 683, column: 11, scope: !254)
!277 = !DILocation(line: 684, column: 1, scope: !254)
!278 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 640, type: !279, scopeLine: 640, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!279 = !DISubroutineType(types: !280)
!280 = !{!11, !281, !281}
!281 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 13, baseType: !179)
!282 = !DILocalVariable(name: "nmemb", arg: 1, scope: !278, file: !3, line: 640, type: !281)
!283 = !DILocation(line: 0, scope: !278)
!284 = !DILocalVariable(name: "size", arg: 2, scope: !278, file: !3, line: 640, type: !281)
!285 = !DILocation(line: 641, column: 30, scope: !278)
!286 = !DILocation(line: 641, column: 17, scope: !278)
!287 = !DILocalVariable(name: "ptr", scope: !278, file: !3, line: 641, type: !11)
!288 = !DILocation(line: 642, column: 33, scope: !278)
!289 = !DILocation(line: 642, column: 12, scope: !278)
!290 = !DILocation(line: 642, column: 5, scope: !278)
