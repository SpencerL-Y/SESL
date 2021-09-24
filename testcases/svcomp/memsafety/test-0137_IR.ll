; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-0mce8am2.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.node = type { i32, %struct.list_head }

@gl_list = internal global %struct.list_head { %struct.list_head* @gl_list, %struct.list_head* @gl_list }, align 8, !dbg !0
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [42 x i8] c"../testcases/svcomp/memsafety/test-0137.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !25 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !28, !verifier.code !31
  unreachable, !dbg !28, !verifier.code !31
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !32 {
  call void @gl_read(), !dbg !35, !verifier.code !31
  call void @gl_sort(), !dbg !36, !verifier.code !31
  call void @gl_destroy(), !dbg !37, !verifier.code !31
  ret i32 0, !dbg !38, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_read() #0 !dbg !39 {
  br label %1, !dbg !40, !verifier.code !31

1:                                                ; preds = %3, %0
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !41, !verifier.code !43
  call void @gl_insert(i32 %2), !dbg !44, !verifier.code !31
  br label %3, !dbg !45, !verifier.code !31

3:                                                ; preds = %1
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !46, !verifier.code !43
  %5 = icmp ne i32 %4, 0, !dbg !45, !verifier.code !31
  br i1 %5, label %1, label %6, !dbg !45, !llvm.loop !47, !verifier.code !31

6:                                                ; preds = %3
  ret void, !dbg !49, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_sort() #0 !dbg !50 {
  %1 = alloca %struct.list_head, align 8, !verifier.code !31
  %2 = call i32 @list_empty(%struct.list_head* @gl_list), !dbg !51, !verifier.code !31
  %3 = icmp ne i32 %2, 0, !dbg !51, !verifier.code !31
  br i1 %3, label %4, label %5, !dbg !53, !verifier.code !31

4:                                                ; preds = %0
  br label %22, !dbg !54, !verifier.code !31

5:                                                ; preds = %0
  call void @llvm.dbg.declare(metadata %struct.list_head* %1, metadata !55, metadata !DIExpression()), !dbg !56, !verifier.code !31
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !56, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !56, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !56, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %7, align 8, !dbg !56, !verifier.code !31
  %8 = call %struct.list_head* @gl_seek_max(), !dbg !57, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %8, metadata !58, metadata !DIExpression()), !dbg !59, !verifier.code !31
  %9 = icmp ne %struct.list_head* %8, null, !dbg !60, !verifier.code !31
  br i1 %9, label %.lr.ph, label %14, !dbg !60, !verifier.code !31

.lr.ph:                                           ; preds = %5
  br label %10, !dbg !60, !verifier.code !31

10:                                               ; preds = %forwarder, %.lr.ph
  %11 = phi %struct.list_head* [ %8, %.lr.ph ], [ %12, %forwarder ], !verifier.code !31
  call void @list_move(%struct.list_head* %11, %struct.list_head* %1), !dbg !61, !verifier.code !31
  %12 = call %struct.list_head* @gl_seek_max(), !dbg !57, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %12, metadata !58, metadata !DIExpression()), !dbg !59, !verifier.code !31
  %13 = icmp ne %struct.list_head* %12, null, !dbg !60, !verifier.code !31
  br i1 %13, label %forwarder, label %._crit_edge, !dbg !60, !llvm.loop !62, !verifier.code !31

._crit_edge:                                      ; preds = %10
  br label %14, !dbg !60, !verifier.code !31

