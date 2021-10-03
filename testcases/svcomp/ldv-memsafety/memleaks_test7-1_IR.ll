; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-y_rdx5ak.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ldv_list_head = type { %struct.ldv_list_head*, %struct.ldv_list_head* }
%struct.ldv_msg = type { i8*, %struct.ldv_list_head }
%struct.ldv_kobject = type { i8*, %struct.ldv_list_head, %struct.ldv_kref }
%struct.ldv_kref = type { %struct.ldv_atomic_t }
%struct.ldv_atomic_t = type { i32 }
%struct.A = type { i8* }

@ldv_global_msg_list = internal global %struct.ldv_list_head { %struct.ldv_list_head* @ldv_global_msg_list, %struct.ldv_list_head* @ldv_global_msg_list }, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_nonpositive() #0 !dbg !41 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !44, !verifier.code !45
  call void @llvm.dbg.value(metadata i32 %1, metadata !46, metadata !DIExpression()), !dbg !47, !verifier.code !48
  %2 = icmp slt i32 %1, 0, !dbg !49, !verifier.code !48
  br i1 %2, label %3, label %4, !dbg !51, !verifier.code !48

3:                                                ; preds = %0
  br label %5, !dbg !52, !verifier.code !48

4:                                                ; preds = %0
  br label %5, !dbg !53, !verifier.code !48

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ %1, %3 ], [ 0, %4 ], !dbg !54, !verifier.code !48
  ret i32 %.0, !dbg !55, !verifier.code !48
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_positive() #0 !dbg !56 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !57, !verifier.code !45
  call void @llvm.dbg.value(metadata i32 %1, metadata !58, metadata !DIExpression()), !dbg !59, !verifier.code !48
  %2 = icmp sgt i32 %1, 0, !dbg !60, !verifier.code !48
  br i1 %2, label %3, label %4, !dbg !62, !verifier.code !48

3:                                                ; preds = %0
  br label %5, !dbg !63, !verifier.code !48

4:                                                ; preds = %0
  br label %5, !dbg !64, !verifier.code !48

5:                                                ; preds = %4, %3
  %.0 = phi i32 [ %1, %3 ], [ 1, %4 ], !dbg !65, !verifier.code !48
  ret i32 %.0, !dbg !66, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i8* @ldv_malloc(i32 %0) #0 !dbg !67 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !70, metadata !DIExpression()), !dbg !71, !verifier.code !48
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !72, !verifier.code !45
  %3 = icmp ne i32 %2, 0, !dbg !72, !verifier.code !48
  br i1 %3, label %4, label %6, !dbg !74, !verifier.code !48

4:                                                ; preds = %1
  %5 = call noalias i8* @malloc(i32 %0) #4, !dbg !75, !verifier.code !48
  br label %7, !dbg !77, !verifier.code !48

6:                                                ; preds = %1
  br label %7, !dbg !78, !verifier.code !48

7:                                                ; preds = %6, %4
  %.0 = phi i8* [ %5, %4 ], [ null, %6 ], !dbg !80, !verifier.code !48
  ret i8* %.0, !dbg !81, !verifier.code !48
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

; Function Attrs: noinline nounwind uwtable
define internal i8* @ldv_zalloc(i32 %0) #0 !dbg !82 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !83, metadata !DIExpression()), !dbg !84, !verifier.code !48
  %2 = call noalias i8* @calloc(i32 %0, i32 1) #4, !dbg !85, !verifier.code !48
  ret i8* %2, !dbg !86, !verifier.code !48
}

; Function Attrs: nounwind
declare dso_local noalias i8* @calloc(i32, i32) #3

; Function Attrs: noinline nounwind uwtable
define internal %struct.ldv_msg* @ldv_msg_alloc() #0 !dbg !87 {
  %1 = call i8* @ldv_malloc(i32 24), !dbg !90, !verifier.code !48
  %2 = bitcast i8* %1 to %struct.ldv_msg*, !dbg !91, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %2, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !48
  %3 = icmp ne %struct.ldv_msg* %2, null, !dbg !94, !verifier.code !48
  br i1 %3, label %4, label %7, !dbg !96, !verifier.code !48

4:                                                ; preds = %0
  %5 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %2, i32 0, i32 0, !dbg !97, !verifier.code !48
  store i8* null, i8** %5, align 8, !dbg !99, !verifier.code !48
  %6 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %2, i32 0, i32 1, !dbg !100, !verifier.code !48
  call void @LDV_INIT_LIST_HEAD(%struct.ldv_list_head* %6), !dbg !101, !verifier.code !48
  br label %7, !dbg !102, !verifier.code !48

7:                                                ; preds = %4, %0
  ret %struct.ldv_msg* %2, !dbg !103, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @LDV_INIT_LIST_HEAD(%struct.ldv_list_head* %0) #0 !dbg !104 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !107, metadata !DIExpression()), !dbg !108, !verifier.code !48
  %2 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !109, !verifier.code !48
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %2, align 8, !dbg !110, !verifier.code !48
  %3 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 1, !dbg !111, !verifier.code !48
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %3, align 8, !dbg !112, !verifier.code !48
  ret void, !dbg !113, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_msg_fill(%struct.ldv_msg* %0, i8* %1, i32 %2) #0 !dbg !114 {
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %0, metadata !117, metadata !DIExpression()), !dbg !118, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %1, metadata !119, metadata !DIExpression()), !dbg !118, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %2, metadata !120, metadata !DIExpression()), !dbg !118, !verifier.code !48
  %4 = call i8* @ldv_malloc(i32 %2), !dbg !121, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %4, metadata !122, metadata !DIExpression()), !dbg !118, !verifier.code !48
  %5 = icmp ne i8* %4, null, !dbg !123, !verifier.code !48
  br i1 %5, label %7, label %6, !dbg !125, !verifier.code !48

6:                                                ; preds = %3
  br label %10, !dbg !126, !verifier.code !48

7:                                                ; preds = %3
  %8 = call i8* @memcpy(i8* %4, i8* %1, i32 %2), !dbg !127, !verifier.code !48
  %9 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %0, i32 0, i32 0, !dbg !128, !verifier.code !48
  store i8* %4, i8** %9, align 8, !dbg !129, !verifier.code !48
  br label %10, !dbg !130, !verifier.code !48

10:                                               ; preds = %7, %6
  %.0 = phi i32 [ 0, %7 ], [ 3, %6 ], !dbg !118, !verifier.code !48
  ret i32 %.0, !dbg !131, !verifier.code !48
}

declare dso_local i8* @memcpy(i8*, i8*, i32) #2

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_msg_free(%struct.ldv_msg* %0) #0 !dbg !132 {
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %0, metadata !135, metadata !DIExpression()), !dbg !136, !verifier.code !48
  %2 = icmp ne %struct.ldv_msg* %0, null, !dbg !137, !verifier.code !48
  br i1 %2, label %3, label %7, !dbg !139, !verifier.code !48

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %0, i32 0, i32 0, !dbg !140, !verifier.code !48
  %5 = load i8*, i8** %4, align 8, !dbg !140, !verifier.code !48
  call void @free(i8* %5) #4, !dbg !142, !verifier.code !48
  %6 = bitcast %struct.ldv_msg* %0 to i8*, !dbg !143, !verifier.code !48
  call void @free(i8* %6) #4, !dbg !144, !verifier.code !48
  br label %7, !dbg !145, !verifier.code !48

7:                                                ; preds = %3, %1
  ret void, !dbg !146, !verifier.code !48
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_submit_msg(%struct.ldv_msg* %0) #0 !dbg !147 {
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %0, metadata !150, metadata !DIExpression()), !dbg !151, !verifier.code !48
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !152, !verifier.code !45
  %3 = icmp ne i32 %2, 0, !dbg !152, !verifier.code !48
  br i1 %3, label %4, label %6, !dbg !154, !verifier.code !48

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %0, i32 0, i32 1, !dbg !155, !verifier.code !48
  call void @ldv_list_add(%struct.ldv_list_head* %5, %struct.ldv_list_head* @ldv_global_msg_list), !dbg !157, !verifier.code !48
  br label %7, !dbg !158, !verifier.code !48

6:                                                ; preds = %1
  br label %7, !dbg !159, !verifier.code !48

