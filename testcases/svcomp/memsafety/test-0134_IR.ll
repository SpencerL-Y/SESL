; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-rom40rcd.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.node = type { i32, %struct.list_head }

@gl_list = internal global %struct.list_head { %struct.list_head* @gl_list, %struct.list_head* @gl_list }, align 8, !dbg !0
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [42 x i8] c"../testcases/svcomp/memsafety/test-0134.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !25 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !28, !verifier.code !31
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
  br label %15, !dbg !54, !verifier.code !31

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
  call void @list_add(%struct.list_head* @gl_list, %struct.list_head* %1), !dbg !64, !verifier.code !31
  call void @list_del(%struct.list_head* %1), !dbg !65, !verifier.code !31
  br label %15, !dbg !66, !verifier.code !31

15:                                               ; preds = %14, %4
  ret void, !dbg !66, !verifier.code !31

forwarder:                                        ; preds = %10
  br label %10, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_destroy() #0 !dbg !67 {
  %1 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !68, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !69, metadata !DIExpression()), !dbg !70, !verifier.code !31
  %2 = icmp ne %struct.list_head* @gl_list, %1, !dbg !71, !verifier.code !31
  br i1 %2, label %.lr.ph, label %13, !dbg !72, !verifier.code !31

.lr.ph:                                           ; preds = %0
  br label %3, !dbg !72, !verifier.code !31

3:                                                ; preds = %forwarder, %.lr.ph
  %4 = phi %struct.list_head* [ %1, %.lr.ph ], [ %11, %forwarder ], !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %4, i32 0, i32 0, !dbg !73, !verifier.code !31
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !73, !verifier.code !31
  store %struct.list_head* %6, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !75, !verifier.code !31
  %7 = bitcast %struct.list_head* %4 to i8*, !dbg !76, !verifier.code !31
  %8 = getelementptr inbounds i8, i8* %7, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !76, !verifier.code !31
  %9 = bitcast i8* %8 to %struct.node*, !dbg !76, !verifier.code !31
  %10 = bitcast %struct.node* %9 to i8*, !dbg !76, !verifier.code !31
  call void @free(i8* %10) #6, !dbg !77, !verifier.code !31
  %11 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !68, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %11, metadata !69, metadata !DIExpression()), !dbg !70, !verifier.code !31
  %12 = icmp ne %struct.list_head* @gl_list, %11, !dbg !71, !verifier.code !31
  br i1 %12, label %forwarder, label %._crit_edge, !dbg !72, !llvm.loop !78, !verifier.code !31

._crit_edge:                                      ; preds = %3
  br label %13, !dbg !72, !verifier.code !31

13:                                               ; preds = %._crit_edge, %0
  ret void, !dbg !80, !verifier.code !31

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !31
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @list_empty(%struct.list_head* %0) #0 !dbg !81 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !84, metadata !DIExpression()), !dbg !85, !verifier.code !31
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !86, !verifier.code !31
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !86, !verifier.code !31
  %4 = icmp eq %struct.list_head* %3, %0, !dbg !87, !verifier.code !31
  %5 = zext i1 %4 to i32, !dbg !87, !verifier.code !31
  ret i32 %5, !dbg !88, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.list_head* @gl_seek_max() #0 !dbg !89 {
  %1 = call i32 @list_empty(%struct.list_head* @gl_list), !dbg !92, !verifier.code !31
  %2 = icmp ne i32 %1, 0, !dbg !92, !verifier.code !31
  br i1 %2, label %3, label %4, !dbg !94, !verifier.code !31

3:                                                ; preds = %0
  br label %20, !dbg !95, !verifier.code !31

4:                                                ; preds = %0
  %5 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !96, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %5, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %6 = call i32 @val_from_node(%struct.list_head* %5), !dbg !99, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %6, metadata !100, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %5, i32 0, i32 0, !dbg !101, !verifier.code !31
  %8 = load %struct.list_head*, %struct.list_head** %7, align 8, !dbg !101, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %8, metadata !103, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %5, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %6, metadata !100, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %9 = icmp ne %struct.list_head* @gl_list, %8, !dbg !104, !verifier.code !31
  br i1 %9, label %.lr.ph, label %19, !dbg !106, !verifier.code !31