14:                                               ; preds = %._crit_edge, %5
  %15 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !64, !verifier.code !31
  %16 = load %struct.list_head*, %struct.list_head** %15, align 8, !dbg !64, !verifier.code !31
  %17 = getelementptr inbounds %struct.list_head, %struct.list_head* %16, i32 0, i32 1, !dbg !65, !verifier.code !31
  store %struct.list_head* @gl_list, %struct.list_head** %17, align 8, !dbg !66, !verifier.code !31
  %18 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !67, !verifier.code !31
  %19 = load %struct.list_head*, %struct.list_head** %18, align 8, !dbg !67, !verifier.code !31
  %20 = getelementptr inbounds %struct.list_head, %struct.list_head* %19, i32 0, i32 0, !dbg !68, !verifier.code !31
  store %struct.list_head* @gl_list, %struct.list_head** %20, align 8, !dbg !69, !verifier.code !31
  %21 = bitcast %struct.list_head* %1 to i8*, !dbg !70, !verifier.code !31
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 bitcast (%struct.list_head* @gl_list to i8*), i8* align 8 %21, i64 16, i1 false), !dbg !70, !verifier.code !31
  br label %22, !dbg !71, !verifier.code !31

22:                                               ; preds = %14, %4
  ret void, !dbg !71, !verifier.code !31

forwarder:                                        ; preds = %10
  br label %10, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_destroy() #0 !dbg !72 {
  %1 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !73, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !74, metadata !DIExpression()), !dbg !75, !verifier.code !31
  %2 = icmp ne %struct.list_head* @gl_list, %1, !dbg !76, !verifier.code !31
  br i1 %2, label %.lr.ph, label %13, !dbg !77, !verifier.code !31

.lr.ph:                                           ; preds = %0
  br label %3, !dbg !77, !verifier.code !31

3:                                                ; preds = %forwarder, %.lr.ph
  %4 = phi %struct.list_head* [ %1, %.lr.ph ], [ %11, %forwarder ], !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %4, i32 0, i32 0, !dbg !78, !verifier.code !31
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !78, !verifier.code !31
  store %struct.list_head* %6, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !80, !verifier.code !31
  %7 = bitcast %struct.list_head* %4 to i8*, !dbg !81, !verifier.code !31
  %8 = getelementptr inbounds i8, i8* %7, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !81, !verifier.code !31
  %9 = bitcast i8* %8 to %struct.node*, !dbg !81, !verifier.code !31
  %10 = bitcast %struct.node* %9 to i8*, !dbg !81, !verifier.code !31
  call void @free(i8* %10) #7, !dbg !82, !verifier.code !31
  %11 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !73, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %11, metadata !74, metadata !DIExpression()), !dbg !75, !verifier.code !31
  %12 = icmp ne %struct.list_head* @gl_list, %11, !dbg !76, !verifier.code !31
  br i1 %12, label %forwarder, label %._crit_edge, !dbg !77, !llvm.loop !83, !verifier.code !31

._crit_edge:                                      ; preds = %3
  br label %13, !dbg !77, !verifier.code !31

13:                                               ; preds = %._crit_edge, %0
  ret void, !dbg !85, !verifier.code !31

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !31
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @list_empty(%struct.list_head* %0) #0 !dbg !86 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !89, metadata !DIExpression()), !dbg !90, !verifier.code !31
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !91, !verifier.code !31
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !91, !verifier.code !31
  %4 = icmp eq %struct.list_head* %3, %0, !dbg !92, !verifier.code !31
  %5 = zext i1 %4 to i32, !dbg !92, !verifier.code !31
  ret i32 %5, !dbg !93, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.list_head* @gl_seek_max() #0 !dbg !94 {
  call void @llvm.dbg.value(metadata %struct.list_head* null, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %1 = call i32 @list_empty(%struct.list_head* @gl_list), !dbg !99, !verifier.code !31
  %2 = icmp ne i32 %1, 0, !dbg !99, !verifier.code !31
  br i1 %2, label %3, label %4, !dbg !101, !verifier.code !31

3:                                                ; preds = %0
  br label %21, !dbg !102, !verifier.code !31

4:                                                ; preds = %0
  %5 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !103, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %5, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %6 = call i32 @val_from_node(%struct.list_head* %5), !dbg !105, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %6, metadata !106, metadata !DIExpression()), !dbg !98, !verifier.code !31
  br label %7, !verifier.code !31

