; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-cshderi2.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, %struct.node* }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !7 {
  ret void, !dbg !11, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define internal void @init_back_link(%struct.node* %0) #0 !dbg !13 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !21, metadata !DIExpression()), !dbg !22, !verifier.code !12
  %2 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !23, !verifier.code !12
  %3 = load %struct.node*, %struct.node** %2, align 8, !dbg !23, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !27, metadata !DIExpression()), !dbg !28, !verifier.code !12
  %4 = icmp ne %struct.node* %3, null, !dbg !29, !verifier.code !12
  br i1 %4, label %.lr.ph, label %5, !dbg !31, !verifier.code !12

.lr.ph:                                           ; preds = %1
  br label %6, !dbg !31, !verifier.code !12

._crit_edge:                                      ; preds = %6
  br label %5, !dbg !31, !verifier.code !12

5:                                                ; preds = %._crit_edge, %1
  ret void, !dbg !32, !verifier.code !12

6:                                                ; preds = %forwarder, %.lr.ph
  %7 = phi %struct.node* [ %3, %.lr.ph ], [ %10, %forwarder ], !verifier.code !12
  %.01 = phi %struct.node* [ %0, %.lr.ph ], [ %7, %forwarder ], !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !21, metadata !DIExpression()), !dbg !22, !verifier.code !12
  %8 = getelementptr inbounds %struct.node, %struct.node* %7, i32 0, i32 1, !dbg !33, !verifier.code !12
  store %struct.node* %.01, %struct.node** %8, align 8, !dbg !34, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %7, metadata !21, metadata !DIExpression()), !dbg !22, !verifier.code !12
  %9 = getelementptr inbounds %struct.node, %struct.node* %7, i32 0, i32 0, !dbg !23, !verifier.code !12
  %10 = load %struct.node*, %struct.node** %9, align 8, !dbg !23, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %10, metadata !27, metadata !DIExpression()), !dbg !28, !verifier.code !12
  %11 = icmp ne %struct.node* %10, null, !dbg !29, !verifier.code !12
  br i1 %11, label %forwarder, label %._crit_edge, !dbg !31, !llvm.loop !35, !verifier.code !12

forwarder:                                        ; preds = %6
  br label %6, !verifier.code !12
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @reverse_dll(%struct.node* %0) #0 !dbg !38 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !39, metadata !DIExpression()), !dbg !40, !verifier.code !12
  %2 = icmp ne %struct.node* %0, null, !dbg !41, !verifier.code !12
  br i1 %2, label %.lr.ph, label %11, !dbg !41, !verifier.code !12

.lr.ph:                                           ; preds = %1
  br label %3, !dbg !41, !verifier.code !12

3:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %0, %.lr.ph ], [ %5, %forwarder ], !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !39, metadata !DIExpression()), !dbg !40, !verifier.code !12
  %4 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !42, !verifier.code !12
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !42, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !12
  %6 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !46, !verifier.code !12
  %7 = load %struct.node*, %struct.node** %6, align 8, !dbg !46, !verifier.code !12
  %8 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !47, !verifier.code !12
  store %struct.node* %7, %struct.node** %8, align 8, !dbg !48, !verifier.code !12
  %9 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !49, !verifier.code !12
  store %struct.node* %5, %struct.node** %9, align 8, !dbg !50, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !39, metadata !DIExpression()), !dbg !40, !verifier.code !12
  %10 = icmp ne %struct.node* %5, null, !dbg !41, !verifier.code !12
  br i1 %10, label %forwarder, label %._crit_edge, !dbg !41, !llvm.loop !51, !verifier.code !12

._crit_edge:                                      ; preds = %3
  br label %11, !dbg !41, !verifier.code !12

11:                                               ; preds = %._crit_edge, %1
  ret void, !dbg !53, !verifier.code !12

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define internal void @remove_fw_link(%struct.node* %0) #0 !dbg !54 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !55, metadata !DIExpression()), !dbg !56, !verifier.code !12
  %2 = icmp ne %struct.node* %0, null, !dbg !57, !verifier.code !12
  br i1 %2, label %.lr.ph, label %8, !dbg !57, !verifier.code !12

.lr.ph:                                           ; preds = %1
  br label %3, !dbg !57, !verifier.code !12

3:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %0, %.lr.ph ], [ %5, %forwarder ], !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !55, metadata !DIExpression()), !dbg !56, !verifier.code !12
  %4 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !58, !verifier.code !12
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !58, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !60, metadata !DIExpression()), !dbg !61, !verifier.code !12
  %6 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !62, !verifier.code !12
  store %struct.node* null, %struct.node** %6, align 8, !dbg !63, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !55, metadata !DIExpression()), !dbg !56, !verifier.code !12
  %7 = icmp ne %struct.node* %5, null, !dbg !57, !verifier.code !12
  br i1 %7, label %forwarder, label %._crit_edge, !dbg !57, !llvm.loop !64, !verifier.code !12

._crit_edge:                                      ; preds = %3
  br label %8, !dbg !57, !verifier.code !12

8:                                                ; preds = %._crit_edge, %1
  ret void, !dbg !66, !verifier.code !12

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define internal void @check_seq_next(%struct.node* %0, %struct.node* %1) #0 !dbg !67 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !75, metadata !DIExpression()), !dbg !74, !verifier.code !12
  br label %3, !dbg !76, !verifier.code !12

