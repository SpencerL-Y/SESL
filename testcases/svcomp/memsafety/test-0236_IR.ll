; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/b-ltopr2m3.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.L0 = type { %struct.L0**, %struct.L0*, %struct.L1* }
%struct.L1 = type { %struct.L2*, %struct.L1*, %struct.L1** }
%struct.L2 = type { %struct.L2**, %struct.L2*, %struct.L3* }
%struct.L3 = type { %struct.L4*, %struct.L3*, %struct.L3** }
%struct.L4 = type { %struct.L4**, %struct.L4*, %struct.L5* }
%struct.L5 = type opaque

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"svcomp/memsafety/test-0236.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !54 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !57, !verifier.code !60
  unreachable, !dbg !57, !verifier.code !60
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  br label %1, !dbg !61, !verifier.code !60

1:                                                ; preds = %2, %0
  call void @l0_insert(%struct.L0** @main.list), !dbg !62, !verifier.code !60
  br label %2, !dbg !62, !verifier.code !60

2:                                                ; preds = %1
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !63, !verifier.code !64
  %4 = icmp ne i32 %3, 0, !dbg !62, !verifier.code !60
  br i1 %4, label %1, label %5, !dbg !62, !llvm.loop !65, !verifier.code !60

5:                                                ; preds = %2
  %6 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !67, !verifier.code !60
  call void @l0_destroy(%struct.L0* %6), !dbg !68, !verifier.code !60
  ret i32 0, !dbg !69, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !70 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !60
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !75, !verifier.code !60
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !75, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !76, metadata !DIExpression()), !dbg !74, !verifier.code !60
  br label %4, !dbg !77, !verifier.code !60

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 2, !dbg !78, !verifier.code !60
  call void @l1_insert(%struct.L1** %5), !dbg !79, !verifier.code !60
  br label %6, !dbg !79, !verifier.code !60

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !80, !verifier.code !64
  %8 = icmp ne i32 %7, 0, !dbg !79, !verifier.code !60
  br i1 %8, label %4, label %9, !dbg !79, !llvm.loop !81, !verifier.code !60

9:                                                ; preds = %6
  %10 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !83, !verifier.code !60
  store %struct.L0** %0, %struct.L0*** %10, align 8, !dbg !84, !verifier.code !60
  %11 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !85, !verifier.code !60
  %12 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !86, !verifier.code !60
  store %struct.L0* %11, %struct.L0** %12, align 8, !dbg !87, !verifier.code !60
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !88, !verifier.code !60
  ret void, !dbg !89, !verifier.code !60
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0) #0 !dbg !90 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !60
  br label %2, !dbg !95, !verifier.code !60

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L0* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !60
  %3 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 2, !dbg !96, !verifier.code !60
  %4 = load %struct.L1*, %struct.L1** %3, align 8, !dbg !96, !verifier.code !60
  call void @l1_destroy(%struct.L1* %4), !dbg !98, !verifier.code !60
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !99, !verifier.code !60
  %6 = load %struct.L0*, %struct.L0** %5, align 8, !dbg !99, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !100, metadata !DIExpression()), !dbg !101, !verifier.code !60
  %7 = bitcast %struct.L0* %.0 to i8*, !dbg !102, !verifier.code !60
  call void @free(i8* %7) #7, !dbg !103, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !60
  br label %8, !dbg !104, !verifier.code !60

8:                                                ; preds = %2
  %9 = icmp ne %struct.L0* %6, null, !dbg !104, !verifier.code !60
  br i1 %9, label %forwarder, label %10, !dbg !104, !llvm.loop !105, !verifier.code !60