7:                                                ; preds = %4
  %8 = getelementptr inbounds %struct.list_head, %struct.list_head* %5, i32 0, i32 0, !dbg !107, !verifier.code !31
  %9 = load %struct.list_head*, %struct.list_head** %8, align 8, !dbg !107, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %9, metadata !109, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %5, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %6, metadata !106, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %10 = icmp ne %struct.list_head* %9, %5, !dbg !110, !verifier.code !31
  br i1 %10, label %.lr.ph, label %20, !dbg !107, !verifier.code !31

.lr.ph:                                           ; preds = %7
  br label %11, !dbg !107, !verifier.code !31

11:                                               ; preds = %forwarder, %.lr.ph
  %.017 = phi %struct.list_head* [ %9, %.lr.ph ], [ %18, %forwarder ], !verifier.code !31
  %.026 = phi %struct.list_head* [ %5, %.lr.ph ], [ %.1, %forwarder ], !verifier.code !31
  %.035 = phi i32 [ %6, %.lr.ph ], [ %.14, %forwarder ], !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.017, metadata !109, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.026, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %.035, metadata !106, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %12 = call i32 @val_from_node(%struct.list_head* %.017), !dbg !112, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %12, metadata !114, metadata !DIExpression()), !dbg !116, !verifier.code !31
  %13 = icmp slt i32 %12, %.035, !dbg !117, !verifier.code !31
  br i1 %13, label %14, label %15, !dbg !119, !verifier.code !31

14:                                               ; preds = %11
  br label %16, !dbg !120, !verifier.code !31

15:                                               ; preds = %11
  call void @llvm.dbg.value(metadata %struct.list_head* %.017, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %12, metadata !106, metadata !DIExpression()), !dbg !98, !verifier.code !31
  br label %16, !dbg !121, !verifier.code !31

16:                                               ; preds = %15, %14
  %.018 = phi %struct.list_head* [ %.017, %14 ], [ %.017, %15 ], !verifier.code !31
  %.14 = phi i32 [ %.035, %14 ], [ %12, %15 ], !dbg !98, !verifier.code !31
  %.1 = phi %struct.list_head* [ %.026, %14 ], [ %.017, %15 ], !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.1, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %.14, metadata !106, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %17 = getelementptr inbounds %struct.list_head, %struct.list_head* %.018, i32 0, i32 0, !dbg !110, !verifier.code !31
  %18 = load %struct.list_head*, %struct.list_head** %17, align 8, !dbg !110, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %18, metadata !109, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %19 = icmp ne %struct.list_head* %18, %.1, !dbg !110, !verifier.code !31
  br i1 %19, label %forwarder, label %._crit_edge, !dbg !107, !llvm.loop !122, !verifier.code !31

._crit_edge:                                      ; preds = %16
  %split = phi %struct.list_head* [ %.1, %16 ], !verifier.code !31
  br label %20, !dbg !107, !verifier.code !31

20:                                               ; preds = %._crit_edge, %7
  %.02.lcssa = phi %struct.list_head* [ %split, %._crit_edge ], [ %5, %7 ], !dbg !124, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.02.lcssa, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  br label %21, !dbg !125, !verifier.code !31

21:                                               ; preds = %20, %3
  %.0 = phi %struct.list_head* [ null, %3 ], [ %.02.lcssa, %20 ], !dbg !98, !verifier.code !31
  ret %struct.list_head* %.0, !dbg !126, !verifier.code !31