3:                                                ; preds = %2
  %4 = icmp ne %struct.node* %0, null, !dbg !77, !verifier.code !12
  br i1 %4, label %6, label %5, !dbg !80, !verifier.code !12

5:                                                ; preds = %3
  call void @fail(), !dbg !77, !verifier.code !12
  br label %6, !dbg !77, !verifier.code !12

6:                                                ; preds = %5, %3
  br label %7, !dbg !80, !verifier.code !12

7:                                                ; preds = %6
  br label %8, !dbg !81, !verifier.code !12

8:                                                ; preds = %7
  %9 = icmp ne %struct.node* %1, null, !dbg !82, !verifier.code !12
  br i1 %9, label %11, label %10, !dbg !85, !verifier.code !12

10:                                               ; preds = %8
  call void @fail(), !dbg !82, !verifier.code !12
  br label %11, !dbg !82, !verifier.code !12

11:                                               ; preds = %10, %8
  br label %12, !dbg !85, !verifier.code !12

12:                                               ; preds = %11
  %13 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 0, !dbg !86, !verifier.code !12
  %14 = load %struct.node*, %struct.node** %13, align 8, !dbg !86, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %14, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !12
  %15 = icmp ne %struct.node* %1, %14, !dbg !88, !verifier.code !12
  br i1 %15, label %.lr.ph, label %26, !dbg !90, !verifier.code !12

.lr.ph:                                           ; preds = %12
  br label %16, !dbg !90, !verifier.code !12

16:                                               ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %14, %.lr.ph ], [ %24, %forwarder ], !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !12
  br label %17, !dbg !91, !verifier.code !12

17:                                               ; preds = %16
  %18 = icmp ne %struct.node* %.01, null, !dbg !92, !verifier.code !12
  br i1 %18, label %20, label %19, !dbg !95, !verifier.code !12

19:                                               ; preds = %17
  call void @fail(), !dbg !92, !verifier.code !12
  br label %20, !dbg !92, !verifier.code !12

20:                                               ; preds = %19, %17
  br label %21, !dbg !95, !verifier.code !12

21:                                               ; preds = %20
  br label %22, !dbg !95, !verifier.code !12

22:                                               ; preds = %21
  %23 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !96, !verifier.code !12
  %24 = load %struct.node*, %struct.node** %23, align 8, !dbg !96, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %24, metadata !73, metadata !DIExpression()), !dbg !74, !verifier.code !12
  %25 = icmp ne %struct.node* %1, %24, !dbg !88, !verifier.code !12
  br i1 %25, label %forwarder, label %._crit_edge, !dbg !90, !llvm.loop !97, !verifier.code !12

._crit_edge:                                      ; preds = %22
  br label %26, !dbg !90, !verifier.code !12

26:                                               ; preds = %._crit_edge, %12
  ret void, !dbg !99, !verifier.code !12

forwarder:                                        ; preds = %22
  br label %16, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define internal void @fail() #0 !dbg !100 {
  br label %1, !dbg !101, !verifier.code !12

1:                                                ; preds = %0
  call void @llvm.dbg.label(metadata !102), !dbg !103, !verifier.code !12
  call void @reach_error(), !dbg !104, !verifier.code !12
  call void @abort() #5, !dbg !106, !verifier.code !12
  unreachable, !dbg !106, !verifier.code !12
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #2

; Function Attrs: noinline nounwind uwtable
define internal void @check_seq_prev(%struct.node* %0, %struct.node* %1) #0 !dbg !107 {
  call void @llvm.dbg.value(metadata %struct.node* %0, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %1, metadata !110, metadata !DIExpression()), !dbg !109, !verifier.code !12
  br label %3, !dbg !111, !verifier.code !12

3:                                                ; preds = %2
  %4 = icmp ne %struct.node* %0, null, !dbg !112, !verifier.code !12
  br i1 %4, label %6, label %5, !dbg !115, !verifier.code !12

5:                                                ; preds = %3
  call void @fail(), !dbg !112, !verifier.code !12
  br label %6, !dbg !112, !verifier.code !12

6:                                                ; preds = %5, %3
  br label %7, !dbg !115, !verifier.code !12

7:                                                ; preds = %6
  br label %8, !dbg !116, !verifier.code !12

8:                                                ; preds = %7
  %9 = icmp ne %struct.node* %1, null, !dbg !117, !verifier.code !12
  br i1 %9, label %11, label %10, !dbg !120, !verifier.code !12

10:                                               ; preds = %8
  call void @fail(), !dbg !117, !verifier.code !12
  br label %11, !dbg !117, !verifier.code !12

11:                                               ; preds = %10, %8
  br label %12, !dbg !120, !verifier.code !12

12:                                               ; preds = %11
  %13 = getelementptr inbounds %struct.node, %struct.node* %0, i32 0, i32 1, !dbg !121, !verifier.code !12
  %14 = load %struct.node*, %struct.node** %13, align 8, !dbg !121, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %14, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !12
  %15 = icmp ne %struct.node* %1, %14, !dbg !123, !verifier.code !12
  br i1 %15, label %.lr.ph, label %26, !dbg !125, !verifier.code !12