7:                                                ; preds = %6, %4
  %.0 = phi i32 [ 0, %4 ], [ -1, %6 ], !dbg !151, !verifier.code !48
  ret i32 %.0, !dbg !160, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_list_add(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1) #0 !dbg !161 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !164, metadata !DIExpression()), !dbg !165, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !166, metadata !DIExpression()), !dbg !165, !verifier.code !48
  %3 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %1, i32 0, i32 0, !dbg !167, !verifier.code !48
  %4 = load %struct.ldv_list_head*, %struct.ldv_list_head** %3, align 8, !dbg !167, !verifier.code !48
  call void @__ldv_list_add(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1, %struct.ldv_list_head* %4), !dbg !168, !verifier.code !48
  ret void, !dbg !169, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @__ldv_list_add(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1, %struct.ldv_list_head* %2) #0 !dbg !170 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !173, metadata !DIExpression()), !dbg !174, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !175, metadata !DIExpression()), !dbg !174, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %2, metadata !176, metadata !DIExpression()), !dbg !174, !verifier.code !48
  %4 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %2, i32 0, i32 1, !dbg !177, !verifier.code !48
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %4, align 8, !dbg !178, !verifier.code !48
  %5 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !179, !verifier.code !48
  store %struct.ldv_list_head* %2, %struct.ldv_list_head** %5, align 8, !dbg !180, !verifier.code !48
  %6 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 1, !dbg !181, !verifier.code !48
  store %struct.ldv_list_head* %1, %struct.ldv_list_head** %6, align 8, !dbg !182, !verifier.code !48
  %7 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %1, i32 0, i32 0, !dbg !183, !verifier.code !48
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %7, align 8, !dbg !184, !verifier.code !48
  ret void, !dbg !185, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_destroy_msgs() #0 !dbg !186 {
  %1 = load %struct.ldv_list_head*, %struct.ldv_list_head** getelementptr inbounds (%struct.ldv_list_head, %struct.ldv_list_head* @ldv_global_msg_list, i32 0, i32 0), align 8, !dbg !189, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !192, metadata !DIExpression()), !dbg !195, !verifier.code !48
  %2 = bitcast %struct.ldv_list_head* %1 to i8*, !dbg !196, !verifier.code !48
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_list_head* getelementptr inbounds (%struct.ldv_msg, %struct.ldv_msg* null, i32 0, i32 1) to i32) to i64)), !dbg !197, !verifier.code !48
  %4 = bitcast i8* %3 to %struct.ldv_msg*, !dbg !198, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %4, metadata !199, metadata !DIExpression()), !dbg !200, !verifier.code !48
  %5 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %4, i32 0, i32 1, !dbg !201, !verifier.code !48
  %6 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %4, i32 0, i32 1, i32 0
  %7 = load %struct.ldv_list_head*, %struct.ldv_list_head** %6, align 8, !dbg !203, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %7, metadata !204, metadata !DIExpression()), !dbg !205, !verifier.code !48
  %8 = bitcast %struct.ldv_list_head* %7 to i8*, !dbg !206, !verifier.code !48
  %9 = getelementptr inbounds i8, i8* %8, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_list_head* getelementptr inbounds (%struct.ldv_msg, %struct.ldv_msg* null, i32 0, i32 1) to i32) to i64)), !dbg !207, !verifier.code !48
  %10 = bitcast i8* %9 to %struct.ldv_msg*, !dbg !208, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %10, metadata !209, metadata !DIExpression()), !dbg !200, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %4, metadata !199, metadata !DIExpression()), !dbg !200, !verifier.code !48
  %11 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %4, i32 0, i32 1, !dbg !210, !verifier.code !48
  %12 = icmp ne %struct.ldv_list_head* %11, @ldv_global_msg_list, !dbg !212, !verifier.code !48
  br i1 %12, label %.lr.ph, label %24, !dbg !213, !verifier.code !48

.lr.ph:                                           ; preds = %0
  br label %13, !dbg !213, !verifier.code !48

13:                                               ; preds = %forwarder, %.lr.ph
  %.03 = phi %struct.ldv_msg* [ %4, %.lr.ph ], [ %.012, %forwarder ], !verifier.code !48
  %.012 = phi %struct.ldv_msg* [ %10, %.lr.ph ], [ %21, %forwarder ], !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %.03, metadata !199, metadata !DIExpression()), !dbg !200, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %.012, metadata !209, metadata !DIExpression()), !dbg !200, !verifier.code !48
  %14 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.03, i32 0, i32 1, !dbg !214, !verifier.code !48
  call void @ldv_list_del(%struct.ldv_list_head* %14), !dbg !216, !verifier.code !48
  call void @ldv_msg_free(%struct.ldv_msg* %.03), !dbg !217, !verifier.code !48
  br label %15, !dbg !218, !verifier.code !48

15:                                               ; preds = %13
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %.012, metadata !199, metadata !DIExpression()), !dbg !200, !verifier.code !48
  %16 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.012, i32 0, i32 1, !dbg !219, !verifier.code !48
  %17 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.012, i32 0, i32 1, i32 0
  %18 = load %struct.ldv_list_head*, %struct.ldv_list_head** %17, align 8, !dbg !221, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %18, metadata !222, metadata !DIExpression()), !dbg !223, !verifier.code !48
  %19 = bitcast %struct.ldv_list_head* %18 to i8*, !dbg !224, !verifier.code !48
  %20 = getelementptr inbounds i8, i8* %19, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_list_head* getelementptr inbounds (%struct.ldv_msg, %struct.ldv_msg* null, i32 0, i32 1) to i32) to i64)), !dbg !225, !verifier.code !48
  %21 = bitcast i8* %20 to %struct.ldv_msg*, !dbg !226, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_msg* %21, metadata !209, metadata !DIExpression()), !dbg !200, !verifier.code !48
  %22 = getelementptr inbounds %struct.ldv_msg, %struct.ldv_msg* %.012, i32 0, i32 1, !dbg !210, !verifier.code !48
  %23 = icmp ne %struct.ldv_list_head* %22, @ldv_global_msg_list, !dbg !212, !verifier.code !48
  br i1 %23, label %forwarder, label %._crit_edge, !dbg !213, !llvm.loop !227, !verifier.code !48

._crit_edge:                                      ; preds = %15
  br label %24, !dbg !213, !verifier.code !48

24:                                               ; preds = %._crit_edge, %0
  ret void, !dbg !229, !verifier.code !48

forwarder:                                        ; preds = %15
  br label %13, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_list_del(%struct.ldv_list_head* %0) #0 !dbg !230 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !231, metadata !DIExpression()), !dbg !232, !verifier.code !48
  %2 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 1, !dbg !233, !verifier.code !48
  %3 = load %struct.ldv_list_head*, %struct.ldv_list_head** %2, align 8, !dbg !233, !verifier.code !48
  %4 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !234, !verifier.code !48
  %5 = load %struct.ldv_list_head*, %struct.ldv_list_head** %4, align 8, !dbg !234, !verifier.code !48
  call void @__ldv_list_del(%struct.ldv_list_head* %3, %struct.ldv_list_head* %5), !dbg !235, !verifier.code !48
  ret void, !dbg !236, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @__ldv_list_del(%struct.ldv_list_head* %0, %struct.ldv_list_head* %1) #0 !dbg !237 {
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %0, metadata !238, metadata !DIExpression()), !dbg !239, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_list_head* %1, metadata !240, metadata !DIExpression()), !dbg !239, !verifier.code !48
  %3 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %1, i32 0, i32 1, !dbg !241, !verifier.code !48
  store %struct.ldv_list_head* %0, %struct.ldv_list_head** %3, align 8, !dbg !242, !verifier.code !48
  %4 = getelementptr inbounds %struct.ldv_list_head, %struct.ldv_list_head* %0, i32 0, i32 0, !dbg !243, !verifier.code !48
  store %struct.ldv_list_head* %1, %struct.ldv_list_head** %4, align 8, !dbg !244, !verifier.code !48
  ret void, !dbg !245, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_del(%struct.ldv_kobject* %0) #0 !dbg !246 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !249, metadata !DIExpression()), !dbg !250, !verifier.code !48
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !251, !verifier.code !48
  br i1 %2, label %4, label %3, !dbg !253, !verifier.code !48

3:                                                ; preds = %1
  br label %4, !dbg !254, !verifier.code !48