.lr.ph:                                           ; preds = %4
  br label %10, !dbg !106, !verifier.code !31

10:                                               ; preds = %forwarder, %.lr.ph
  %.017 = phi %struct.list_head* [ %8, %.lr.ph ], [ %17, %forwarder ], !verifier.code !31
  %.026 = phi %struct.list_head* [ %5, %.lr.ph ], [ %.1, %forwarder ], !verifier.code !31
  %.035 = phi i32 [ %6, %.lr.ph ], [ %.14, %forwarder ], !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.017, metadata !103, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.026, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %.035, metadata !100, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %11 = call i32 @val_from_node(%struct.list_head* %.017), !dbg !107, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %11, metadata !109, metadata !DIExpression()), !dbg !111, !verifier.code !31
  %12 = icmp slt i32 %11, %.035, !dbg !112, !verifier.code !31
  br i1 %12, label %13, label %14, !dbg !114, !verifier.code !31

13:                                               ; preds = %10
  br label %15, !dbg !115, !verifier.code !31

14:                                               ; preds = %10
  call void @llvm.dbg.value(metadata %struct.list_head* %.017, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %11, metadata !100, metadata !DIExpression()), !dbg !98, !verifier.code !31
  br label %15, !dbg !116, !verifier.code !31

15:                                               ; preds = %14, %13
  %.018 = phi %struct.list_head* [ %.017, %13 ], [ %.017, %14 ], !verifier.code !31
  %.14 = phi i32 [ %.035, %13 ], [ %11, %14 ], !dbg !98, !verifier.code !31
  %.1 = phi %struct.list_head* [ %.026, %13 ], [ %.017, %14 ], !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.1, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  call void @llvm.dbg.value(metadata i32 %.14, metadata !100, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %16 = getelementptr inbounds %struct.list_head, %struct.list_head* %.018, i32 0, i32 0, !dbg !117, !verifier.code !31
  %17 = load %struct.list_head*, %struct.list_head** %16, align 8, !dbg !117, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %17, metadata !103, metadata !DIExpression()), !dbg !98, !verifier.code !31
  %18 = icmp ne %struct.list_head* @gl_list, %17, !dbg !104, !verifier.code !31
  br i1 %18, label %forwarder, label %._crit_edge, !dbg !106, !llvm.loop !118, !verifier.code !31

._crit_edge:                                      ; preds = %15
  %split = phi %struct.list_head* [ %.1, %15 ], !verifier.code !31
  br label %19, !dbg !106, !verifier.code !31

19:                                               ; preds = %._crit_edge, %4
  %.02.lcssa = phi %struct.list_head* [ %split, %._crit_edge ], [ %5, %4 ], !dbg !120, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %.02.lcssa, metadata !97, metadata !DIExpression()), !dbg !98, !verifier.code !31
  br label %20, !dbg !121, !verifier.code !31

20:                                               ; preds = %19, %3
  %.0 = phi %struct.list_head* [ null, %3 ], [ %.02.lcssa, %19 ], !dbg !98, !verifier.code !31
  ret %struct.list_head* %.0, !dbg !122, !verifier.code !31