10:                                               ; preds = %8
  ret void, !dbg !107, !verifier.code !60

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !60
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0) #0 !dbg !108 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !111, metadata !DIExpression()), !dbg !112, !verifier.code !60
  br label %2, !dbg !113, !verifier.code !60

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L1* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !111, metadata !DIExpression()), !dbg !112, !verifier.code !60
  %3 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !114, !verifier.code !60
  %4 = load %struct.L2*, %struct.L2** %3, align 8, !dbg !114, !verifier.code !60
  call void @l2_destroy(%struct.L2* %4), !dbg !116, !verifier.code !60
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !117, !verifier.code !60
  %6 = load %struct.L1*, %struct.L1** %5, align 8, !dbg !117, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !118, metadata !DIExpression()), !dbg !119, !verifier.code !60
  %7 = bitcast %struct.L1* %.0 to i8*, !dbg !120, !verifier.code !60
  call void @free(i8* %7) #7, !dbg !121, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !111, metadata !DIExpression()), !dbg !112, !verifier.code !60
  br label %8, !dbg !122, !verifier.code !60

8:                                                ; preds = %2
  %9 = icmp ne %struct.L1* %6, null, !dbg !122, !verifier.code !60
  br i1 %9, label %forwarder, label %10, !dbg !122, !llvm.loop !123, !verifier.code !60

10:                                               ; preds = %8
  ret void, !dbg !125, !verifier.code !60

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !60
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 !dbg !126 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !60
  br label %2, !dbg !131, !verifier.code !60

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L2* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !60
  %3 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 2, !dbg !132, !verifier.code !60
  %4 = load %struct.L3*, %struct.L3** %3, align 8, !dbg !132, !verifier.code !60
  call void @l3_destroy(%struct.L3* %4), !dbg !134, !verifier.code !60
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !135, !verifier.code !60
  %6 = load %struct.L2*, %struct.L2** %5, align 8, !dbg !135, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !136, metadata !DIExpression()), !dbg !137, !verifier.code !60
  %7 = bitcast %struct.L2* %.0 to i8*, !dbg !138, !verifier.code !60
  call void @free(i8* %7) #7, !dbg !139, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !129, metadata !DIExpression()), !dbg !130, !verifier.code !60
  br label %8, !dbg !140, !verifier.code !60

8:                                                ; preds = %2
  %9 = icmp ne %struct.L2* %6, null, !dbg !140, !verifier.code !60
  br i1 %9, label %forwarder, label %10, !dbg !140, !llvm.loop !141, !verifier.code !60

10:                                               ; preds = %8
  ret void, !dbg !143, !verifier.code !60

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0) #0 !dbg !144 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !147, metadata !DIExpression()), !dbg !148, !verifier.code !60
  br label %2, !dbg !149, !verifier.code !60

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L3* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !147, metadata !DIExpression()), !dbg !148, !verifier.code !60
  %3 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !150, !verifier.code !60
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !150, !verifier.code !60
  call void @l4_destroy(%struct.L4* %4), !dbg !152, !verifier.code !60
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !153, !verifier.code !60
  %6 = load %struct.L3*, %struct.L3** %5, align 8, !dbg !153, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !154, metadata !DIExpression()), !dbg !155, !verifier.code !60
  %7 = bitcast %struct.L3* %.0 to i8*, !dbg !156, !verifier.code !60
  call void @free(i8* %7) #7, !dbg !157, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !147, metadata !DIExpression()), !dbg !148, !verifier.code !60
  br label %8, !dbg !158, !verifier.code !60

8:                                                ; preds = %2
  %9 = icmp ne %struct.L3* %6, null, !dbg !158, !verifier.code !60
  br i1 %9, label %forwarder, label %10, !dbg !158, !llvm.loop !159, !verifier.code !60

10:                                               ; preds = %8
  ret void, !dbg !161, !verifier.code !60

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0) #0 !dbg !162 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !165, metadata !DIExpression()), !dbg !166, !verifier.code !60
  br label %2, !dbg !167, !verifier.code !60

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L4* [ %0, %1 ], [ %7, %forwarder ], !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !165, metadata !DIExpression()), !dbg !166, !verifier.code !60
  %3 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 2, !dbg !168, !verifier.code !60
  %4 = load %struct.L5*, %struct.L5** %3, align 8, !dbg !168, !verifier.code !60
  %5 = bitcast %struct.L5* %4 to i8*, !dbg !170, !verifier.code !60
  call void @free(i8* %5) #7, !dbg !171, !verifier.code !60
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !172, !verifier.code !60
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !172, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !173, metadata !DIExpression()), !dbg !174, !verifier.code !60
  %8 = bitcast %struct.L4* %.0 to i8*, !dbg !175, !verifier.code !60
  call void @free(i8* %8) #7, !dbg !176, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L4* %7, metadata !165, metadata !DIExpression()), !dbg !166, !verifier.code !60
  br label %9, !dbg !177, !verifier.code !60