forwarder:                                        ; preds = %16
  br label %11, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_move(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !127 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !130, metadata !DIExpression()), !dbg !131, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !132, metadata !DIExpression()), !dbg !131, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !133, !verifier.code !31
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !133, !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !134, !verifier.code !31
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !134, !verifier.code !31
  call void @__list_del(%struct.list_head* %4, %struct.list_head* %6), !dbg !135, !verifier.code !31
  call void @list_add(%struct.list_head* %0, %struct.list_head* %1), !dbg !136, !verifier.code !31
  ret void, !dbg !137, !verifier.code !31
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal void @__list_del(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !138 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !139, metadata !DIExpression()), !dbg !140, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !141, metadata !DIExpression()), !dbg !140, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !142, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !143, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !144, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %4, align 8, !dbg !145, !verifier.code !31
  ret void, !dbg !146, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_add(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !147 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !148, metadata !DIExpression()), !dbg !149, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !151, !verifier.code !31
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !151, !verifier.code !31
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %4), !dbg !152, !verifier.code !31
  ret void, !dbg !153, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !154 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !157, metadata !DIExpression()), !dbg !158, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !159, metadata !DIExpression()), !dbg !158, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !160, metadata !DIExpression()), !dbg !158, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !161, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !162, !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !163, !verifier.code !31
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !164, !verifier.code !31
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !165, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !166, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !167, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !168, !verifier.code !31
  ret void, !dbg !169, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @val_from_node(%struct.list_head* %0) #0 !dbg !170 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !171, metadata !DIExpression()), !dbg !172, !verifier.code !31
  %2 = bitcast %struct.list_head* %0 to i8*, !dbg !173, !verifier.code !31
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !173, !verifier.code !31
  %4 = bitcast i8* %3 to %struct.node*, !dbg !173, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !174, metadata !DIExpression()), !dbg !172, !verifier.code !31
  %5 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 0, !dbg !175, !verifier.code !31
  %6 = load i32, i32* %5, align 8, !dbg !175, !verifier.code !31
  ret i32 %6, !dbg !176, !verifier.code !31
}

declare dso_local i32 @__VERIFIER_nondet_int() #5

; Function Attrs: noinline nounwind uwtable
define internal void @gl_insert(i32 %0) #0 !dbg !177 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !180, metadata !DIExpression()), !dbg !181, !verifier.code !31
  %2 = call noalias i8* @malloc(i64 24) #7, !dbg !182, !verifier.code !31
  %3 = bitcast i8* %2 to %struct.node*, !dbg !182, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !183, metadata !DIExpression()), !dbg !181, !verifier.code !31
  %4 = icmp ne %struct.node* %3, null, !dbg !184, !verifier.code !31
  br i1 %4, label %6, label %5, !dbg !186, !verifier.code !31

