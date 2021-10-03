; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-qs22klnm.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ldv_list_head = type { %struct.ldv_list_head*, %struct.ldv_list_head* }
%struct.A = type { i8* }
%struct.ldv_msg = type { i8*, %struct.ldv_list_head }
%struct.ldv_kobject = type { i8*, %struct.ldv_list_head, %struct.ldv_kref }
%struct.ldv_kref = type { %struct.ldv_atomic_t }
%struct.ldv_atomic_t = type { i32 }

@ldv_global_msg_list = internal global %struct.ldv_list_head { %struct.ldv_list_head* @ldv_global_msg_list, %struct.ldv_list_head* @ldv_global_msg_list }, align 8, !dbg !0
@a6 = internal global %struct.A zeroinitializer, align 8, !dbg !37

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_nonpositive() #0 !dbg !46 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !49, !verifier.code !50
  call void @llvm.dbg.value(metadata i32 %1, metadata !51, metadata !DIExpression()), !dbg !52, !verifier.code !53
  %2 = icmp slt i32 %1, 0, !dbg !54, !verifier.code !53
  br i1 %2, label %3, label %4, !dbg !56, !verifier.code !53

3:                                                ; preds = %0
  br label %5, !dbg !57, !verifier.code !53

4:                                                ; preds = %0
  br label %5, !dbg !58, !verifier.code !53

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ %1, %3 ], [ 0, %4 ], !dbg !59, !verifier.code !53
  ret i32 %.0, !dbg !60, !verifier.code !53
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_positive() #0 !dbg !61 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !62, !verifier.code !50
  call void @llvm.dbg.value(metadata i32 %1, metadata !63, metadata !DIExpression()), !dbg !64, !verifier.code !53
  %2 = icmp sgt i32 %1, 0, !dbg !65, !verifier.code !53
  br i1 %2, label %3, label %4, !dbg !67, !verifier.code !53

3:                                                ; preds = %0
  br label %5, !dbg !68, !verifier.code !53

4:                                                ; preds = %0
  br label %5, !dbg !69, !verifier.code !53

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ %1, %3 ], [ 1, %4 ], !dbg !70, !verifier.code !53
  ret i32 %.0, !dbg !71, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @ldv_malloc(i32 %0) #0 !dbg !72 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !53
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !77, !verifier.code !50
  %3 = icmp ne i32 %2, 0, !dbg !77, !verifier.code !53
  br i1 %3, label %4, label %6, !dbg !79, !verifier.code !53

4:                                                ; preds = %1
  %5 = call noalias i8* @malloc(i32 %0) #4, !dbg !80, !verifier.code !53
  br label %7, !dbg !82, !verifier.code !53

6:                                                ; preds = %1
  br label %7, !dbg !83, !verifier.code !53

7:                                                ; preds = %6, %4
  %.0 = phi i8* [ %5, %4 ], [ null, %6 ], !dbg !85, !verifier.code !53
  ret i8* %.0, !dbg !86, !verifier.code !53
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

; Function Attrs: noinline nounwind uwtable
define internal i8* @ldv_zalloc(i32 %0) #0 !dbg !87 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !53
  %2 = call noalias i8* @calloc(i32 %0, i32 1) #4, !dbg !90, !verifier.code !53
  ret i8* %2, !dbg !91, !verifier.code !53
}

; Function Attrs: nounwind
declare dso_local noalias i8* @calloc(i32, i32) #3

; Function Attrs: noinline nounwind uwtable
define internal %struct.ldv_msg* @ldv_msg_alloc() #0 !dbg !92 {
  %1 = call i8* @ldv_malloc(i32 24), !dbg !95, !verifier.code !53
  %2 = bitcast i8* %1 to %struct.ldv_msg*, !dbg !96, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %2, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !53
  %3 = icmp ne %struct.ldv_msg* %2, null, !dbg !99, !verifier.code !53
  br i1 %3, label %4, label %7, !dbg !101, !verifier.code !53

4:                                                ; preds = %0
  %5 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %2, i32 0, i32 0, !dbg !102, !verifier.code !53
  store i8* null, i8** %5, align 8, !dbg !104, !verifier.code !53
  %6 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %2, i32 0, i32 1, !dbg !105, !verifier.code !53
  call void @LDV_INIT_LIST_HEAD(%struct.ldv_list_head* %6), !dbg !106, !verifier.code !53
  br label %7, !dbg !107, !verifier.code !53

7:                                                ; preds = %4, %0
  ret %struct.ldv_msg* %2, !dbg !108, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @LDV_INIT_LIST_HEAD(%struct.ldv_list_head* %0) #0 !dbg !109 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !112, metadata !DIExpression()), !dbg !113, !verifier.code !53
  %2 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !114, !verifier.code !53
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %2, align 8, !dbg !115, !verifier.code !53
  %3 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 1, !dbg !116, !verifier.code !53
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %3, align 8, !dbg !117, !verifier.code !53
  ret void, !dbg !118, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_msg_fill(%struct.ldv_msg* %0, i8* %1, i32 %2) #0 !dbg !119 {
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %0, metadata !122, metadata !DIExpression()), !dbg !123, !verifier.code !53
  call void @llvm.dbg.value(metadata i8* %1, metadata !124, metadata !DIExpression()), !dbg !123, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %2, metadata !125, metadata !DIExpression()), !dbg !123, !verifier.code !53
  %4 = call i8* @ldv_malloc(i32 %2), !dbg !126, !verifier.code !53
  call void @llvm.dbg.value(metadata i8* %4, metadata !127, metadata !DIExpression()), !dbg !123, !verifier.code !53
  %5 = icmp ne i8* %4, null, !dbg !128, !verifier.code !53
  br i1 %5, label %7, label %6, !dbg !130, !verifier.code !53

6:                                                ; preds = %3
  br label %10, !dbg !131, !verifier.code !53

7:                                                ; preds = %3
  %8 = call i8* @memcpy(i8* %4, i8* %1, i32 %2), !dbg !132, !verifier.code !53
  %9 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %0, i32 0, i32 0, !dbg !133, !verifier.code !53
  store i8* %4, i8** %9, align 8, !dbg !134, !verifier.code !53
  br label %10, !dbg !135, !verifier.code !53

10:                                               ; preds = %7, %6
  %.0 = phi i32 [ 0, %7 ], [ 3, %6 ], !dbg !123, !verifier.code !53
  ret i32 %.0, !dbg !136, !verifier.code !53
}

declare dso_local i8* @memcpy(i8*, i8*, i32) #2

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_msg_free(%struct.ldv_msg* %0) #0 !dbg !137 {
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %0, metadata !140, metadata !DIExpression()), !dbg !141, !verifier.code !53
  %2 = icmp ne %struct.ldv_msg* %0, null, !dbg !142, !verifier.code !53
  br i1 %2, label %3, label %7, !dbg !144, !verifier.code !53

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %0, i32 0, i32 0, !dbg !145, !verifier.code !53
  %5 = load i8*, i8** %4, align 8, !dbg !145, !verifier.code !53
  call void @free(i8* %5) #4, !dbg !147, !verifier.code !53
  %6 = bitcast %struct.ldv_msg* %0 to i8*, !dbg !148, !verifier.code !53
  call void @free(i8* %6) #4, !dbg !149, !verifier.code !53
  br label %7, !dbg !150, !verifier.code !53

7:                                                ; preds = %3, %1
  ret void, !dbg !151, !verifier.code !53
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_submit_msg(%struct.ldv_msg* %0) #0 !dbg !152 {
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %0, metadata !155, metadata !DIExpression()), !dbg !156, !verifier.code !53
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !157, !verifier.code !50
  %3 = icmp ne i32 %2, 0, !dbg !157, !verifier.code !53
  br i1 %3, label %4, label %6, !dbg !159, !verifier.code !53

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %0, i32 0, i32 1, !dbg !160, !verifier.code !53
  call void @ldv_list_add(%struct.ldv_list_head* %5, %struct.ldv_list_head* @ldv_global_msg_list), !dbg !162, !verifier.code !53
  br label %7, !dbg !163, !verifier.code !53

6:                                                ; preds = %1
  br label %7, !dbg !164, !verifier.code !53