.lr.ph:                                           ; preds = %12
  br label %16, !dbg !125, !verifier.code !12

16:                                               ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %14, %.lr.ph ], [ %24, %forwarder ], !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !12
  br label %17, !dbg !126, !verifier.code !12

17:                                               ; preds = %16
  %18 = icmp ne %struct.node* %.01, null, !dbg !127, !verifier.code !12
  br i1 %18, label %20, label %19, !dbg !130, !verifier.code !12

19:                                               ; preds = %17
  call void @fail(), !dbg !127, !verifier.code !12
  br label %20, !dbg !127, !verifier.code !12

20:                                               ; preds = %19, %17
  br label %21, !dbg !130, !verifier.code !12

21:                                               ; preds = %20
  br label %22, !dbg !130, !verifier.code !12

22:                                               ; preds = %21
  %23 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !131, !verifier.code !12
  %24 = load %struct.node*, %struct.node** %23, align 8, !dbg !131, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %24, metadata !108, metadata !DIExpression()), !dbg !109, !verifier.code !12
  %25 = icmp ne %struct.node* %1, %24, !dbg !123, !verifier.code !12
  br i1 %25, label %forwarder, label %._crit_edge, !dbg !125, !llvm.loop !132, !verifier.code !12

._crit_edge:                                      ; preds = %22
  br label %26, !dbg !125, !verifier.code !12

26:                                               ; preds = %._crit_edge, %12
  ret void, !dbg !134, !verifier.code !12

forwarder:                                        ; preds = %22
  br label %16, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !135 {
  %1 = alloca %struct.node*, align 8, !verifier.code !12
  %2 = alloca %struct.node*, align 8, !verifier.code !12
  call void @llvm.dbg.declare(metadata %struct.node** %1, metadata !139, metadata !DIExpression()), !dbg !140, !verifier.code !12
  call void @llvm.dbg.declare(metadata %struct.node** %2, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !12
  %3 = call %struct.node* @create_sll(%struct.node** %1, %struct.node** %2), !dbg !143, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !12
  br label %4, !dbg !146, !verifier.code !12

4:                                                ; preds = %0
  br label %5, !dbg !147, !verifier.code !12

5:                                                ; preds = %4
  %6 = load %struct.node*, %struct.node** %1, align 8, !dbg !149, !verifier.code !12
  %7 = load %struct.node*, %struct.node** %2, align 8, !dbg !150, !verifier.code !12
  call void @check_seq_next(%struct.node* %6, %struct.node* %7), !dbg !151, !verifier.code !12
  br label %8, !dbg !152, !verifier.code !12

8:                                                ; preds = %5
  %9 = load %struct.node*, %struct.node** %1, align 8, !dbg !153, !verifier.code !12
  %10 = getelementptr inbounds %struct.node, %struct.node* %9, i32 0, i32 1, !dbg !153, !verifier.code !12
  %11 = load %struct.node*, %struct.node** %10, align 8, !dbg !153, !verifier.code !12
  %12 = icmp ne %struct.node* %11, null, !dbg !153, !verifier.code !12
  br i1 %12, label %13, label %14, !dbg !156, !verifier.code !12

13:                                               ; preds = %8
  call void @fail(), !dbg !153, !verifier.code !12
  br label %14, !dbg !153, !verifier.code !12

14:                                               ; preds = %13, %8
  br label %15, !dbg !156, !verifier.code !12

15:                                               ; preds = %14
  br label %16, !dbg !157, !verifier.code !12

16:                                               ; preds = %15
  %17 = load %struct.node*, %struct.node** %2, align 8, !dbg !158, !verifier.code !12
  %18 = getelementptr inbounds %struct.node, %struct.node* %17, i32 0, i32 1, !dbg !158, !verifier.code !12
  %19 = load %struct.node*, %struct.node** %18, align 8, !dbg !158, !verifier.code !12
  %20 = icmp ne %struct.node* %19, null, !dbg !158, !verifier.code !12
  br i1 %20, label %21, label %22, !dbg !161, !verifier.code !12

21:                                               ; preds = %16
  call void @fail(), !dbg !158, !verifier.code !12
  br label %22, !dbg !158, !verifier.code !12

22:                                               ; preds = %21, %16
  br label %23, !dbg !161, !verifier.code !12

23:                                               ; preds = %22
  call void @init_back_link(%struct.node* %3), !dbg !162, !verifier.code !12
  br label %24, !dbg !163, !verifier.code !12

24:                                               ; preds = %23
  br label %25, !dbg !164, !verifier.code !12

25:                                               ; preds = %24
  %26 = load %struct.node*, %struct.node** %1, align 8, !dbg !166, !verifier.code !12
  %27 = load %struct.node*, %struct.node** %2, align 8, !dbg !167, !verifier.code !12
  call void @check_seq_next(%struct.node* %26, %struct.node* %27), !dbg !168, !verifier.code !12
  %28 = load %struct.node*, %struct.node** %2, align 8, !dbg !169, !verifier.code !12
  %29 = load %struct.node*, %struct.node** %1, align 8, !dbg !170, !verifier.code !12
  call void @check_seq_prev(%struct.node* %28, %struct.node* %29), !dbg !171, !verifier.code !12
  call void @reverse_dll(%struct.node* %3), !dbg !172, !verifier.code !12
  br label %30, !dbg !173, !verifier.code !12

30:                                               ; preds = %25
  br label %31, !dbg !174, !verifier.code !12

31:                                               ; preds = %30
  %32 = load %struct.node*, %struct.node** %1, align 8, !dbg !176, !verifier.code !12
  %33 = load %struct.node*, %struct.node** %2, align 8, !dbg !177, !verifier.code !12
  call void @check_seq_prev(%struct.node* %32, %struct.node* %33), !dbg !178, !verifier.code !12
  %34 = load %struct.node*, %struct.node** %2, align 8, !dbg !179, !verifier.code !12
  %35 = load %struct.node*, %struct.node** %1, align 8, !dbg !180, !verifier.code !12
  call void @check_seq_next(%struct.node* %34, %struct.node* %35), !dbg !181, !verifier.code !12
  call void @remove_fw_link(%struct.node* %3), !dbg !182, !verifier.code !12
  br label %36, !dbg !183, !verifier.code !12

36:                                               ; preds = %31
  br label %37, !dbg !184, !verifier.code !12

37:                                               ; preds = %36
  %38 = load %struct.node*, %struct.node** %1, align 8, !dbg !186, !verifier.code !12
  %39 = load %struct.node*, %struct.node** %2, align 8, !dbg !187, !verifier.code !12
  call void @check_seq_prev(%struct.node* %38, %struct.node* %39), !dbg !188, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !12
  %40 = icmp ne %struct.node* %3, null, !dbg !189, !verifier.code !12
  br i1 %40, label %.lr.ph, label %46, !dbg !189, !verifier.code !12

.lr.ph:                                           ; preds = %37
  br label %41, !dbg !189, !verifier.code !12

41:                                               ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %3, %.lr.ph ], [ %43, %forwarder ], !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !12
  %42 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 1, !dbg !190, !verifier.code !12
  %43 = load %struct.node*, %struct.node** %42, align 8, !dbg !190, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %43, metadata !192, metadata !DIExpression()), !dbg !193, !verifier.code !12
  %44 = bitcast %struct.node* %.01 to i8*, !dbg !194, !verifier.code !12
  call void @free(i8* %44) #6, !dbg !195, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %43, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !12
  %45 = icmp ne %struct.node* %43, null, !dbg !189, !verifier.code !12
  br i1 %45, label %forwarder, label %._crit_edge, !dbg !189, !llvm.loop !196, !verifier.code !12

