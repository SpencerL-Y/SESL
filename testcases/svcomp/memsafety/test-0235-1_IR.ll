; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-3zf_eztg.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.L0 = type { %struct.L0*, %struct.L1* }
%struct.L1 = type { %struct.L2*, %struct.L1* }
%struct.L2 = type { %struct.L2*, %struct.L3* }
%struct.L3 = type { %struct.L4*, %struct.L3* }
%struct.L4 = type { %struct.L4*, %struct.L5* }
%struct.L5 = type opaque

@main.list = internal global %struct.L0* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  br label %1, !dbg !41, !verifier.code !42

1:                                                ; preds = %2, %0
  call void @l0_insert(%struct.L0** @main.list), !dbg !43, !verifier.code !42
  br label %2, !dbg !43, !verifier.code !42

2:                                                ; preds = %1
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !44, !verifier.code !45
  %4 = icmp ne i32 %3, 0, !dbg !43, !verifier.code !42
  br i1 %4, label %1, label %5, !dbg !43, !llvm.loop !46, !verifier.code !42

5:                                                ; preds = %2
  %6 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !48, !verifier.code !42
  call void @l0_destroy(%struct.L0* %6, i32 4), !dbg !49, !verifier.code !42
  %7 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !50, !verifier.code !42
  call void @l0_destroy(%struct.L0* %7, i32 3), !dbg !51, !verifier.code !42
  %8 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !52, !verifier.code !42
  call void @l0_destroy(%struct.L0* %8, i32 2), !dbg !53, !verifier.code !42
  %9 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !54, !verifier.code !42
  call void @l0_destroy(%struct.L0* %9, i32 1), !dbg !55, !verifier.code !42
  %10 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !56, !verifier.code !42
  call void @l0_destroy(%struct.L0* %10, i32 0), !dbg !57, !verifier.code !42
  %11 = load %struct.L0*, %struct.L0** @main.list, align 8, !dbg !58, !verifier.code !42
  %12 = icmp ne %struct.L0* %11, null, !dbg !59, !verifier.code !42
  %13 = xor i1 %12, true, !dbg !59, !verifier.code !42
  %14 = xor i1 %13, true, !dbg !60, !verifier.code !42
  %15 = zext i1 %14 to i32, !dbg !60, !verifier.code !42
  ret i32 %15, !dbg !61, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !62 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !66, metadata !DIExpression()), !dbg !67, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !68, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !68, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !69, metadata !DIExpression()), !dbg !67, !verifier.code !42
  br label %4, !dbg !70, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !71, !verifier.code !42
  call void @l1_insert(%struct.L1** %5), !dbg !72, !verifier.code !42
  br label %6, !dbg !72, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !73, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !72, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !72, !llvm.loop !74, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !76, !verifier.code !42
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !77, !verifier.code !42
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !78, !verifier.code !42
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !79, !verifier.code !42
  ret void, !dbg !80, !verifier.code !42
}

declare dso_local i32 @__VERIFIER_nondet_int() #1

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0, i32 %1) #0 !dbg !81 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !84, metadata !DIExpression()), !dbg !85, !verifier.code !42
  call void @llvm.dbg.value(metadata i32 %1, metadata !86, metadata !DIExpression()), !dbg !85, !verifier.code !42
  br label %3, !dbg !87, !verifier.code !42

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L0* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !84, metadata !DIExpression()), !dbg !85, !verifier.code !42
  %4 = icmp slt i32 0, %1, !dbg !88, !verifier.code !42
  br i1 %4, label %5, label %8, !dbg !91, !verifier.code !42

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !92, !verifier.code !42
  %7 = load %struct.L1*, %struct.L1** %6, align 8, !dbg !92, !verifier.code !42
  call void @l1_destroy(%struct.L1* %7, i32 %1), !dbg !93, !verifier.code !42
  br label %8, !dbg !93, !verifier.code !42

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !94, !verifier.code !42
  %10 = load %struct.L0*, %struct.L0** %9, align 8, !dbg !94, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !95, metadata !DIExpression()), !dbg !96, !verifier.code !42
  %11 = icmp eq i32 0, %1, !dbg !97, !verifier.code !42
  br i1 %11, label %12, label %14, !dbg !99, !verifier.code !42

