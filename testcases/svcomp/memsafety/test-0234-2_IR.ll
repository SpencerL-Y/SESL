; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-086ub8q8.bc'
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
  call void @l0_destroy(%struct.L0* %6), !dbg !49, !verifier.code !42
  ret i32 0, !dbg !50, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l0_insert(%struct.L0** %0) #0 !dbg !51 {
  call void @llvm.dbg.value(metadata %struct.L0** %0, metadata !55, metadata !DIExpression()), !dbg !56, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !57, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L0*, !dbg !57, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %3, metadata !58, metadata !DIExpression()), !dbg !56, !verifier.code !42
  br label %4, !dbg !59, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 1, !dbg !60, !verifier.code !42
  call void @l1_insert(%struct.L1** %5), !dbg !61, !verifier.code !42
  br label %6, !dbg !61, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !62, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !61, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !61, !llvm.loop !63, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L0*, %struct.L0** %0, align 8, !dbg !65, !verifier.code !42
  %11 = getelementptr inbounds %struct.L0, %struct.L0* %3, i32 0, i32 0, !dbg !66, !verifier.code !42
  store %struct.L0* %10, %struct.L0** %11, align 8, !dbg !67, !verifier.code !42
  store %struct.L0* %3, %struct.L0** %0, align 8, !dbg !68, !verifier.code !42
  ret void, !dbg !69, !verifier.code !42
}

declare dso_local i32 @__VERIFIER_nondet_int() #1

; Function Attrs: noinline nounwind uwtable
define internal void @l0_destroy(%struct.L0* %0) #0 !dbg !70 {
  call void @llvm.dbg.value(metadata %struct.L0* %0, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !42
  br label %2, !dbg !75, !verifier.code !42

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L0* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %.0, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !42
  %3 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 1, !dbg !76, !verifier.code !42
  %4 = load %struct.L1*, %struct.L1** %3, align 8, !dbg !76, !verifier.code !42
  call void @l1_destroy(%struct.L1* %4), !dbg !78, !verifier.code !42
  %5 = getelementptr inbounds %struct.L0, %struct.L0* %.0, i32 0, i32 0, !dbg !79, !verifier.code !42
  %6 = load %struct.L0*, %struct.L0** %5, align 8, !dbg !79, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !80, metadata !DIExpression()), !dbg !81, !verifier.code !42
  %7 = bitcast %struct.L0* %.0 to i8*, !dbg !82, !verifier.code !42
  call void @free(i8* %7) #6, !dbg !83, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L0* %6, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !42
  br label %8, !dbg !84, !verifier.code !42

8:                                                ; preds = %2
  %9 = icmp ne %struct.L0* %6, null, !dbg !84, !verifier.code !42
  br i1 %9, label %forwarder, label %10, !dbg !84, !llvm.loop !85, !verifier.code !42

10:                                               ; preds = %8
  ret void, !dbg !87, !verifier.code !42

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !42
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal void @l1_destroy(%struct.L1* %0) #0 !dbg !88 {
  call void @llvm.dbg.value(metadata %struct.L1* %0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !42
  br label %2, !dbg !93, !verifier.code !42

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L1* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %.0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !42
  %3 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 0, !dbg !94, !verifier.code !42
  %4 = load %struct.L2*, %struct.L2** %3, align 8, !dbg !94, !verifier.code !42
  call void @l2_destroy(%struct.L2* %4), !dbg !96, !verifier.code !42
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %.0, i32 0, i32 1, !dbg !97, !verifier.code !42
  %6 = load %struct.L1*, %struct.L1** %5, align 8, !dbg !97, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !98, metadata !DIExpression()), !dbg !99, !verifier.code !42
  %7 = bitcast %struct.L1* %.0 to i8*, !dbg !100, !verifier.code !42
  call void @free(i8* %7) #6, !dbg !101, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %6, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !42
  br label %8, !dbg !102, !verifier.code !42

8:                                                ; preds = %2
  %9 = icmp ne %struct.L1* %6, null, !dbg !102, !verifier.code !42
  br i1 %9, label %forwarder, label %10, !dbg !102, !llvm.loop !103, !verifier.code !42

