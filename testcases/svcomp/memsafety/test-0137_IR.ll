; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-bsh15d5j.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.node = type { i32, %struct.list_head }

@gl_list = internal global %struct.list_head { %struct.list_head* @gl_list, %struct.list_head* @gl_list }, align 8, !dbg !0
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c"test-0137.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !25 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !28, !verifier.code !31
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
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !57, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !57, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !57, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %7, align 8, !dbg !57, !verifier.code !31
  %8 = call %struct.list_head* @gl_seek_max(), !dbg !58, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %8, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !31
  %9 = icmp ne %struct.list_head* %8, null, !dbg !61, !verifier.code !31
  br i1 %9, label %.lr.ph, label %14, !dbg !61, !verifier.code !31

.lr.ph:                                           ; preds = %5
  br label %10, !dbg !61, !verifier.code !31

10:                                               ; preds = %forwarder, %.lr.ph
  %11 = phi %struct.list_head* [ %8, %.lr.ph ], [ %12, %forwarder ], !verifier.code !31
  call void @list_move(%struct.list_head* %11, %struct.list_head* %1), !dbg !62, !verifier.code !31
  %12 = call %struct.list_head* @gl_seek_max(), !dbg !58, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %12, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !31
  %13 = icmp ne %struct.list_head* %12, null, !dbg !61, !verifier.code !31
  br i1 %13, label %forwarder, label %._crit_edge, !dbg !61, !llvm.loop !63, !verifier.code !31

._crit_edge:                                      ; preds = %10
  br label %14, !dbg !61, !verifier.code !31

14:                                               ; preds = %._crit_edge, %5
  %15 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !65, !verifier.code !31
  %16 = load %struct.list_head*, %struct.list_head** %15, align 8, !dbg !65, !verifier.code !31
  %17 = getelementptr inbounds %struct.list_head, %struct.list_head* %16, i32 0, i32 1, !dbg !66, !verifier.code !31
  store %struct.list_head* @gl_list, %struct.list_head** %17, align 8, !dbg !67, !verifier.code !31
  %18 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !68, !verifier.code !31
  %19 = load %struct.list_head*, %struct.list_head** %18, align 8, !dbg !68, !verifier.code !31
  %20 = getelementptr inbounds %struct.list_head, %struct.list_head* %19, i32 0, i32 0, !dbg !69, !verifier.code !31
  store %struct.list_head* @gl_list, %struct.list_head** %20, align 8, !dbg !70, !verifier.code !31
  %21 = bitcast %struct.list_head* %1 to i8*, !dbg !71, !verifier.code !31
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 bitcast (%struct.list_head* @gl_list to i8*), i8* align 8 %21, i64 16, i1 false), !dbg !71, !verifier.code !31
  br label %22, !dbg !72, !verifier.code !31

22:                                               ; preds = %14, %4
  ret void, !dbg !72, !verifier.code !31

forwarder:                                        ; preds = %10
  br label %10, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_destroy() #0 !dbg !73 {
  %1 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !74, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !31
  %2 = icmp ne %struct.list_head* @gl_list, %1, !dbg !77, !verifier.code !31
  br i1 %2, label %.lr.ph, label %13, !dbg !78, !verifier.code !31

.lr.ph:                                           ; preds = %0
  br label %3, !dbg !78, !verifier.code !31

3:                                                ; preds = %forwarder, %.lr.ph
  %4 = phi %struct.list_head* [ %1, %.lr.ph ], [ %11, %forwarder ], !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %4, i32 0, i32 0, !dbg !79, !verifier.code !31
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !79, !verifier.code !31
  store %struct.list_head* %6, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !81, !verifier.code !31
  %7 = bitcast %struct.list_head* %4 to i8*, !dbg !82, !verifier.code !31
  %8 = getelementptr inbounds i8, i8* %7, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !83, !verifier.code !31
  %9 = bitcast i8* %8 to %struct.node*, !dbg !84, !verifier.code !31
  %10 = bitcast %struct.node* %9 to i8*, !dbg !85, !verifier.code !31
  call void @free(i8* %10) #7, !dbg !86, !verifier.code !31
  %11 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !74, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %11, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !31
  %12 = icmp ne %struct.list_head* @gl_list, %11, !dbg !77, !verifier.code !31
  br i1 %12, label %forwarder, label %._crit_edge, !dbg !78, !llvm.loop !87, !verifier.code !31

._crit_edge:                                      ; preds = %3
  br label %13, !dbg !78, !verifier.code !31