4:                                                ; preds = %3, %1
  ret void, !dbg !255, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_put(%struct.ldv_kobject* %0) #0 !dbg !256 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !257, metadata !DIExpression()), !dbg !258, !verifier.code !48
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !259, !verifier.code !48
  br i1 %2, label %3, label %6, !dbg !261, !verifier.code !48

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 2, !dbg !262, !verifier.code !48
  %5 = call i32 @ldv_kref_put(%struct.ldv_kref* %4, void (%struct.ldv_kref*)* @ldv_kobject_release), !dbg !264, !verifier.code !48
  br label %6, !dbg !265, !verifier.code !48

6:                                                ; preds = %3, %1
  ret void, !dbg !266, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_release(%struct.ldv_kref* %0) #0 !dbg !267 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !271, metadata !DIExpression()), !dbg !272, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !273, metadata !DIExpression()), !dbg !277, !verifier.code !48
  %2 = bitcast %struct.ldv_kref* %0 to i8*, !dbg !278, !verifier.code !48
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 zext (i32 ptrtoint (%struct.ldv_kref* getelementptr inbounds (%struct.ldv_kobject, %struct.ldv_kobject* null, i32 0, i32 2) to i32) to i64)), !dbg !279, !verifier.code !48
  %4 = bitcast i8* %3 to %struct.ldv_kobject*, !dbg !280, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %4, metadata !281, metadata !DIExpression()), !dbg !272, !verifier.code !48
  call void @ldv_kobject_cleanup(%struct.ldv_kobject* %4), !dbg !282, !verifier.code !48
  ret void, !dbg !283, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_kref_put(%struct.ldv_kref* %0, void (%struct.ldv_kref*)* %1) #0 !dbg !284 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !288, metadata !DIExpression()), !dbg !289, !verifier.code !48
  call void @llvm.dbg.value(metadata void (%struct.ldv_kref*)* %1, metadata !290, metadata !DIExpression()), !dbg !289, !verifier.code !48
  %3 = call i32 @ldv_kref_sub(%struct.ldv_kref* %0, i32 1, void (%struct.ldv_kref*)* %1), !dbg !291, !verifier.code !48
  ret i32 %3, !dbg !292, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_kref_sub(%struct.ldv_kref* %0, i32 %1, void (%struct.ldv_kref*)* %2) #0 !dbg !293 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !296, metadata !DIExpression()), !dbg !297, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %1, metadata !298, metadata !DIExpression()), !dbg !297, !verifier.code !48
  call void @llvm.dbg.value(metadata void (%struct.ldv_kref*)* %2, metadata !299, metadata !DIExpression()), !dbg !297, !verifier.code !48
  %4 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, !dbg !300, !verifier.code !48
  %5 = call i32 @ldv_atomic_sub_return(i32 %1, %struct.ldv_atomic_t* %4), !dbg !302, !verifier.code !48
  %6 = icmp eq i32 %5, 0, !dbg !303, !verifier.code !48
  br i1 %6, label %7, label %8, !dbg !304, !verifier.code !48

7:                                                ; preds = %3
  call void @devirtbounce(void (%struct.ldv_kref*)* %2, %struct.ldv_kref* %0)
  br label %9, !dbg !305, !verifier.code !48

8:                                                ; preds = %3
  br label %9, !dbg !307, !verifier.code !48

9:                                                ; preds = %8, %7
  %.0 = phi i32 [ 1, %7 ], [ 0, %8 ], !dbg !297, !verifier.code !48
  ret i32 %.0, !dbg !308, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_atomic_sub_return(i32 %0, %struct.ldv_atomic_t* %1) #0 !dbg !309 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !313, metadata !DIExpression()), !dbg !314, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_atomic_t* %1, metadata !315, metadata !DIExpression()), !dbg !314, !verifier.code !48
  %3 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !316, !verifier.code !48
  %4 = load i32, i32* %3, align 4, !dbg !316, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %4, metadata !317, metadata !DIExpression()), !dbg !314, !verifier.code !48
  %5 = sub nsw i32 %4, %0, !dbg !318, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %5, metadata !317, metadata !DIExpression()), !dbg !314, !verifier.code !48
  %6 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !319, !verifier.code !48
  store i32 %5, i32* %6, align 4, !dbg !320, !verifier.code !48
  ret i32 %5, !dbg !321, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_cleanup(%struct.ldv_kobject* %0) #0 !dbg !322 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !323, metadata !DIExpression()), !dbg !324, !verifier.code !48
  %2 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 0, !dbg !325, !verifier.code !48
  %3 = load i8*, i8** %2, align 8, !dbg !325, !verifier.code !48
  call void @llvm.dbg.value(metadata i8* %3, metadata !326, metadata !DIExpression()), !dbg !324, !verifier.code !48
  %4 = bitcast %struct.ldv_kobject* %0 to i8*, !dbg !327, !verifier.code !48
  call void @free(i8* %4) #4, !dbg !328, !verifier.code !48
  %5 = icmp ne i8* %3, null, !dbg !329, !verifier.code !48
  br i1 %5, label %6, label %7, !dbg !331, !verifier.code !48

6:                                                ; preds = %1
  call void @free(i8* %3) #4, !dbg !332, !verifier.code !48
  br label %7, !dbg !334, !verifier.code !48

7:                                                ; preds = %6, %1
  ret void, !dbg !335, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.ldv_kobject* @ldv_kobject_get(%struct.ldv_kobject* %0) #0 !dbg !336 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !339, metadata !DIExpression()), !dbg !340, !verifier.code !48
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !341, !verifier.code !48
  br i1 %2, label %3, label %5, !dbg !343, !verifier.code !48

3:                                                ; preds = %1
  %4 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 2, !dbg !344, !verifier.code !48
  call void @ldv_kref_get(%struct.ldv_kref* %4), !dbg !345, !verifier.code !48
  br label %5, !dbg !345, !verifier.code !48

5:                                                ; preds = %3, %1
  ret %struct.ldv_kobject* %0, !dbg !346, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kref_get(%struct.ldv_kref* %0) #0 !dbg !347 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !348, metadata !DIExpression()), !dbg !349, !verifier.code !48
  %2 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, !dbg !350, !verifier.code !48
  %3 = call i32 @ldv_atomic_add_return(i32 1, %struct.ldv_atomic_t* %2), !dbg !351, !verifier.code !48
  ret void, !dbg !352, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @ldv_atomic_add_return(i32 %0, %struct.ldv_atomic_t* %1) #0 !dbg !353 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !354, metadata !DIExpression()), !dbg !355, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_atomic_t* %1, metadata !356, metadata !DIExpression()), !dbg !355, !verifier.code !48
  %3 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !357, !verifier.code !48
  %4 = load i32, i32* %3, align 4, !dbg !357, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %4, metadata !358, metadata !DIExpression()), !dbg !355, !verifier.code !48
  %5 = add nsw i32 %4, %0, !dbg !359, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %5, metadata !358, metadata !DIExpression()), !dbg !355, !verifier.code !48
  %6 = getelementptr inbounds %struct.ldv_atomic_t, %struct.ldv_atomic_t* %1, i32 0, i32 0, !dbg !360, !verifier.code !48
  store i32 %5, i32* %6, align 4, !dbg !361, !verifier.code !48
  ret i32 %5, !dbg !362, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_init(%struct.ldv_kobject* %0) #0 !dbg !363 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !364, metadata !DIExpression()), !dbg !365, !verifier.code !48
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !366, !verifier.code !48
  br i1 %2, label %4, label %3, !dbg !368, !verifier.code !48

3:                                                ; preds = %1
  br label %5, !dbg !369, !verifier.code !48

4:                                                ; preds = %1
  call void @ldv_kobject_init_internal(%struct.ldv_kobject* %0), !dbg !371, !verifier.code !48
  br label %6, !dbg !372, !verifier.code !48

5:                                                ; preds = %3
  call void @llvm.dbg.label(metadata !373), !dbg !374, !verifier.code !48
  br label %6, !dbg !375, !verifier.code !48

6:                                                ; preds = %5, %4
  ret void, !dbg !376, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kobject_init_internal(%struct.ldv_kobject* %0) #0 !dbg !377 {
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %0, metadata !378, metadata !DIExpression()), !dbg !379, !verifier.code !48
  %2 = icmp ne %struct.ldv_kobject* %0, null, !dbg !380, !verifier.code !48
  br i1 %2, label %4, label %3, !dbg !382, !verifier.code !48