10:                                               ; preds = %8
  ret void, !dbg !105, !verifier.code !42

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !42
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 !dbg !106 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !109, metadata !DIExpression()), !dbg !110, !verifier.code !42
  br label %2, !dbg !111, !verifier.code !42

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L2* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !109, metadata !DIExpression()), !dbg !110, !verifier.code !42
  %3 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !112, !verifier.code !42
  %4 = load %struct.L3*, %struct.L3** %3, align 8, !dbg !112, !verifier.code !42
  call void @l3_destroy(%struct.L3* %4), !dbg !114, !verifier.code !42
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 0, !dbg !115, !verifier.code !42
  %6 = load %struct.L2*, %struct.L2** %5, align 8, !dbg !115, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !42
  %7 = bitcast %struct.L2* %.0 to i8*, !dbg !118, !verifier.code !42
  call void @free(i8* %7) #6, !dbg !119, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !109, metadata !DIExpression()), !dbg !110, !verifier.code !42
  br label %8, !dbg !120, !verifier.code !42

8:                                                ; preds = %2
  %9 = icmp ne %struct.L2* %6, null, !dbg !120, !verifier.code !42
  br i1 %9, label %forwarder, label %10, !dbg !120, !llvm.loop !121, !verifier.code !42

10:                                               ; preds = %8
  ret void, !dbg !123, !verifier.code !42

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_destroy(%struct.L3* %0) #0 !dbg !124 {
  call void @llvm.dbg.value(metadata %struct.L3* %0, metadata !127, metadata !DIExpression()), !dbg !128, !verifier.code !42
  br label %2, !dbg !129, !verifier.code !42

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L3* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %.0, metadata !127, metadata !DIExpression()), !dbg !128, !verifier.code !42
  %3 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 0, !dbg !130, !verifier.code !42
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !130, !verifier.code !42
  call void @l4_destroy(%struct.L4* %4), !dbg !132, !verifier.code !42
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %.0, i32 0, i32 1, !dbg !133, !verifier.code !42
  %6 = load %struct.L3*, %struct.L3** %5, align 8, !dbg !133, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !134, metadata !DIExpression()), !dbg !135, !verifier.code !42
  %7 = bitcast %struct.L3* %.0 to i8*, !dbg !136, !verifier.code !42
  call void @free(i8* %7) #6, !dbg !137, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %6, metadata !127, metadata !DIExpression()), !dbg !128, !verifier.code !42
  br label %8, !dbg !138, !verifier.code !42

8:                                                ; preds = %2
  %9 = icmp ne %struct.L3* %6, null, !dbg !138, !verifier.code !42
  br i1 %9, label %forwarder, label %10, !dbg !138, !llvm.loop !139, !verifier.code !42

10:                                               ; preds = %8
  ret void, !dbg !141, !verifier.code !42

forwarder:                                        ; preds = %8
  br label %2, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_destroy(%struct.L4* %0) #0 !dbg !142 {
  call void @llvm.dbg.value(metadata %struct.L4* %0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !42
  br label %2, !dbg !147, !verifier.code !42

2:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L4* [ %0, %1 ], [ %4, %forwarder ], !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %.0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !42
  %3 = getelementptr inbounds %struct.L4, %struct.L4* %.0, i32 0, i32 0, !dbg !148, !verifier.code !42
  %4 = load %struct.L4*, %struct.L4** %3, align 8, !dbg !148, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %4, metadata !150, metadata !DIExpression()), !dbg !151, !verifier.code !42
  %5 = bitcast %struct.L4* %.0 to i8*, !dbg !152, !verifier.code !42
  call void @free(i8* %5) #6, !dbg !153, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %4, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !42
  br label %6, !dbg !154, !verifier.code !42

6:                                                ; preds = %2
  %7 = icmp ne %struct.L4* %4, null, !dbg !154, !verifier.code !42
  br i1 %7, label %forwarder, label %8, !dbg !154, !llvm.loop !155, !verifier.code !42

8:                                                ; preds = %6
  ret void, !dbg !157, !verifier.code !42