13:                                               ; preds = %._crit_edge, %0
  ret void, !dbg !89, !verifier.code !31

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !31
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @list_empty(%struct.list_head* %0) #0 !dbg !90 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !31
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !95, !verifier.code !31
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !95, !verifier.code !31
  %4 = icmp eq %struct.list_head* %3, %0, !dbg !96, !verifier.code !31
  %5 = zext i1 %4 to i32, !dbg !96, !verifier.code !31
  ret i32 %5, !dbg !97, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.list_head* @gl_seek_max() #0 !dbg !98 {
  call void @llvm.dbg.value(metadata %struct.list_head* null, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  %1 = call i32 @list_empty(%struct.list_head* @gl_list), !dbg !103, !verifier.code !31
  %2 = icmp ne i32 %1, 0, !dbg !103, !verifier.code !31
  br i1 %2, label %3, label %4, !dbg !105, !verifier.code !31

3:                                                ; preds = %0
  br label %21, !dbg !106, !verifier.code !31

4:                                                ; preds = %0
  %5 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !107, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %5, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  %6 = call i32 @val_from_node(%struct.list_head* %5), !dbg !109, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %6, metadata !110, metadata !DIExpression()), !dbg !102, !verifier.code !31
  br label %7, !verifier.code !31

7:                                                ; preds = %4
  %8 = getelementptr inbounds %struct.list_head, %struct.list_head* %5, i32 0, i32 0, !dbg !111, !verifier.code !31
  %9 = load %struct.list_head*, %struct.list_head** %8, align 8, !dbg !111, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %9, metadata !113, metadata !DIExpression()), !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %5, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %6, metadata !110, metadata !DIExpression()), !dbg !102, !verifier.code !31
  %10 = icmp ne %struct.list_head* %9, %5, !dbg !114, !verifier.code !31
  br i1 %10, label %.lr.ph, label %20, !dbg !116, !verifier.code !31

.lr.ph:                                           ; preds = %7
  br label %11, !dbg !116, !verifier.code !31

11:                                               ; preds = %forwarder, %.lr.ph
  %.017 = phi %struct.list_head* [ %9, %.lr.ph ], [ %18, %forwarder ], !verifier.code !31
  %.026 = phi %struct.list_head* [ %5, %.lr.ph ], [ %.1, %forwarder ], !verifier.code !31
  %.035 = phi i32 [ %6, %.lr.ph ], [ %.14, %forwarder ], !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.017, metadata !113, metadata !DIExpression()), !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.026, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %.035, metadata !110, metadata !DIExpression()), !dbg !102, !verifier.code !31
  %12 = call i32 @val_from_node(%struct.list_head* %.017), !dbg !117, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %12, metadata !119, metadata !DIExpression()), !dbg !121, !verifier.code !31
  %13 = icmp slt i32 %12, %.035, !dbg !122, !verifier.code !31
  br i1 %13, label %14, label %15, !dbg !124, !verifier.code !31

14:                                               ; preds = %11
  br label %16, !dbg !125, !verifier.code !31

15:                                               ; preds = %11
  call void @llvm.dbg.value(metadata %struct.list_head* %.017, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %12, metadata !110, metadata !DIExpression()), !dbg !102, !verifier.code !31
  br label %16, !dbg !126, !verifier.code !31

16:                                               ; preds = %15, %14
  %.018 = phi %struct.list_head* [ %.017, %14 ], [ %.017, %15 ], !verifier.code !31
  %.14 = phi i32 [ %.035, %14 ], [ %12, %15 ], !dbg !102, !verifier.code !31
  %.1 = phi %struct.list_head* [ %.026, %14 ], [ %.017, %15 ], !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.1, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %.14, metadata !110, metadata !DIExpression()), !dbg !102, !verifier.code !31
  %17 = getelementptr inbounds %struct.list_head, %struct.list_head* %.018, i32 0, i32 0, !dbg !127, !verifier.code !31
  %18 = load %struct.list_head*, %struct.list_head** %17, align 8, !dbg !127, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %18, metadata !113, metadata !DIExpression()), !dbg !102, !verifier.code !31
  %19 = icmp ne %struct.list_head* %18, %.1, !dbg !114, !verifier.code !31
  br i1 %19, label %forwarder, label %._crit_edge, !dbg !116, !llvm.loop !128, !verifier.code !31

._crit_edge:                                      ; preds = %16
  %split = phi %struct.list_head* [ %.1, %16 ], !verifier.code !31
  br label %20, !dbg !116, !verifier.code !31