7:                                                ; preds = %6, %4
  %.0 = phi i32 [ 0, %4 ], [ -1, %6 ], !dbg !156, !verifier.code !53
  ret i32 %.0, !dbg !165, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_list_add(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1) #0 !dbg !166 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !169, metadata !DIExpression()), !dbg !170, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !171, metadata !DIExpression()), !dbg !170, !verifier.code !53
  %3 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %1, i32 0, i32 0, !dbg !172, !verifier.code !53
  %4 = load %struct.ldv_list_head*, %struct.ldv_list_head** %3, align 8, !dbg !172, !verifier.code !53
  call void @__ldv_list_add(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1, %struct.ldv_list_head* %4), !dbg !173, !verifier.code !53
  ret void, !dbg !174, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @__ldv_list_add(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1, %struct.ldv_list_head* %2) #0 !dbg !175 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !178, metadata !DIExpression()), !dbg !179, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !180, metadata !DIExpression()), !dbg !179, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %2, metadata !181, metadata !DIExpression()), !dbg !179, !verifier.code !53
  %4 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %2, i32 0, i32 1, !dbg !182, !verifier.code !53
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %4, align 8, !dbg !183, !verifier.code !53
  %5 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !184, !verifier.code !53
  store %struct.ldv_list_head* %2, %struct.ldv_list_head** %5, align 8, !dbg !185, !verifier.code !53
  %6 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 1, !dbg !186, !verifier.code !53
  store %struct.ldv_list_head* %1, %struct.ldv_list_head** %6, align 8, !dbg !187, !verifier.code !53
  %7 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %1, i32 0, i32 0, !dbg !188, !verifier.code !53
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %7, align 8, !dbg !189, !verifier.code !53
  ret void, !dbg !190, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_destroy_msgs() #0 !dbg !191 {
  %1 = load %struct.ldv_list_head*, %struct.ldv_list_head** getelementptr inbounds (%struct.ldv_list_head, %struct.ldv_list_head* @ldv_global_msg_list, i32 0, i32 0), align 8, !dbg !194, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !197, metadata !DIExpression()), !dbg !200, !verifier.code !53
  %2 = bitcast %struct.ldv_list_head* %1 to i8*, !dbg !201, !verifier.code !53
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_list_head* getelementptr inbounds (%struct.ldv_msg, %struct.ldv_msg* null, i32 0, i32 1) to i32) to i64)), !dbg !202, !verifier.code !53
  %4 = bitcast i8* %3 to %struct.ldv_msg*, !dbg !203, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %4, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !53
  %5 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %4, i32 0, i32 1, !dbg !206, !verifier.code !53
  %6 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %4, i32 0, i32 1, i32 0
  %7 = load %struct.ldv_list_head*, %struct.ldv_list_head** %6, align 8, !dbg !208, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %7, metadata !209, metadata !DIExpression()), !dbg !210, !verifier.code !53
  %8 = bitcast %struct.ldv_list_head* %7 to i8*, !dbg !211, !verifier.code !53
  %9 = getelementptr inbounds i8, i8* %8, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_list_head* getelementptr inbounds (%struct.ldv_msg, %struct.ldv_msg* null, i32 0, i32 1) to i32) to i64)), !dbg !212, !verifier.code !53
  %10 = bitcast i8* %9 to %struct.ldv_msg*, !dbg !213, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %10, metadata !214, metadata !DIExpression()), !dbg !205, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %4, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !53
  %11 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %4, i32 0, i32 1, !dbg !215, !verifier.code !53
  %12 = icmp ne %struct.ldv_list_head* %11, @ldv_global_msg_list, !dbg !217, !verifier.code !53
  br i1 %12, label %.lr.ph, label %24, !dbg !218, !verifier.code !53

.lr.ph:                                           ; preds = %0
  br label %13, !dbg !218, !verifier.code !53

13:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.ldv_msg* [ %4, %.lr.ph ], [ %.012, %forwarder ], !verifier.code !53
  %.012 = phi %struct.ldv_msg* [ %10, %.lr.ph ], [ %21, %forwarder ], !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %.03, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %.012, metadata !214, metadata !DIExpression()), !dbg !205, !verifier.code !53
  %14 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.03, i32 0, i32 1, !dbg !219, !verifier.code !53
  call void @ldv_list_del(%struct.ldv_list_head* %14), !dbg !221, !verifier.code !53
  call void @ldv_msg_free(%struct.ldv_msg* %.03), !dbg !222, !verifier.code !53
  br label %15, !dbg !223, !verifier.code !53

15:                                               ; preds = %13
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %.012, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !53
  %16 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.012, i32 0, i32 1, !dbg !224, !verifier.code !53
  %17 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.012, i32 0, i32 1, i32 0
  %18 = load %struct.ldv_list_head*, %struct.ldv_list_head** %17, align 8, !dbg !226, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %18, metadata !227, metadata !DIExpression()), !dbg !228, !verifier.code !53
  %19 = bitcast %struct.ldv_list_head* %18 to i8*, !dbg !229, !verifier.code !53
  %20 = getelementptr inbounds i8, i8* %19, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_list_head* getelementptr inbounds (%struct.ldv_msg, %struct.ldv_msg* null, i32 0, i32 1) to i32) to i64)), !dbg !230, !verifier.code !53
  %21 = bitcast i8* %20 to %struct.ldv_msg*, !dbg !231, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %21, metadata !214, metadata !DIExpression()), !dbg !205, !verifier.code !53
  %22 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.012, i32 0, i32 1, !dbg !215, !verifier.code !53
  %23 = icmp ne %struct.ldv_list_head* %22, @ldv_global_msg_list, !dbg !217, !verifier.code !53
  br i1 %23, label %forwarder, label %._crit_edge, !dbg !218, !llvm.loop !232, !verifier.code !53

._crit_edge:                                      ; preds = %15
  br label %24, !dbg !218, !verifier.code !53

24:                                               ; preds = %._crit_edge, %0
  ret void, !dbg !234, !verifier.code !53

forwarder:                                        ; preds = %15
  br label %13, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_list_del(%struct.ldv_list_head* %0) #0 !dbg !235 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !236, metadata !DIExpression()), !dbg !237, !verifier.code !53
  %2 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 1, !dbg !238, !verifier.code !53
  %3 = load %struct.ldv_list_head*, %struct.ldv_list_head** %2, align 8, !dbg !238, !verifier.code !53
  %4 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !239, !verifier.code !53
  %5 = load %struct.ldv_list_head*, %struct.ldv_list_head** %4, align 8, !dbg !239, !verifier.code !53
  call void @__ldv_list_del(%struct.ldv_list_head* %3, %struct.ldv_list_head* %5), !dbg !240, !verifier.code !53
  ret void, !dbg !241, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @__ldv_list_del(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1) #0 !dbg !242 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !243, metadata !DIExpression()), !dbg !244, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !245, metadata !DIExpression()), !dbg !244, !verifier.code !53
  %3 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %1, i32 0, i32 1, !dbg !246, !verifier.code !53
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %3, align 8, !dbg !247, !verifier.code !53
  %4 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !248, !verifier.code !53
  store %struct.ldv_list_head* %1, %struct.ldv_list_head** %4, align 8, !dbg !249, !verifier.code !53
  ret void, !dbg !250, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_del(%struct.ldv_kobject* %0) #0 !dbg !251 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !254, metadata !DIExpression()), !dbg !255, !verifier.code !53
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !256, !verifier.code !53
  br i1 %2, label %4, label %3, !dbg !258, !verifier.code !53

3:                                                ; preds = %1
  br label %4, !dbg !259, !verifier.code !53

4:                                                ; preds = %3, %1
  ret void, !dbg !260, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_put(%struct.ldv_kobject* %0) #0 !dbg !261 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !262, metadata !DIExpression()), !dbg !263, !verifier.code !53
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !264, !verifier.code !53
  br i1 %2, label %3, label %6, !dbg !266, !verifier.code !53

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 2, !dbg !267, !verifier.code !53
  %5 = call i32 @ldv_kref_put(%struct.ldv_kref* %4, void (%struct.ldv_kref*)* @ldv_kobject_release), !dbg !269, !verifier.code !53
  br label %6, !dbg !270, !verifier.code !53