3:                                                ; preds = %1
  br label %7, !dbg !383, !verifier.code !48

4:                                                ; preds = %1
  %5 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 2, !dbg !384, !verifier.code !48
  call void @ldv_kref_init(%struct.ldv_kref* %5), !dbg !385, !verifier.code !48
  %6 = getelementptr inbounds %struct.ldv_kobject, %struct.ldv_kobject* %0, i32 0, i32 1, !dbg !386, !verifier.code !48
  call void @LDV_INIT_LIST_HEAD(%struct.ldv_list_head* %6), !dbg !387, !verifier.code !48
  br label %7, !dbg !388, !verifier.code !48

7:                                                ; preds = %4, %3
  ret void, !dbg !388, !verifier.code !48
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @ldv_kref_init(%struct.ldv_kref* %0) #0 !dbg !389 {
  call void @llvm.dbg.value(metadata %struct.ldv_kref* %0, metadata !390, metadata !DIExpression()), !dbg !391, !verifier.code !48
  %2 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, !dbg !392, !verifier.code !48
  %3 = getelementptr inbounds %struct.ldv_kref, %struct.ldv_kref* %0, i32 0, i32 0, i32 0
  store i32 1, i32* %3, align 4, !dbg !393, !verifier.code !48
  ret void, !dbg !394, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.ldv_kobject* @ldv_kobject_create() #0 !dbg !395 {
  %1 = call i8* @ldv_malloc(i32 32), !dbg !398, !verifier.code !48
  %2 = bitcast i8* %1 to %struct.ldv_kobject*, !dbg !398, !verifier.code !48
  call void @llvm.dbg.value(metadata %struct.ldv_kobject* %2, metadata !399, metadata !DIExpression()), !dbg !400, !verifier.code !48
  %3 = icmp ne %struct.ldv_kobject* %2, null, !dbg !401, !verifier.code !48
  br i1 %3, label %5, label %4, !dbg !403, !verifier.code !48

4:                                                ; preds = %0
  br label %8, !dbg !404, !verifier.code !48

5:                                                ; preds = %0
  %6 = bitcast %struct.ldv_kobject* %2 to i8*, !dbg !405, !verifier.code !48
  %7 = call i8* @memset(i8* %6, i32 0, i32 32), !dbg !406, !verifier.code !48
  call void @ldv_kobject_init(%struct.ldv_kobject* %2), !dbg !407, !verifier.code !48
  br label %8, !dbg !408, !verifier.code !48

8:                                                ; preds = %5, %4
  %.0 = phi %struct.ldv_kobject* [ %2, %5 ], [ null, %4 ], !dbg !400, !verifier.code !48
  ret %struct.ldv_kobject* %.0, !dbg !409, !verifier.code !48
}

declare dso_local i8* @memset(i8*, i32, i32) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @f() #0 !dbg !410 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !411, !verifier.code !45
  ret i32 %1, !dbg !412, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @g() #0 !dbg !413 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !414, !verifier.code !45
  ret i32 %1, !dbg !415, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @f6() #0 !dbg !416 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !417, !verifier.code !45
  ret i32 %1, !dbg !418, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @g6() #0 !dbg !419 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !420, !verifier.code !45
  ret i32 %1, !dbg !421, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @probe1_6(%struct.A* %0) #0 !dbg !422 {
  call void @llvm.dbg.value(metadata %struct.A* %0, metadata !429, metadata !DIExpression()), !dbg !430, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 3, metadata !431, metadata !DIExpression()), !dbg !430, !verifier.code !48
  %2 = call i8* @ldv_malloc(i32 4), !dbg !432, !verifier.code !48
  %3 = bitcast i8* %2 to i32*, !dbg !433, !verifier.code !48
  call void @llvm.dbg.value(metadata i32* %3, metadata !434, metadata !DIExpression()), !dbg !430, !verifier.code !48
  %4 = icmp eq i32* %3, null, !dbg !435, !verifier.code !48
  br i1 %4, label %5, label %6, !dbg !437, !verifier.code !48

5:                                                ; preds = %1
  br label %19, !dbg !438, !verifier.code !48

6:                                                ; preds = %1
  %7 = call i32 @f6(), !dbg !439, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %7, metadata !431, metadata !DIExpression()), !dbg !430, !verifier.code !48
  %8 = icmp slt i32 %7, 0, !dbg !440, !verifier.code !48
  br i1 %8, label %9, label %10, !dbg !442, !verifier.code !48

9:                                                ; preds = %6
  br label %17, !dbg !443, !verifier.code !48

10:                                               ; preds = %6
  %11 = call i32 @g6(), !dbg !444, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %11, metadata !431, metadata !DIExpression()), !dbg !430, !verifier.code !48
  %12 = icmp slt i32 %11, 0, !dbg !445, !verifier.code !48
  br i1 %12, label %13, label %14, !dbg !447, !verifier.code !48

13:                                               ; preds = %10
  br label %17, !dbg !448, !verifier.code !48

14:                                               ; preds = %10
  %15 = bitcast i32* %3 to i8*, !dbg !449, !verifier.code !48
  %16 = getelementptr inbounds %struct.A, %struct.A* %0, i32 0, i32 0, !dbg !450, !verifier.code !48
  store i8* %15, i8** %16, align 8, !dbg !451, !verifier.code !48
  br label %19, !dbg !452, !verifier.code !48

17:                                               ; preds = %13, %9
  %.01 = phi i32 [ %7, %9 ], [ %11, %13 ], !dbg !430, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %.01, metadata !431, metadata !DIExpression()), !dbg !430, !verifier.code !48
  call void @llvm.dbg.label(metadata !453), !dbg !454, !verifier.code !48
  %18 = bitcast i32* %3 to i8*, !dbg !455, !verifier.code !48
  call void @free(i8* %18) #4, !dbg !456, !verifier.code !48
  br label %19, !dbg !457, !verifier.code !48

19:                                               ; preds = %17, %14, %5
  %.0 = phi i32 [ 3, %5 ], [ %.01, %17 ], [ 0, %14 ], !dbg !430, !verifier.code !48
  ret i32 %.0, !dbg !458, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @disconnect_2_6(%struct.A* %0) #0 !dbg !459 {
  call void @llvm.dbg.value(metadata %struct.A* %0, metadata !462, metadata !DIExpression()), !dbg !463, !verifier.code !48
  ret void, !dbg !464, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define internal void @entry_point() #0 !dbg !465 {
  %1 = alloca %struct.A, align 8, !verifier.code !48
  call void @llvm.dbg.declare(metadata %struct.A* %1, metadata !466, metadata !DIExpression()), !dbg !467, !verifier.code !48
  %2 = call i32 @probe1_6(%struct.A* %1), !dbg !468, !verifier.code !48
  call void @llvm.dbg.value(metadata i32 %2, metadata !469, metadata !DIExpression()), !dbg !470, !verifier.code !48
  %3 = icmp eq i32 %2, 0, !dbg !471, !verifier.code !48
  br i1 %3, label %4, label %5, !dbg !473, !verifier.code !48

4:                                                ; preds = %0
  call void @disconnect_2_6(%struct.A* %1), !dbg !474, !verifier.code !48
  br label %5, !dbg !476, !verifier.code !48