20:                                               ; preds = %._crit_edge, %7
  %.02.lcssa = phi %struct.list_head* [ %split, %._crit_edge ], [ %5, %7 ], !dbg !130, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.02.lcssa, metadata !101, metadata !DIExpression()), !dbg !102, !verifier.code !31
  br label %21, !dbg !131, !verifier.code !31

21:                                               ; preds = %20, %3
  %.0 = phi %struct.list_head* [ null, %3 ], [ %.02.lcssa, %20 ], !dbg !102, !verifier.code !31
  ret %struct.list_head* %.0, !dbg !132, !verifier.code !31

forwarder:                                        ; preds = %16
  br label %11, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_move(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !133 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !136, metadata !DIExpression()), !dbg !137, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !138, metadata !DIExpression()), !dbg !137, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !139, !verifier.code !31
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !139, !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !140, !verifier.code !31
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !140, !verifier.code !31
  call void @__list_del(%struct.list_head* %4, %struct.list_head* %6), !dbg !141, !verifier.code !31
  call void @list_add(%struct.list_head* %0, %struct.list_head* %1), !dbg !142, !verifier.code !31
  ret void, !dbg !143, !verifier.code !31
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define internal void @__list_del(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !144 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !145, metadata !DIExpression()), !dbg !146, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !147, metadata !DIExpression()), !dbg !146, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !148, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !149, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !150, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %4, align 8, !dbg !151, !verifier.code !31
  ret void, !dbg !152, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_add(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !153 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !154, metadata !DIExpression()), !dbg !155, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !156, metadata !DIExpression()), !dbg !155, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !157, !verifier.code !31
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !157, !verifier.code !31
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %4), !dbg !158, !verifier.code !31
  ret void, !dbg !159, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !160 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !163, metadata !DIExpression()), !dbg !164, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !165, metadata !DIExpression()), !dbg !164, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !166, metadata !DIExpression()), !dbg !164, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !167, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !168, !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !169, !verifier.code !31
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !170, !verifier.code !31
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !171, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !172, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !173, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !174, !verifier.code !31
  ret void, !dbg !175, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @val_from_node(%struct.list_head* %0) #0 !dbg !176 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !177, metadata !DIExpression()), !dbg !178, !verifier.code !31
  %2 = bitcast %struct.list_head* %0 to i8*, !dbg !179, !verifier.code !31
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !180, !verifier.code !31
  %4 = bitcast i8* %3 to %struct.node*, !dbg !181, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !182, metadata !DIExpression()), !dbg !178, !verifier.code !31
  %5 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 0, !dbg !183, !verifier.code !31
  %6 = load i32, i32* %5, align 8, !dbg !183, !verifier.code !31
  ret i32 %6, !dbg !184, !verifier.code !31
}

declare dso_local i32 @__VERIFIER_nondet_int() #5

; Function Attrs: noinline nounwind uwtable
define internal void @gl_insert(i32 %0) #0 !dbg !185 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !188, metadata !DIExpression()), !dbg !189, !verifier.code !31
  %2 = call noalias i8* @malloc(i32 24) #7, !dbg !190, !verifier.code !31
  %3 = bitcast i8* %2 to %struct.node*, !dbg !190, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !191, metadata !DIExpression()), !dbg !189, !verifier.code !31
  %4 = icmp ne %struct.node* %3, null, !dbg !192, !verifier.code !31
  br i1 %4, label %6, label %5, !dbg !194, !verifier.code !31