6:                                                ; preds = %3, %1
  ret void, !dbg !271, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_release(%struct.ldv_kref* %0) #0 !dbg !272 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !276, metadata !DIExpression()), !dbg !277, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !278, metadata !DIExpression()), !dbg !282, !verifier.code !53
  %2 = bitcast %struct.ldv_kref* %0 to i8*, !dbg !283, !verifier.code !53
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_kref* getelementptr inbounds (%struct.ldv_kobject, %struct.ldv_kobject* null, i32 0, i32 2) to i32) to i64)), !dbg !284, !verifier.code !53
  %4 = bitcast i8* %3 to %struct.ldv_kobject*, !dbg !285, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %4, metadata !286, metadata !DIExpression()), !dbg !277, !verifier.code !53
  call void @ldv_kobject_cleanup(%struct.ldv_kobject* %4), !dbg !287, !verifier.code !53
  ret void, !dbg !288, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_kref_put(%struct.ldv_kref* %0, void (%struct.ldv_kref*)* %1) #0 !dbg !289 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !293, metadata !DIExpression()), !dbg !294, !verifier.code !53
  call void @llvm.dbg.value(metadata void (%struct.ldv_kref*)* %1, metadata !295, metadata !DIExpression()), !dbg !294, !verifier.code !53
  %3 = call i32 @ldv_kref_sub(%struct.ldv_kref* %0, i32 1, void (%struct.ldv_kref*)* %1), !dbg !296, !verifier.code !53
  ret i32 %3, !dbg !297, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_kref_sub(%struct.ldv_kref* %0, i32 %1, void (%struct.ldv_kref*)* %2) #0 !dbg !298 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !301, metadata !DIExpression()), !dbg !302, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %1, metadata !303, metadata !DIExpression()), !dbg !302, !verifier.code !53
  call void @llvm.dbg.value(metadata void (%struct.ldv_kref*)* %2, metadata !304, metadata !DIExpression()), !dbg !302, !verifier.code !53
  %4 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, !dbg !305, !verifier.code !53
  %5 = call i32 @ldv_atomic_sub_return(i32 %1, %struct.ldv_atomic_t* %4), !dbg !307, !verifier.code !53
  %6 = icmp eq i32 %5, 0, !dbg !308, !verifier.code !53
  br i1 %6, label %7, label %8, !dbg !309, !verifier.code !53

7:                                                ; preds = %3
  call void @devirtbounce(void (%struct.ldv_kref*)* %2, %struct.ldv_kref* %0)
  br label %9, !dbg !310, !verifier.code !53

8:                                                ; preds = %3
  br label %9, !dbg !312, !verifier.code !53

9:                                                ; preds = %8, %7
  %.0 = phi i32 [ 1, %7 ], [ 0, %8 ], !dbg !302, !verifier.code !53
  ret i32 %.0, !dbg !313, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_atomic_sub_return(i32 %0, %struct.ldv_atomic_t* %1) #0 !dbg !314 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !318, metadata !DIExpression()), !dbg !319, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_atomic_t* %1, metadata !320, metadata !DIExpression()), !dbg !319, !verifier.code !53
  %3 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !321, !verifier.code !53
  %4 = load i32, i32* %3, align 4, !dbg !321, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %4, metadata !322, metadata !DIExpression()), !dbg !319, !verifier.code !53
  %5 = sub nsw i32 %4, %0, !dbg !323, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %5, metadata !322, metadata !DIExpression()), !dbg !319, !verifier.code !53
  %6 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !324, !verifier.code !53
  store i32 %5, i32* %6, align 4, !dbg !325, !verifier.code !53
  ret i32 %5, !dbg !326, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_cleanup(%struct.ldv_kobject* %0) #0 !dbg !327 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !328, metadata !DIExpression()), !dbg !329, !verifier.code !53
  %2 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 0, !dbg !330, !verifier.code !53
  %3 = load i8*, i8** %2, align 8, !dbg !330, !verifier.code !53
  call void @llvm.dbg.value(metadata i8* %3, metadata !331, metadata !DIExpression()), !dbg !329, !verifier.code !53
  %4 = bitcast %struct.ldv_kobject* %0 to i8*, !dbg !332, !verifier.code !53
  call void @free(i8* %4) #4, !dbg !333, !verifier.code !53
  %5 = icmp ne i8* %3, null, !dbg !334, !verifier.code !53
  br i1 %5, label %6, label %7, !dbg !336, !verifier.code !53

6:                                                ; preds = %1
  call void @free(i8* %3) #4, !dbg !337, !verifier.code !53
  br label %7, !dbg !339, !verifier.code !53

7:                                                ; preds = %6, %1
  ret void, !dbg !340, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.ldv_kobject* @ldv_kobject_get(%struct.ldv_kobject* %0) #0 !dbg !341 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !344, metadata !DIExpression()), !dbg !345, !verifier.code !53
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !346, !verifier.code !53
  br i1 %2, label %3, label %5, !dbg !348, !verifier.code !53

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 2, !dbg !349, !verifier.code !53
  call void @ldv_kref_get(%struct.ldv_kref* %4), !dbg !350, !verifier.code !53
  br label %5, !dbg !350, !verifier.code !53

5:                                                ; preds = %3, %1
  ret %struct.ldv_kobject* %0, !dbg !351, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kref_get(%struct.ldv_kref* %0) #0 !dbg !352 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !353, metadata !DIExpression()), !dbg !354, !verifier.code !53
  %2 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, !dbg !355, !verifier.code !53
  %3 = call i32 @ldv_atomic_add_return(i32 1, %struct.ldv_atomic_t* %2), !dbg !356, !verifier.code !53
  ret void, !dbg !357, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_atomic_add_return(i32 %0, %struct.ldv_atomic_t* %1) #0 !dbg !358 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !359, metadata !DIExpression()), !dbg !360, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_atomic_t* %1, metadata !361, metadata !DIExpression()), !dbg !360, !verifier.code !53
  %3 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !362, !verifier.code !53
  %4 = load i32, i32* %3, align 4, !dbg !362, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %4, metadata !363, metadata !DIExpression()), !dbg !360, !verifier.code !53
  %5 = add nsw i32 %4, %0, !dbg !364, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %5, metadata !363, metadata !DIExpression()), !dbg !360, !verifier.code !53
  %6 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !365, !verifier.code !53
  store i32 %5, i32* %6, align 4, !dbg !366, !verifier.code !53
  ret i32 %5, !dbg !367, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_init(%struct.ldv_kobject* %0) #0 !dbg !368 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !369, metadata !DIExpression()), !dbg !370, !verifier.code !53
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !371, !verifier.code !53
  br i1 %2, label %4, label %3, !dbg !373, !verifier.code !53

3:                                                ; preds = %1
  br label %5, !dbg !374, !verifier.code !53

4:                                                ; preds = %1
  call void @ldv_kobject_init_internal(%struct.ldv_kobject* %0), !dbg !376, !verifier.code !53
  br label %6, !dbg !377, !verifier.code !53

5:                                                ; preds = %3
  call void @llvm.dbg.label(metadata !378), !dbg !379, !verifier.code !53
  br label %6, !dbg !380, !verifier.code !53

6:                                                ; preds = %5, %4
  ret void, !dbg !381, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_init_internal(%struct.ldv_kobject* %0) #0 !dbg !382 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !383, metadata !DIExpression()), !dbg !384, !verifier.code !53
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !385, !verifier.code !53
  br i1 %2, label %4, label %3, !dbg !387, !verifier.code !53

3:                                                ; preds = %1
  br label %7, !dbg !388, !verifier.code !53

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 2, !dbg !389, !verifier.code !53
  call void @ldv_kref_init(%struct.ldv_kref* %5), !dbg !390, !verifier.code !53
  %6 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 1, !dbg !391, !verifier.code !53
  call void @LDV_INIT_LIST_HEAD(%struct.ldv_list_head* %6), !dbg !392, !verifier.code !53
  br label %7, !dbg !393, !verifier.code !53

7:                                                ; preds = %4, %3
  ret void, !dbg !393, !verifier.code !53
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kref_init(%struct.ldv_kref* %0) #0 !dbg !394 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !395, metadata !DIExpression()), !dbg !396, !verifier.code !53
  %2 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, !dbg !397, !verifier.code !53
  %3 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, i32 0
  store i32 1, i32* %3, align 4, !dbg !398, !verifier.code !53
  ret void, !dbg !399, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.ldv_kobject* @ldv_kobject_create() #0 !dbg !400 {
  %1 = call i8* @ldv_malloc(i32 32), !dbg !403, !verifier.code !53
  %2 = bitcast i8* %1 to %struct.ldv_kobject*, !dbg !403, !verifier.code !53
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %2, metadata !404, metadata !DIExpression()), !dbg !405, !verifier.code !53
  %3 = icmp ne %struct.ldv_kobject* %2, null, !dbg !406, !verifier.code !53
  br i1 %3, label %5, label %4, !dbg !408, !verifier.code !53