._crit_edge:                                      ; preds = %41
  br label %46, !dbg !189, !verifier.code !12

46:                                               ; preds = %._crit_edge, %37
  ret i32 0, !dbg !198, !verifier.code !12

forwarder:                                        ; preds = %41
  br label %41, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @create_sll(%struct.node** %0, %struct.node** %1) #0 !dbg !199 {
  %3 = alloca %struct.node*, align 8, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node** %0, metadata !203, metadata !DIExpression()), !dbg !204, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node** %1, metadata !205, metadata !DIExpression()), !dbg !204, !verifier.code !12
  call void @llvm.dbg.declare(metadata %struct.node** %3, metadata !206, metadata !DIExpression()), !dbg !207, !verifier.code !12
  store %struct.node* null, %struct.node** %3, align 8, !dbg !207, !verifier.code !12
  br label %4, !dbg !208, !verifier.code !12

4:                                                ; preds = %5, %2
  call void @chain_node(%struct.node** %3), !dbg !209, !verifier.code !12
  br label %5, !dbg !209, !verifier.code !12

5:                                                ; preds = %4
  %6 = call i32 @__VERIFIER_nondet_int(), !dbg !210, !verifier.code !211
  %7 = icmp ne i32 %6, 0, !dbg !209, !verifier.code !12
  br i1 %7, label %4, label %8, !dbg !209, !llvm.loop !212, !verifier.code !12

8:                                                ; preds = %5
  %9 = load %struct.node*, %struct.node** %3, align 8, !dbg !214, !verifier.code !12
  store %struct.node* %9, %struct.node** %1, align 8, !dbg !215, !verifier.code !12
  %10 = call i32 @__VERIFIER_nondet_int(), !dbg !216, !verifier.code !211
  %11 = icmp ne i32 %10, 0, !dbg !217, !verifier.code !12
  br i1 %11, label %.lr.ph, label %15, !dbg !217, !verifier.code !12

.lr.ph:                                           ; preds = %8
  br label %12, !dbg !217, !verifier.code !12

12:                                               ; preds = %.lr.ph, %12
  call void @chain_node(%struct.node** %3), !dbg !218, !verifier.code !12
  %13 = call i32 @__VERIFIER_nondet_int(), !dbg !216, !verifier.code !211
  %14 = icmp ne i32 %13, 0, !dbg !217, !verifier.code !12
  br i1 %14, label %12, label %._crit_edge, !dbg !217, !llvm.loop !219, !verifier.code !12

._crit_edge:                                      ; preds = %12
  br label %15, !dbg !217, !verifier.code !12