5:                                                ; preds = %4, %0
  ret void, !dbg !477, !verifier.code !48
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @main() #0 !dbg !478 {
  call void @entry_point(), !dbg !479, !verifier.code !48
  ret void, !dbg !480, !verifier.code !48
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
!llvm.ident = !{!37}
!llvm.module.flags = !{!38, !39, !40}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "ldv_global_msg_list", scope: !2, file: !3, line: 569, type: !12, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !36, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/ldv-memsafety/memleaks_test7-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!36 = !{!0}
!37 = !{!"clang version 10.0.0-4ubuntu1 "}
!38 = !{i32 7, !"Dwarf Version", i32 4}
!39 = !{i32 2, !"Debug Info Version", i32 3}
!40 = !{i32 1, !"wchar_size", i32 4}
!41 = distinct !DISubprogram(name: "ldv_nonpositive", scope: !3, file: !3, line: 513, type: !42, scopeLine: 513, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!42 = !DISubroutineType(types: !43)
!43 = !{!22}
!44 = !DILocation(line: 514, column: 10, scope: !41)
!45 = !{i1 true}
!46 = !DILocalVariable(name: "r", scope: !41, file: !3, line: 514, type: !22)
!47 = !DILocation(line: 0, scope: !41)
!48 = !{i1 false}
!49 = !DILocation(line: 515, column: 6, scope: !50)
!50 = distinct !DILexicalBlock(scope: !41, file: !3, line: 515, column: 5)
!51 = !DILocation(line: 515, column: 5, scope: !41)
!52 = !DILocation(line: 515, column: 10, scope: !50)
!53 = !DILocation(line: 516, column: 7, scope: !50)
!54 = !DILocation(line: 0, scope: !50)
!55 = !DILocation(line: 517, column: 1, scope: !41)
!56 = distinct !DISubprogram(name: "ldv_positive", scope: !3, file: !3, line: 518, type: !42, scopeLine: 518, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!57 = !DILocation(line: 519, column: 10, scope: !56)
!58 = !DILocalVariable(name: "r", scope: !56, file: !3, line: 519, type: !22)
!59 = !DILocation(line: 0, scope: !56)
!60 = !DILocation(line: 520, column: 6, scope: !61)
!61 = distinct !DILexicalBlock(scope: !56, file: !3, line: 520, column: 5)
!62 = !DILocation(line: 520, column: 5, scope: !56)
!63 = !DILocation(line: 520, column: 10, scope: !61)
!64 = !DILocation(line: 521, column: 7, scope: !61)
!65 = !DILocation(line: 0, scope: !61)
!66 = !DILocation(line: 522, column: 1, scope: !56)
!67 = distinct !DISubprogram(name: "ldv_malloc", scope: !3, file: !3, line: 525, type: !68, scopeLine: 525, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!68 = !DISubroutineType(types: !69)
!69 = !{!10, !19}
!70 = !DILocalVariable(name: "size", arg: 1, scope: !67, file: !3, line: 525, type: !19)
!71 = !DILocation(line: 0, scope: !67)
!72 = !DILocation(line: 526, column: 5, scope: !73)
!73 = distinct !DILexicalBlock(scope: !67, file: !3, line: 526, column: 5)
!74 = !DILocation(line: 526, column: 5, scope: !67)
!75 = !DILocation(line: 527, column: 10, scope: !76)
!76 = distinct !DILexicalBlock(scope: !73, file: !3, line: 526, column: 30)
!77 = !DILocation(line: 527, column: 3, scope: !76)
!78 = !DILocation(line: 529, column: 3, scope: !79)
!79 = distinct !DILexicalBlock(scope: !73, file: !3, line: 528, column: 9)
!80 = !DILocation(line: 0, scope: !73)
!81 = !DILocation(line: 531, column: 1, scope: !67)
!82 = distinct !DISubprogram(name: "ldv_zalloc", scope: !3, file: !3, line: 532, type: !68, scopeLine: 532, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!83 = !DILocalVariable(name: "size", arg: 1, scope: !82, file: !3, line: 532, type: !19)
!84 = !DILocation(line: 0, scope: !82)
!85 = !DILocation(line: 533, column: 9, scope: !82)
!86 = !DILocation(line: 533, column: 2, scope: !82)
!87 = distinct !DISubprogram(name: "ldv_msg_alloc", scope: !3, file: !3, line: 574, type: !88, scopeLine: 574, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!88 = !DISubroutineType(types: !89)
!89 = !{!6}
!90 = !DILocation(line: 576, column: 25, scope: !87)
!91 = !DILocation(line: 576, column: 8, scope: !87)
!92 = !DILocalVariable(name: "msg", scope: !87, file: !3, line: 575, type: !6)
!93 = !DILocation(line: 0, scope: !87)
!94 = !DILocation(line: 577, column: 5, scope: !95)
!95 = distinct !DILexicalBlock(scope: !87, file: !3, line: 577, column: 5)
!96 = !DILocation(line: 577, column: 5, scope: !87)
!97 = !DILocation(line: 578, column: 8, scope: !98)
!98 = distinct !DILexicalBlock(scope: !95, file: !3, line: 577, column: 10)
!99 = !DILocation(line: 578, column: 12, scope: !98)
!100 = !DILocation(line: 579, column: 28, scope: !98)
!101 = !DILocation(line: 579, column: 3, scope: !98)
!102 = !DILocation(line: 580, column: 2, scope: !98)
!103 = !DILocation(line: 581, column: 2, scope: !87)
!104 = distinct !DISubprogram(name: "LDV_INIT_LIST_HEAD", scope: !3, file: !3, line: 538, type: !105, scopeLine: 539, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!105 = !DISubroutineType(types: !106)
!106 = !{null, !15}
!107 = !DILocalVariable(name: "list", arg: 1, scope: !104, file: !3, line: 538, type: !15)
!108 = !DILocation(line: 0, scope: !104)
!109 = !DILocation(line: 540, column: 8, scope: !104)
!110 = !DILocation(line: 540, column: 13, scope: !104)
!111 = !DILocation(line: 541, column: 8, scope: !104)
!112 = !DILocation(line: 541, column: 13, scope: !104)
!113 = !DILocation(line: 542, column: 1, scope: !104)
!114 = distinct !DISubprogram(name: "ldv_msg_fill", scope: !3, file: !3, line: 583, type: !115, scopeLine: 583, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!115 = !DISubroutineType(types: !116)
!116 = !{!22, !6, !10, !22}
!117 = !DILocalVariable(name: "msg", arg: 1, scope: !114, file: !3, line: 583, type: !6)
!118 = !DILocation(line: 0, scope: !114)
!119 = !DILocalVariable(name: "buf", arg: 2, scope: !114, file: !3, line: 583, type: !10)
!120 = !DILocalVariable(name: "len", arg: 3, scope: !114, file: !3, line: 583, type: !22)
!121 = !DILocation(line: 585, column: 9, scope: !114)
!122 = !DILocalVariable(name: "data", scope: !114, file: !3, line: 584, type: !10)
!123 = !DILocation(line: 586, column: 6, scope: !124)
!124 = distinct !DILexicalBlock(scope: !114, file: !3, line: 586, column: 5)
!125 = !DILocation(line: 586, column: 5, scope: !114)
!126 = !DILocation(line: 586, column: 12, scope: !124)
!127 = !DILocation(line: 587, column: 2, scope: !114)
!128 = !DILocation(line: 588, column: 7, scope: !114)
!129 = !DILocation(line: 588, column: 12, scope: !114)
!130 = !DILocation(line: 589, column: 2, scope: !114)
!131 = !DILocation(line: 590, column: 1, scope: !114)
!132 = distinct !DISubprogram(name: "ldv_msg_free", scope: !3, file: !3, line: 591, type: !133, scopeLine: 591, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!133 = !DISubroutineType(types: !134)
!134 = !{null, !6}
!135 = !DILocalVariable(name: "msg", arg: 1, scope: !132, file: !3, line: 591, type: !6)
!136 = !DILocation(line: 0, scope: !132)
!137 = !DILocation(line: 592, column: 5, scope: !138)
!138 = distinct !DILexicalBlock(scope: !132, file: !3, line: 592, column: 5)
!139 = !DILocation(line: 592, column: 5, scope: !132)
!140 = !DILocation(line: 593, column: 13, scope: !141)
!141 = distinct !DILexicalBlock(scope: !138, file: !3, line: 592, column: 10)
!142 = !DILocation(line: 593, column: 3, scope: !141)
!143 = !DILocation(line: 594, column: 8, scope: !141)
!144 = !DILocation(line: 594, column: 3, scope: !141)
!145 = !DILocation(line: 595, column: 2, scope: !141)
!146 = !DILocation(line: 596, column: 1, scope: !132)
!147 = distinct !DISubprogram(name: "ldv_submit_msg", scope: !3, file: !3, line: 597, type: !148, scopeLine: 597, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!148 = !DISubroutineType(types: !149)
!149 = !{!22, !6}
!150 = !DILocalVariable(name: "msg", arg: 1, scope: !147, file: !3, line: 597, type: !6)
!151 = !DILocation(line: 0, scope: !147)
!152 = !DILocation(line: 598, column: 6, scope: !153)
!153 = distinct !DILexicalBlock(scope: !147, file: !3, line: 598, column: 6)
!154 = !DILocation(line: 598, column: 6, scope: !147)
!155 = !DILocation(line: 599, column: 23, scope: !156)
!156 = distinct !DILexicalBlock(scope: !153, file: !3, line: 598, column: 31)
!157 = !DILocation(line: 599, column: 4, scope: !156)
!158 = !DILocation(line: 600, column: 4, scope: !156)
!159 = !DILocation(line: 602, column: 3, scope: !147)
!160 = !DILocation(line: 603, column: 1, scope: !147)
!161 = distinct !DISubprogram(name: "ldv_list_add", scope: !3, file: !3, line: 557, type: !162, scopeLine: 558, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!162 = !DISubroutineType(types: !163)
!163 = !{null, !15, !15}
!164 = !DILocalVariable(name: "new", arg: 1, scope: !161, file: !3, line: 557, type: !15)
!165 = !DILocation(line: 0, scope: !161)
!166 = !DILocalVariable(name: "head", arg: 2, scope: !161, file: !3, line: 557, type: !15)
!167 = !DILocation(line: 559, column: 34, scope: !161)
!168 = !DILocation(line: 559, column: 2, scope: !161)
!169 = !DILocation(line: 560, column: 1, scope: !161)
!170 = distinct !DISubprogram(name: "__ldv_list_add", scope: !3, file: !3, line: 543, type: !171, scopeLine: 546, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!171 = !DISubroutineType(types: !172)
!172 = !{null, !15, !15, !15}
!173 = !DILocalVariable(name: "new", arg: 1, scope: !170, file: !3, line: 543, type: !15)
!174 = !DILocation(line: 0, scope: !170)
!175 = !DILocalVariable(name: "prev", arg: 2, scope: !170, file: !3, line: 544, type: !15)
!176 = !DILocalVariable(name: "next", arg: 3, scope: !170, file: !3, line: 545, type: !15)
!177 = !DILocation(line: 547, column: 8, scope: !170)
!178 = !DILocation(line: 547, column: 13, scope: !170)
!179 = !DILocation(line: 548, column: 7, scope: !170)
!180 = !DILocation(line: 548, column: 12, scope: !170)
!181 = !DILocation(line: 549, column: 7, scope: !170)
!182 = !DILocation(line: 549, column: 12, scope: !170)
!183 = !DILocation(line: 550, column: 8, scope: !170)
!184 = !DILocation(line: 550, column: 13, scope: !170)
!185 = !DILocation(line: 551, column: 1, scope: !170)
!186 = distinct !DISubprogram(name: "ldv_destroy_msgs", scope: !3, file: !3, line: 604, type: !187, scopeLine: 604, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!187 = !DISubroutineType(types: !188)
!188 = !{null}
!189 = !DILocation(line: 607, column: 93, scope: !190)
!190 = distinct !DILexicalBlock(scope: !191, file: !3, line: 607, column: 14)
!191 = distinct !DILexicalBlock(scope: !186, file: !3, line: 607, column: 2)
!192 = !DILocalVariable(name: "__mptr", scope: !190, file: !3, line: 607, type: !193)
!193 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !194, size: 64)
!194 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !12)
!195 = !DILocation(line: 0, scope: !190)
!196 = !DILocation(line: 607, column: 118, scope: !190)
!197 = !DILocation(line: 607, column: 133, scope: !190)
!198 = !DILocation(line: 607, column: 100, scope: !190)
!199 = !DILocalVariable(name: "msg", scope: !186, file: !3, line: 605, type: !6)
!200 = !DILocation(line: 0, scope: !186)
!201 = !DILocation(line: 607, column: 248, scope: !202)
!202 = distinct !DILexicalBlock(scope: !191, file: !3, line: 607, column: 184)
!203 = !DILocation(line: 607, column: 253, scope: !202)
!204 = !DILocalVariable(name: "__mptr", scope: !202, file: !3, line: 607, type: !193)
!205 = !DILocation(line: 0, scope: !202)
!206 = !DILocation(line: 607, column: 280, scope: !202)
!207 = !DILocation(line: 607, column: 295, scope: !202)
!208 = !DILocation(line: 607, column: 260, scope: !202)
!209 = !DILocalVariable(name: "n", scope: !186, file: !3, line: 606, type: !6)
!210 = !DILocation(line: 607, column: 349, scope: !211)
!211 = distinct !DILexicalBlock(scope: !191, file: !3, line: 607, column: 2)
!212 = !DILocation(line: 607, column: 354, scope: !211)
!213 = !DILocation(line: 607, column: 2, scope: !191)
!214 = !DILocation(line: 608, column: 22, scope: !215)
!215 = distinct !DILexicalBlock(scope: !211, file: !3, line: 607, column: 546)
!216 = !DILocation(line: 608, column: 3, scope: !215)
!217 = !DILocation(line: 609, column: 3, scope: !215)
!218 = !DILocation(line: 610, column: 2, scope: !215)
!219 = !DILocation(line: 607, column: 455, scope: !220)
!220 = distinct !DILexicalBlock(scope: !211, file: !3, line: 607, column: 395)
!221 = !DILocation(line: 607, column: 460, scope: !220)
!222 = !DILocalVariable(name: "__mptr", scope: !220, file: !3, line: 607, type: !193)
!223 = !DILocation(line: 0, scope: !220)
!224 = !DILocation(line: 607, column: 485, scope: !220)
!225 = !DILocation(line: 607, column: 500, scope: !220)
!226 = !DILocation(line: 607, column: 467, scope: !220)
!227 = distinct !{!227, !213, !228}
!228 = !DILocation(line: 610, column: 2, scope: !191)
!229 = !DILocation(line: 611, column: 1, scope: !186)
!230 = distinct !DISubprogram(name: "ldv_list_del", scope: !3, file: !3, line: 565, type: !105, scopeLine: 566, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!231 = !DILocalVariable(name: "entry", arg: 1, scope: !230, file: !3, line: 565, type: !15)
!232 = !DILocation(line: 0, scope: !230)
!233 = !DILocation(line: 567, column: 24, scope: !230)
!234 = !DILocation(line: 567, column: 37, scope: !230)
!235 = !DILocation(line: 567, column: 2, scope: !230)
!236 = !DILocation(line: 568, column: 1, scope: !230)
!237 = distinct !DISubprogram(name: "__ldv_list_del", scope: !3, file: !3, line: 552, type: !162, scopeLine: 553, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!238 = !DILocalVariable(name: "prev", arg: 1, scope: !237, file: !3, line: 552, type: !15)
!239 = !DILocation(line: 0, scope: !237)
!240 = !DILocalVariable(name: "next", arg: 2, scope: !237, file: !3, line: 552, type: !15)
!241 = !DILocation(line: 554, column: 8, scope: !237)
!242 = !DILocation(line: 554, column: 13, scope: !237)
!243 = !DILocation(line: 555, column: 8, scope: !237)
!244 = !DILocation(line: 555, column: 13, scope: !237)
!245 = !DILocation(line: 556, column: 1, scope: !237)
!246 = distinct !DISubprogram(name: "ldv_kobject_del", scope: !3, file: !3, line: 692, type: !247, scopeLine: 693, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!247 = !DISubroutineType(types: !248)
!248 = !{null, !23}
!249 = !DILocalVariable(name: "kobj", arg: 1, scope: !246, file: !3, line: 692, type: !23)
!250 = !DILocation(line: 0, scope: !246)
!251 = !DILocation(line: 694, column: 14, scope: !252)
!252 = distinct !DILexicalBlock(scope: !246, file: !3, line: 694, column: 13)
!253 = !DILocation(line: 694, column: 13, scope: !246)
!254 = !DILocation(line: 695, column: 17, scope: !252)
!255 = !DILocation(line: 696, column: 1, scope: !246)
!256 = distinct !DISubprogram(name: "ldv_kobject_put", scope: !3, file: !3, line: 709, type: !247, scopeLine: 710, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!257 = !DILocalVariable(name: "kobj", arg: 1, scope: !256, file: !3, line: 709, type: !23)
!258 = !DILocation(line: 0, scope: !256)
!259 = !DILocation(line: 711, column: 13, scope: !260)
!260 = distinct !DILexicalBlock(scope: !256, file: !3, line: 711, column: 13)
!261 = !DILocation(line: 711, column: 13, scope: !256)
!262 = !DILocation(line: 712, column: 37, scope: !263)
!263 = distinct !DILexicalBlock(scope: !260, file: !3, line: 711, column: 19)
!264 = !DILocation(line: 712, column: 17, scope: !263)
!265 = !DILocation(line: 713, column: 9, scope: !263)
!266 = !DILocation(line: 714, column: 1, scope: !256)
!267 = distinct !DISubprogram(name: "ldv_kobject_release", scope: !3, file: !3, line: 705, type: !268, scopeLine: 705, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!268 = !DISubroutineType(types: !269)
!269 = !{null, !270}
!270 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!271 = !DILocalVariable(name: "kref", arg: 1, scope: !267, file: !3, line: 705, type: !270)
!272 = !DILocation(line: 0, scope: !267)
!273 = !DILocalVariable(name: "__mptr", scope: !274, file: !3, line: 706, type: !275)
!274 = distinct !DILexicalBlock(scope: !267, file: !3, line: 706, column: 30)
!275 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !276, size: 64)
!276 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !29)
!277 = !DILocation(line: 0, scope: !274)
!278 = !DILocation(line: 706, column: 122, scope: !274)
!279 = !DILocation(line: 706, column: 137, scope: !274)
!280 = !DILocation(line: 706, column: 98, scope: !274)
!281 = !DILocalVariable(name: "kobj", scope: !267, file: !3, line: 706, type: !23)
!282 = !DILocation(line: 707, column: 9, scope: !267)
!283 = !DILocation(line: 708, column: 1, scope: !267)
!284 = distinct !DISubprogram(name: "ldv_kref_put", scope: !3, file: !3, line: 688, type: !285, scopeLine: 689, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!285 = !DISubroutineType(types: !286)
!286 = !{!22, !270, !287}
!287 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !268, size: 64)
!288 = !DILocalVariable(name: "kref", arg: 1, scope: !284, file: !3, line: 688, type: !270)
!289 = !DILocation(line: 0, scope: !284)
!290 = !DILocalVariable(name: "release", arg: 2, scope: !284, file: !3, line: 688, type: !287)
!291 = !DILocation(line: 690, column: 16, scope: !284)
!292 = !DILocation(line: 690, column: 9, scope: !284)
!293 = distinct !DISubprogram(name: "ldv_kref_sub", scope: !3, file: !3, line: 671, type: !294, scopeLine: 673, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!294 = !DISubroutineType(types: !295)
!295 = !{!22, !270, !20, !287}
!296 = !DILocalVariable(name: "kref", arg: 1, scope: !293, file: !3, line: 671, type: !270)
!297 = !DILocation(line: 0, scope: !293)
!298 = !DILocalVariable(name: "count", arg: 2, scope: !293, file: !3, line: 671, type: !20)
!299 = !DILocalVariable(name: "release", arg: 3, scope: !293, file: !3, line: 672, type: !287)
!300 = !DILocation(line: 674, column: 59, scope: !301)
!301 = distinct !DILexicalBlock(scope: !293, file: !3, line: 674, column: 13)
!302 = !DILocation(line: 674, column: 14, scope: !301)
!303 = !DILocation(line: 674, column: 70, scope: !301)
!304 = !DILocation(line: 674, column: 13, scope: !293)
!305 = !DILocation(line: 676, column: 17, scope: !306)
!306 = distinct !DILexicalBlock(scope: !301, file: !3, line: 674, column: 77)
!307 = !DILocation(line: 678, column: 9, scope: !293)
!308 = !DILocation(line: 679, column: 1, scope: !293)
!309 = distinct !DISubprogram(name: "ldv_atomic_sub_return", scope: !3, file: !3, line: 663, type: !310, scopeLine: 664, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!310 = !DISubroutineType(types: !311)
!311 = !{!22, !22, !312}
!312 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!313 = !DILocalVariable(name: "i", arg: 1, scope: !309, file: !3, line: 663, type: !22)
!314 = !DILocation(line: 0, scope: !309)
!315 = !DILocalVariable(name: "v", arg: 2, scope: !309, file: !3, line: 663, type: !312)
!316 = !DILocation(line: 666, column: 19, scope: !309)
!317 = !DILocalVariable(name: "temp", scope: !309, file: !3, line: 665, type: !22)
!318 = !DILocation(line: 667, column: 14, scope: !309)
!319 = !DILocation(line: 668, column: 12, scope: !309)
!320 = !DILocation(line: 668, column: 20, scope: !309)
!321 = !DILocation(line: 669, column: 9, scope: !309)
!322 = distinct !DISubprogram(name: "ldv_kobject_cleanup", scope: !3, file: !3, line: 697, type: !247, scopeLine: 698, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!323 = !DILocalVariable(name: "kobj", arg: 1, scope: !322, file: !3, line: 697, type: !23)
!324 = !DILocation(line: 0, scope: !322)
!325 = !DILocation(line: 699, column: 28, scope: !322)
!326 = !DILocalVariable(name: "name", scope: !322, file: !3, line: 699, type: !17)
!327 = !DILocation(line: 700, column: 14, scope: !322)
!328 = !DILocation(line: 700, column: 9, scope: !322)
!329 = !DILocation(line: 701, column: 13, scope: !330)
!330 = distinct !DILexicalBlock(scope: !322, file: !3, line: 701, column: 13)
!331 = !DILocation(line: 701, column: 13, scope: !322)
!332 = !DILocation(line: 702, column: 17, scope: !333)
!333 = distinct !DILexicalBlock(scope: !330, file: !3, line: 701, column: 19)
!334 = !DILocation(line: 703, column: 9, scope: !333)
!335 = !DILocation(line: 704, column: 1, scope: !322)
!336 = distinct !DISubprogram(name: "ldv_kobject_get", scope: !3, file: !3, line: 715, type: !337, scopeLine: 716, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!337 = !DISubroutineType(types: !338)
!338 = !{!23, !23}
!339 = !DILocalVariable(name: "kobj", arg: 1, scope: !336, file: !3, line: 715, type: !23)
!340 = !DILocation(line: 0, scope: !336)
!341 = !DILocation(line: 717, column: 13, scope: !342)
!342 = distinct !DILexicalBlock(scope: !336, file: !3, line: 717, column: 13)
!343 = !DILocation(line: 717, column: 13, scope: !336)
!344 = !DILocation(line: 718, column: 37, scope: !342)
!345 = !DILocation(line: 718, column: 17, scope: !342)
!346 = !DILocation(line: 719, column: 9, scope: !336)
!347 = distinct !DISubprogram(name: "ldv_kref_get", scope: !3, file: !3, line: 684, type: !268, scopeLine: 685, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!348 = !DILocalVariable(name: "kref", arg: 1, scope: !347, file: !3, line: 684, type: !270)
!349 = !DILocation(line: 0, scope: !347)
!350 = !DILocation(line: 686, column: 42, scope: !347)
!351 = !DILocation(line: 686, column: 9, scope: !347)
!352 = !DILocation(line: 687, column: 1, scope: !347)
!353 = distinct !DISubprogram(name: "ldv_atomic_add_return", scope: !3, file: !3, line: 655, type: !310, scopeLine: 656, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!354 = !DILocalVariable(name: "i", arg: 1, scope: !353, file: !3, line: 655, type: !22)
!355 = !DILocation(line: 0, scope: !353)
!356 = !DILocalVariable(name: "v", arg: 2, scope: !353, file: !3, line: 655, type: !312)
!357 = !DILocation(line: 658, column: 19, scope: !353)
!358 = !DILocalVariable(name: "temp", scope: !353, file: !3, line: 657, type: !22)
!359 = !DILocation(line: 659, column: 14, scope: !353)
!360 = !DILocation(line: 660, column: 12, scope: !353)
!361 = !DILocation(line: 660, column: 20, scope: !353)
!362 = !DILocation(line: 661, column: 9, scope: !353)
!363 = distinct !DISubprogram(name: "ldv_kobject_init", scope: !3, file: !3, line: 728, type: !247, scopeLine: 729, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!364 = !DILocalVariable(name: "kobj", arg: 1, scope: !363, file: !3, line: 728, type: !23)
!365 = !DILocation(line: 0, scope: !363)
!366 = !DILocation(line: 730, column: 14, scope: !367)
!367 = distinct !DILexicalBlock(scope: !363, file: !3, line: 730, column: 13)
!368 = !DILocation(line: 730, column: 13, scope: !363)
!369 = !DILocation(line: 731, column: 17, scope: !370)
!370 = distinct !DILexicalBlock(scope: !367, file: !3, line: 730, column: 20)
!371 = !DILocation(line: 733, column: 9, scope: !363)
!372 = !DILocation(line: 734, column: 9, scope: !363)
!373 = !DILabel(scope: !363, name: "error", file: !3, line: 735)
!374 = !DILocation(line: 735, column: 1, scope: !363)
!375 = !DILocation(line: 736, column: 2, scope: !363)
!376 = !DILocation(line: 737, column: 1, scope: !363)
!377 = distinct !DISubprogram(name: "ldv_kobject_init_internal", scope: !3, file: !3, line: 721, type: !247, scopeLine: 722, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!378 = !DILocalVariable(name: "kobj", arg: 1, scope: !377, file: !3, line: 721, type: !23)
!379 = !DILocation(line: 0, scope: !377)
!380 = !DILocation(line: 723, column: 14, scope: !381)
!381 = distinct !DILexicalBlock(scope: !377, file: !3, line: 723, column: 13)
!382 = !DILocation(line: 723, column: 13, scope: !377)
!383 = !DILocation(line: 724, column: 17, scope: !381)
!384 = !DILocation(line: 725, column: 30, scope: !377)
!385 = !DILocation(line: 725, column: 9, scope: !377)
!386 = !DILocation(line: 726, column: 35, scope: !377)
!387 = !DILocation(line: 726, column: 9, scope: !377)
!388 = !DILocation(line: 727, column: 1, scope: !377)
!389 = distinct !DISubprogram(name: "ldv_kref_init", scope: !3, file: !3, line: 680, type: !268, scopeLine: 681, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!390 = !DILocalVariable(name: "kref", arg: 1, scope: !389, file: !3, line: 680, type: !270)
!391 = !DILocation(line: 0, scope: !389)
!392 = !DILocation(line: 682, column: 19, scope: !389)
!393 = !DILocation(line: 682, column: 39, scope: !389)
!394 = !DILocation(line: 683, column: 1, scope: !389)
!395 = distinct !DISubprogram(name: "ldv_kobject_create", scope: !3, file: !3, line: 738, type: !396, scopeLine: 739, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!396 = !DISubroutineType(types: !397)
!397 = !{!23}
!398 = !DILocation(line: 741, column: 16, scope: !395)
!399 = !DILocalVariable(name: "kobj", scope: !395, file: !3, line: 740, type: !23)
!400 = !DILocation(line: 0, scope: !395)
!401 = !DILocation(line: 742, column: 14, scope: !402)
!402 = distinct !DILexicalBlock(scope: !395, file: !3, line: 742, column: 13)
!403 = !DILocation(line: 742, column: 13, scope: !395)
!404 = !DILocation(line: 743, column: 17, scope: !402)
!405 = !DILocation(line: 744, column: 9, scope: !395)
!406 = !DILocation(line: 744, column: 2, scope: !395)
!407 = !DILocation(line: 745, column: 9, scope: !395)
!408 = !DILocation(line: 746, column: 9, scope: !395)
!409 = !DILocation(line: 747, column: 1, scope: !395)
!410 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 751, type: !42, scopeLine: 751, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!411 = !DILocation(line: 752, column: 9, scope: !410)
!412 = !DILocation(line: 752, column: 2, scope: !410)
!413 = distinct !DISubprogram(name: "g", scope: !3, file: !3, line: 754, type: !42, scopeLine: 754, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!414 = !DILocation(line: 755, column: 9, scope: !413)
!415 = !DILocation(line: 755, column: 2, scope: !413)
!416 = distinct !DISubprogram(name: "f6", scope: !3, file: !3, line: 757, type: !42, scopeLine: 757, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!417 = !DILocation(line: 758, column: 9, scope: !416)
!418 = !DILocation(line: 758, column: 2, scope: !416)
!419 = distinct !DISubprogram(name: "g6", scope: !3, file: !3, line: 760, type: !42, scopeLine: 760, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!420 = !DILocation(line: 761, column: 9, scope: !419)
!421 = !DILocation(line: 761, column: 2, scope: !419)
!422 = distinct !DISubprogram(name: "probe1_6", scope: !3, file: !3, line: 763, type: !423, scopeLine: 763, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!423 = !DISubroutineType(types: !424)
!424 = !{!22, !425}
!425 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !426, size: 64)
!426 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "A", file: !3, line: 748, size: 64, elements: !427)
!427 = !{!428}
!428 = !DIDerivedType(tag: DW_TAG_member, name: "p", scope: !426, file: !3, line: 749, baseType: !10, size: 64)
!429 = !DILocalVariable(name: "a", arg: 1, scope: !422, file: !3, line: 763, type: !425)
!430 = !DILocation(line: 0, scope: !422)
!431 = !DILocalVariable(name: "ret", scope: !422, file: !3, line: 764, type: !22)
!432 = !DILocation(line: 765, column: 18, scope: !422)
!433 = !DILocation(line: 765, column: 11, scope: !422)
!434 = !DILocalVariable(name: "p", scope: !422, file: !3, line: 765, type: !21)
!435 = !DILocation(line: 766, column: 6, scope: !436)
!436 = distinct !DILexicalBlock(scope: !422, file: !3, line: 766, column: 5)
!437 = !DILocation(line: 766, column: 5, scope: !422)
!438 = !DILocation(line: 767, column: 3, scope: !436)
!439 = !DILocation(line: 768, column: 8, scope: !422)
!440 = !DILocation(line: 769, column: 8, scope: !441)
!441 = distinct !DILexicalBlock(scope: !422, file: !3, line: 769, column: 5)
!442 = !DILocation(line: 769, column: 5, scope: !422)
!443 = !DILocation(line: 770, column: 3, scope: !441)
!444 = !DILocation(line: 771, column: 8, scope: !422)
!445 = !DILocation(line: 772, column: 8, scope: !446)
!446 = distinct !DILexicalBlock(scope: !422, file: !3, line: 772, column: 5)
!447 = !DILocation(line: 772, column: 5, scope: !422)
!448 = !DILocation(line: 773, column: 3, scope: !446)
!449 = !DILocation(line: 774, column: 9, scope: !422)
!450 = !DILocation(line: 774, column: 5, scope: !422)
!451 = !DILocation(line: 774, column: 7, scope: !422)
!452 = !DILocation(line: 775, column: 2, scope: !422)
!453 = !DILabel(scope: !422, name: "err", file: !3, line: 776)
!454 = !DILocation(line: 776, column: 2, scope: !422)
!455 = !DILocation(line: 777, column: 8, scope: !422)
!456 = !DILocation(line: 777, column: 3, scope: !422)
!457 = !DILocation(line: 778, column: 3, scope: !422)
!458 = !DILocation(line: 779, column: 1, scope: !422)
!459 = distinct !DISubprogram(name: "disconnect_2_6", scope: !3, file: !3, line: 780, type: !460, scopeLine: 780, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!460 = !DISubroutineType(types: !461)
!461 = !{null, !425}
!462 = !DILocalVariable(name: "a", arg: 1, scope: !459, file: !3, line: 780, type: !425)
!463 = !DILocation(line: 0, scope: !459)
!464 = !DILocation(line: 781, column: 1, scope: !459)
!465 = distinct !DISubprogram(name: "entry_point", scope: !3, file: !3, line: 782, type: !187, scopeLine: 782, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!466 = !DILocalVariable(name: "a7", scope: !465, file: !3, line: 783, type: !426)
!467 = !DILocation(line: 783, column: 11, scope: !465)
!468 = !DILocation(line: 784, column: 12, scope: !465)
!469 = !DILocalVariable(name: "ret", scope: !465, file: !3, line: 784, type: !22)
!470 = !DILocation(line: 0, scope: !465)
!471 = !DILocation(line: 785, column: 8, scope: !472)
!472 = distinct !DILexicalBlock(scope: !465, file: !3, line: 785, column: 5)
!473 = !DILocation(line: 785, column: 5, scope: !465)
!474 = !DILocation(line: 786, column: 3, scope: !475)
!475 = distinct !DILexicalBlock(scope: !472, file: !3, line: 785, column: 13)
!476 = !DILocation(line: 787, column: 2, scope: !475)
!477 = !DILocation(line: 788, column: 1, scope: !465)
!478 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 789, type: !187, scopeLine: 789, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!479 = !DILocation(line: 790, column: 6, scope: !478)
!480 = !DILocation(line: 791, column: 1, scope: !478)