4:                                                ; preds = %0
  br label %8, !dbg !409, !verifier.code !53

5:                                                ; preds = %0
  %6 = bitcast %struct.ldv_kobject* %2 to i8*, !dbg !410, !verifier.code !53
  %7 = call i8* @memset(i8* %6, i32 0, i32 32), !dbg !411, !verifier.code !53
  call void @ldv_kobject_init(%struct.ldv_kobject* %2), !dbg !412, !verifier.code !53
  br label %8, !dbg !413, !verifier.code !53

8:                                                ; preds = %5, %4
  %.0 = phi %struct.ldv_kobject* [ %2, %5 ], [ null, %4 ], !dbg !405, !verifier.code !53
  ret %struct.ldv_kobject* %.0, !dbg !414, !verifier.code !53
}

declare dso_local i8* @memset(i8*, i32, i32) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @f() #0 !dbg !415 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !416, !verifier.code !50
  ret i32 %1, !dbg !417, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @g() #0 !dbg !418 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !419, !verifier.code !50
  ret i32 %1, !dbg !420, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @f6() #0 !dbg !421 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !422, !verifier.code !50
  ret i32 %1, !dbg !423, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @g6() #0 !dbg !424 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !425, !verifier.code !50
  ret i32 %1, !dbg !426, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @probe1_6(%struct.A* %0) #0 !dbg !427 {
  call void @llvm.dbg.value(metadata %struct.A* %0, metadata !431, metadata !DIExpression()), !dbg !432, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 3, metadata !433, metadata !DIExpression()), !dbg !432, !verifier.code !53
  %2 = call i8* @ldv_malloc(i32 4), !dbg !434, !verifier.code !53
  %3 = bitcast i8* %2 to i32*, !dbg !435, !verifier.code !53
  call void @llvm.dbg.value(metadata i32* %3, metadata !436, metadata !DIExpression()), !dbg !432, !verifier.code !53
  %4 = icmp eq i32* %3, null, !dbg !437, !verifier.code !53
  br i1 %4, label %5, label %6, !dbg !439, !verifier.code !53

5:                                                ; preds = %1
  br label %19, !dbg !440, !verifier.code !53

6:                                                ; preds = %1
  %7 = call i32 @f6(), !dbg !441, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %7, metadata !433, metadata !DIExpression()), !dbg !432, !verifier.code !53
  %8 = icmp slt i32 %7, 0, !dbg !442, !verifier.code !53
  br i1 %8, label %9, label %10, !dbg !444, !verifier.code !53

9:                                                ; preds = %6
  br label %17, !dbg !445, !verifier.code !53

10:                                               ; preds = %6
  %11 = call i32 @g6(), !dbg !446, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %11, metadata !433, metadata !DIExpression()), !dbg !432, !verifier.code !53
  %12 = icmp slt i32 %11, 0, !dbg !447, !verifier.code !53
  br i1 %12, label %13, label %14, !dbg !449, !verifier.code !53

13:                                               ; preds = %10
  br label %17, !dbg !450, !verifier.code !53

14:                                               ; preds = %10
  %15 = bitcast i32* %3 to i8*, !dbg !451, !verifier.code !53
  %16 = getelementptr inbounds %struct.A, %struct.A* %0, i32 0, i32 0, !dbg !452, !verifier.code !53
  store i8* %15, i8** %16, align 8, !dbg !453, !verifier.code !53
  br label %19, !dbg !454, !verifier.code !53

17:                                               ; preds = %13, %9
  %.01 = phi i32 [ %7, %9 ], [ %11, %13 ], !dbg !432, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %.01, metadata !433, metadata !DIExpression()), !dbg !432, !verifier.code !53
  call void @llvm.dbg.label(metadata !455), !dbg !456, !verifier.code !53
  %18 = bitcast i32* %3 to i8*, !dbg !457, !verifier.code !53
  call void @free(i8* %18) #4, !dbg !458, !verifier.code !53
  br label %19, !dbg !459, !verifier.code !53

19:                                               ; preds = %17, %14, %5
  %.0 = phi i32 [ 3, %5 ], [ %.01, %17 ], [ 0, %14 ], !dbg !432, !verifier.code !53
  ret i32 %.0, !dbg !460, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @disconnect_2_6(%struct.A* %0) #0 !dbg !461 {
  call void @llvm.dbg.value(metadata %struct.A* %0, metadata !464, metadata !DIExpression()), !dbg !465, !verifier.code !53
  ret void, !dbg !466, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define internal void @entry_point() #0 !dbg !467 {
  %1 = call i32 @probe1_6(%struct.A* @a6), !dbg !468, !verifier.code !53
  call void @llvm.dbg.value(metadata i32 %1, metadata !469, metadata !DIExpression()), !dbg !470, !verifier.code !53
  %2 = icmp eq i32 %1, 0, !dbg !471, !verifier.code !53
  br i1 %2, label %3, label %4, !dbg !473, !verifier.code !53

3:                                                ; preds = %0
  call void @disconnect_2_6(%struct.A* @a6), !dbg !474, !verifier.code !53
  br label %4, !dbg !476, !verifier.code !53

4:                                                ; preds = %3, %0
  store i8* null, i8** getelementptr inbounds (%struct.A, %struct.A* @a6, i32 0, i32 0), align 8, !dbg !477, !verifier.code !53
  ret void, !dbg !478, !verifier.code !53
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @main() #0 !dbg !479 {
  call void @entry_point(), !dbg !480, !verifier.code !53
  ret void, !dbg !481, !verifier.code !53
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