15:                                               ; preds = %._crit_edge, %8
  %16 = load %struct.node*, %struct.node** %3, align 8, !dbg !221, !verifier.code !12
  store %struct.node* %16, %struct.node** %0, align 8, !dbg !222, !verifier.code !12
  br label %17, !dbg !223, !verifier.code !12

17:                                               ; preds = %18, %15
  call void @chain_node(%struct.node** %3), !dbg !224, !verifier.code !12
  br label %18, !dbg !224, !verifier.code !12

18:                                               ; preds = %17
  %19 = call i32 @__VERIFIER_nondet_int(), !dbg !225, !verifier.code !211
  %20 = icmp ne i32 %19, 0, !dbg !224, !verifier.code !12
  br i1 %20, label %17, label %21, !dbg !224, !llvm.loop !226, !verifier.code !12

21:                                               ; preds = %18
  %22 = load %struct.node*, %struct.node** %3, align 8, !dbg !228, !verifier.code !12
  ret %struct.node* %22, !dbg !229, !verifier.code !12
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal void @chain_node(%struct.node** %0) #0 !dbg !230 {
  call void @llvm.dbg.value(metadata %struct.node** %0, metadata !234, metadata !DIExpression()), !dbg !235, !verifier.code !12
  %2 = call %struct.node* @alloc_node(), !dbg !236, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %2, metadata !237, metadata !DIExpression()), !dbg !235, !verifier.code !12
  %3 = load %struct.node*, %struct.node** %0, align 8, !dbg !238, !verifier.code !12
  %4 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !239, !verifier.code !12
  store %struct.node* %3, %struct.node** %4, align 8, !dbg !240, !verifier.code !12
  store %struct.node* %2, %struct.node** %0, align 8, !dbg !241, !verifier.code !12
  ret void, !dbg !242, !verifier.code !12
}

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal %struct.node* @alloc_node() #0 !dbg !243 {
  %1 = call noalias i8* @malloc(i64 16) #6, !dbg !246, !verifier.code !12
  %2 = bitcast i8* %1 to %struct.node*, !dbg !246, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %2, metadata !247, metadata !DIExpression()), !dbg !248, !verifier.code !12
  %3 = icmp ne %struct.node* %2, null, !dbg !249, !verifier.code !12
  br i1 %3, label %5, label %4, !dbg !251, !verifier.code !12

4:                                                ; preds = %0
  call void @abort() #5, !dbg !252, !verifier.code !12
  unreachable, !dbg !252, !verifier.code !12