12:                                               ; preds = %8
  %13 = bitcast %struct.L0* %.0 to i8*, !dbg !100, !verifier.code !42
  call void @free(i8* %13) #6, !dbg !101, !verifier.code !42
  br label %14, !dbg !101, !verifier.code !42

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L0* %10, metadata !84, metadata !DIExpression()), !dbg !85, !verifier.code !42
  br label %15, !dbg !102, !verifier.code !42

15:                                               ; preds = %14
  %16 = icmp ne %struct.L0* %10, null, !dbg !102, !verifier.code !42
  br i1 %16, label %forwarder, label %17, !dbg !102, !llvm.loop !103, !verifier.code !42

17:                                               ; preds = %15
  ret void, !dbg !105, !verifier.code !42

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !42
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0, i32 %1) #0 !dbg !106 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !109, metadata !DIExpression()), !dbg !110, !verifier.code !42
  call void @llvm.dbg.value(metadata i32 %1, metadata !111, metadata !DIExpression()), !dbg !110, !verifier.code !42
  br label %3, !dbg !112, !verifier.code !42

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L1* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !109, metadata !DIExpression()), !dbg !110, !verifier.code !42
  %4 = icmp slt i32 1, %1, !dbg !113, !verifier.code !42
  br i1 %4, label %5, label %8, !dbg !116, !verifier.code !42

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !117, !verifier.code !42
  %7 = load %struct.L2*, %struct.L2** %6, align 8, !dbg !117, !verifier.code !42
  call void @l2_destroy(%struct.L2* %7, i32 %1), !dbg !118, !verifier.code !42
  br label %8, !dbg !118, !verifier.code !42

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !119, !verifier.code !42
  %10 = load %struct.L1*, %struct.L1** %9, align 8, !dbg !119, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !42
  %11 = icmp eq i32 1, %1, !dbg !122, !verifier.code !42
  br i1 %11, label %12, label %14, !dbg !124, !verifier.code !42

12:                                               ; preds = %8
  %13 = bitcast %struct.L1* %.0 to i8*, !dbg !125, !verifier.code !42
  call void @free(i8* %13) #6, !dbg !126, !verifier.code !42
  br label %14, !dbg !126, !verifier.code !42

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L1* %10, metadata !109, metadata !DIExpression()), !dbg !110, !verifier.code !42
  br label %15, !dbg !127, !verifier.code !42

15:                                               ; preds = %14
  %16 = icmp ne %struct.L1* %10, null, !dbg !127, !verifier.code !42
  br i1 %16, label %forwarder, label %17, !dbg !127, !llvm.loop !128, !verifier.code !42

17:                                               ; preds = %15
  ret void, !dbg !130, !verifier.code !42

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !42
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0, i32 %1) #0 !dbg !131 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !42
  call void @llvm.dbg.value(metadata i32 %1, metadata !136, metadata !DIExpression()), !dbg !135, !verifier.code !42
  br label %3, !dbg !137, !verifier.code !42

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L2* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !42
  %4 = icmp slt i32 2, %1, !dbg !138, !verifier.code !42
  br i1 %4, label %5, label %8, !dbg !141, !verifier.code !42

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !142, !verifier.code !42
  %7 = load %struct.L3*, %struct.L3** %6, align 8, !dbg !142, !verifier.code !42
  call void @l3_destroy(%struct.L3* %7, i32 %1), !dbg !143, !verifier.code !42
  br label %8, !dbg !143, !verifier.code !42

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !144, !verifier.code !42
  %10 = load %struct.L2*, %struct.L2** %9, align 8, !dbg !144, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !42
  %11 = icmp eq i32 2, %1, !dbg !147, !verifier.code !42
  br i1 %11, label %12, label %14, !dbg !149, !verifier.code !42

12:                                               ; preds = %8
  %13 = bitcast %struct.L2* %.0 to i8*, !dbg !150, !verifier.code !42
  call void @free(i8* %13) #6, !dbg !151, !verifier.code !42
  br label %14, !dbg !151, !verifier.code !42

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L2* %10, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !42
  br label %15, !dbg !152, !verifier.code !42

15:                                               ; preds = %14
  %16 = icmp ne %struct.L2* %10, null, !dbg !152, !verifier.code !42
  br i1 %16, label %forwarder, label %17, !dbg !152, !llvm.loop !153, !verifier.code !42