define internal void @devirtbounce(void (%struct.ldv_kref*)* %funcPtr, %struct.ldv_kref* %arg) {
entry:
  %0 = bitcast void (%struct.ldv_kref*)* %funcPtr to i8*
  br label %test.ldv_kobject_release

ldv_kobject_release:                              ; preds = %test.ldv_kobject_release
  call void @ldv_kobject_release(%struct.ldv_kref* %arg)
  ret void

fail:                                             ; preds = %test.ldv_kobject_release
  unreachable

test.ldv_kobject_release:                         ; preds = %entry
  %sc = icmp eq i8* bitcast (void (%struct.ldv_kref*)* @ldv_kobject_release to i8*), %0
  br i1 %sc, label %ldv_kobject_release, label %fail
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!42}
!llvm.module.flags = !{!43, !44, !45}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "ldv_global_msg_list", scope: !2, file: !3, line: 569, type: !12, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !36, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/ldv-memsafety/memleaks_test6_3.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !17, !19, !21, !22, !23}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ldv_msg", file: !3, line: 570, size: 192, elements: !8)
!8 = !{!9, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !7, file: !3, line: 571, baseType: !10, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "list", scope: !7, file: !3, line: 572, baseType: !12, size: 128, offset: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ldv_list_head", file: !3, line: 535, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !12, file: !3, line: 536, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !12, file: !3, line: 536, baseType: !15, size: 64, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !3, line: 1, baseType: !20)
!20 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ldv_kobject", file: !3, line: 650, size: 256, elements: !25)
!25 = !{!26, !27, !28}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !24, file: !3, line: 651, baseType: !17, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "entry", scope: !24, file: !3, line: 652, baseType: !12, size: 128, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "kref", scope: !24, file: !3, line: 653, baseType: !29, size: 32, offset: 192)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ldv_kref", file: !3, line: 647, size: 32, elements: !30)
!30 = !{!31}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "refcount", scope: !29, file: !3, line: 648, baseType: !32, size: 32)
!32 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldv_atomic_t", file: !3, line: 646, baseType: !33)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 644, size: 32, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "counter", scope: !33, file: !3, line: 645, baseType: !22, size: 32)
!36 = !{!0, !37}
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "a6", scope: !2, file: !3, line: 782, type: !39, isLocal: false, isDefinition: true)
!39 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "A", file: !3, line: 748, size: 64, elements: !40)
!40 = !{!41}
!41 = !DIDerivedType(tag: DW_TAG_member, name: "p", scope: !39, file: !3, line: 749, baseType: !10, size: 64)
!42 = !{!"clang version 10.0.0-4ubuntu1 "}
!43 = !{i32 7, !"Dwarf Version", i32 4}
!44 = !{i32 2, !"Debug Info Version", i32 3}
!45 = !{i32 1, !"wchar_size", i32 4}
!46 = distinct !DISubprogram(name: "ldv_nonpositive", scope: !3, file: !3, line: 513, type: !47, scopeLine: 513, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!47 = !DISubroutineType(types: !48)
!48 = !{!22}
!49 = !DILocation(line: 514, column: 10, scope: !46)
!50 = !{i1 true}
!51 = !DILocalVariable(name: "r", scope: !46, file: !3, line: 514, type: !22)
!52 = !DILocation(line: 0, scope: !46)
!53 = !{i1 false}
!54 = !DILocation(line: 515, column: 6, scope: !55)
!55 = distinct !DILexicalBlock(scope: !46, file: !3, line: 515, column: 5)
!56 = !DILocation(line: 515, column: 5, scope: !46)
!57 = !DILocation(line: 515, column: 10, scope: !55)
!58 = !DILocation(line: 516, column: 7, scope: !55)
!59 = !DILocation(line: 0, scope: !55)
!60 = !DILocation(line: 517, column: 1, scope: !46)
!61 = distinct !DISubprogram(name: "ldv_positive", scope: !3, file: !3, line: 518, type: !47, scopeLine: 518, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!62 = !DILocation(line: 519, column: 10, scope: !61)
!63 = !DILocalVariable(name: "r", scope: !61, file: !3, line: 519, type: !22)
!64 = !DILocation(line: 0, scope: !61)
!65 = !DILocation(line: 520, column: 6, scope: !66)
!66 = distinct !DILexicalBlock(scope: !61, file: !3, line: 520, column: 5)
!67 = !DILocation(line: 520, column: 5, scope: !61)
!68 = !DILocation(line: 520, column: 10, scope: !66)
!69 = !DILocation(line: 521, column: 7, scope: !66)
!70 = !DILocation(line: 0, scope: !66)
!71 = !DILocation(line: 522, column: 1, scope: !61)
!72 = distinct !DISubprogram(name: "ldv_malloc", scope: !3, file: !3, line: 525, type: !73, scopeLine: 525, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!73 = !DISubroutineType(types: !74)
!74 = !{!10, !19}
!75 = !DILocalVariable(name: "size", arg: 1, scope: !72, file: !3, line: 525, type: !19)
!76 = !DILocation(line: 0, scope: !72)
!77 = !DILocation(line: 526, column: 5, scope: !78)
!78 = distinct !DILexicalBlock(scope: !72, file: !3, line: 526, column: 5)
!79 = !DILocation(line: 526, column: 5, scope: !72)
!80 = !DILocation(line: 527, column: 10, scope: !81)
!81 = distinct !DILexicalBlock(scope: !78, file: !3, line: 526, column: 30)
!82 = !DILocation(line: 527, column: 3, scope: !81)
!83 = !DILocation(line: 529, column: 3, scope: !84)
!84 = distinct !DILexicalBlock(scope: !78, file: !3, line: 528, column: 9)
!85 = !DILocation(line: 0, scope: !78)
!86 = !DILocation(line: 531, column: 1, scope: !72)
!87 = distinct !DISubprogram(name: "ldv_zalloc", scope: !3, file: !3, line: 532, type: !73, scopeLine: 532, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!88 = !DILocalVariable(name: "size", arg: 1, scope: !87, file: !3, line: 532, type: !19)
!89 = !DILocation(line: 0, scope: !87)
!90 = !DILocation(line: 533, column: 9, scope: !87)
!91 = !DILocation(line: 533, column: 2, scope: !87)
!92 = distinct !DISubprogram(name: "ldv_msg_alloc", scope: !3, file: !3, line: 574, type: !93, scopeLine: 574, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!93 = !DISubroutineType(types: !94)
!94 = !{!6}
!95 = !DILocation(line: 576, column: 25, scope: !92)
!96 = !DILocation(line: 576, column: 8, scope: !92)
!97 = !DILocalVariable(name: "msg", scope: !92, file: !3, line: 575, type: !6)
!98 = !DILocation(line: 0, scope: !92)
!99 = !DILocation(line: 577, column: 5, scope: !100)
!100 = distinct !DILexicalBlock(scope: !92, file: !3, line: 577, column: 5)
!101 = !DILocation(line: 577, column: 5, scope: !92)
!102 = !DILocation(line: 578, column: 8, scope: !103)
!103 = distinct !DILexicalBlock(scope: !100, file: !3, line: 577, column: 10)
!104 = !DILocation(line: 578, column: 12, scope: !103)
!105 = !DILocation(line: 579, column: 28, scope: !103)
!106 = !DILocation(line: 579, column: 3, scope: !103)
!107 = !DILocation(line: 580, column: 2, scope: !103)
!108 = !DILocation(line: 581, column: 2, scope: !92)
!109 = distinct !DISubprogram(name: "LDV_INIT_LIST_HEAD", scope: !3, file: !3, line: 538, type: !110, scopeLine: 539, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!110 = !DISubroutineType(types: !111)
!111 = !{null, !15}
!112 = !DILocalVariable(name: "list", arg: 1, scope: !109, file: !3, line: 538, type: !15)
!113 = !DILocation(line: 0, scope: !109)
!114 = !DILocation(line: 540, column: 8, scope: !109)
!115 = !DILocation(line: 540, column: 13, scope: !109)
!116 = !DILocation(line: 541, column: 8, scope: !109)
!117 = !DILocation(line: 541, column: 13, scope: !109)
!118 = !DILocation(line: 542, column: 1, scope: !109)
!119 = distinct !DISubprogram(name: "ldv_msg_fill", scope: !3, file: !3, line: 583, type: !120, scopeLine: 583, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!120 = !DISubroutineType(types: !121)
!121 = !{!22, !6, !10, !22}
!122 = !DILocalVariable(name: "msg", arg: 1, scope: !119, file: !3, line: 583, type: !6)
!123 = !DILocation(line: 0, scope: !119)
!124 = !DILocalVariable(name: "buf", arg: 2, scope: !119, file: !3, line: 583, type: !10)
!125 = !DILocalVariable(name: "len", arg: 3, scope: !119, file: !3, line: 583, type: !22)
!126 = !DILocation(line: 585, column: 9, scope: !119)
!127 = !DILocalVariable(name: "data", scope: !119, file: !3, line: 584, type: !10)
!128 = !DILocation(line: 586, column: 6, scope: !129)
!129 = distinct !DILexicalBlock(scope: !119, file: !3, line: 586, column: 5)
!130 = !DILocation(line: 586, column: 5, scope: !119)
!131 = !DILocation(line: 586, column: 12, scope: !129)
!132 = !DILocation(line: 587, column: 2, scope: !119)
!133 = !DILocation(line: 588, column: 7, scope: !119)
!134 = !DILocation(line: 588, column: 12, scope: !119)
!135 = !DILocation(line: 589, column: 2, scope: !119)
!136 = !DILocation(line: 590, column: 1, scope: !119)
!137 = distinct !DISubprogram(name: "ldv_msg_free", scope: !3, file: !3, line: 591, type: !138, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!138 = !DISubroutineType(types: !139)
!139 = !{null, !6}
!140 = !DILocalVariable(name: "msg", arg: 1, scope: !137, file: !3, line: 591, type: !6)
!141 = !DILocation(line: 0, scope: !137)
!142 = !DILocation(line: 592, column: 5, scope: !143)
!143 = distinct !DILexicalBlock(scope: !137, file: !3, line: 592, column: 5)
!144 = !DILocation(line: 592, column: 5, scope: !137)
!145 = !DILocation(line: 593, column: 13, scope: !146)
!146 = distinct !DILexicalBlock(scope: !143, file: !3, line: 592, column: 10)
!147 = !DILocation(line: 593, column: 3, scope: !146)
!148 = !DILocation(line: 594, column: 8, scope: !146)
!149 = !DILocation(line: 594, column: 3, scope: !146)
!150 = !DILocation(line: 595, column: 2, scope: !146)
!151 = !DILocation(line: 596, column: 1, scope: !137)
!152 = distinct !DISubprogram(name: "ldv_submit_msg", scope: !3, file: !3, line: 597, type: !153, scopeLine: 597, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!153 = !DISubroutineType(types: !154)
!154 = !{!22, !6}
!155 = !DILocalVariable(name: "msg", arg: 1, scope: !152, file: !3, line: 597, type: !6)
!156 = !DILocation(line: 0, scope: !152)
!157 = !DILocation(line: 598, column: 6, scope: !158)
!158 = distinct !DILexicalBlock(scope: !152, file: !3, line: 598, column: 6)
!159 = !DILocation(line: 598, column: 6, scope: !152)
!160 = !DILocation(line: 599, column: 23, scope: !161)
!161 = distinct !DILexicalBlock(scope: !158, file: !3, line: 598, column: 31)
!162 = !DILocation(line: 599, column: 4, scope: !161)
!163 = !DILocation(line: 600, column: 4, scope: !161)
!164 = !DILocation(line: 602, column: 3, scope: !152)
!165 = !DILocation(line: 603, column: 1, scope: !152)
!166 = distinct !DISubprogram(name: "ldv_list_add", scope: !3, file: !3, line: 557, type: !167, scopeLine: 558, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!167 = !DISubroutineType(types: !168)
!168 = !{null, !15, !15}
!169 = !DILocalVariable(name: "new", arg: 1, scope: !166, file: !3, line: 557, type: !15)
!170 = !DILocation(line: 0, scope: !166)
!171 = !DILocalVariable(name: "head", arg: 2, scope: !166, file: !3, line: 557, type: !15)
!172 = !DILocation(line: 559, column: 34, scope: !166)
!173 = !DILocation(line: 559, column: 2, scope: !166)
!174 = !DILocation(line: 560, column: 1, scope: !166)
!175 = distinct !DISubprogram(name: "__ldv_list_add", scope: !3, file: !3, line: 543, type: !176, scopeLine: 546, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!176 = !DISubroutineType(types: !177)
!177 = !{null, !15, !15, !15}
!178 = !DILocalVariable(name: "new", arg: 1, scope: !175, file: !3, line: 543, type: !15)
!179 = !DILocation(line: 0, scope: !175)
!180 = !DILocalVariable(name: "prev", arg: 2, scope: !175, file: !3, line: 544, type: !15)
!181 = !DILocalVariable(name: "next", arg: 3, scope: !175, file: !3, line: 545, type: !15)
!182 = !DILocation(line: 547, column: 8, scope: !175)
!183 = !DILocation(line: 547, column: 13, scope: !175)
!184 = !DILocation(line: 548, column: 7, scope: !175)
!185 = !DILocation(line: 548, column: 12, scope: !175)
!186 = !DILocation(line: 549, column: 7, scope: !175)
!187 = !DILocation(line: 549, column: 12, scope: !175)
!188 = !DILocation(line: 550, column: 8, scope: !175)
!189 = !DILocation(line: 550, column: 13, scope: !175)
!190 = !DILocation(line: 551, column: 1, scope: !175)
!191 = distinct !DISubprogram(name: "ldv_destroy_msgs", scope: !3, file: !3, line: 604, type: !192, scopeLine: 604, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!192 = !DISubroutineType(types: !193)
!193 = !{null}
!194 = !DILocation(line: 607, column: 93, scope: !195)
!195 = distinct !DILexicalBlock(scope: !196, file: !3, line: 607, column: 14)
!196 = distinct !DILexicalBlock(scope: !191, file: !3, line: 607, column: 2)
!197 = !DILocalVariable(name: "__mptr", scope: !195, file: !3, line: 607, type: !198)
!198 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !199, size: 64)
!199 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !12)
!200 = !DILocation(line: 0, scope: !195)
!201 = !DILocation(line: 607, column: 118, scope: !195)
!202 = !DILocation(line: 607, column: 133, scope: !195)
!203 = !DILocation(line: 607, column: 100, scope: !195)
!204 = !DILocalVariable(name: "msg", scope: !191, file: !3, line: 605, type: !6)
!205 = !DILocation(line: 0, scope: !191)
!206 = !DILocation(line: 607, column: 248, scope: !207)
!207 = distinct !DILexicalBlock(scope: !196, file: !3, line: 607, column: 184)
!208 = !DILocation(line: 607, column: 253, scope: !207)
!209 = !DILocalVariable(name: "__mptr", scope: !207, file: !3, line: 607, type: !198)
!210 = !DILocation(line: 0, scope: !207)
!211 = !DILocation(line: 607, column: 280, scope: !207)
!212 = !DILocation(line: 607, column: 295, scope: !207)
!213 = !DILocation(line: 607, column: 260, scope: !207)
!214 = !DILocalVariable(name: "n", scope: !191, file: !3, line: 606, type: !6)
!215 = !DILocation(line: 607, column: 349, scope: !216)
!216 = distinct !DILexicalBlock(scope: !196, file: !3, line: 607, column: 2)
!217 = !DILocation(line: 607, column: 354, scope: !216)
!218 = !DILocation(line: 607, column: 2, scope: !196)
!219 = !DILocation(line: 608, column: 22, scope: !220)
!220 = distinct !DILexicalBlock(scope: !216, file: !3, line: 607, column: 546)
!221 = !DILocation(line: 608, column: 3, scope: !220)
!222 = !DILocation(line: 609, column: 3, scope: !220)
!223 = !DILocation(line: 610, column: 2, scope: !220)
!224 = !DILocation(line: 607, column: 455, scope: !225)
!225 = distinct !DILexicalBlock(scope: !216, file: !3, line: 607, column: 395)
!226 = !DILocation(line: 607, column: 460, scope: !225)
!227 = !DILocalVariable(name: "__mptr", scope: !225, file: !3, line: 607, type: !198)
!228 = !DILocation(line: 0, scope: !225)
!229 = !DILocation(line: 607, column: 485, scope: !225)
!230 = !DILocation(line: 607, column: 500, scope: !225)
!231 = !DILocation(line: 607, column: 467, scope: !225)
!232 = distinct !{!232, !218, !233}
!233 = !DILocation(line: 610, column: 2, scope: !196)
!234 = !DILocation(line: 611, column: 1, scope: !191)
!235 = distinct !DISubprogram(name: "ldv_list_del", scope: !3, file: !3, line: 565, type: !110, scopeLine: 566, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!236 = !DILocalVariable(name: "entry", arg: 1, scope: !235, file: !3, line: 565, type: !15)
!237 = !DILocation(line: 0, scope: !235)
!238 = !DILocation(line: 567, column: 24, scope: !235)
!239 = !DILocation(line: 567, column: 37, scope: !235)
!240 = !DILocation(line: 567, column: 2, scope: !235)
!241 = !DILocation(line: 568, column: 1, scope: !235)
!242 = distinct !DISubprogram(name: "__ldv_list_del", scope: !3, file: !3, line: 552, type: !167, scopeLine: 553, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!243 = !DILocalVariable(name: "prev", arg: 1, scope: !242, file: !3, line: 552, type: !15)
!244 = !DILocation(line: 0, scope: !242)
!245 = !DILocalVariable(name: "next", arg: 2, scope: !242, file: !3, line: 552, type: !15)
!246 = !DILocation(line: 554, column: 8, scope: !242)
!247 = !DILocation(line: 554, column: 13, scope: !242)
!248 = !DILocation(line: 555, column: 8, scope: !242)
!249 = !DILocation(line: 555, column: 13, scope: !242)
!250 = !DILocation(line: 556, column: 1, scope: !242)
!251 = distinct !DISubprogram(name: "ldv_kobject_del", scope: !3, file: !3, line: 692, type: !252, scopeLine: 693, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!252 = !DISubroutineType(types: !253)
!253 = !{null, !23}
!254 = !DILocalVariable(name: "kobj", arg: 1, scope: !251, file: !3, line: 692, type: !23)
!255 = !DILocation(line: 0, scope: !251)
!256 = !DILocation(line: 694, column: 14, scope: !257)
!257 = distinct !DILexicalBlock(scope: !251, file: !3, line: 694, column: 13)
!258 = !DILocation(line: 694, column: 13, scope: !251)
!259 = !DILocation(line: 695, column: 17, scope: !257)
!260 = !DILocation(line: 696, column: 1, scope: !251)
!261 = distinct !DISubprogram(name: "ldv_kobject_put", scope: !3, file: !3, line: 709, type: !252, scopeLine: 710, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!262 = !DILocalVariable(name: "kobj", arg: 1, scope: !261, file: !3, line: 709, type: !23)
!263 = !DILocation(line: 0, scope: !261)
!264 = !DILocation(line: 711, column: 13, scope: !265)
!265 = distinct !DILexicalBlock(scope: !261, file: !3, line: 711, column: 13)
!266 = !DILocation(line: 711, column: 13, scope: !261)
!267 = !DILocation(line: 712, column: 37, scope: !268)
!268 = distinct !DILexicalBlock(scope: !265, file: !3, line: 711, column: 19)
!269 = !DILocation(line: 712, column: 17, scope: !268)
!270 = !DILocation(line: 713, column: 9, scope: !268)
!271 = !DILocation(line: 714, column: 1, scope: !261)
!272 = distinct !DISubprogram(name: "ldv_kobject_release", scope: !3, file: !3, line: 705, type: !273, scopeLine: 705, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!273 = !DISubroutineType(types: !274)
!274 = !{null, !275}
!275 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!276 = !DILocalVariable(name: "kref", arg: 1, scope: !272, file: !3, line: 705, type: !275)
!277 = !DILocation(line: 0, scope: !272)
!278 = !DILocalVariable(name: "__mptr", scope: !279, file: !3, line: 706, type: !280)
!279 = distinct !DILexicalBlock(scope: !272, file: !3, line: 706, column: 30)
!280 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !281, size: 64)
!281 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !29)
!282 = !DILocation(line: 0, scope: !279)
!283 = !DILocation(line: 706, column: 122, scope: !279)
!284 = !DILocation(line: 706, column: 137, scope: !279)
!285 = !DILocation(line: 706, column: 98, scope: !279)
!286 = !DILocalVariable(name: "kobj", scope: !272, file: !3, line: 706, type: !23)
!287 = !DILocation(line: 707, column: 9, scope: !272)
!288 = !DILocation(line: 708, column: 1, scope: !272)
!289 = distinct !DISubprogram(name: "ldv_kref_put", scope: !3, file: !3, line: 688, type: !290, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!290 = !DISubroutineType(types: !291)
!291 = !{!22, !275, !292}
!292 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !273, size: 64)
!293 = !DILocalVariable(name: "kref", arg: 1, scope: !289, file: !3, line: 688, type: !275)
!294 = !DILocation(line: 0, scope: !289)
!295 = !DILocalVariable(name: "release", arg: 2, scope: !289, file: !3, line: 688, type: !292)
!296 = !DILocation(line: 690, column: 16, scope: !289)
!297 = !DILocation(line: 690, column: 9, scope: !289)
!298 = distinct !DISubprogram(name: "ldv_kref_sub", scope: !3, file: !3, line: 671, type: !299, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!299 = !DISubroutineType(types: !300)
!300 = !{!22, !275, !20, !292}
!301 = !DILocalVariable(name: "kref", arg: 1, scope: !298, file: !3, line: 671, type: !275)
!302 = !DILocation(line: 0, scope: !298)
!303 = !DILocalVariable(name: "count", arg: 2, scope: !298, file: !3, line: 671, type: !20)
!304 = !DILocalVariable(name: "release", arg: 3, scope: !298, file: !3, line: 672, type: !292)
!305 = !DILocation(line: 674, column: 59, scope: !306)
!306 = distinct !DILexicalBlock(scope: !298, file: !3, line: 674, column: 13)
!307 = !DILocation(line: 674, column: 14, scope: !306)
!308 = !DILocation(line: 674, column: 70, scope: !306)
!309 = !DILocation(line: 674, column: 13, scope: !298)
!310 = !DILocation(line: 676, column: 17, scope: !311)
!311 = distinct !DILexicalBlock(scope: !306, file: !3, line: 674, column: 77)
!312 = !DILocation(line: 678, column: 9, scope: !298)
!313 = !DILocation(line: 679, column: 1, scope: !298)
!314 = distinct !DISubprogram(name: "ldv_atomic_sub_return", scope: !3, file: !3, line: 663, type: !315, scopeLine: 664, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!315 = !DISubroutineType(types: !316)
!316 = !{!22, !22, !317}
!317 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!318 = !DILocalVariable(name: "i", arg: 1, scope: !314, file: !3, line: 663, type: !22)
!319 = !DILocation(line: 0, scope: !314)
!320 = !DILocalVariable(name: "v", arg: 2, scope: !314, file: !3, line: 663, type: !317)
!321 = !DILocation(line: 666, column: 19, scope: !314)
!322 = !DILocalVariable(name: "temp", scope: !314, file: !3, line: 665, type: !22)
!323 = !DILocation(line: 667, column: 14, scope: !314)
!324 = !DILocation(line: 668, column: 12, scope: !314)
!325 = !DILocation(line: 668, column: 20, scope: !314)
!326 = !DILocation(line: 669, column: 9, scope: !314)
!327 = distinct !DISubprogram(name: "ldv_kobject_cleanup", scope: !3, file: !3, line: 697, type: !252, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!328 = !DILocalVariable(name: "kobj", arg: 1, scope: !327, file: !3, line: 697, type: !23)
!329 = !DILocation(line: 0, scope: !327)
!330 = !DILocation(line: 699, column: 28, scope: !327)
!331 = !DILocalVariable(name: "name", scope: !327, file: !3, line: 699, type: !17)
!332 = !DILocation(line: 700, column: 14, scope: !327)
!333 = !DILocation(line: 700, column: 9, scope: !327)
!334 = !DILocation(line: 701, column: 13, scope: !335)
!335 = distinct !DILexicalBlock(scope: !327, file: !3, line: 701, column: 13)
!336 = !DILocation(line: 701, column: 13, scope: !327)
!337 = !DILocation(line: 702, column: 17, scope: !338)
!338 = distinct !DILexicalBlock(scope: !335, file: !3, line: 701, column: 19)
!339 = !DILocation(line: 703, column: 9, scope: !338)
!340 = !DILocation(line: 704, column: 1, scope: !327)
!341 = distinct !DISubprogram(name: "ldv_kobject_get", scope: !3, file: !3, line: 715, type: !342, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!342 = !DISubroutineType(types: !343)
!343 = !{!23, !23}
!344 = !DILocalVariable(name: "kobj", arg: 1, scope: !341, file: !3, line: 715, type: !23)
!345 = !DILocation(line: 0, scope: !341)
!346 = !DILocation(line: 717, column: 13, scope: !347)
!347 = distinct !DILexicalBlock(scope: !341, file: !3, line: 717, column: 13)
!348 = !DILocation(line: 717, column: 13, scope: !341)
!349 = !DILocation(line: 718, column: 37, scope: !347)
!350 = !DILocation(line: 718, column: 17, scope: !347)
!351 = !DILocation(line: 719, column: 9, scope: !341)
!352 = distinct !DISubprogram(name: "ldv_kref_get", scope: !3, file: !3, line: 684, type: !273, scopeLine: 685, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!353 = !DILocalVariable(name: "kref", arg: 1, scope: !352, file: !3, line: 684, type: !275)
!354 = !DILocation(line: 0, scope: !352)
!355 = !DILocation(line: 686, column: 42, scope: !352)
!356 = !DILocation(line: 686, column: 9, scope: !352)
!357 = !DILocation(line: 687, column: 1, scope: !352)
!358 = distinct !DISubprogram(name: "ldv_atomic_add_return", scope: !3, file: !3, line: 655, type: !315, scopeLine: 656, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!359 = !DILocalVariable(name: "i", arg: 1, scope: !358, file: !3, line: 655, type: !22)
!360 = !DILocation(line: 0, scope: !358)
!361 = !DILocalVariable(name: "v", arg: 2, scope: !358, file: !3, line: 655, type: !317)
!362 = !DILocation(line: 658, column: 19, scope: !358)
!363 = !DILocalVariable(name: "temp", scope: !358, file: !3, line: 657, type: !22)
!364 = !DILocation(line: 659, column: 14, scope: !358)
!365 = !DILocation(line: 660, column: 12, scope: !358)
!366 = !DILocation(line: 660, column: 20, scope: !358)
!367 = !DILocation(line: 661, column: 9, scope: !358)
!368 = distinct !DISubprogram(name: "ldv_kobject_init", scope: !3, file: !3, line: 728, type: !252, scopeLine: 729, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!369 = !DILocalVariable(name: "kobj", arg: 1, scope: !368, file: !3, line: 728, type: !23)
!370 = !DILocation(line: 0, scope: !368)
!371 = !DILocation(line: 730, column: 14, scope: !372)
!372 = distinct !DILexicalBlock(scope: !368, file: !3, line: 730, column: 13)
!373 = !DILocation(line: 730, column: 13, scope: !368)
!374 = !DILocation(line: 731, column: 17, scope: !375)
!375 = distinct !DILexicalBlock(scope: !372, file: !3, line: 730, column: 20)
!376 = !DILocation(line: 733, column: 9, scope: !368)
!377 = !DILocation(line: 734, column: 9, scope: !368)
!378 = !DILabel(scope: !368, name: "error", file: !3, line: 735)
!379 = !DILocation(line: 735, column: 1, scope: !368)
!380 = !DILocation(line: 736, column: 2, scope: !368)
!381 = !DILocation(line: 737, column: 1, scope: !368)
!382 = distinct !DISubprogram(name: "ldv_kobject_init_internal", scope: !3, file: !3, line: 721, type: !252, scopeLine: 722, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!383 = !DILocalVariable(name: "kobj", arg: 1, scope: !382, file: !3, line: 721, type: !23)
!384 = !DILocation(line: 0, scope: !382)
!385 = !DILocation(line: 723, column: 14, scope: !386)
!386 = distinct !DILexicalBlock(scope: !382, file: !3, line: 723, column: 13)
!387 = !DILocation(line: 723, column: 13, scope: !382)
!388 = !DILocation(line: 724, column: 17, scope: !386)
!389 = !DILocation(line: 725, column: 30, scope: !382)
!390 = !DILocation(line: 725, column: 9, scope: !382)
!391 = !DILocation(line: 726, column: 35, scope: !382)
!392 = !DILocation(line: 726, column: 9, scope: !382)
!393 = !DILocation(line: 727, column: 1, scope: !382)
!394 = distinct !DISubprogram(name: "ldv_kref_init", scope: !3, file: !3, line: 680, type: !273, scopeLine: 681, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!395 = !DILocalVariable(name: "kref", arg: 1, scope: !394, file: !3, line: 680, type: !275)
!396 = !DILocation(line: 0, scope: !394)
!397 = !DILocation(line: 682, column: 19, scope: !394)
!398 = !DILocation(line: 682, column: 39, scope: !394)
!399 = !DILocation(line: 683, column: 1, scope: !394)
!400 = distinct !DISubprogram(name: "ldv_kobject_create", scope: !3, file: !3, line: 738, type: !401, scopeLine: 739, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!401 = !DISubroutineType(types: !402)
!402 = !{!23}
!403 = !DILocation(line: 741, column: 16, scope: !400)
!404 = !DILocalVariable(name: "kobj", scope: !400, file: !3, line: 740, type: !23)
!405 = !DILocation(line: 0, scope: !400)
!406 = !DILocation(line: 742, column: 14, scope: !407)
!407 = distinct !DILexicalBlock(scope: !400, file: !3, line: 742, column: 13)
!408 = !DILocation(line: 742, column: 13, scope: !400)
!409 = !DILocation(line: 743, column: 17, scope: !407)
!410 = !DILocation(line: 744, column: 9, scope: !400)
!411 = !DILocation(line: 744, column: 2, scope: !400)
!412 = !DILocation(line: 745, column: 9, scope: !400)
!413 = !DILocation(line: 746, column: 9, scope: !400)
!414 = !DILocation(line: 747, column: 1, scope: !400)
!415 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 751, type: !47, scopeLine: 751, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!416 = !DILocation(line: 752, column: 9, scope: !415)
!417 = !DILocation(line: 752, column: 2, scope: !415)
!418 = distinct !DISubprogram(name: "g", scope: !3, file: !3, line: 754, type: !47, scopeLine: 754, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!419 = !DILocation(line: 755, column: 9, scope: !418)
!420 = !DILocation(line: 755, column: 2, scope: !418)
!421 = distinct !DISubprogram(name: "f6", scope: !3, file: !3, line: 757, type: !47, scopeLine: 757, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!422 = !DILocation(line: 758, column: 9, scope: !421)
!423 = !DILocation(line: 758, column: 2, scope: !421)
!424 = distinct !DISubprogram(name: "g6", scope: !3, file: !3, line: 760, type: !47, scopeLine: 760, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!425 = !DILocation(line: 761, column: 9, scope: !424)
!426 = !DILocation(line: 761, column: 2, scope: !424)
!427 = distinct !DISubprogram(name: "probe1_6", scope: !3, file: !3, line: 763, type: !428, scopeLine: 763, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!428 = !DISubroutineType(types: !429)
!429 = !{!22, !430}
!430 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !39, size: 64)
!431 = !DILocalVariable(name: "a", arg: 1, scope: !427, file: !3, line: 763, type: !430)
!432 = !DILocation(line: 0, scope: !427)
!433 = !DILocalVariable(name: "ret", scope: !427, file: !3, line: 764, type: !22)
!434 = !DILocation(line: 765, column: 18, scope: !427)
!435 = !DILocation(line: 765, column: 11, scope: !427)
!436 = !DILocalVariable(name: "p", scope: !427, file: !3, line: 765, type: !21)
!437 = !DILocation(line: 766, column: 6, scope: !438)
!438 = distinct !DILexicalBlock(scope: !427, file: !3, line: 766, column: 5)
!439 = !DILocation(line: 766, column: 5, scope: !427)
!440 = !DILocation(line: 767, column: 3, scope: !438)
!441 = !DILocation(line: 768, column: 8, scope: !427)
!442 = !DILocation(line: 769, column: 8, scope: !443)
!443 = distinct !DILexicalBlock(scope: !427, file: !3, line: 769, column: 5)
!444 = !DILocation(line: 769, column: 5, scope: !427)
!445 = !DILocation(line: 770, column: 3, scope: !443)
!446 = !DILocation(line: 771, column: 8, scope: !427)
!447 = !DILocation(line: 772, column: 8, scope: !448)
!448 = distinct !DILexicalBlock(scope: !427, file: !3, line: 772, column: 5)
!449 = !DILocation(line: 772, column: 5, scope: !427)
!450 = !DILocation(line: 773, column: 3, scope: !448)
!451 = !DILocation(line: 774, column: 9, scope: !427)
!452 = !DILocation(line: 774, column: 5, scope: !427)
!453 = !DILocation(line: 774, column: 7, scope: !427)
!454 = !DILocation(line: 775, column: 2, scope: !427)
!455 = !DILabel(scope: !427, name: "err", file: !3, line: 776)
!456 = !DILocation(line: 776, column: 2, scope: !427)
!457 = !DILocation(line: 777, column: 8, scope: !427)
!458 = !DILocation(line: 777, column: 3, scope: !427)
!459 = !DILocation(line: 778, column: 3, scope: !427)
!460 = !DILocation(line: 779, column: 1, scope: !427)
!461 = distinct !DISubprogram(name: "disconnect_2_6", scope: !3, file: !3, line: 780, type: !462, scopeLine: 780, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!462 = !DISubroutineType(types: !463)
!463 = !{null, !430}
!464 = !DILocalVariable(name: "a", arg: 1, scope: !461, file: !3, line: 780, type: !430)
!465 = !DILocation(line: 0, scope: !461)
!466 = !DILocation(line: 781, column: 1, scope: !461)
!467 = distinct !DISubprogram(name: "entry_point", scope: !3, file: !3, line: 783, type: !192, scopeLine: 783, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!468 = !DILocation(line: 784, column: 12, scope: !467)
!469 = !DILocalVariable(name: "ret", scope: !467, file: !3, line: 784, type: !22)
!470 = !DILocation(line: 0, scope: !467)
!471 = !DILocation(line: 785, column: 8, scope: !472)
!472 = distinct !DILexicalBlock(scope: !467, file: !3, line: 785, column: 5)
!473 = !DILocation(line: 785, column: 5, scope: !467)
!474 = !DILocation(line: 786, column: 3, scope: !475)
!475 = distinct !DILexicalBlock(scope: !472, file: !3, line: 785, column: 13)
!476 = !DILocation(line: 787, column: 2, scope: !475)
!477 = !DILocation(line: 788, column: 7, scope: !467)
!478 = !DILocation(line: 789, column: 1, scope: !467)
!479 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 790, type: !192, scopeLine: 790, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!480 = !DILocation(line: 791, column: 6, scope: !479)
!481 = !DILocation(line: 792, column: 1, scope: !479)