5:                                                ; preds = %1
  call void @abort() #6, !dbg !195, !verifier.code !31
  unreachable, !dbg !195, !verifier.code !31

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !196, !verifier.code !31
  store i32 %0, i32* %7, align 8, !dbg !197, !verifier.code !31
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !198, !verifier.code !31
  call void @list_add(%struct.list_head* %8, %struct.list_head* @gl_list), !dbg !199, !verifier.code !31
  ret void, !dbg !200, !verifier.code !31
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

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
!1 = distinct !DIGlobalVariable(name: "gl_list", scope: !2, file: !3, line: 564, type: !12, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0137.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !17, !19}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !3, line: 560, size: 192, elements: !8)
!8 = !{!9, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !7, file: !3, line: 561, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "linkage", scope: !7, file: !3, line: 562, baseType: !12, size: 128, offset: 64)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list_head", file: !3, line: 524, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !12, file: !3, line: 525, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !12, file: !3, line: 525, baseType: !15, size: 64, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!20 = !{!0}
!21 = !{!"clang version 10.0.0-4ubuntu1 "}
!22 = !{i32 7, !"Dwarf Version", i32 4}
!23 = !{i32 2, !"Debug Info Version", i32 3}
!24 = !{i32 1, !"wchar_size", i32 4}
!25 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 12, type: !26, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DISubroutineType(types: !27)
!27 = !{null}
!28 = !DILocation(line: 12, column: 83, scope: !29)
!29 = distinct !DILexicalBlock(scope: !30, file: !3, line: 12, column: 73)
!30 = distinct !DILexicalBlock(scope: !25, file: !3, line: 12, column: 67)
!31 = !{i1 false}
!32 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 623, type: !33, scopeLine: 624, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!33 = !DISubroutineType(types: !34)
!34 = !{!10}
!35 = !DILocation(line: 625, column: 5, scope: !32)
!36 = !DILocation(line: 626, column: 5, scope: !32)
!37 = !DILocation(line: 627, column: 5, scope: !32)
!38 = !DILocation(line: 628, column: 5, scope: !32)
!39 = distinct !DISubprogram(name: "gl_read", scope: !3, file: !3, line: 573, type: !26, scopeLine: 574, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!40 = !DILocation(line: 575, column: 5, scope: !39)
!41 = !DILocation(line: 576, column: 19, scope: !42)
!42 = distinct !DILexicalBlock(scope: !39, file: !3, line: 575, column: 8)
!43 = !{i1 true}
!44 = !DILocation(line: 576, column: 9, scope: !42)
!45 = !DILocation(line: 577, column: 5, scope: !42)
!46 = !DILocation(line: 578, column: 12, scope: !39)
!47 = distinct !{!47, !40, !48}
!48 = !DILocation(line: 578, column: 35, scope: !39)
!49 = !DILocation(line: 579, column: 1, scope: !39)
!50 = distinct !DISubprogram(name: "gl_sort", scope: !3, file: !3, line: 611, type: !26, scopeLine: 612, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!51 = !DILocation(line: 613, column: 9, scope: !52)
!52 = distinct !DILexicalBlock(scope: !50, file: !3, line: 613, column: 9)
!53 = !DILocation(line: 613, column: 9, scope: !50)
!54 = !DILocation(line: 614, column: 9, scope: !52)
!55 = !DILocalVariable(name: "dst", scope: !50, file: !3, line: 615, type: !12)
!56 = !DILocation(line: 615, column: 22, scope: !50)
!57 = !DILocation(line: 615, column: 28, scope: !50)
!58 = !DILocation(line: 617, column: 23, scope: !50)
!59 = !DILocalVariable(name: "max_pos", scope: !50, file: !3, line: 616, type: !15)
!60 = !DILocation(line: 0, scope: !50)
!61 = !DILocation(line: 617, column: 5, scope: !50)
!62 = !DILocation(line: 618, column: 9, scope: !50)
!63 = distinct !{!63, !61, !64}
!64 = !DILocation(line: 618, column: 32, scope: !50)
!65 = !DILocation(line: 619, column: 9, scope: !50)
!66 = !DILocation(line: 619, column: 15, scope: !50)
!67 = !DILocation(line: 619, column: 20, scope: !50)
!68 = !DILocation(line: 620, column: 9, scope: !50)
!69 = !DILocation(line: 620, column: 15, scope: !50)
!70 = !DILocation(line: 620, column: 20, scope: !50)
!71 = !DILocation(line: 621, column: 15, scope: !50)
!72 = !DILocation(line: 622, column: 1, scope: !50)
!73 = distinct !DISubprogram(name: "gl_destroy", scope: !3, file: !3, line: 580, type: !26, scopeLine: 581, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!74 = !DILocation(line: 583, column: 40, scope: !73)
!75 = !DILocalVariable(name: "next", scope: !73, file: !3, line: 582, type: !15)
!76 = !DILocation(line: 0, scope: !73)
!77 = !DILocation(line: 583, column: 21, scope: !73)
!78 = !DILocation(line: 583, column: 5, scope: !73)
!79 = !DILocation(line: 584, column: 30, scope: !80)
!80 = distinct !DILexicalBlock(scope: !73, file: !3, line: 583, column: 47)
!81 = !DILocation(line: 584, column: 22, scope: !80)
!82 = !DILocation(line: 585, column: 31, scope: !80)
!83 = !DILocation(line: 585, column: 45, scope: !80)
!84 = !DILocation(line: 585, column: 15, scope: !80)
!85 = !DILocation(line: 585, column: 14, scope: !80)
!86 = !DILocation(line: 585, column: 9, scope: !80)
!87 = distinct !{!87, !78, !88}
!88 = !DILocation(line: 586, column: 2, scope: !73)
!89 = !DILocation(line: 587, column: 1, scope: !73)
!90 = distinct !DISubprogram(name: "list_empty", scope: !3, file: !3, line: 527, type: !91, scopeLine: 528, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!91 = !DISubroutineType(types: !92)
!92 = !{!10, !15}
!93 = !DILocalVariable(name: "head", arg: 1, scope: !90, file: !3, line: 527, type: !15)
!94 = !DILocation(line: 0, scope: !90)
!95 = !DILocation(line: 529, column: 15, scope: !90)
!96 = !DILocation(line: 529, column: 20, scope: !90)
!97 = !DILocation(line: 529, column: 2, scope: !90)
!98 = distinct !DISubprogram(name: "gl_seek_max", scope: !3, file: !3, line: 592, type: !99, scopeLine: 593, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!99 = !DISubroutineType(types: !100)
!100 = !{!15}
!101 = !DILocalVariable(name: "max_pos", scope: !98, file: !3, line: 594, type: !15)
!102 = !DILocation(line: 0, scope: !98)
!103 = !DILocation(line: 596, column: 9, scope: !104)
!104 = distinct !DILexicalBlock(scope: !98, file: !3, line: 596, column: 9)
!105 = !DILocation(line: 596, column: 9, scope: !98)
!106 = !DILocation(line: 597, column: 9, scope: !104)
!107 = !DILocation(line: 599, column: 27, scope: !108)
!108 = distinct !DILexicalBlock(scope: !104, file: !3, line: 598, column: 10)
!109 = !DILocation(line: 600, column: 15, scope: !108)
!110 = !DILocalVariable(name: "max", scope: !98, file: !3, line: 595, type: !10)
!111 = !DILocation(line: 602, column: 27, scope: !112)
!112 = distinct !DILexicalBlock(scope: !98, file: !3, line: 602, column: 5)
!113 = !DILocalVariable(name: "pos", scope: !98, file: !3, line: 594, type: !15)
!114 = !DILocation(line: 602, column: 37, scope: !115)
!115 = distinct !DILexicalBlock(scope: !112, file: !3, line: 602, column: 5)
!116 = !DILocation(line: 602, column: 5, scope: !112)
!117 = !DILocation(line: 603, column: 27, scope: !118)
!118 = distinct !DILexicalBlock(scope: !115, file: !3, line: 602, column: 68)
!119 = !DILocalVariable(name: "value", scope: !118, file: !3, line: 603, type: !120)
!120 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!121 = !DILocation(line: 0, scope: !118)
!122 = !DILocation(line: 604, column: 19, scope: !123)
!123 = distinct !DILexicalBlock(scope: !118, file: !3, line: 604, column: 13)
!124 = !DILocation(line: 604, column: 13, scope: !118)
!125 = !DILocation(line: 605, column: 13, scope: !123)
!126 = !DILocation(line: 608, column: 5, scope: !118)
!127 = !DILocation(line: 602, column: 62, scope: !115)
!128 = distinct !{!128, !116, !129}
!129 = !DILocation(line: 608, column: 5, scope: !112)
!130 = !DILocation(line: 599, column: 17, scope: !108)
!131 = !DILocation(line: 609, column: 5, scope: !98)
!132 = !DILocation(line: 610, column: 1, scope: !98)
!133 = distinct !DISubprogram(name: "list_move", scope: !3, file: !3, line: 555, type: !134, scopeLine: 556, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!134 = !DISubroutineType(types: !135)
!135 = !{null, !15, !15}
!136 = !DILocalVariable(name: "list", arg: 1, scope: !133, file: !3, line: 555, type: !15)
!137 = !DILocation(line: 0, scope: !133)
!138 = !DILocalVariable(name: "head", arg: 2, scope: !133, file: !3, line: 555, type: !15)
!139 = !DILocation(line: 557, column: 26, scope: !133)
!140 = !DILocation(line: 557, column: 38, scope: !133)
!141 = !DILocation(line: 557, column: 9, scope: !133)
!142 = !DILocation(line: 558, column: 9, scope: !133)
!143 = !DILocation(line: 559, column: 1, scope: !133)
!144 = distinct !DISubprogram(name: "__list_del", scope: !3, file: !3, line: 540, type: !134, scopeLine: 541, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!145 = !DILocalVariable(name: "prev", arg: 1, scope: !144, file: !3, line: 540, type: !15)
!146 = !DILocation(line: 0, scope: !144)
!147 = !DILocalVariable(name: "next", arg: 2, scope: !144, file: !3, line: 540, type: !15)
!148 = !DILocation(line: 542, column: 8, scope: !144)
!149 = !DILocation(line: 542, column: 13, scope: !144)
!150 = !DILocation(line: 543, column: 8, scope: !144)
!151 = !DILocation(line: 543, column: 13, scope: !144)
!152 = !DILocation(line: 544, column: 1, scope: !144)
!153 = distinct !DISubprogram(name: "list_add", scope: !3, file: !3, line: 545, type: !134, scopeLine: 546, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!154 = !DILocalVariable(name: "new", arg: 1, scope: !153, file: !3, line: 545, type: !15)
!155 = !DILocation(line: 0, scope: !153)
!156 = !DILocalVariable(name: "head", arg: 2, scope: !153, file: !3, line: 545, type: !15)
!157 = !DILocation(line: 547, column: 30, scope: !153)
!158 = !DILocation(line: 547, column: 2, scope: !153)
!159 = !DILocation(line: 548, column: 1, scope: !153)
!160 = distinct !DISubprogram(name: "__list_add", scope: !3, file: !3, line: 531, type: !161, scopeLine: 534, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!161 = !DISubroutineType(types: !162)
!162 = !{null, !15, !15, !15}
!163 = !DILocalVariable(name: "new", arg: 1, scope: !160, file: !3, line: 531, type: !15)
!164 = !DILocation(line: 0, scope: !160)
!165 = !DILocalVariable(name: "prev", arg: 2, scope: !160, file: !3, line: 532, type: !15)
!166 = !DILocalVariable(name: "next", arg: 3, scope: !160, file: !3, line: 533, type: !15)
!167 = !DILocation(line: 535, column: 8, scope: !160)
!168 = !DILocation(line: 535, column: 13, scope: !160)
!169 = !DILocation(line: 536, column: 7, scope: !160)
!170 = !DILocation(line: 536, column: 12, scope: !160)
!171 = !DILocation(line: 537, column: 7, scope: !160)
!172 = !DILocation(line: 537, column: 12, scope: !160)
!173 = !DILocation(line: 538, column: 8, scope: !160)
!174 = !DILocation(line: 538, column: 13, scope: !160)
!175 = !DILocation(line: 539, column: 1, scope: !160)
!176 = distinct !DISubprogram(name: "val_from_node", scope: !3, file: !3, line: 588, type: !91, scopeLine: 588, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!177 = !DILocalVariable(name: "head", arg: 1, scope: !176, file: !3, line: 588, type: !15)
!178 = !DILocation(line: 0, scope: !176)
!179 = !DILocation(line: 589, column: 43, scope: !176)
!180 = !DILocation(line: 589, column: 57, scope: !176)
!181 = !DILocation(line: 589, column: 27, scope: !176)
!182 = !DILocalVariable(name: "entry", scope: !176, file: !3, line: 589, type: !6)
!183 = !DILocation(line: 590, column: 19, scope: !176)
!184 = !DILocation(line: 590, column: 5, scope: !176)
!185 = distinct !DISubprogram(name: "gl_insert", scope: !3, file: !3, line: 565, type: !186, scopeLine: 566, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!186 = !DISubroutineType(types: !187)
!187 = !{null, !10}
!188 = !DILocalVariable(name: "value", arg: 1, scope: !185, file: !3, line: 565, type: !10)
!189 = !DILocation(line: 0, scope: !185)
!190 = !DILocation(line: 567, column: 25, scope: !185)
!191 = !DILocalVariable(name: "node", scope: !185, file: !3, line: 567, type: !6)
!192 = !DILocation(line: 568, column: 10, scope: !193)
!193 = distinct !DILexicalBlock(scope: !185, file: !3, line: 568, column: 9)
!194 = !DILocation(line: 568, column: 9, scope: !185)
!195 = !DILocation(line: 569, column: 9, scope: !193)
!196 = !DILocation(line: 570, column: 11, scope: !185)
!197 = !DILocation(line: 570, column: 17, scope: !185)
!198 = !DILocation(line: 571, column: 21, scope: !185)
!199 = !DILocation(line: 571, column: 5, scope: !185)
!200 = !DILocation(line: 572, column: 1, scope: !185)