9:                                                ; preds = %2
  %10 = icmp ne %struct.L4* %7, null, !dbg !177, !verifier.code !60
  br i1 %10, label %forwarder, label %11, !dbg !177, !llvm.loop !178, !verifier.code !60

11:                                               ; preds = %9
  ret void, !dbg !180, !verifier.code !60

forwarder:                                        ; preds = %9
  br label %2, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !181 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !185, metadata !DIExpression()), !dbg !186, !verifier.code !60
  %2 = zext i32 %0 to i64, !dbg !187, !verifier.code !60
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !188, !verifier.code !60
  call void @llvm.dbg.value(metadata i8* %3, metadata !189, metadata !DIExpression()), !dbg !186, !verifier.code !60
  %4 = icmp ne i8* %3, null, !dbg !190, !verifier.code !60
  br i1 %4, label %5, label %6, !dbg !192, !verifier.code !60

5:                                                ; preds = %1
  ret i8* %3, !dbg !193, !verifier.code !60

6:                                                ; preds = %1
  call void @abort() #6, !dbg !194, !verifier.code !60
  unreachable, !dbg !194, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !195 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !198, metadata !DIExpression()), !dbg !199, !verifier.code !60
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !200, !verifier.code !60
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !200, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !201, metadata !DIExpression()), !dbg !199, !verifier.code !60
  br label %4, !dbg !202, !verifier.code !60

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !203, !verifier.code !60
  call void @l2_insert(%struct.L2** %5), !dbg !204, !verifier.code !60
  br label %6, !dbg !204, !verifier.code !60

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !205, !verifier.code !64
  %8 = icmp ne i32 %7, 0, !dbg !204, !verifier.code !60
  br i1 %8, label %4, label %9, !dbg !204, !llvm.loop !206, !verifier.code !60

9:                                                ; preds = %6
  %10 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 2, !dbg !208, !verifier.code !60
  store %struct.L1** %0, %struct.L1*** %10, align 8, !dbg !209, !verifier.code !60
  %11 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !210, !verifier.code !60
  %12 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !211, !verifier.code !60
  store %struct.L1* %11, %struct.L1** %12, align 8, !dbg !212, !verifier.code !60
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !213, !verifier.code !60
  ret void, !dbg !214, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !215 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !218, metadata !DIExpression()), !dbg !219, !verifier.code !60
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !220, !verifier.code !60
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !220, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !221, metadata !DIExpression()), !dbg !219, !verifier.code !60
  br label %4, !dbg !222, !verifier.code !60

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 2, !dbg !223, !verifier.code !60
  call void @l3_insert(%struct.L3** %5), !dbg !224, !verifier.code !60
  br label %6, !dbg !224, !verifier.code !60

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !225, !verifier.code !64
  %8 = icmp ne i32 %7, 0, !dbg !224, !verifier.code !60
  br i1 %8, label %4, label %9, !dbg !224, !llvm.loop !226, !verifier.code !60

9:                                                ; preds = %6
  %10 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !228, !verifier.code !60
  store %struct.L2** %0, %struct.L2*** %10, align 8, !dbg !229, !verifier.code !60
  %11 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !230, !verifier.code !60
  %12 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !231, !verifier.code !60
  store %struct.L2* %11, %struct.L2** %12, align 8, !dbg !232, !verifier.code !60
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !233, !verifier.code !60
  ret void, !dbg !234, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !235 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !238, metadata !DIExpression()), !dbg !239, !verifier.code !60
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !240, !verifier.code !60
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !240, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !241, metadata !DIExpression()), !dbg !239, !verifier.code !60
  br label %4, !dbg !242, !verifier.code !60

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !243, !verifier.code !60
  call void @l4_insert(%struct.L4** %5), !dbg !244, !verifier.code !60
  br label %6, !dbg !244, !verifier.code !60

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !245, !verifier.code !64
  %8 = icmp ne i32 %7, 0, !dbg !244, !verifier.code !60
  br i1 %8, label %4, label %9, !dbg !244, !llvm.loop !246, !verifier.code !60