17:                                               ; preds = %15
  ret void, !dbg !155, !verifier.code !42

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0, i32 %1) #0 !dbg !156 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !159, metadata !DIExpression()), !dbg !160, !verifier.code !42
  call void @llvm.dbg.value(metadata i32 %1, metadata !161, metadata !DIExpression()), !dbg !160, !verifier.code !42
  br label %3, !dbg !162, !verifier.code !42

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L3* [ %0, %2 ], [ %10, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !159, metadata !DIExpression()), !dbg !160, !verifier.code !42
  %4 = icmp slt i32 3, %1, !dbg !163, !verifier.code !42
  br i1 %4, label %5, label %8, !dbg !166, !verifier.code !42

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !167, !verifier.code !42
  %7 = load %struct.L4*, %struct.L4** %6, align 8, !dbg !167, !verifier.code !42
  call void @l4_destroy(%struct.L4* %7, i32 %1), !dbg !168, !verifier.code !42
  br label %8, !dbg !168, !verifier.code !42

8:                                                ; preds = %5, %3
  %9 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !169, !verifier.code !42
  %10 = load %struct.L3*, %struct.L3** %9, align 8, !dbg !169, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !170, metadata !DIExpression()), !dbg !171, !verifier.code !42
  %11 = icmp eq i32 3, %1, !dbg !172, !verifier.code !42
  br i1 %11, label %12, label %14, !dbg !174, !verifier.code !42

12:                                               ; preds = %8
  %13 = bitcast %struct.L3* %.0 to i8*, !dbg !175, !verifier.code !42
  call void @free(i8* %13) #6, !dbg !176, !verifier.code !42
  br label %14, !dbg !176, !verifier.code !42

14:                                               ; preds = %12, %8
  call void @llvm.dbg.value(metadata %struct.L3* %10, metadata !159, metadata !DIExpression()), !dbg !160, !verifier.code !42
  br label %15, !dbg !177, !verifier.code !42

15:                                               ; preds = %14
  %16 = icmp ne %struct.L3* %10, null, !dbg !177, !verifier.code !42
  br i1 %16, label %forwarder, label %17, !dbg !177, !llvm.loop !178, !verifier.code !42

17:                                               ; preds = %15
  ret void, !dbg !180, !verifier.code !42

forwarder:                                        ; preds = %15
  br label %3, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0, i32 %1) #0 !dbg !181 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !42
  call void @llvm.dbg.value(metadata i32 %1, metadata !186, metadata !DIExpression()), !dbg !185, !verifier.code !42
  br label %3, !dbg !187, !verifier.code !42

3:                                                ; preds = %forwarder, %2
  %.0 = phi %struct.L4* [ %0, %2 ], [ %11, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !42
  %4 = icmp eq i32 5, %1, !dbg !188, !verifier.code !42
  br i1 %4, label %5, label %9, !dbg !191, !verifier.code !42

5:                                                ; preds = %3
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 1, !dbg !192, !verifier.code !42
  %7 = load %struct.L5*, %struct.L5** %6, align 8, !dbg !192, !verifier.code !42
  %8 = bitcast %struct.L5* %7 to i8*, !dbg !193, !verifier.code !42
  call void @free(i8* %8) #6, !dbg !194, !verifier.code !42
  br label %9, !dbg !194, !verifier.code !42

9:                                                ; preds = %5, %3
  %10 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !195, !verifier.code !42
  %11 = load %struct.L4*, %struct.L4** %10, align 8, !dbg !195, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !196, metadata !DIExpression()), !dbg !197, !verifier.code !42
  %12 = icmp eq i32 4, %1, !dbg !198, !verifier.code !42
  br i1 %12, label %13, label %15, !dbg !200, !verifier.code !42

13:                                               ; preds = %9
  %14 = bitcast %struct.L4* %.0 to i8*, !dbg !201, !verifier.code !42
  call void @free(i8* %14) #6, !dbg !202, !verifier.code !42
  br label %15, !dbg !202, !verifier.code !42