forwarder:                                        ; preds = %15
  br label %10, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_move(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !123 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !126, metadata !DIExpression()), !dbg !127, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !128, metadata !DIExpression()), !dbg !127, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !129, !verifier.code !31
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !129, !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !130, !verifier.code !31
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !130, !verifier.code !31
  call void @__list_del(%struct.list_head* %4, %struct.list_head* %6), !dbg !131, !verifier.code !31
  call void @list_add(%struct.list_head* %0, %struct.list_head* %1), !dbg !132, !verifier.code !31
  ret void, !dbg !133, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_add(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !134 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !135, metadata !DIExpression()), !dbg !136, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !137, metadata !DIExpression()), !dbg !136, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !138, !verifier.code !31
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !138, !verifier.code !31
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %4), !dbg !139, !verifier.code !31
  ret void, !dbg !140, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_del(%struct.list_head* %0) #0 !dbg !141 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !31
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !146, !verifier.code !31
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !146, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !147, !verifier.code !31
  %5 = load %struct.list_head*, %struct.list_head** %4, align 8, !dbg !147, !verifier.code !31
  call void @__list_del(%struct.list_head* %3, %struct.list_head* %5), !dbg !148, !verifier.code !31
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !149, !verifier.code !31
  store %struct.list_head* null, %struct.list_head** %6, align 8, !dbg !150, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !151, !verifier.code !31
  store %struct.list_head* null, %struct.list_head** %7, align 8, !dbg !152, !verifier.code !31
  ret void, !dbg !153, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_del(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !154 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !155, metadata !DIExpression()), !dbg !156, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !157, metadata !DIExpression()), !dbg !156, !verifier.code !31
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !158, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !159, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !160, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %4, align 8, !dbg !161, !verifier.code !31
  ret void, !dbg !162, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !163 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !166, metadata !DIExpression()), !dbg !167, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !168, metadata !DIExpression()), !dbg !167, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !169, metadata !DIExpression()), !dbg !167, !verifier.code !31
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !170, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !171, !verifier.code !31
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !172, !verifier.code !31
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !173, !verifier.code !31
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !174, !verifier.code !31
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !175, !verifier.code !31
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !176, !verifier.code !31
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !177, !verifier.code !31
  ret void, !dbg !178, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @val_from_node(%struct.list_head* %0) #0 !dbg !179 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !180, metadata !DIExpression()), !dbg !181, !verifier.code !31
  %2 = bitcast %struct.list_head* %0 to i8*, !dbg !182, !verifier.code !31
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !182, !verifier.code !31
  %4 = bitcast i8* %3 to %struct.node*, !dbg !182, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !183, metadata !DIExpression()), !dbg !181, !verifier.code !31
  %5 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 0, !dbg !184, !verifier.code !31
  %6 = load i32, i32* %5, align 8, !dbg !184, !verifier.code !31
  ret i32 %6, !dbg !185, !verifier.code !31
}

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @gl_insert(i32 %0) #0 !dbg !186 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !189, metadata !DIExpression()), !dbg !190, !verifier.code !31
  %2 = call noalias i8* @malloc(i64 24) #6, !dbg !191, !verifier.code !31
  %3 = bitcast i8* %2 to %struct.node*, !dbg !191, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !192, metadata !DIExpression()), !dbg !190, !verifier.code !31
  %4 = icmp ne %struct.node* %3, null, !dbg !193, !verifier.code !31
  br i1 %4, label %6, label %5, !dbg !195, !verifier.code !31