9:                                                ; preds = %6
  %10 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 2, !dbg !248, !verifier.code !60
  store %struct.L3** %0, %struct.L3*** %10, align 8, !dbg !249, !verifier.code !60
  %11 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !250, !verifier.code !60
  %12 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !251, !verifier.code !60
  store %struct.L3* %11, %struct.L3** %12, align 8, !dbg !252, !verifier.code !60
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !253, !verifier.code !60
  ret void, !dbg !254, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !255 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !258, metadata !DIExpression()), !dbg !259, !verifier.code !60
  %2 = call i8* @zalloc_or_die(i32 24), !dbg !260, !verifier.code !60
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !260, !verifier.code !60
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !261, metadata !DIExpression()), !dbg !259, !verifier.code !60
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !262, !verifier.code !60
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !262, !verifier.code !60
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 2, !dbg !263, !verifier.code !60
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !264, !verifier.code !60
  %7 = bitcast %struct.L4* %3 to i8*, !dbg !265, !verifier.code !60
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 2, !dbg !266, !verifier.code !60
  %9 = load %struct.L5*, %struct.L5** %8, align 8, !dbg !266, !verifier.code !60
  %10 = bitcast %struct.L5* %9 to i8**, !dbg !267, !verifier.code !60
  store i8* %7, i8** %10, align 8, !dbg !268, !verifier.code !60
  %11 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !269, !verifier.code !60
  store %struct.L4** %0, %struct.L4*** %11, align 8, !dbg !270, !verifier.code !60
  %12 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !271, !verifier.code !60
  %13 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !272, !verifier.code !60
  store %struct.L4* %12, %struct.L4** %13, align 8, !dbg !273, !verifier.code !60
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !274, !verifier.code !60
  ret void, !dbg !275, !verifier.code !60
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !276 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !282, metadata !DIExpression()), !dbg !283, !verifier.code !60
  call void @llvm.dbg.value(metadata i64 %1, metadata !284, metadata !DIExpression()), !dbg !283, !verifier.code !60
  %3 = mul i64 %0, %1, !dbg !285, !verifier.code !60
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !286, !verifier.code !60
  call void @llvm.dbg.value(metadata i8* %4, metadata !287, metadata !DIExpression()), !dbg !283, !verifier.code !60
  %5 = mul i64 %0, %1, !dbg !288, !verifier.code !60
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !289, !verifier.code !60
  ret i8* %4, !dbg !290, !verifier.code !60
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
!llvm.ident = !{!50}
!llvm.module.flags = !{!51, !52, !53}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 179, type: !13, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 177, type: !4, scopeLine: 178, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "svcomp/memsafety/test-0236.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases")
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
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L0", file: !3, line: 39, size: 192, elements: !15)
!15 = !{!16, !18, !19}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !14, file: !3, line: 40, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !3, line: 41, baseType: !13, size: 64, offset: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !14, file: !3, line: 42, baseType: !20, size: 64, offset: 128)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L1", file: !3, line: 33, size: 192, elements: !22)
!22 = !{!23, !47, !48}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !21, file: !3, line: 34, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L2", file: !3, line: 27, size: 192, elements: !26)
!26 = !{!27, !29, !30}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !25, file: !3, line: 28, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !25, file: !3, line: 29, baseType: !24, size: 64, offset: 64)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !25, file: !3, line: 30, baseType: !31, size: 64, offset: 128)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L3", file: !3, line: 21, size: 192, elements: !33)
!33 = !{!34, !44, !45}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !32, file: !3, line: 22, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!36 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L4", file: !3, line: 15, size: 192, elements: !37)
!37 = !{!38, !40, !41}
!38 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !36, file: !3, line: 16, baseType: !39, size: 64)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !36, file: !3, line: 17, baseType: !35, size: 64, offset: 64)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "down", scope: !36, file: !3, line: 18, baseType: !42, size: 64, offset: 128)
!42 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!43 = !DICompositeType(tag: DW_TAG_structure_type, name: "L5", file: !3, line: 18, flags: DIFlagFwdDecl)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !32, file: !3, line: 23, baseType: !31, size: 64, offset: 64)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !32, file: !3, line: 24, baseType: !46, size: 64, offset: 128)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !21, file: !3, line: 35, baseType: !20, size: 64, offset: 64)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "owner", scope: !21, file: !3, line: 36, baseType: !49, size: 64, offset: 128)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!50 = !{!"clang version 10.0.0-4ubuntu1 "}
!51 = !{i32 7, !"Dwarf Version", i32 4}
!52 = !{i32 2, !"Debug Info Version", i32 3}
!53 = !{i32 1, !"wchar_size", i32 4}
!54 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !55, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!55 = !DISubroutineType(types: !56)
!56 = !{null}
!57 = !DILocation(line: 3, column: 22, scope: !58)
!58 = distinct !DILexicalBlock(scope: !59, file: !3, line: 3, column: 22)
!59 = distinct !DILexicalBlock(scope: !54, file: !3, line: 3, column: 22)
!60 = !{i1 false}
!61 = !DILocation(line: 181, column: 5, scope: !2)
!62 = !DILocation(line: 182, column: 9, scope: !2)
!63 = !DILocation(line: 183, column: 12, scope: !2)
!64 = !{i1 true}
!65 = distinct !{!65, !61, !66}
!66 = !DILocation(line: 183, column: 35, scope: !2)
!67 = !DILocation(line: 185, column: 16, scope: !2)
!68 = !DILocation(line: 185, column: 5, scope: !2)
!69 = !DILocation(line: 186, column: 1, scope: !2)
!70 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 104, type: !71, scopeLine: 105, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !17}
!73 = !DILocalVariable(name: "list", arg: 1, scope: !70, file: !3, line: 104, type: !17)
!74 = !DILocation(line: 0, scope: !70)
!75 = !DILocation(line: 106, column: 23, scope: !70)
!76 = !DILocalVariable(name: "item", scope: !70, file: !3, line: 106, type: !13)
!77 = !DILocation(line: 108, column: 5, scope: !70)
!78 = !DILocation(line: 109, column: 26, scope: !70)
!79 = !DILocation(line: 109, column: 9, scope: !70)
!80 = !DILocation(line: 110, column: 12, scope: !70)
!81 = distinct !{!81, !77, !82}
!82 = !DILocation(line: 110, column: 35, scope: !70)
!83 = !DILocation(line: 112, column: 11, scope: !70)
!84 = !DILocation(line: 112, column: 17, scope: !70)
!85 = !DILocation(line: 113, column: 18, scope: !70)
!86 = !DILocation(line: 113, column: 11, scope: !70)
!87 = !DILocation(line: 113, column: 16, scope: !70)
!88 = !DILocation(line: 114, column: 11, scope: !70)
!89 = !DILocation(line: 115, column: 1, scope: !70)
!90 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 165, type: !91, scopeLine: 166, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!91 = !DISubroutineType(types: !92)
!92 = !{null, !13}
!93 = !DILocalVariable(name: "list", arg: 1, scope: !90, file: !3, line: 165, type: !13)
!94 = !DILocation(line: 0, scope: !90)
!95 = !DILocation(line: 167, column: 5, scope: !90)
!96 = !DILocation(line: 168, column: 26, scope: !97)
!97 = distinct !DILexicalBlock(scope: !90, file: !3, line: 167, column: 8)
!98 = !DILocation(line: 168, column: 9, scope: !97)
!99 = !DILocation(line: 170, column: 33, scope: !97)
!100 = !DILocalVariable(name: "next", scope: !97, file: !3, line: 170, type: !13)
!101 = !DILocation(line: 0, scope: !97)
!102 = !DILocation(line: 171, column: 14, scope: !97)
!103 = !DILocation(line: 171, column: 9, scope: !97)
!104 = !DILocation(line: 173, column: 5, scope: !97)
!105 = distinct !{!105, !95, !106}
!106 = !DILocation(line: 174, column: 16, scope: !90)
!107 = !DILocation(line: 175, column: 1, scope: !90)
!108 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 153, type: !109, scopeLine: 154, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!109 = !DISubroutineType(types: !110)
!110 = !{null, !20}
!111 = !DILocalVariable(name: "list", arg: 1, scope: !108, file: !3, line: 153, type: !20)
!112 = !DILocation(line: 0, scope: !108)
!113 = !DILocation(line: 155, column: 5, scope: !108)
!114 = !DILocation(line: 156, column: 26, scope: !115)
!115 = distinct !DILexicalBlock(scope: !108, file: !3, line: 155, column: 8)
!116 = !DILocation(line: 156, column: 9, scope: !115)
!117 = !DILocation(line: 158, column: 33, scope: !115)
!118 = !DILocalVariable(name: "next", scope: !115, file: !3, line: 158, type: !20)
!119 = !DILocation(line: 0, scope: !115)
!120 = !DILocation(line: 159, column: 14, scope: !115)
!121 = !DILocation(line: 159, column: 9, scope: !115)
!122 = !DILocation(line: 161, column: 5, scope: !115)
!123 = distinct !{!123, !113, !124}
!124 = !DILocation(line: 162, column: 16, scope: !108)
!125 = !DILocation(line: 163, column: 1, scope: !108)
!126 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 141, type: !127, scopeLine: 142, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!127 = !DISubroutineType(types: !128)
!128 = !{null, !24}
!129 = !DILocalVariable(name: "list", arg: 1, scope: !126, file: !3, line: 141, type: !24)
!130 = !DILocation(line: 0, scope: !126)
!131 = !DILocation(line: 143, column: 5, scope: !126)
!132 = !DILocation(line: 144, column: 26, scope: !133)
!133 = distinct !DILexicalBlock(scope: !126, file: !3, line: 143, column: 8)
!134 = !DILocation(line: 144, column: 9, scope: !133)
!135 = !DILocation(line: 146, column: 33, scope: !133)
!136 = !DILocalVariable(name: "next", scope: !133, file: !3, line: 146, type: !24)
!137 = !DILocation(line: 0, scope: !133)
!138 = !DILocation(line: 147, column: 14, scope: !133)
!139 = !DILocation(line: 147, column: 9, scope: !133)
!140 = !DILocation(line: 149, column: 5, scope: !133)
!141 = distinct !{!141, !131, !142}
!142 = !DILocation(line: 150, column: 16, scope: !126)
!143 = !DILocation(line: 151, column: 1, scope: !126)
!144 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 129, type: !145, scopeLine: 130, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!145 = !DISubroutineType(types: !146)
!146 = !{null, !31}
!147 = !DILocalVariable(name: "list", arg: 1, scope: !144, file: !3, line: 129, type: !31)
!148 = !DILocation(line: 0, scope: !144)
!149 = !DILocation(line: 131, column: 5, scope: !144)
!150 = !DILocation(line: 132, column: 26, scope: !151)
!151 = distinct !DILexicalBlock(scope: !144, file: !3, line: 131, column: 8)
!152 = !DILocation(line: 132, column: 9, scope: !151)
!153 = !DILocation(line: 134, column: 33, scope: !151)
!154 = !DILocalVariable(name: "next", scope: !151, file: !3, line: 134, type: !31)
!155 = !DILocation(line: 0, scope: !151)
!156 = !DILocation(line: 135, column: 14, scope: !151)
!157 = !DILocation(line: 135, column: 9, scope: !151)
!158 = !DILocation(line: 137, column: 5, scope: !151)
!159 = distinct !{!159, !149, !160}
!160 = !DILocation(line: 138, column: 16, scope: !144)
!161 = !DILocation(line: 139, column: 1, scope: !144)
!162 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 117, type: !163, scopeLine: 118, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!163 = !DISubroutineType(types: !164)
!164 = !{null, !35}
!165 = !DILocalVariable(name: "list", arg: 1, scope: !162, file: !3, line: 117, type: !35)
!166 = !DILocation(line: 0, scope: !162)
!167 = !DILocation(line: 119, column: 5, scope: !162)
!168 = !DILocation(line: 120, column: 20, scope: !169)
!169 = distinct !DILexicalBlock(scope: !162, file: !3, line: 119, column: 8)
!170 = !DILocation(line: 120, column: 14, scope: !169)
!171 = !DILocation(line: 120, column: 9, scope: !169)
!172 = !DILocation(line: 122, column: 33, scope: !169)
!173 = !DILocalVariable(name: "next", scope: !169, file: !3, line: 122, type: !35)
!174 = !DILocation(line: 0, scope: !169)
!175 = !DILocation(line: 123, column: 14, scope: !169)
!176 = !DILocation(line: 123, column: 9, scope: !169)
!177 = !DILocation(line: 125, column: 5, scope: !169)
!178 = distinct !{!178, !167, !179}
!179 = !DILocation(line: 126, column: 16, scope: !162)
!180 = !DILocation(line: 127, column: 1, scope: !162)
!181 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 45, type: !182, scopeLine: 46, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!182 = !DISubroutineType(types: !183)
!183 = !{!11, !184}
!184 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!185 = !DILocalVariable(name: "size", arg: 1, scope: !181, file: !3, line: 45, type: !184)
!186 = !DILocation(line: 0, scope: !181)
!187 = !DILocation(line: 47, column: 34, scope: !181)
!188 = !DILocation(line: 47, column: 17, scope: !181)
!189 = !DILocalVariable(name: "ptr", scope: !181, file: !3, line: 47, type: !11)
!190 = !DILocation(line: 48, column: 9, scope: !191)
!191 = distinct !DILexicalBlock(scope: !181, file: !3, line: 48, column: 9)
!192 = !DILocation(line: 48, column: 9, scope: !181)
!193 = !DILocation(line: 49, column: 9, scope: !191)
!194 = !DILocation(line: 51, column: 5, scope: !181)
!195 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 91, type: !196, scopeLine: 92, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!196 = !DISubroutineType(types: !197)
!197 = !{null, !49}
!198 = !DILocalVariable(name: "list", arg: 1, scope: !195, file: !3, line: 91, type: !49)
!199 = !DILocation(line: 0, scope: !195)
!200 = !DILocation(line: 93, column: 23, scope: !195)
!201 = !DILocalVariable(name: "item", scope: !195, file: !3, line: 93, type: !20)
!202 = !DILocation(line: 95, column: 5, scope: !195)
!203 = !DILocation(line: 96, column: 26, scope: !195)
!204 = !DILocation(line: 96, column: 9, scope: !195)
!205 = !DILocation(line: 97, column: 12, scope: !195)
!206 = distinct !{!206, !202, !207}
!207 = !DILocation(line: 97, column: 35, scope: !195)
!208 = !DILocation(line: 99, column: 11, scope: !195)
!209 = !DILocation(line: 99, column: 17, scope: !195)
!210 = !DILocation(line: 100, column: 18, scope: !195)
!211 = !DILocation(line: 100, column: 11, scope: !195)
!212 = !DILocation(line: 100, column: 16, scope: !195)
!213 = !DILocation(line: 101, column: 11, scope: !195)
!214 = !DILocation(line: 102, column: 1, scope: !195)
!215 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 78, type: !216, scopeLine: 79, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!216 = !DISubroutineType(types: !217)
!217 = !{null, !28}
!218 = !DILocalVariable(name: "list", arg: 1, scope: !215, file: !3, line: 78, type: !28)
!219 = !DILocation(line: 0, scope: !215)
!220 = !DILocation(line: 80, column: 23, scope: !215)
!221 = !DILocalVariable(name: "item", scope: !215, file: !3, line: 80, type: !24)
!222 = !DILocation(line: 82, column: 5, scope: !215)
!223 = !DILocation(line: 83, column: 26, scope: !215)
!224 = !DILocation(line: 83, column: 9, scope: !215)
!225 = !DILocation(line: 84, column: 12, scope: !215)
!226 = distinct !{!226, !222, !227}
!227 = !DILocation(line: 84, column: 35, scope: !215)
!228 = !DILocation(line: 86, column: 11, scope: !215)
!229 = !DILocation(line: 86, column: 17, scope: !215)
!230 = !DILocation(line: 87, column: 18, scope: !215)
!231 = !DILocation(line: 87, column: 11, scope: !215)
!232 = !DILocation(line: 87, column: 16, scope: !215)
!233 = !DILocation(line: 88, column: 11, scope: !215)
!234 = !DILocation(line: 89, column: 1, scope: !215)
!235 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 65, type: !236, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!236 = !DISubroutineType(types: !237)
!237 = !{null, !46}
!238 = !DILocalVariable(name: "list", arg: 1, scope: !235, file: !3, line: 65, type: !46)
!239 = !DILocation(line: 0, scope: !235)
!240 = !DILocation(line: 67, column: 23, scope: !235)
!241 = !DILocalVariable(name: "item", scope: !235, file: !3, line: 67, type: !31)
!242 = !DILocation(line: 69, column: 5, scope: !235)
!243 = !DILocation(line: 70, column: 26, scope: !235)
!244 = !DILocation(line: 70, column: 9, scope: !235)
!245 = !DILocation(line: 71, column: 12, scope: !235)
!246 = distinct !{!246, !242, !247}
!247 = !DILocation(line: 71, column: 35, scope: !235)
!248 = !DILocation(line: 73, column: 11, scope: !235)
!249 = !DILocation(line: 73, column: 17, scope: !235)
!250 = !DILocation(line: 74, column: 18, scope: !235)
!251 = !DILocation(line: 74, column: 11, scope: !235)
!252 = !DILocation(line: 74, column: 16, scope: !235)
!253 = !DILocation(line: 75, column: 11, scope: !235)
!254 = !DILocation(line: 76, column: 1, scope: !235)
!255 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 54, type: !256, scopeLine: 55, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!256 = !DISubroutineType(types: !257)
!257 = !{null, !39}
!258 = !DILocalVariable(name: "list", arg: 1, scope: !255, file: !3, line: 54, type: !39)
!259 = !DILocation(line: 0, scope: !255)
!260 = !DILocation(line: 56, column: 23, scope: !255)
!261 = !DILocalVariable(name: "item", scope: !255, file: !3, line: 56, type: !35)
!262 = !DILocation(line: 57, column: 18, scope: !255)
!263 = !DILocation(line: 57, column: 11, scope: !255)
!264 = !DILocation(line: 57, column: 16, scope: !255)
!265 = !DILocation(line: 58, column: 30, scope: !255)
!266 = !DILocation(line: 58, column: 22, scope: !255)
!267 = !DILocation(line: 58, column: 5, scope: !255)
!268 = !DILocation(line: 58, column: 28, scope: !255)
!269 = !DILocation(line: 60, column: 11, scope: !255)
!270 = !DILocation(line: 60, column: 17, scope: !255)
!271 = !DILocation(line: 61, column: 18, scope: !255)
!272 = !DILocation(line: 61, column: 11, scope: !255)
!273 = !DILocation(line: 61, column: 16, scope: !255)
!274 = !DILocation(line: 62, column: 11, scope: !255)
!275 = !DILocation(line: 63, column: 1, scope: !255)
!276 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !277, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!277 = !DISubroutineType(types: !278)
!278 = !{!11, !279, !279}
!279 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !280, line: 46, baseType: !281)
!280 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!281 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!282 = !DILocalVariable(name: "nmemb", arg: 1, scope: !276, file: !3, line: 8, type: !279)
!283 = !DILocation(line: 0, scope: !276)
!284 = !DILocalVariable(name: "size", arg: 2, scope: !276, file: !3, line: 8, type: !279)
!285 = !DILocation(line: 9, column: 30, scope: !276)
!286 = !DILocation(line: 9, column: 17, scope: !276)
!287 = !DILocalVariable(name: "ptr", scope: !276, file: !3, line: 9, type: !11)
!288 = !DILocation(line: 10, column: 33, scope: !276)
!289 = !DILocation(line: 10, column: 12, scope: !276)
!290 = !DILocation(line: 10, column: 5, scope: !276)