15:                                               ; preds = %13, %9
  call void @llvm.dbg.value(metadata %struct.L4* %11, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !42
  br label %16, !dbg !203, !verifier.code !42

16:                                               ; preds = %15
  %17 = icmp ne %struct.L4* %11, null, !dbg !203, !verifier.code !42
  br i1 %17, label %forwarder, label %18, !dbg !203, !llvm.loop !204, !verifier.code !42

18:                                               ; preds = %16
  ret void, !dbg !206, !verifier.code !42

forwarder:                                        ; preds = %16
  br label %3, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !207 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !212, metadata !DIExpression()), !dbg !213, !verifier.code !42
  %2 = zext i32 %0 to i64, !dbg !214, !verifier.code !42
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !215, !verifier.code !42
  call void @llvm.dbg.value(metadata i8* %3, metadata !216, metadata !DIExpression()), !dbg !213, !verifier.code !42
  %4 = icmp ne i8* %3, null, !dbg !217, !verifier.code !42
  br i1 %4, label %5, label %6, !dbg !219, !verifier.code !42

5:                                                ; preds = %1
  ret i8* %3, !dbg !220, !verifier.code !42

6:                                                ; preds = %1
  call void @abort() #7, !dbg !221, !verifier.code !42
  unreachable, !dbg !221, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !222 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !226, metadata !DIExpression()), !dbg !227, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !228, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !228, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !229, metadata !DIExpression()), !dbg !227, !verifier.code !42
  br label %4, !dbg !230, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !231, !verifier.code !42
  call void @l2_insert(%struct.L2** %5), !dbg !232, !verifier.code !42
  br label %6, !dbg !232, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !233, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !232, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !232, !llvm.loop !234, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !236, !verifier.code !42
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !237, !verifier.code !42
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !238, !verifier.code !42
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !239, !verifier.code !42
  ret void, !dbg !240, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !241 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !245, metadata !DIExpression()), !dbg !246, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !247, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !247, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !248, metadata !DIExpression()), !dbg !246, !verifier.code !42
  br label %4, !dbg !249, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !250, !verifier.code !42
  call void @l3_insert(%struct.L3** %5), !dbg !251, !verifier.code !42
  br label %6, !dbg !251, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !252, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !251, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !251, !llvm.loop !253, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !255, !verifier.code !42
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !256, !verifier.code !42
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !257, !verifier.code !42
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !258, !verifier.code !42
  ret void, !dbg !259, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !260 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !264, metadata !DIExpression()), !dbg !265, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !266, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !266, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !267, metadata !DIExpression()), !dbg !265, !verifier.code !42
  br label %4, !dbg !268, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !269, !verifier.code !42
  call void @l4_insert(%struct.L4** %5), !dbg !270, !verifier.code !42
  br label %6, !dbg !270, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !271, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !270, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !270, !llvm.loop !272, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !274, !verifier.code !42
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !275, !verifier.code !42
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !276, !verifier.code !42
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !277, !verifier.code !42
  ret void, !dbg !278, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !279 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !283, metadata !DIExpression()), !dbg !284, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !285, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !285, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !286, metadata !DIExpression()), !dbg !284, !verifier.code !42
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !287, !verifier.code !42
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !287, !verifier.code !42
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !288, !verifier.code !42
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !289, !verifier.code !42
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !290, !verifier.code !42
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !291, !verifier.code !42
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !292, !verifier.code !42
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !293, !verifier.code !42
  ret void, !dbg !294, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !295 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !301, metadata !DIExpression()), !dbg !302, !verifier.code !42
  call void @llvm.dbg.value(metadata i64 %1, metadata !303, metadata !DIExpression()), !dbg !302, !verifier.code !42
  %3 = mul i64 %0, %1, !dbg !304, !verifier.code !42
  %4 = call noalias i8* @malloc(i64 %3) #6, !dbg !305, !verifier.code !42
  call void @llvm.dbg.value(metadata i8* %4, metadata !306, metadata !DIExpression()), !dbg !302, !verifier.code !42
  %5 = mul i64 %0, %1, !dbg !307, !verifier.code !42
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !308, !verifier.code !42
  ret i8* %4, !dbg !309, !verifier.code !42
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #4

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  store %struct.L0* null, %struct.L0** @main.list
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind willreturn }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!37}
!llvm.module.flags = !{!38, !39, !40}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 183, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 181, type: !4, scopeLine: 182, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0235-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!41 = !DILocation(line: 185, column: 5, scope: !2)
!42 = !{i1 false}
!43 = !DILocation(line: 186, column: 9, scope: !2)
!44 = !DILocation(line: 187, column: 12, scope: !2)
!45 = !{i1 true}
!46 = distinct !{!46, !41, !47}
!47 = !DILocation(line: 187, column: 35, scope: !2)
!48 = !DILocation(line: 189, column: 16, scope: !2)
!49 = !DILocation(line: 189, column: 5, scope: !2)
!50 = !DILocation(line: 190, column: 16, scope: !2)
!51 = !DILocation(line: 190, column: 5, scope: !2)
!52 = !DILocation(line: 191, column: 16, scope: !2)
!53 = !DILocation(line: 191, column: 5, scope: !2)
!54 = !DILocation(line: 192, column: 16, scope: !2)
!55 = !DILocation(line: 192, column: 5, scope: !2)
!56 = !DILocation(line: 193, column: 16, scope: !2)
!57 = !DILocation(line: 193, column: 5, scope: !2)
!58 = !DILocation(line: 195, column: 14, scope: !2)
!59 = !DILocation(line: 195, column: 13, scope: !2)
!60 = !DILocation(line: 195, column: 12, scope: !2)
!61 = !DILocation(line: 195, column: 5, scope: !2)
!62 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !63, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!63 = !DISubroutineType(types: !64)
!64 = !{null, !65}
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!66 = !DILocalVariable(name: "list", arg: 1, scope: !62, file: !3, line: 94, type: !65)
!67 = !DILocation(line: 0, scope: !62)
!68 = !DILocation(line: 96, column: 23, scope: !62)
!69 = !DILocalVariable(name: "item", scope: !62, file: !3, line: 96, type: !10)
!70 = !DILocation(line: 98, column: 5, scope: !62)
!71 = !DILocation(line: 99, column: 26, scope: !62)
!72 = !DILocation(line: 99, column: 9, scope: !62)
!73 = !DILocation(line: 100, column: 12, scope: !62)
!74 = distinct !{!74, !70, !75}
!75 = !DILocation(line: 100, column: 35, scope: !62)
!76 = !DILocation(line: 102, column: 18, scope: !62)
!77 = !DILocation(line: 102, column: 11, scope: !62)
!78 = !DILocation(line: 102, column: 16, scope: !62)
!79 = !DILocation(line: 103, column: 11, scope: !62)
!80 = !DILocation(line: 104, column: 1, scope: !62)
!81 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 166, type: !82, scopeLine: 167, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!82 = !DISubroutineType(types: !83)
!83 = !{null, !10, !6}
!84 = !DILocalVariable(name: "list", arg: 1, scope: !81, file: !3, line: 166, type: !10)
!85 = !DILocation(line: 0, scope: !81)
!86 = !DILocalVariable(name: "level", arg: 2, scope: !81, file: !3, line: 166, type: !6)
!87 = !DILocation(line: 168, column: 5, scope: !81)
!88 = !DILocation(line: 169, column: 15, scope: !89)
!89 = distinct !DILexicalBlock(scope: !90, file: !3, line: 169, column: 13)
!90 = distinct !DILexicalBlock(scope: !81, file: !3, line: 168, column: 8)
!91 = !DILocation(line: 169, column: 13, scope: !90)
!92 = !DILocation(line: 170, column: 30, scope: !89)
!93 = !DILocation(line: 170, column: 13, scope: !89)
!94 = !DILocation(line: 172, column: 33, scope: !90)
!95 = !DILocalVariable(name: "next", scope: !90, file: !3, line: 172, type: !10)
!96 = !DILocation(line: 0, scope: !90)
!97 = !DILocation(line: 173, column: 15, scope: !98)
!98 = distinct !DILexicalBlock(scope: !90, file: !3, line: 173, column: 13)
!99 = !DILocation(line: 173, column: 13, scope: !90)
!100 = !DILocation(line: 174, column: 18, scope: !98)
!101 = !DILocation(line: 174, column: 13, scope: !98)
!102 = !DILocation(line: 177, column: 5, scope: !90)
!103 = distinct !{!103, !87, !104}
!104 = !DILocation(line: 178, column: 16, scope: !81)
!105 = !DILocation(line: 179, column: 1, scope: !81)
!106 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 151, type: !107, scopeLine: 152, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!107 = !DISubroutineType(types: !108)
!108 = !{null, !15, !6}
!109 = !DILocalVariable(name: "list", arg: 1, scope: !106, file: !3, line: 151, type: !15)
!110 = !DILocation(line: 0, scope: !106)
!111 = !DILocalVariable(name: "level", arg: 2, scope: !106, file: !3, line: 151, type: !6)
!112 = !DILocation(line: 153, column: 5, scope: !106)
!113 = !DILocation(line: 154, column: 15, scope: !114)
!114 = distinct !DILexicalBlock(scope: !115, file: !3, line: 154, column: 13)
!115 = distinct !DILexicalBlock(scope: !106, file: !3, line: 153, column: 8)
!116 = !DILocation(line: 154, column: 13, scope: !115)
!117 = !DILocation(line: 155, column: 30, scope: !114)
!118 = !DILocation(line: 155, column: 13, scope: !114)
!119 = !DILocation(line: 157, column: 33, scope: !115)
!120 = !DILocalVariable(name: "next", scope: !115, file: !3, line: 157, type: !15)
!121 = !DILocation(line: 0, scope: !115)
!122 = !DILocation(line: 158, column: 15, scope: !123)
!123 = distinct !DILexicalBlock(scope: !115, file: !3, line: 158, column: 13)
!124 = !DILocation(line: 158, column: 13, scope: !115)
!125 = !DILocation(line: 159, column: 18, scope: !123)
!126 = !DILocation(line: 159, column: 13, scope: !123)
!127 = !DILocation(line: 162, column: 5, scope: !115)
!128 = distinct !{!128, !112, !129}
!129 = !DILocation(line: 163, column: 16, scope: !106)
!130 = !DILocation(line: 164, column: 1, scope: !106)
!131 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 136, type: !132, scopeLine: 137, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!132 = !DISubroutineType(types: !133)
!133 = !{null, !19, !6}
!134 = !DILocalVariable(name: "list", arg: 1, scope: !131, file: !3, line: 136, type: !19)
!135 = !DILocation(line: 0, scope: !131)
!136 = !DILocalVariable(name: "level", arg: 2, scope: !131, file: !3, line: 136, type: !6)
!137 = !DILocation(line: 138, column: 5, scope: !131)
!138 = !DILocation(line: 139, column: 15, scope: !139)
!139 = distinct !DILexicalBlock(scope: !140, file: !3, line: 139, column: 13)
!140 = distinct !DILexicalBlock(scope: !131, file: !3, line: 138, column: 8)
!141 = !DILocation(line: 139, column: 13, scope: !140)
!142 = !DILocation(line: 140, column: 30, scope: !139)
!143 = !DILocation(line: 140, column: 13, scope: !139)
!144 = !DILocation(line: 142, column: 33, scope: !140)
!145 = !DILocalVariable(name: "next", scope: !140, file: !3, line: 142, type: !19)
!146 = !DILocation(line: 0, scope: !140)
!147 = !DILocation(line: 143, column: 15, scope: !148)
!148 = distinct !DILexicalBlock(scope: !140, file: !3, line: 143, column: 13)
!149 = !DILocation(line: 143, column: 13, scope: !140)
!150 = !DILocation(line: 144, column: 18, scope: !148)
!151 = !DILocation(line: 144, column: 13, scope: !148)
!152 = !DILocation(line: 147, column: 5, scope: !140)
!153 = distinct !{!153, !137, !154}
!154 = !DILocation(line: 148, column: 16, scope: !131)
!155 = !DILocation(line: 149, column: 1, scope: !131)
!156 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 121, type: !157, scopeLine: 122, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!157 = !DISubroutineType(types: !158)
!158 = !{null, !24, !6}
!159 = !DILocalVariable(name: "list", arg: 1, scope: !156, file: !3, line: 121, type: !24)
!160 = !DILocation(line: 0, scope: !156)
!161 = !DILocalVariable(name: "level", arg: 2, scope: !156, file: !3, line: 121, type: !6)
!162 = !DILocation(line: 123, column: 5, scope: !156)
!163 = !DILocation(line: 124, column: 15, scope: !164)
!164 = distinct !DILexicalBlock(scope: !165, file: !3, line: 124, column: 13)
!165 = distinct !DILexicalBlock(scope: !156, file: !3, line: 123, column: 8)
!166 = !DILocation(line: 124, column: 13, scope: !165)
!167 = !DILocation(line: 125, column: 30, scope: !164)
!168 = !DILocation(line: 125, column: 13, scope: !164)
!169 = !DILocation(line: 127, column: 33, scope: !165)
!170 = !DILocalVariable(name: "next", scope: !165, file: !3, line: 127, type: !24)
!171 = !DILocation(line: 0, scope: !165)
!172 = !DILocation(line: 128, column: 15, scope: !173)
!173 = distinct !DILexicalBlock(scope: !165, file: !3, line: 128, column: 13)
!174 = !DILocation(line: 128, column: 13, scope: !165)
!175 = !DILocation(line: 129, column: 18, scope: !173)
!176 = !DILocation(line: 129, column: 13, scope: !173)
!177 = !DILocation(line: 132, column: 5, scope: !165)
!178 = distinct !{!178, !162, !179}
!179 = !DILocation(line: 133, column: 16, scope: !156)
!180 = !DILocation(line: 134, column: 1, scope: !156)
!181 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !182, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!182 = !DISubroutineType(types: !183)
!183 = !{null, !28, !6}
!184 = !DILocalVariable(name: "list", arg: 1, scope: !181, file: !3, line: 106, type: !28)
!185 = !DILocation(line: 0, scope: !181)
!186 = !DILocalVariable(name: "level", arg: 2, scope: !181, file: !3, line: 106, type: !6)
!187 = !DILocation(line: 108, column: 5, scope: !181)
!188 = !DILocation(line: 109, column: 15, scope: !189)
!189 = distinct !DILexicalBlock(scope: !190, file: !3, line: 109, column: 13)
!190 = distinct !DILexicalBlock(scope: !181, file: !3, line: 108, column: 8)
!191 = !DILocation(line: 109, column: 13, scope: !190)
!192 = !DILocation(line: 110, column: 24, scope: !189)
!193 = !DILocation(line: 110, column: 18, scope: !189)
!194 = !DILocation(line: 110, column: 13, scope: !189)
!195 = !DILocation(line: 112, column: 33, scope: !190)
!196 = !DILocalVariable(name: "next", scope: !190, file: !3, line: 112, type: !28)
!197 = !DILocation(line: 0, scope: !190)
!198 = !DILocation(line: 113, column: 15, scope: !199)
!199 = distinct !DILexicalBlock(scope: !190, file: !3, line: 113, column: 13)
!200 = !DILocation(line: 113, column: 13, scope: !190)
!201 = !DILocation(line: 114, column: 18, scope: !199)
!202 = !DILocation(line: 114, column: 13, scope: !199)
!203 = !DILocation(line: 117, column: 5, scope: !190)
!204 = distinct !{!204, !187, !205}
!205 = !DILocation(line: 118, column: 16, scope: !181)
!206 = !DILocation(line: 119, column: 1, scope: !181)
!207 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !208, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!208 = !DISubroutineType(types: !209)
!209 = !{!210, !211}
!210 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!211 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!212 = !DILocalVariable(name: "size", arg: 1, scope: !207, file: !3, line: 40, type: !211)
!213 = !DILocation(line: 0, scope: !207)
!214 = !DILocation(line: 42, column: 34, scope: !207)
!215 = !DILocation(line: 42, column: 17, scope: !207)
!216 = !DILocalVariable(name: "ptr", scope: !207, file: !3, line: 42, type: !210)
!217 = !DILocation(line: 43, column: 9, scope: !218)
!218 = distinct !DILexicalBlock(scope: !207, file: !3, line: 43, column: 9)
!219 = !DILocation(line: 43, column: 9, scope: !207)
!220 = !DILocation(line: 44, column: 9, scope: !218)
!221 = !DILocation(line: 46, column: 5, scope: !207)
!222 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !223, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!223 = !DISubroutineType(types: !224)
!224 = !{null, !225}
!225 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!226 = !DILocalVariable(name: "list", arg: 1, scope: !222, file: !3, line: 82, type: !225)
!227 = !DILocation(line: 0, scope: !222)
!228 = !DILocation(line: 84, column: 23, scope: !222)
!229 = !DILocalVariable(name: "item", scope: !222, file: !3, line: 84, type: !15)
!230 = !DILocation(line: 86, column: 5, scope: !222)
!231 = !DILocation(line: 87, column: 26, scope: !222)
!232 = !DILocation(line: 87, column: 9, scope: !222)
!233 = !DILocation(line: 88, column: 12, scope: !222)
!234 = distinct !{!234, !230, !235}
!235 = !DILocation(line: 88, column: 35, scope: !222)
!236 = !DILocation(line: 90, column: 18, scope: !222)
!237 = !DILocation(line: 90, column: 11, scope: !222)
!238 = !DILocation(line: 90, column: 16, scope: !222)
!239 = !DILocation(line: 91, column: 11, scope: !222)
!240 = !DILocation(line: 92, column: 1, scope: !222)
!241 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !242, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!242 = !DISubroutineType(types: !243)
!243 = !{null, !244}
!244 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!245 = !DILocalVariable(name: "list", arg: 1, scope: !241, file: !3, line: 70, type: !244)
!246 = !DILocation(line: 0, scope: !241)
!247 = !DILocation(line: 72, column: 23, scope: !241)
!248 = !DILocalVariable(name: "item", scope: !241, file: !3, line: 72, type: !19)
!249 = !DILocation(line: 74, column: 5, scope: !241)
!250 = !DILocation(line: 75, column: 26, scope: !241)
!251 = !DILocation(line: 75, column: 9, scope: !241)
!252 = !DILocation(line: 76, column: 12, scope: !241)
!253 = distinct !{!253, !249, !254}
!254 = !DILocation(line: 76, column: 35, scope: !241)
!255 = !DILocation(line: 78, column: 18, scope: !241)
!256 = !DILocation(line: 78, column: 11, scope: !241)
!257 = !DILocation(line: 78, column: 16, scope: !241)
!258 = !DILocation(line: 79, column: 11, scope: !241)
!259 = !DILocation(line: 80, column: 1, scope: !241)
!260 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !261, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!261 = !DISubroutineType(types: !262)
!262 = !{null, !263}
!263 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!264 = !DILocalVariable(name: "list", arg: 1, scope: !260, file: !3, line: 58, type: !263)
!265 = !DILocation(line: 0, scope: !260)
!266 = !DILocation(line: 60, column: 23, scope: !260)
!267 = !DILocalVariable(name: "item", scope: !260, file: !3, line: 60, type: !24)
!268 = !DILocation(line: 62, column: 5, scope: !260)
!269 = !DILocation(line: 63, column: 26, scope: !260)
!270 = !DILocation(line: 63, column: 9, scope: !260)
!271 = !DILocation(line: 64, column: 12, scope: !260)
!272 = distinct !{!272, !268, !273}
!273 = !DILocation(line: 64, column: 35, scope: !260)
!274 = !DILocation(line: 66, column: 18, scope: !260)
!275 = !DILocation(line: 66, column: 11, scope: !260)
!276 = !DILocation(line: 66, column: 16, scope: !260)
!277 = !DILocation(line: 67, column: 11, scope: !260)
!278 = !DILocation(line: 68, column: 1, scope: !260)
!279 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !280, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!280 = !DISubroutineType(types: !281)
!281 = !{null, !282}
!282 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!283 = !DILocalVariable(name: "list", arg: 1, scope: !279, file: !3, line: 49, type: !282)
!284 = !DILocation(line: 0, scope: !279)
!285 = !DILocation(line: 51, column: 23, scope: !279)
!286 = !DILocalVariable(name: "item", scope: !279, file: !3, line: 51, type: !28)
!287 = !DILocation(line: 52, column: 18, scope: !279)
!288 = !DILocation(line: 52, column: 11, scope: !279)
!289 = !DILocation(line: 52, column: 16, scope: !279)
!290 = !DILocation(line: 54, column: 18, scope: !279)
!291 = !DILocation(line: 54, column: 11, scope: !279)
!292 = !DILocation(line: 54, column: 16, scope: !279)
!293 = !DILocation(line: 55, column: 11, scope: !279)
!294 = !DILocation(line: 56, column: 1, scope: !279)
!295 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !296, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!296 = !DISubroutineType(types: !297)
!297 = !{!210, !298, !298}
!298 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !299, line: 46, baseType: !300)
!299 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!300 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!301 = !DILocalVariable(name: "nmemb", arg: 1, scope: !295, file: !3, line: 8, type: !298)
!302 = !DILocation(line: 0, scope: !295)
!303 = !DILocalVariable(name: "size", arg: 2, scope: !295, file: !3, line: 8, type: !298)
!304 = !DILocation(line: 9, column: 30, scope: !295)
!305 = !DILocation(line: 9, column: 17, scope: !295)
!306 = !DILocalVariable(name: "ptr", scope: !295, file: !3, line: 9, type: !210)
!307 = !DILocation(line: 10, column: 33, scope: !295)
!308 = !DILocation(line: 10, column: 12, scope: !295)
!309 = !DILocation(line: 10, column: 5, scope: !295)