forwarder:                                        ; preds = %6
  br label %2, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @zalloc_or_die(i32 %0) #0 !dbg !158 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !163, metadata !DIExpression()), !dbg !164, !verifier.code !42
  %2 = zext i32 %0 to i64, !dbg !165, !verifier.code !42
  %3 = call i8* @calloc_model(i64 1, i64 %2), !dbg !166, !verifier.code !42
  call void @llvm.dbg.value(metadata i8* %3, metadata !167, metadata !DIExpression()), !dbg !164, !verifier.code !42
  %4 = icmp ne i8* %3, null, !dbg !168, !verifier.code !42
  br i1 %4, label %5, label %6, !dbg !170, !verifier.code !42

5:                                                ; preds = %1
  ret i8* %3, !dbg !171, !verifier.code !42

6:                                                ; preds = %1
  call void @abort() #7, !dbg !172, !verifier.code !42
  unreachable, !dbg !172, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !173 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !177, metadata !DIExpression()), !dbg !178, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !179, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !179, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !180, metadata !DIExpression()), !dbg !178, !verifier.code !42
  br label %4, !dbg !181, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !182, !verifier.code !42
  call void @l2_insert(%struct.L2** %5), !dbg !183, !verifier.code !42
  br label %6, !dbg !183, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !184, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !183, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !183, !llvm.loop !185, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !187, !verifier.code !42
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !188, !verifier.code !42
  store %struct.L1* %10, %struct.L1** %11, align 8, !dbg !189, !verifier.code !42
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !190, !verifier.code !42
  ret void, !dbg !191, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !192 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !196, metadata !DIExpression()), !dbg !197, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !198, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !198, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !199, metadata !DIExpression()), !dbg !197, !verifier.code !42
  br label %4, !dbg !200, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !201, !verifier.code !42
  call void @l3_insert(%struct.L3** %5), !dbg !202, !verifier.code !42
  br label %6, !dbg !202, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !203, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !202, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !202, !llvm.loop !204, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !206, !verifier.code !42
  %11 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !207, !verifier.code !42
  store %struct.L2* %10, %struct.L2** %11, align 8, !dbg !208, !verifier.code !42
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !209, !verifier.code !42
  ret void, !dbg !210, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l3_insert(%struct.L3** %0) #0 !dbg !211 {
  call void @llvm.dbg.value(metadata %struct.L3** %0, metadata !215, metadata !DIExpression()), !dbg !216, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !217, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L3*, !dbg !217, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L3* %3, metadata !218, metadata !DIExpression()), !dbg !216, !verifier.code !42
  br label %4, !dbg !219, !verifier.code !42

4:                                                ; preds = %6, %1
  %5 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 0, !dbg !220, !verifier.code !42
  call void @l4_insert(%struct.L4** %5), !dbg !221, !verifier.code !42
  br label %6, !dbg !221, !verifier.code !42

6:                                                ; preds = %4
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !222, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !221, !verifier.code !42
  br i1 %8, label %4, label %9, !dbg !221, !llvm.loop !223, !verifier.code !42