5:                                                ; preds = %0
  %6 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !253, !verifier.code !12
  store %struct.node* null, %struct.node** %6, align 8, !dbg !254, !verifier.code !12
  %7 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 1, !dbg !255, !verifier.code !12
  store %struct.node* null, %struct.node** %7, align 8, !dbg !256, !verifier.code !12
  ret %struct.node* %2, !dbg !257, !verifier.code !12
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/sll_to_dll_rev-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "reach_error", scope: !8, file: !8, line: 2, type: !9, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//sll_to_dll_rev-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !DISubroutineType(types: !10)
!10 = !{null}
!11 = !DILocation(line: 2, column: 20, scope: !7)
!12 = !{i1 false}
!13 = distinct !DISubprogram(name: "init_back_link", scope: !8, file: !8, line: 66, type: !14, scopeLine: 66, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!14 = !DISubroutineType(types: !15)
!15 = !{null, !16}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !8, line: 21, size: 128, elements: !18)
!18 = !{!19, !20}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !17, file: !8, line: 22, baseType: !16, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !17, file: !8, line: 23, baseType: !16, size: 64, offset: 64)
!21 = !DILocalVariable(name: "list", arg: 1, scope: !13, file: !8, line: 66, type: !16)
!22 = !DILocation(line: 0, scope: !13)
!23 = !DILocation(line: 68, column: 35, scope: !24)
!24 = distinct !DILexicalBlock(scope: !25, file: !8, line: 67, column: 14)
!25 = distinct !DILexicalBlock(scope: !26, file: !8, line: 67, column: 5)
!26 = distinct !DILexicalBlock(scope: !13, file: !8, line: 67, column: 5)
!27 = !DILocalVariable(name: "next", scope: !24, file: !8, line: 68, type: !16)
!28 = !DILocation(line: 0, scope: !24)
!29 = !DILocation(line: 69, column: 14, scope: !30)
!30 = distinct !DILexicalBlock(scope: !24, file: !8, line: 69, column: 13)
!31 = !DILocation(line: 69, column: 13, scope: !24)
!32 = !DILocation(line: 70, column: 13, scope: !30)
!33 = !DILocation(line: 72, column: 15, scope: !24)
!34 = !DILocation(line: 72, column: 20, scope: !24)
!35 = distinct !{!35, !36, !37}
!36 = !DILocation(line: 67, column: 5, scope: !26)
!37 = !DILocation(line: 74, column: 5, scope: !26)
!38 = distinct !DISubprogram(name: "reverse_dll", scope: !8, file: !8, line: 77, type: !14, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!39 = !DILocalVariable(name: "list", arg: 1, scope: !38, file: !8, line: 77, type: !16)
!40 = !DILocation(line: 0, scope: !38)
!41 = !DILocation(line: 78, column: 5, scope: !38)
!42 = !DILocation(line: 79, column: 35, scope: !43)
!43 = distinct !DILexicalBlock(scope: !38, file: !8, line: 78, column: 18)
!44 = !DILocalVariable(name: "next", scope: !43, file: !8, line: 79, type: !16)
!45 = !DILocation(line: 0, scope: !43)
!46 = !DILocation(line: 80, column: 28, scope: !43)
!47 = !DILocation(line: 80, column: 15, scope: !43)
!48 = !DILocation(line: 80, column: 20, scope: !43)
!49 = !DILocation(line: 81, column: 15, scope: !43)
!50 = !DILocation(line: 81, column: 20, scope: !43)
!51 = distinct !{!51, !41, !52}
!52 = !DILocation(line: 83, column: 5, scope: !38)
!53 = !DILocation(line: 84, column: 1, scope: !38)
!54 = distinct !DISubprogram(name: "remove_fw_link", scope: !8, file: !8, line: 86, type: !14, scopeLine: 86, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!55 = !DILocalVariable(name: "list", arg: 1, scope: !54, file: !8, line: 86, type: !16)
!56 = !DILocation(line: 0, scope: !54)
!57 = !DILocation(line: 87, column: 5, scope: !54)
!58 = !DILocation(line: 88, column: 35, scope: !59)
!59 = distinct !DILexicalBlock(scope: !54, file: !8, line: 87, column: 18)
!60 = !DILocalVariable(name: "next", scope: !59, file: !8, line: 88, type: !16)
!61 = !DILocation(line: 0, scope: !59)
!62 = !DILocation(line: 89, column: 15, scope: !59)
!63 = !DILocation(line: 89, column: 20, scope: !59)
!64 = distinct !{!64, !57, !65}
!65 = !DILocation(line: 91, column: 5, scope: !54)
!66 = !DILocation(line: 92, column: 1, scope: !54)
!67 = distinct !DISubprogram(name: "check_seq_next", scope: !8, file: !8, line: 94, type: !68, scopeLine: 94, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!68 = !DISubroutineType(types: !69)
!69 = !{null, !70, !72}
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !17)
!72 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !70)
!73 = !DILocalVariable(name: "beg", arg: 1, scope: !67, file: !8, line: 94, type: !70)
!74 = !DILocation(line: 0, scope: !67)
!75 = !DILocalVariable(name: "end", arg: 2, scope: !67, file: !8, line: 94, type: !72)
!76 = !DILocation(line: 95, column: 5, scope: !67)
!77 = !DILocation(line: 95, column: 5, scope: !78)
!78 = distinct !DILexicalBlock(scope: !79, file: !8, line: 95, column: 5)
!79 = distinct !DILexicalBlock(scope: !67, file: !8, line: 95, column: 5)
!80 = !DILocation(line: 95, column: 5, scope: !79)
!81 = !DILocation(line: 96, column: 5, scope: !67)
!82 = !DILocation(line: 96, column: 5, scope: !83)
!83 = distinct !DILexicalBlock(scope: !84, file: !8, line: 96, column: 5)
!84 = distinct !DILexicalBlock(scope: !67, file: !8, line: 96, column: 5)
!85 = !DILocation(line: 96, column: 5, scope: !84)
!86 = !DILocation(line: 98, column: 21, scope: !87)
!87 = distinct !DILexicalBlock(scope: !67, file: !8, line: 98, column: 5)
!88 = !DILocation(line: 98, column: 31, scope: !89)
!89 = distinct !DILexicalBlock(scope: !87, file: !8, line: 98, column: 5)
!90 = !DILocation(line: 98, column: 5, scope: !87)
!91 = !DILocation(line: 99, column: 9, scope: !89)
!92 = !DILocation(line: 99, column: 9, scope: !93)
!93 = distinct !DILexicalBlock(scope: !94, file: !8, line: 99, column: 9)
!94 = distinct !DILexicalBlock(scope: !89, file: !8, line: 99, column: 9)
!95 = !DILocation(line: 99, column: 9, scope: !94)
!96 = !DILocation(line: 98, column: 50, scope: !89)
!97 = distinct !{!97, !90, !98}
!98 = !DILocation(line: 99, column: 9, scope: !87)
!99 = !DILocation(line: 100, column: 1, scope: !67)
!100 = distinct !DISubprogram(name: "fail", scope: !8, file: !8, line: 8, type: !9, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!101 = !DILocation(line: 8, column: 24, scope: !100)
!102 = !DILabel(scope: !100, name: "ERROR", file: !8, line: 9)
!103 = !DILocation(line: 9, column: 1, scope: !100)
!104 = !DILocation(line: 9, column: 9, scope: !105)
!105 = distinct !DILexicalBlock(scope: !100, file: !8, line: 9, column: 8)
!106 = !DILocation(line: 9, column: 23, scope: !105)
!107 = distinct !DISubprogram(name: "check_seq_prev", scope: !8, file: !8, line: 102, type: !68, scopeLine: 102, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!108 = !DILocalVariable(name: "beg", arg: 1, scope: !107, file: !8, line: 102, type: !70)
!109 = !DILocation(line: 0, scope: !107)
!110 = !DILocalVariable(name: "end", arg: 2, scope: !107, file: !8, line: 102, type: !72)
!111 = !DILocation(line: 103, column: 5, scope: !107)
!112 = !DILocation(line: 103, column: 5, scope: !113)
!113 = distinct !DILexicalBlock(scope: !114, file: !8, line: 103, column: 5)
!114 = distinct !DILexicalBlock(scope: !107, file: !8, line: 103, column: 5)
!115 = !DILocation(line: 103, column: 5, scope: !114)
!116 = !DILocation(line: 104, column: 5, scope: !107)
!117 = !DILocation(line: 104, column: 5, scope: !118)
!118 = distinct !DILexicalBlock(scope: !119, file: !8, line: 104, column: 5)
!119 = distinct !DILexicalBlock(scope: !107, file: !8, line: 104, column: 5)
!120 = !DILocation(line: 104, column: 5, scope: !119)
!121 = !DILocation(line: 106, column: 21, scope: !122)
!122 = distinct !DILexicalBlock(scope: !107, file: !8, line: 106, column: 5)
!123 = !DILocation(line: 106, column: 31, scope: !124)
!124 = distinct !DILexicalBlock(scope: !122, file: !8, line: 106, column: 5)
!125 = !DILocation(line: 106, column: 5, scope: !122)
!126 = !DILocation(line: 107, column: 9, scope: !124)
!127 = !DILocation(line: 107, column: 9, scope: !128)
!128 = distinct !DILexicalBlock(scope: !129, file: !8, line: 107, column: 9)
!129 = distinct !DILexicalBlock(scope: !124, file: !8, line: 107, column: 9)
!130 = !DILocation(line: 107, column: 9, scope: !129)
!131 = !DILocation(line: 106, column: 50, scope: !124)
!132 = distinct !{!132, !125, !133}
!133 = !DILocation(line: 107, column: 9, scope: !122)
!134 = !DILocation(line: 108, column: 1, scope: !107)
!135 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 110, type: !136, scopeLine: 111, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!136 = !DISubroutineType(types: !137)
!137 = !{!138}
!138 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!139 = !DILocalVariable(name: "p1", scope: !135, file: !8, line: 112, type: !70)
!140 = !DILocation(line: 112, column: 24, scope: !135)
!141 = !DILocalVariable(name: "p2", scope: !135, file: !8, line: 112, type: !70)
!142 = !DILocation(line: 112, column: 29, scope: !135)
!143 = !DILocation(line: 114, column: 25, scope: !135)
!144 = !DILocalVariable(name: "list", scope: !135, file: !8, line: 114, type: !16)
!145 = !DILocation(line: 0, scope: !135)
!146 = !DILocation(line: 115, column: 5, scope: !135)
!147 = !DILocation(line: 115, column: 5, scope: !148)
!148 = distinct !DILexicalBlock(scope: !135, file: !8, line: 115, column: 5)
!149 = !DILocation(line: 116, column: 20, scope: !135)
!150 = !DILocation(line: 116, column: 24, scope: !135)
!151 = !DILocation(line: 116, column: 5, scope: !135)
!152 = !DILocation(line: 117, column: 5, scope: !135)
!153 = !DILocation(line: 117, column: 5, scope: !154)
!154 = distinct !DILexicalBlock(scope: !155, file: !8, line: 117, column: 5)
!155 = distinct !DILexicalBlock(scope: !135, file: !8, line: 117, column: 5)
!156 = !DILocation(line: 117, column: 5, scope: !155)
!157 = !DILocation(line: 118, column: 5, scope: !135)
!158 = !DILocation(line: 118, column: 5, scope: !159)
!159 = distinct !DILexicalBlock(scope: !160, file: !8, line: 118, column: 5)
!160 = distinct !DILexicalBlock(scope: !135, file: !8, line: 118, column: 5)
!161 = !DILocation(line: 118, column: 5, scope: !160)
!162 = !DILocation(line: 120, column: 5, scope: !135)
!163 = !DILocation(line: 121, column: 5, scope: !135)
!164 = !DILocation(line: 121, column: 5, scope: !165)
!165 = distinct !DILexicalBlock(scope: !135, file: !8, line: 121, column: 5)
!166 = !DILocation(line: 122, column: 20, scope: !135)
!167 = !DILocation(line: 122, column: 24, scope: !135)
!168 = !DILocation(line: 122, column: 5, scope: !135)
!169 = !DILocation(line: 123, column: 20, scope: !135)
!170 = !DILocation(line: 123, column: 24, scope: !135)
!171 = !DILocation(line: 123, column: 5, scope: !135)
!172 = !DILocation(line: 125, column: 5, scope: !135)
!173 = !DILocation(line: 126, column: 5, scope: !135)
!174 = !DILocation(line: 126, column: 5, scope: !175)
!175 = distinct !DILexicalBlock(scope: !135, file: !8, line: 126, column: 5)
!176 = !DILocation(line: 127, column: 20, scope: !135)
!177 = !DILocation(line: 127, column: 24, scope: !135)
!178 = !DILocation(line: 127, column: 5, scope: !135)
!179 = !DILocation(line: 128, column: 20, scope: !135)
!180 = !DILocation(line: 128, column: 24, scope: !135)
!181 = !DILocation(line: 128, column: 5, scope: !135)
!182 = !DILocation(line: 130, column: 5, scope: !135)
!183 = !DILocation(line: 131, column: 5, scope: !135)
!184 = !DILocation(line: 131, column: 5, scope: !185)
!185 = distinct !DILexicalBlock(scope: !135, file: !8, line: 131, column: 5)
!186 = !DILocation(line: 132, column: 20, scope: !135)
!187 = !DILocation(line: 132, column: 24, scope: !135)
!188 = !DILocation(line: 132, column: 5, scope: !135)
!189 = !DILocation(line: 134, column: 5, scope: !135)
!190 = !DILocation(line: 135, column: 35, scope: !191)
!191 = distinct !DILexicalBlock(scope: !135, file: !8, line: 134, column: 18)
!192 = !DILocalVariable(name: "prev", scope: !191, file: !8, line: 135, type: !16)
!193 = !DILocation(line: 0, scope: !191)
!194 = !DILocation(line: 136, column: 14, scope: !191)
!195 = !DILocation(line: 136, column: 9, scope: !191)
!196 = distinct !{!196, !189, !197}
!197 = !DILocation(line: 138, column: 5, scope: !135)
!198 = !DILocation(line: 140, column: 5, scope: !135)
!199 = distinct !DISubprogram(name: "create_sll", scope: !8, file: !8, line: 44, type: !200, scopeLine: 45, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!200 = !DISubroutineType(types: !201)
!201 = !{!16, !202, !202}
!202 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!203 = !DILocalVariable(name: "pp1", arg: 1, scope: !199, file: !8, line: 44, type: !202)
!204 = !DILocation(line: 0, scope: !199)
!205 = !DILocalVariable(name: "pp2", arg: 2, scope: !199, file: !8, line: 44, type: !202)
!206 = !DILocalVariable(name: "list", scope: !199, file: !8, line: 46, type: !16)
!207 = !DILocation(line: 46, column: 18, scope: !199)
!208 = !DILocation(line: 48, column: 5, scope: !199)
!209 = !DILocation(line: 49, column: 9, scope: !199)
!210 = !DILocation(line: 50, column: 12, scope: !199)
!211 = !{i1 true}
!212 = distinct !{!212, !208, !213}
!213 = !DILocation(line: 50, column: 35, scope: !199)
!214 = !DILocation(line: 52, column: 12, scope: !199)
!215 = !DILocation(line: 52, column: 10, scope: !199)
!216 = !DILocation(line: 54, column: 12, scope: !199)
!217 = !DILocation(line: 54, column: 5, scope: !199)
!218 = !DILocation(line: 55, column: 9, scope: !199)
!219 = distinct !{!219, !217, !220}
!220 = !DILocation(line: 55, column: 25, scope: !199)
!221 = !DILocation(line: 57, column: 12, scope: !199)
!222 = !DILocation(line: 57, column: 10, scope: !199)
!223 = !DILocation(line: 59, column: 5, scope: !199)
!224 = !DILocation(line: 60, column: 9, scope: !199)
!225 = !DILocation(line: 61, column: 12, scope: !199)
!226 = distinct !{!226, !223, !227}
!227 = !DILocation(line: 61, column: 35, scope: !199)
!228 = !DILocation(line: 63, column: 12, scope: !199)
!229 = !DILocation(line: 63, column: 5, scope: !199)
!230 = distinct !DISubprogram(name: "chain_node", scope: !8, file: !8, line: 37, type: !231, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!231 = !DISubroutineType(types: !232)
!232 = !{null, !233}
!233 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!234 = !DILocalVariable(name: "ppnode", arg: 1, scope: !230, file: !8, line: 37, type: !233)
!235 = !DILocation(line: 0, scope: !230)
!236 = !DILocation(line: 39, column: 25, scope: !230)
!237 = !DILocalVariable(name: "node", scope: !230, file: !8, line: 39, type: !16)
!238 = !DILocation(line: 40, column: 18, scope: !230)
!239 = !DILocation(line: 40, column: 11, scope: !230)
!240 = !DILocation(line: 40, column: 16, scope: !230)
!241 = !DILocation(line: 41, column: 13, scope: !230)
!242 = !DILocation(line: 42, column: 1, scope: !230)
!243 = distinct !DISubprogram(name: "alloc_node", scope: !8, file: !8, line: 26, type: !244, scopeLine: 27, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!244 = !DISubroutineType(types: !245)
!245 = !{!16}
!246 = !DILocation(line: 28, column: 24, scope: !243)
!247 = !DILocalVariable(name: "ptr", scope: !243, file: !8, line: 28, type: !16)
!248 = !DILocation(line: 0, scope: !243)
!249 = !DILocation(line: 29, column: 10, scope: !250)
!250 = distinct !DILexicalBlock(scope: !243, file: !8, line: 29, column: 9)
!251 = !DILocation(line: 29, column: 9, scope: !243)
!252 = !DILocation(line: 30, column: 9, scope: !250)
!253 = !DILocation(line: 32, column: 10, scope: !243)
!254 = !DILocation(line: 32, column: 15, scope: !243)
!255 = !DILocation(line: 33, column: 10, scope: !243)
!256 = !DILocation(line: 33, column: 15, scope: !243)
!257 = !DILocation(line: 34, column: 5, scope: !243)