5:                                                ; preds = %1
  call void @abort() #6, !dbg !187, !verifier.code !31
  unreachable, !dbg !187, !verifier.code !31

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !188, !verifier.code !31
  store i32 %0, i32* %7, align 8, !dbg !189, !verifier.code !31
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !190, !verifier.code !31
  call void @list_add(%struct.list_head* %8, %struct.list_head* @gl_list), !dbg !191, !verifier.code !31
  ret void, !dbg !192, !verifier.code !31
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  store %struct.list_head* @gl_list, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0)
  store %struct.list_head* @gl_list, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 1)
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!21}
!llvm.module.flags = !{!22, !23, !24}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "gl_list", scope: !2, file: !3, line: 78, type: !12, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0137.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !17, !19}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !3, line: 73, size: 192, elements: !8)
!8 = !{!9, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !7, file: !3, line: 74, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "linkage", scope: !7, file: !3, line: 75, baseType: !12, size: 128, offset: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list_head", file: !3, line: 14, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !12, file: !3, line: 15, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !12, file: !3, line: 15, baseType: !15, size: 64, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!20 = !{!0}
!21 = !{!"clang version 10.0.0-4ubuntu1 "}
!22 = !{i32 7, !"Dwarf Version", i32 4}
!23 = !{i32 2, !"Debug Info Version", i32 3}
!24 = !{i32 1, !"wchar_size", i32 4}
!25 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !26, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{null}
!28 = !DILocation(line: 3, column: 22, scope: !29)
!29 = distinct !DILexicalBlock(scope: !30, file: !3, line: 3, column: 22)
!30 = distinct !DILexicalBlock(scope: !25, file: !3, line: 3, column: 22)
!31 = !{i1 false}
!32 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 153, type: !33, scopeLine: 154, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!33 = !DISubroutineType(types: !34)
!34 = !{!10}
!35 = !DILocation(line: 155, column: 5, scope: !32)
!36 = !DILocation(line: 156, column: 5, scope: !32)
!37 = !DILocation(line: 157, column: 5, scope: !32)
!38 = !DILocation(line: 159, column: 5, scope: !32)
!39 = distinct !DISubprogram(name: "gl_read", scope: !3, file: !3, line: 90, type: !26, scopeLine: 91, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!40 = !DILocation(line: 92, column: 5, scope: !39)
!41 = !DILocation(line: 93, column: 19, scope: !42)
!42 = distinct !DILexicalBlock(scope: !39, file: !3, line: 92, column: 8)
!43 = !{i1 true}
!44 = !DILocation(line: 93, column: 9, scope: !42)
!45 = !DILocation(line: 94, column: 5, scope: !42)
!46 = !DILocation(line: 95, column: 12, scope: !39)
!47 = distinct !{!47, !40, !48}
!48 = !DILocation(line: 95, column: 35, scope: !39)
!49 = !DILocation(line: 96, column: 1, scope: !39)
!50 = distinct !DISubprogram(name: "gl_sort", scope: !3, file: !3, line: 137, type: !26, scopeLine: 138, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!51 = !DILocation(line: 139, column: 9, scope: !52)
!52 = distinct !DILexicalBlock(scope: !50, file: !3, line: 139, column: 9)
!53 = !DILocation(line: 139, column: 9, scope: !50)
!54 = !DILocation(line: 140, column: 9, scope: !52)
!55 = !DILocalVariable(name: "dst", scope: !50, file: !3, line: 142, type: !12)
!56 = !DILocation(line: 142, column: 5, scope: !50)
!57 = !DILocation(line: 145, column: 23, scope: !50)
!58 = !DILocalVariable(name: "max_pos", scope: !50, file: !3, line: 144, type: !15)
!59 = !DILocation(line: 0, scope: !50)
!60 = !DILocation(line: 145, column: 5, scope: !50)
!61 = !DILocation(line: 146, column: 9, scope: !50)
!62 = distinct !{!62, !60, !63}
!63 = !DILocation(line: 146, column: 32, scope: !50)
!64 = !DILocation(line: 148, column: 9, scope: !50)
!65 = !DILocation(line: 148, column: 15, scope: !50)
!66 = !DILocation(line: 148, column: 20, scope: !50)
!67 = !DILocation(line: 149, column: 9, scope: !50)
!68 = !DILocation(line: 149, column: 15, scope: !50)
!69 = !DILocation(line: 149, column: 20, scope: !50)
!70 = !DILocation(line: 150, column: 15, scope: !50)
!71 = !DILocation(line: 151, column: 1, scope: !50)
!72 = distinct !DISubprogram(name: "gl_destroy", scope: !3, file: !3, line: 98, type: !26, scopeLine: 99, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!73 = !DILocation(line: 101, column: 40, scope: !72)
!74 = !DILocalVariable(name: "next", scope: !72, file: !3, line: 100, type: !15)
!75 = !DILocation(line: 0, scope: !72)
!76 = !DILocation(line: 101, column: 21, scope: !72)
!77 = !DILocation(line: 101, column: 5, scope: !72)
!78 = !DILocation(line: 102, column: 30, scope: !79)
!79 = distinct !DILexicalBlock(scope: !72, file: !3, line: 101, column: 47)
!80 = !DILocation(line: 102, column: 22, scope: !79)
!81 = !DILocation(line: 103, column: 14, scope: !79)
!82 = !DILocation(line: 103, column: 9, scope: !79)
!83 = distinct !{!83, !77, !84}
!84 = !DILocation(line: 104, column: 2, scope: !72)
!85 = !DILocation(line: 105, column: 1, scope: !72)
!86 = distinct !DISubprogram(name: "list_empty", scope: !3, file: !3, line: 34, type: !87, scopeLine: 35, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!87 = !DISubroutineType(types: !88)
!88 = !{!10, !15}
!89 = !DILocalVariable(name: "head", arg: 1, scope: !86, file: !3, line: 34, type: !15)
!90 = !DILocation(line: 0, scope: !86)
!91 = !DILocation(line: 36, column: 15, scope: !86)
!92 = !DILocation(line: 36, column: 20, scope: !86)
!93 = !DILocation(line: 36, column: 2, scope: !86)
!94 = distinct !DISubprogram(name: "gl_seek_max", scope: !3, file: !3, line: 112, type: !95, scopeLine: 113, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!95 = !DISubroutineType(types: !96)
!96 = !{!15}
!97 = !DILocalVariable(name: "max_pos", scope: !94, file: !3, line: 114, type: !15)
!98 = !DILocation(line: 0, scope: !94)
!99 = !DILocation(line: 117, column: 9, scope: !100)
!100 = distinct !DILexicalBlock(scope: !94, file: !3, line: 117, column: 9)
!101 = !DILocation(line: 117, column: 9, scope: !94)
!102 = !DILocation(line: 118, column: 9, scope: !100)
!103 = !DILocation(line: 120, column: 27, scope: !104)
!104 = distinct !DILexicalBlock(scope: !100, file: !3, line: 119, column: 10)
!105 = !DILocation(line: 121, column: 15, scope: !104)
!106 = !DILocalVariable(name: "max", scope: !94, file: !3, line: 115, type: !10)
!107 = !DILocation(line: 125, column: 5, scope: !108)
!108 = distinct !DILexicalBlock(scope: !94, file: !3, line: 125, column: 5)
!109 = !DILocalVariable(name: "pos", scope: !94, file: !3, line: 114, type: !15)
!110 = !DILocation(line: 125, column: 5, scope: !111)
!111 = distinct !DILexicalBlock(scope: !108, file: !3, line: 125, column: 5)
!112 = !DILocation(line: 126, column: 27, scope: !113)
!113 = distinct !DILexicalBlock(scope: !111, file: !3, line: 125, column: 33)
!114 = !DILocalVariable(name: "value", scope: !113, file: !3, line: 126, type: !115)
!115 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!116 = !DILocation(line: 0, scope: !113)
!117 = !DILocation(line: 127, column: 19, scope: !118)
!118 = distinct !DILexicalBlock(scope: !113, file: !3, line: 127, column: 13)
!119 = !DILocation(line: 127, column: 13, scope: !113)
!120 = !DILocation(line: 128, column: 13, scope: !118)
!121 = !DILocation(line: 132, column: 5, scope: !113)
!122 = distinct !{!122, !107, !123}
!123 = !DILocation(line: 132, column: 5, scope: !108)
!124 = !DILocation(line: 120, column: 17, scope: !104)
!125 = !DILocation(line: 134, column: 5, scope: !94)
!126 = !DILocation(line: 135, column: 1, scope: !94)
!127 = distinct !DISubprogram(name: "list_move", scope: !3, file: !3, line: 67, type: !128, scopeLine: 68, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!128 = !DISubroutineType(types: !129)
!129 = !{null, !15, !15}
!130 = !DILocalVariable(name: "list", arg: 1, scope: !127, file: !3, line: 67, type: !15)
!131 = !DILocation(line: 0, scope: !127)
!132 = !DILocalVariable(name: "head", arg: 2, scope: !127, file: !3, line: 67, type: !15)
!133 = !DILocation(line: 69, column: 26, scope: !127)
!134 = !DILocation(line: 69, column: 38, scope: !127)
!135 = !DILocation(line: 69, column: 9, scope: !127)
!136 = !DILocation(line: 70, column: 9, scope: !127)
!137 = !DILocation(line: 71, column: 1, scope: !127)
!138 = distinct !DISubprogram(name: "__list_del", scope: !3, file: !3, line: 49, type: !128, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!139 = !DILocalVariable(name: "prev", arg: 1, scope: !138, file: !3, line: 49, type: !15)
!140 = !DILocation(line: 0, scope: !138)
!141 = !DILocalVariable(name: "next", arg: 2, scope: !138, file: !3, line: 49, type: !15)
!142 = !DILocation(line: 51, column: 8, scope: !138)
!143 = !DILocation(line: 51, column: 13, scope: !138)
!144 = !DILocation(line: 52, column: 8, scope: !138)
!145 = !DILocation(line: 52, column: 13, scope: !138)
!146 = !DILocation(line: 53, column: 1, scope: !138)
!147 = distinct !DISubprogram(name: "list_add", scope: !3, file: !3, line: 55, type: !128, scopeLine: 56, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!148 = !DILocalVariable(name: "new", arg: 1, scope: !147, file: !3, line: 55, type: !15)
!149 = !DILocation(line: 0, scope: !147)
!150 = !DILocalVariable(name: "head", arg: 2, scope: !147, file: !3, line: 55, type: !15)
!151 = !DILocation(line: 57, column: 30, scope: !147)
!152 = !DILocation(line: 57, column: 2, scope: !147)
!153 = !DILocation(line: 58, column: 1, scope: !147)
!154 = distinct !DISubprogram(name: "__list_add", scope: !3, file: !3, line: 39, type: !155, scopeLine: 42, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!155 = !DISubroutineType(types: !156)
!156 = !{null, !15, !15, !15}
!157 = !DILocalVariable(name: "new", arg: 1, scope: !154, file: !3, line: 39, type: !15)
!158 = !DILocation(line: 0, scope: !154)
!159 = !DILocalVariable(name: "prev", arg: 2, scope: !154, file: !3, line: 40, type: !15)
!160 = !DILocalVariable(name: "next", arg: 3, scope: !154, file: !3, line: 41, type: !15)
!161 = !DILocation(line: 43, column: 8, scope: !154)
!162 = !DILocation(line: 43, column: 13, scope: !154)
!163 = !DILocation(line: 44, column: 7, scope: !154)
!164 = !DILocation(line: 44, column: 12, scope: !154)
!165 = !DILocation(line: 45, column: 7, scope: !154)
!166 = !DILocation(line: 45, column: 12, scope: !154)
!167 = !DILocation(line: 46, column: 8, scope: !154)
!168 = !DILocation(line: 46, column: 13, scope: !154)
!169 = !DILocation(line: 47, column: 1, scope: !154)
!170 = distinct !DISubprogram(name: "val_from_node", scope: !3, file: !3, line: 107, type: !87, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!171 = !DILocalVariable(name: "head", arg: 1, scope: !170, file: !3, line: 107, type: !15)
!172 = !DILocation(line: 0, scope: !170)
!173 = !DILocation(line: 108, column: 26, scope: !170)
!174 = !DILocalVariable(name: "entry", scope: !170, file: !3, line: 108, type: !6)
!175 = !DILocation(line: 109, column: 19, scope: !170)
!176 = !DILocation(line: 109, column: 5, scope: !170)
!177 = distinct !DISubprogram(name: "gl_insert", scope: !3, file: !3, line: 80, type: !178, scopeLine: 81, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!178 = !DISubroutineType(types: !179)
!179 = !{null, !10}
!180 = !DILocalVariable(name: "value", arg: 1, scope: !177, file: !3, line: 80, type: !10)
!181 = !DILocation(line: 0, scope: !177)
!182 = !DILocation(line: 82, column: 25, scope: !177)
!183 = !DILocalVariable(name: "node", scope: !177, file: !3, line: 82, type: !6)
!184 = !DILocation(line: 83, column: 10, scope: !185)
!185 = distinct !DILexicalBlock(scope: !177, file: !3, line: 83, column: 9)
!186 = !DILocation(line: 83, column: 9, scope: !177)
!187 = !DILocation(line: 84, column: 9, scope: !185)
!188 = !DILocation(line: 86, column: 11, scope: !177)
!189 = !DILocation(line: 86, column: 17, scope: !177)
!190 = !DILocation(line: 87, column: 21, scope: !177)
!191 = !DILocation(line: 87, column: 5, scope: !177)
!192 = !DILocation(line: 88, column: 1, scope: !177)