9:                                                ; preds = %6
  %10 = load %struct.L3*, %struct.L3** %0, align 8, !dbg !225, !verifier.code !42
  %11 = getelementptr inbounds %struct.L3, %struct.L3* %3, i32 0, i32 1, !dbg !226, !verifier.code !42
  store %struct.L3* %10, %struct.L3** %11, align 8, !dbg !227, !verifier.code !42
  store %struct.L3* %3, %struct.L3** %0, align 8, !dbg !228, !verifier.code !42
  ret void, !dbg !229, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal void @l4_insert(%struct.L4** %0) #0 !dbg !230 {
  call void @llvm.dbg.value(metadata %struct.L4** %0, metadata !234, metadata !DIExpression()), !dbg !235, !verifier.code !42
  %2 = call i8* @zalloc_or_die(i32 16), !dbg !236, !verifier.code !42
  %3 = bitcast i8* %2 to %struct.L4*, !dbg !236, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.L4* %3, metadata !237, metadata !DIExpression()), !dbg !235, !verifier.code !42
  %4 = call i8* @zalloc_or_die(i32 119), !dbg !238, !verifier.code !42
  %5 = bitcast i8* %4 to %struct.L5*, !dbg !238, !verifier.code !42
  %6 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 1, !dbg !239, !verifier.code !42
  store %struct.L5* %5, %struct.L5** %6, align 8, !dbg !240, !verifier.code !42
  %7 = load %struct.L4*, %struct.L4** %0, align 8, !dbg !241, !verifier.code !42
  %8 = getelementptr inbounds %struct.L4, %struct.L4* %3, i32 0, i32 0, !dbg !242, !verifier.code !42
  store %struct.L4* %7, %struct.L4** %8, align 8, !dbg !243, !verifier.code !42
  store %struct.L4* %3, %struct.L4** %0, align 8, !dbg !244, !verifier.code !42
  ret void, !dbg !245, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !246 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !252, metadata !DIExpression()), !dbg !253, !verifier.code !42
  call void @llvm.dbg.value(metadata i64 %1, metadata !254, metadata !DIExpression()), !dbg !253, !verifier.code !42
  %3 = mul i64 %0, %1, !dbg !255, !verifier.code !42
  %4 = call noalias i8* @malloc(i64 %3) #6, !dbg !256, !verifier.code !42
  call void @llvm.dbg.value(metadata i8* %4, metadata !257, metadata !DIExpression()), !dbg !253, !verifier.code !42
  %5 = mul i64 %0, %1, !dbg !258, !verifier.code !42
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !259, !verifier.code !42
  ret i8* %4, !dbg !260, !verifier.code !42
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
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 166, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 164, type: !4, scopeLine: 165, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0234-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!41 = !DILocation(line: 168, column: 5, scope: !2)
!42 = !{i1 false}
!43 = !DILocation(line: 169, column: 9, scope: !2)
!44 = !DILocation(line: 170, column: 12, scope: !2)
!45 = !{i1 true}
!46 = distinct !{!46, !41, !47}
!47 = !DILocation(line: 170, column: 35, scope: !2)
!48 = !DILocation(line: 172, column: 16, scope: !2)
!49 = !DILocation(line: 172, column: 5, scope: !2)
!50 = !DILocation(line: 173, column: 1, scope: !2)
!51 = distinct !DISubprogram(name: "l0_insert", scope: !3, file: !3, line: 94, type: !52, scopeLine: 95, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!52 = !DISubroutineType(types: !53)
!53 = !{null, !54}
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!55 = !DILocalVariable(name: "list", arg: 1, scope: !51, file: !3, line: 94, type: !54)
!56 = !DILocation(line: 0, scope: !51)
!57 = !DILocation(line: 96, column: 23, scope: !51)
!58 = !DILocalVariable(name: "item", scope: !51, file: !3, line: 96, type: !10)
!59 = !DILocation(line: 98, column: 5, scope: !51)
!60 = !DILocation(line: 99, column: 26, scope: !51)
!61 = !DILocation(line: 99, column: 9, scope: !51)
!62 = !DILocation(line: 100, column: 12, scope: !51)
!63 = distinct !{!63, !59, !64}
!64 = !DILocation(line: 100, column: 35, scope: !51)
!65 = !DILocation(line: 102, column: 18, scope: !51)
!66 = !DILocation(line: 102, column: 11, scope: !51)
!67 = !DILocation(line: 102, column: 16, scope: !51)
!68 = !DILocation(line: 103, column: 11, scope: !51)
!69 = !DILocation(line: 104, column: 1, scope: !51)
!70 = distinct !DISubprogram(name: "l0_destroy", scope: !3, file: !3, line: 152, type: !71, scopeLine: 153, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!71 = !DISubroutineType(types: !72)
!72 = !{null, !10}
!73 = !DILocalVariable(name: "list", arg: 1, scope: !70, file: !3, line: 152, type: !10)
!74 = !DILocation(line: 0, scope: !70)
!75 = !DILocation(line: 154, column: 5, scope: !70)
!76 = !DILocation(line: 155, column: 26, scope: !77)
!77 = distinct !DILexicalBlock(scope: !70, file: !3, line: 154, column: 8)
!78 = !DILocation(line: 155, column: 9, scope: !77)
!79 = !DILocation(line: 157, column: 33, scope: !77)
!80 = !DILocalVariable(name: "next", scope: !77, file: !3, line: 157, type: !10)
!81 = !DILocation(line: 0, scope: !77)
!82 = !DILocation(line: 158, column: 14, scope: !77)
!83 = !DILocation(line: 158, column: 9, scope: !77)
!84 = !DILocation(line: 160, column: 5, scope: !77)
!85 = distinct !{!85, !75, !86}
!86 = !DILocation(line: 161, column: 16, scope: !70)
!87 = !DILocation(line: 162, column: 1, scope: !70)
!88 = distinct !DISubprogram(name: "l1_destroy", scope: !3, file: !3, line: 140, type: !89, scopeLine: 141, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!89 = !DISubroutineType(types: !90)
!90 = !{null, !15}
!91 = !DILocalVariable(name: "list", arg: 1, scope: !88, file: !3, line: 140, type: !15)
!92 = !DILocation(line: 0, scope: !88)
!93 = !DILocation(line: 142, column: 5, scope: !88)
!94 = !DILocation(line: 143, column: 26, scope: !95)
!95 = distinct !DILexicalBlock(scope: !88, file: !3, line: 142, column: 8)
!96 = !DILocation(line: 143, column: 9, scope: !95)
!97 = !DILocation(line: 145, column: 33, scope: !95)
!98 = !DILocalVariable(name: "next", scope: !95, file: !3, line: 145, type: !15)
!99 = !DILocation(line: 0, scope: !95)
!100 = !DILocation(line: 146, column: 14, scope: !95)
!101 = !DILocation(line: 146, column: 9, scope: !95)
!102 = !DILocation(line: 148, column: 5, scope: !95)
!103 = distinct !{!103, !93, !104}
!104 = !DILocation(line: 149, column: 16, scope: !88)
!105 = !DILocation(line: 150, column: 1, scope: !88)
!106 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 128, type: !107, scopeLine: 129, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!107 = !DISubroutineType(types: !108)
!108 = !{null, !19}
!109 = !DILocalVariable(name: "list", arg: 1, scope: !106, file: !3, line: 128, type: !19)
!110 = !DILocation(line: 0, scope: !106)
!111 = !DILocation(line: 130, column: 5, scope: !106)
!112 = !DILocation(line: 131, column: 26, scope: !113)
!113 = distinct !DILexicalBlock(scope: !106, file: !3, line: 130, column: 8)
!114 = !DILocation(line: 131, column: 9, scope: !113)
!115 = !DILocation(line: 133, column: 33, scope: !113)
!116 = !DILocalVariable(name: "next", scope: !113, file: !3, line: 133, type: !19)
!117 = !DILocation(line: 0, scope: !113)
!118 = !DILocation(line: 134, column: 14, scope: !113)
!119 = !DILocation(line: 134, column: 9, scope: !113)
!120 = !DILocation(line: 136, column: 5, scope: !113)
!121 = distinct !{!121, !111, !122}
!122 = !DILocation(line: 137, column: 16, scope: !106)
!123 = !DILocation(line: 138, column: 1, scope: !106)
!124 = distinct !DISubprogram(name: "l3_destroy", scope: !3, file: !3, line: 116, type: !125, scopeLine: 117, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!125 = !DISubroutineType(types: !126)
!126 = !{null, !24}
!127 = !DILocalVariable(name: "list", arg: 1, scope: !124, file: !3, line: 116, type: !24)
!128 = !DILocation(line: 0, scope: !124)
!129 = !DILocation(line: 118, column: 5, scope: !124)
!130 = !DILocation(line: 119, column: 26, scope: !131)
!131 = distinct !DILexicalBlock(scope: !124, file: !3, line: 118, column: 8)
!132 = !DILocation(line: 119, column: 9, scope: !131)
!133 = !DILocation(line: 121, column: 33, scope: !131)
!134 = !DILocalVariable(name: "next", scope: !131, file: !3, line: 121, type: !24)
!135 = !DILocation(line: 0, scope: !131)
!136 = !DILocation(line: 122, column: 14, scope: !131)
!137 = !DILocation(line: 122, column: 9, scope: !131)
!138 = !DILocation(line: 124, column: 5, scope: !131)
!139 = distinct !{!139, !129, !140}
!140 = !DILocation(line: 125, column: 16, scope: !124)
!141 = !DILocation(line: 126, column: 1, scope: !124)
!142 = distinct !DISubprogram(name: "l4_destroy", scope: !3, file: !3, line: 106, type: !143, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!143 = !DISubroutineType(types: !144)
!144 = !{null, !28}
!145 = !DILocalVariable(name: "list", arg: 1, scope: !142, file: !3, line: 106, type: !28)
!146 = !DILocation(line: 0, scope: !142)
!147 = !DILocation(line: 108, column: 5, scope: !142)
!148 = !DILocation(line: 109, column: 33, scope: !149)
!149 = distinct !DILexicalBlock(scope: !142, file: !3, line: 108, column: 8)
!150 = !DILocalVariable(name: "next", scope: !149, file: !3, line: 109, type: !28)
!151 = !DILocation(line: 0, scope: !149)
!152 = !DILocation(line: 110, column: 14, scope: !149)
!153 = !DILocation(line: 110, column: 9, scope: !149)
!154 = !DILocation(line: 112, column: 5, scope: !149)
!155 = distinct !{!155, !147, !156}
!156 = !DILocation(line: 113, column: 16, scope: !142)
!157 = !DILocation(line: 114, column: 1, scope: !142)
!158 = distinct !DISubprogram(name: "zalloc_or_die", scope: !3, file: !3, line: 40, type: !159, scopeLine: 41, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!159 = !DISubroutineType(types: !160)
!160 = !{!161, !162}
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!162 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!163 = !DILocalVariable(name: "size", arg: 1, scope: !158, file: !3, line: 40, type: !162)
!164 = !DILocation(line: 0, scope: !158)
!165 = !DILocation(line: 42, column: 34, scope: !158)
!166 = !DILocation(line: 42, column: 17, scope: !158)
!167 = !DILocalVariable(name: "ptr", scope: !158, file: !3, line: 42, type: !161)
!168 = !DILocation(line: 43, column: 9, scope: !169)
!169 = distinct !DILexicalBlock(scope: !158, file: !3, line: 43, column: 9)
!170 = !DILocation(line: 43, column: 9, scope: !158)
!171 = !DILocation(line: 44, column: 9, scope: !169)
!172 = !DILocation(line: 46, column: 5, scope: !158)
!173 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 82, type: !174, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!174 = !DISubroutineType(types: !175)
!175 = !{null, !176}
!176 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!177 = !DILocalVariable(name: "list", arg: 1, scope: !173, file: !3, line: 82, type: !176)
!178 = !DILocation(line: 0, scope: !173)
!179 = !DILocation(line: 84, column: 23, scope: !173)
!180 = !DILocalVariable(name: "item", scope: !173, file: !3, line: 84, type: !15)
!181 = !DILocation(line: 86, column: 5, scope: !173)
!182 = !DILocation(line: 87, column: 26, scope: !173)
!183 = !DILocation(line: 87, column: 9, scope: !173)
!184 = !DILocation(line: 88, column: 12, scope: !173)
!185 = distinct !{!185, !181, !186}
!186 = !DILocation(line: 88, column: 35, scope: !173)
!187 = !DILocation(line: 90, column: 18, scope: !173)
!188 = !DILocation(line: 90, column: 11, scope: !173)
!189 = !DILocation(line: 90, column: 16, scope: !173)
!190 = !DILocation(line: 91, column: 11, scope: !173)
!191 = !DILocation(line: 92, column: 1, scope: !173)
!192 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 70, type: !193, scopeLine: 71, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!193 = !DISubroutineType(types: !194)
!194 = !{null, !195}
!195 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!196 = !DILocalVariable(name: "list", arg: 1, scope: !192, file: !3, line: 70, type: !195)
!197 = !DILocation(line: 0, scope: !192)
!198 = !DILocation(line: 72, column: 23, scope: !192)
!199 = !DILocalVariable(name: "item", scope: !192, file: !3, line: 72, type: !19)
!200 = !DILocation(line: 74, column: 5, scope: !192)
!201 = !DILocation(line: 75, column: 26, scope: !192)
!202 = !DILocation(line: 75, column: 9, scope: !192)
!203 = !DILocation(line: 76, column: 12, scope: !192)
!204 = distinct !{!204, !200, !205}
!205 = !DILocation(line: 76, column: 35, scope: !192)
!206 = !DILocation(line: 78, column: 18, scope: !192)
!207 = !DILocation(line: 78, column: 11, scope: !192)
!208 = !DILocation(line: 78, column: 16, scope: !192)
!209 = !DILocation(line: 79, column: 11, scope: !192)
!210 = !DILocation(line: 80, column: 1, scope: !192)
!211 = distinct !DISubprogram(name: "l3_insert", scope: !3, file: !3, line: 58, type: !212, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!212 = !DISubroutineType(types: !213)
!213 = !{null, !214}
!214 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!215 = !DILocalVariable(name: "list", arg: 1, scope: !211, file: !3, line: 58, type: !214)
!216 = !DILocation(line: 0, scope: !211)
!217 = !DILocation(line: 60, column: 23, scope: !211)
!218 = !DILocalVariable(name: "item", scope: !211, file: !3, line: 60, type: !24)
!219 = !DILocation(line: 62, column: 5, scope: !211)
!220 = !DILocation(line: 63, column: 26, scope: !211)
!221 = !DILocation(line: 63, column: 9, scope: !211)
!222 = !DILocation(line: 64, column: 12, scope: !211)
!223 = distinct !{!223, !219, !224}
!224 = !DILocation(line: 64, column: 35, scope: !211)
!225 = !DILocation(line: 66, column: 18, scope: !211)
!226 = !DILocation(line: 66, column: 11, scope: !211)
!227 = !DILocation(line: 66, column: 16, scope: !211)
!228 = !DILocation(line: 67, column: 11, scope: !211)
!229 = !DILocation(line: 68, column: 1, scope: !211)
!230 = distinct !DISubprogram(name: "l4_insert", scope: !3, file: !3, line: 49, type: !231, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!231 = !DISubroutineType(types: !232)
!232 = !{null, !233}
!233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!234 = !DILocalVariable(name: "list", arg: 1, scope: !230, file: !3, line: 49, type: !233)
!235 = !DILocation(line: 0, scope: !230)
!236 = !DILocation(line: 51, column: 23, scope: !230)
!237 = !DILocalVariable(name: "item", scope: !230, file: !3, line: 51, type: !28)
!238 = !DILocation(line: 52, column: 18, scope: !230)
!239 = !DILocation(line: 52, column: 11, scope: !230)
!240 = !DILocation(line: 52, column: 16, scope: !230)
!241 = !DILocation(line: 54, column: 18, scope: !230)
!242 = !DILocation(line: 54, column: 11, scope: !230)
!243 = !DILocation(line: 54, column: 16, scope: !230)
!244 = !DILocation(line: 55, column: 11, scope: !230)
!245 = !DILocation(line: 56, column: 1, scope: !230)
!246 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !247, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!247 = !DISubroutineType(types: !248)
!248 = !{!161, !249, !249}
!249 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !250, line: 46, baseType: !251)
!250 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!251 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!252 = !DILocalVariable(name: "nmemb", arg: 1, scope: !246, file: !3, line: 8, type: !249)
!253 = !DILocation(line: 0, scope: !246)
!254 = !DILocalVariable(name: "size", arg: 2, scope: !246, file: !3, line: 8, type: !249)
!255 = !DILocation(line: 9, column: 30, scope: !246)
!256 = !DILocation(line: 9, column: 17, scope: !246)
!257 = !DILocalVariable(name: "ptr", scope: !246, file: !3, line: 9, type: !161)
!258 = !DILocation(line: 10, column: 33, scope: !246)
!259 = !DILocation(line: 10, column: 12, scope: !246)
!260 = !DILocation(line: 10, column: 5, scope: !246)