5:                                                ; preds = %1
  call void @abort() #5, !dbg !196, !verifier.code !31
  unreachable, !dbg !196, !verifier.code !31

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !197, !verifier.code !31
  store i32 %0, i32* %7, align 8, !dbg !198, !verifier.code !31
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !199, !verifier.code !31
  call void @list_add(%struct.list_head* %8, %struct.list_head* @gl_list), !dbg !200, !verifier.code !31
  ret void, !dbg !201, !verifier.code !31
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
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!21}
!llvm.module.flags = !{!22, !23, !24}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "gl_list", scope: !2, file: !3, line: 74, type: !12, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !20, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0134.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !17, !19}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !3, line: 69, size: 192, elements: !8)
!8 = !{!9, !11}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !7, file: !3, line: 70, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "linkage", scope: !7, file: !3, line: 71, baseType: !12, size: 128, offset: 64)
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
!32 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 144, type: !33, scopeLine: 145, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!33 = !DISubroutineType(types: !34)
!34 = !{!10}
!35 = !DILocation(line: 146, column: 5, scope: !32)
!36 = !DILocation(line: 147, column: 5, scope: !32)
!37 = !DILocation(line: 148, column: 5, scope: !32)
!38 = !DILocation(line: 150, column: 5, scope: !32)
!39 = distinct !DISubprogram(name: "gl_read", scope: !3, file: !3, line: 86, type: !26, scopeLine: 87, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!40 = !DILocation(line: 88, column: 5, scope: !39)
!41 = !DILocation(line: 89, column: 19, scope: !42)
!42 = distinct !DILexicalBlock(scope: !39, file: !3, line: 88, column: 8)
!43 = !{i1 true}
!44 = !DILocation(line: 89, column: 9, scope: !42)
!45 = !DILocation(line: 90, column: 5, scope: !42)
!46 = !DILocation(line: 91, column: 12, scope: !39)
!47 = distinct !{!47, !40, !48}
!48 = !DILocation(line: 91, column: 35, scope: !39)
!49 = !DILocation(line: 92, column: 1, scope: !39)
!50 = distinct !DISubprogram(name: "gl_sort", scope: !3, file: !3, line: 128, type: !26, scopeLine: 129, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!51 = !DILocation(line: 130, column: 9, scope: !52)
!52 = distinct !DILexicalBlock(scope: !50, file: !3, line: 130, column: 9)
!53 = !DILocation(line: 130, column: 9, scope: !50)
!54 = !DILocation(line: 131, column: 9, scope: !52)
!55 = !DILocalVariable(name: "dst", scope: !50, file: !3, line: 133, type: !12)
!56 = !DILocation(line: 133, column: 5, scope: !50)
!57 = !DILocation(line: 136, column: 23, scope: !50)
!58 = !DILocalVariable(name: "max_pos", scope: !50, file: !3, line: 135, type: !15)
!59 = !DILocation(line: 0, scope: !50)
!60 = !DILocation(line: 136, column: 5, scope: !50)
!61 = !DILocation(line: 137, column: 9, scope: !50)
!62 = distinct !{!62, !60, !63}
!63 = !DILocation(line: 137, column: 32, scope: !50)
!64 = !DILocation(line: 140, column: 5, scope: !50)
!65 = !DILocation(line: 141, column: 5, scope: !50)
!66 = !DILocation(line: 142, column: 1, scope: !50)
!67 = distinct !DISubprogram(name: "gl_destroy", scope: !3, file: !3, line: 94, type: !26, scopeLine: 95, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!68 = !DILocation(line: 97, column: 40, scope: !67)
!69 = !DILocalVariable(name: "next", scope: !67, file: !3, line: 96, type: !15)
!70 = !DILocation(line: 0, scope: !67)
!71 = !DILocation(line: 97, column: 21, scope: !67)
!72 = !DILocation(line: 97, column: 5, scope: !67)
!73 = !DILocation(line: 98, column: 30, scope: !74)
!74 = distinct !DILexicalBlock(scope: !67, file: !3, line: 97, column: 47)
!75 = !DILocation(line: 98, column: 22, scope: !74)
!76 = !DILocation(line: 99, column: 14, scope: !74)
!77 = !DILocation(line: 99, column: 9, scope: !74)
!78 = distinct !{!78, !72, !79}
!79 = !DILocation(line: 100, column: 2, scope: !67)
!80 = !DILocation(line: 101, column: 1, scope: !67)
!81 = distinct !DISubprogram(name: "list_empty", scope: !3, file: !3, line: 30, type: !82, scopeLine: 31, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!82 = !DISubroutineType(types: !83)
!83 = !{!10, !15}
!84 = !DILocalVariable(name: "head", arg: 1, scope: !81, file: !3, line: 30, type: !15)
!85 = !DILocation(line: 0, scope: !81)
!86 = !DILocation(line: 32, column: 15, scope: !81)
!87 = !DILocation(line: 32, column: 20, scope: !81)
!88 = !DILocation(line: 32, column: 2, scope: !81)
!89 = distinct !DISubprogram(name: "gl_seek_max", scope: !3, file: !3, line: 108, type: !90, scopeLine: 109, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!90 = !DISubroutineType(types: !91)
!91 = !{!15}
!92 = !DILocation(line: 110, column: 9, scope: !93)
!93 = distinct !DILexicalBlock(scope: !89, file: !3, line: 110, column: 9)
!94 = !DILocation(line: 110, column: 9, scope: !89)
!95 = !DILocation(line: 111, column: 9, scope: !93)
!96 = !DILocation(line: 113, column: 47, scope: !89)
!97 = !DILocalVariable(name: "max_pos", scope: !89, file: !3, line: 113, type: !15)
!98 = !DILocation(line: 0, scope: !89)
!99 = !DILocation(line: 114, column: 15, scope: !89)
!100 = !DILocalVariable(name: "max", scope: !89, file: !3, line: 114, type: !10)
!101 = !DILocation(line: 116, column: 25, scope: !102)
!102 = distinct !DILexicalBlock(scope: !89, file: !3, line: 116, column: 5)
!103 = !DILocalVariable(name: "pos", scope: !89, file: !3, line: 113, type: !15)
!104 = !DILocation(line: 116, column: 40, scope: !105)
!105 = distinct !DILexicalBlock(scope: !102, file: !3, line: 116, column: 5)
!106 = !DILocation(line: 116, column: 5, scope: !102)
!107 = !DILocation(line: 117, column: 27, scope: !108)
!108 = distinct !DILexicalBlock(scope: !105, file: !3, line: 116, column: 65)
!109 = !DILocalVariable(name: "value", scope: !108, file: !3, line: 117, type: !110)
!110 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !10)
!111 = !DILocation(line: 0, scope: !108)
!112 = !DILocation(line: 118, column: 19, scope: !113)
!113 = distinct !DILexicalBlock(scope: !108, file: !3, line: 118, column: 13)
!114 = !DILocation(line: 118, column: 13, scope: !108)
!115 = !DILocation(line: 119, column: 13, scope: !113)
!116 = !DILocation(line: 123, column: 5, scope: !108)
!117 = !DILocation(line: 116, column: 59, scope: !105)
!118 = distinct !{!118, !106, !119}
!119 = !DILocation(line: 123, column: 5, scope: !102)
!120 = !DILocation(line: 113, column: 29, scope: !89)
!121 = !DILocation(line: 125, column: 5, scope: !89)
!122 = !DILocation(line: 126, column: 1, scope: !89)
!123 = distinct !DISubprogram(name: "list_move", scope: !3, file: !3, line: 63, type: !124, scopeLine: 64, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!124 = !DISubroutineType(types: !125)
!125 = !{null, !15, !15}
!126 = !DILocalVariable(name: "list", arg: 1, scope: !123, file: !3, line: 63, type: !15)
!127 = !DILocation(line: 0, scope: !123)
!128 = !DILocalVariable(name: "head", arg: 2, scope: !123, file: !3, line: 63, type: !15)
!129 = !DILocation(line: 65, column: 26, scope: !123)
!130 = !DILocation(line: 65, column: 38, scope: !123)
!131 = !DILocation(line: 65, column: 9, scope: !123)
!132 = !DILocation(line: 66, column: 9, scope: !123)
!133 = !DILocation(line: 67, column: 1, scope: !123)
!134 = distinct !DISubprogram(name: "list_add", scope: !3, file: !3, line: 51, type: !124, scopeLine: 52, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!135 = !DILocalVariable(name: "new", arg: 1, scope: !134, file: !3, line: 51, type: !15)
!136 = !DILocation(line: 0, scope: !134)
!137 = !DILocalVariable(name: "head", arg: 2, scope: !134, file: !3, line: 51, type: !15)
!138 = !DILocation(line: 53, column: 30, scope: !134)
!139 = !DILocation(line: 53, column: 2, scope: !134)
!140 = !DILocation(line: 54, column: 1, scope: !134)
!141 = distinct !DISubprogram(name: "list_del", scope: !3, file: !3, line: 56, type: !142, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!142 = !DISubroutineType(types: !143)
!143 = !{null, !15}
!144 = !DILocalVariable(name: "entry", arg: 1, scope: !141, file: !3, line: 56, type: !15)
!145 = !DILocation(line: 0, scope: !141)
!146 = !DILocation(line: 58, column: 20, scope: !141)
!147 = !DILocation(line: 58, column: 33, scope: !141)
!148 = !DILocation(line: 58, column: 2, scope: !141)
!149 = !DILocation(line: 59, column: 9, scope: !141)
!150 = !DILocation(line: 59, column: 14, scope: !141)
!151 = !DILocation(line: 60, column: 9, scope: !141)
!152 = !DILocation(line: 60, column: 14, scope: !141)
!153 = !DILocation(line: 61, column: 1, scope: !141)
!154 = distinct !DISubprogram(name: "__list_del", scope: !3, file: !3, line: 45, type: !124, scopeLine: 46, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!155 = !DILocalVariable(name: "prev", arg: 1, scope: !154, file: !3, line: 45, type: !15)
!156 = !DILocation(line: 0, scope: !154)
!157 = !DILocalVariable(name: "next", arg: 2, scope: !154, file: !3, line: 45, type: !15)
!158 = !DILocation(line: 47, column: 8, scope: !154)
!159 = !DILocation(line: 47, column: 13, scope: !154)
!160 = !DILocation(line: 48, column: 8, scope: !154)
!161 = !DILocation(line: 48, column: 13, scope: !154)
!162 = !DILocation(line: 49, column: 1, scope: !154)
!163 = distinct !DISubprogram(name: "__list_add", scope: !3, file: !3, line: 35, type: !164, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!164 = !DISubroutineType(types: !165)
!165 = !{null, !15, !15, !15}
!166 = !DILocalVariable(name: "new", arg: 1, scope: !163, file: !3, line: 35, type: !15)
!167 = !DILocation(line: 0, scope: !163)
!168 = !DILocalVariable(name: "prev", arg: 2, scope: !163, file: !3, line: 36, type: !15)
!169 = !DILocalVariable(name: "next", arg: 3, scope: !163, file: !3, line: 37, type: !15)
!170 = !DILocation(line: 39, column: 8, scope: !163)
!171 = !DILocation(line: 39, column: 13, scope: !163)
!172 = !DILocation(line: 40, column: 7, scope: !163)
!173 = !DILocation(line: 40, column: 12, scope: !163)
!174 = !DILocation(line: 41, column: 7, scope: !163)
!175 = !DILocation(line: 41, column: 12, scope: !163)
!176 = !DILocation(line: 42, column: 8, scope: !163)
!177 = !DILocation(line: 42, column: 13, scope: !163)
!178 = !DILocation(line: 43, column: 1, scope: !163)
!179 = distinct !DISubprogram(name: "val_from_node", scope: !3, file: !3, line: 103, type: !82, scopeLine: 103, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!180 = !DILocalVariable(name: "head", arg: 1, scope: !179, file: !3, line: 103, type: !15)
!181 = !DILocation(line: 0, scope: !179)
!182 = !DILocation(line: 104, column: 26, scope: !179)
!183 = !DILocalVariable(name: "entry", scope: !179, file: !3, line: 104, type: !6)
!184 = !DILocation(line: 105, column: 19, scope: !179)
!185 = !DILocation(line: 105, column: 5, scope: !179)
!186 = distinct !DISubprogram(name: "gl_insert", scope: !3, file: !3, line: 76, type: !187, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!187 = !DISubroutineType(types: !188)
!188 = !{null, !10}
!189 = !DILocalVariable(name: "value", arg: 1, scope: !186, file: !3, line: 76, type: !10)
!190 = !DILocation(line: 0, scope: !186)
!191 = !DILocation(line: 78, column: 25, scope: !186)
!192 = !DILocalVariable(name: "node", scope: !186, file: !3, line: 78, type: !6)
!193 = !DILocation(line: 79, column: 10, scope: !194)
!194 = distinct !DILexicalBlock(scope: !186, file: !3, line: 79, column: 9)
!195 = !DILocation(line: 79, column: 9, scope: !186)
!196 = !DILocation(line: 80, column: 9, scope: !194)
!197 = !DILocation(line: 82, column: 11, scope: !186)
!198 = !DILocation(line: 82, column: 17, scope: !186)
!199 = !DILocation(line: 83, column: 21, scope: !186)
!200 = !DILocation(line: 83, column: 5, scope: !186)
!201 = !DILocation(line: 84, column: 1, scope: !186)
