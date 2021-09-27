; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-6rkfzexu.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list = type { %struct.node*, %struct.list* }
%struct.node = type { %struct.node*, i32 }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  ret void, !dbg !13, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !15 {
  call void @llvm.dbg.value(metadata %struct.list* null, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !31, !verifier.code !32
  %2 = icmp ne i32 %1, 0, !dbg !33, !verifier.code !14
  br i1 %2, label %.lr.ph12, label %21, !dbg !33, !verifier.code !14

.lr.ph12:                                         ; preds = %0
  br label %3, !dbg !33, !verifier.code !14

3:                                                ; preds = %forwarder16, %.lr.ph12
  %.0110 = phi %struct.list* [ null, %.lr.ph12 ], [ %13, %forwarder16 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.0110, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %4 = call noalias i8* @malloc(i64 16) #5, !dbg !34, !verifier.code !14
  %5 = bitcast i8* %4 to %struct.node*, !dbg !34, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %5, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !14
  %6 = icmp ne %struct.node* %5, null, !dbg !38, !verifier.code !14
  br i1 %6, label %8, label %7, !dbg !40, !verifier.code !14

7:                                                ; preds = %3
  call void @abort() #6, !dbg !41, !verifier.code !14
  unreachable, !dbg !41, !verifier.code !14

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 0, !dbg !42, !verifier.code !14
  store %struct.node* %5, %struct.node** %9, align 8, !dbg !43, !verifier.code !14
  %10 = call i32 @__VERIFIER_nondet_int(), !dbg !44, !verifier.code !32
  %11 = getelementptr inbounds %struct.node, %struct.node* %5, i32 0, i32 1, !dbg !45, !verifier.code !14
  store i32 %10, i32* %11, align 8, !dbg !46, !verifier.code !14
  %12 = call noalias i8* @malloc(i64 16) #5, !dbg !47, !verifier.code !14
  %13 = bitcast i8* %12 to %struct.list*, !dbg !47, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %13, metadata !48, metadata !DIExpression()), !dbg !37, !verifier.code !14
  %14 = icmp ne %struct.list* %13, null, !dbg !49, !verifier.code !14
  br i1 %14, label %16, label %15, !dbg !51, !verifier.code !14

15:                                               ; preds = %8
  call void @abort() #6, !dbg !52, !verifier.code !14
  unreachable, !dbg !52, !verifier.code !14

16:                                               ; preds = %8
  %17 = getelementptr inbounds %struct.list, %struct.list* %13, i32 0, i32 0, !dbg !53, !verifier.code !14
  store %struct.node* %5, %struct.node** %17, align 8, !dbg !54, !verifier.code !14
  %18 = getelementptr inbounds %struct.list, %struct.list* %13, i32 0, i32 1, !dbg !55, !verifier.code !14
  store %struct.list* %.0110, %struct.list** %18, align 8, !dbg !56, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %13, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %19 = call i32 @__VERIFIER_nondet_int(), !dbg !31, !verifier.code !32
  %20 = icmp ne i32 %19, 0, !dbg !33, !verifier.code !14
  br i1 %20, label %forwarder16, label %._crit_edge13, !dbg !33, !llvm.loop !57, !verifier.code !14

._crit_edge13:                                    ; preds = %16
  %split14 = phi %struct.list* [ %13, %16 ], !verifier.code !14
  br label %21, !dbg !33, !verifier.code !14

21:                                               ; preds = %._crit_edge13, %0
  %.01.lcssa = phi %struct.list* [ %split14, %._crit_edge13 ], [ null, %0 ], !dbg !30, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.01.lcssa, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %22 = icmp ne %struct.list* %.01.lcssa, null, !dbg !59, !verifier.code !14
  br i1 %22, label %24, label %23, !dbg !61, !verifier.code !14

23:                                               ; preds = %21
  br label %44, !dbg !62, !verifier.code !14

24:                                               ; preds = %21
  call void @inspect_before(%struct.list* %.01.lcssa), !dbg !63, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.01.lcssa, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %25 = getelementptr inbounds %struct.list, %struct.list* %.01.lcssa, i32 0, i32 1, !dbg !64, !verifier.code !14
  %26 = load %struct.list*, %struct.list** %25, align 8, !dbg !64, !verifier.code !14
  %27 = icmp ne %struct.list* %26, null, !dbg !65, !verifier.code !14
  br i1 %27, label %.lr.ph8, label %33, !dbg !65, !verifier.code !14

.lr.ph8:                                          ; preds = %24
  br label %28, !dbg !65, !verifier.code !14

28:                                               ; preds = %forwarder15, %.lr.ph8
  %.16 = phi %struct.list* [ %.01.lcssa, %.lr.ph8 ], [ %29, %forwarder15 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.16, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %29 = call %struct.list* @seq_sort_core(%struct.list* %.16), !dbg !66, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %29, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %30 = getelementptr inbounds %struct.list, %struct.list* %29, i32 0, i32 1, !dbg !64, !verifier.code !14
  %31 = load %struct.list*, %struct.list** %30, align 8, !dbg !64, !verifier.code !14
  %32 = icmp ne %struct.list* %31, null, !dbg !65, !verifier.code !14
  br i1 %32, label %forwarder15, label %._crit_edge9, !dbg !65, !llvm.loop !67, !verifier.code !14

._crit_edge9:                                     ; preds = %28
  %split = phi %struct.list* [ %29, %28 ], !verifier.code !14
  br label %33, !dbg !65, !verifier.code !14

33:                                               ; preds = %._crit_edge9, %24
  %.1.lcssa = phi %struct.list* [ %split, %._crit_edge9 ], [ %.01.lcssa, %24 ], !dbg !30, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.1.lcssa, metadata !19, metadata !DIExpression()), !dbg !30, !verifier.code !14
  call void @inspect_after(%struct.list* %.1.lcssa), !dbg !69, !verifier.code !14
  %34 = getelementptr inbounds %struct.list, %struct.list* %.1.lcssa, i32 0, i32 0, !dbg !70, !verifier.code !14
  %35 = load %struct.node*, %struct.node** %34, align 8, !dbg !70, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %35, metadata !71, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %36 = bitcast %struct.list* %.1.lcssa to i8*, !dbg !72, !verifier.code !14
  call void @free(i8* %36) #5, !dbg !73, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %35, metadata !71, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %37 = icmp ne %struct.node* %35, null, !dbg !74, !verifier.code !14
  br i1 %37, label %.lr.ph, label %43, !dbg !74, !verifier.code !14

.lr.ph:                                           ; preds = %33
  br label %38, !dbg !74, !verifier.code !14

38:                                               ; preds = %forwarder, %.lr.ph
  %.025 = phi %struct.node* [ %35, %.lr.ph ], [ %40, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.025, metadata !71, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %39 = getelementptr inbounds %struct.node, %struct.node* %.025, i32 0, i32 0, !dbg !75, !verifier.code !14
  %40 = load %struct.node*, %struct.node** %39, align 8, !dbg !75, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %40, metadata !77, metadata !DIExpression()), !dbg !78, !verifier.code !14
  %41 = bitcast %struct.node* %.025 to i8*, !dbg !79, !verifier.code !14
  call void @free(i8* %41) #5, !dbg !80, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %40, metadata !71, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %42 = icmp ne %struct.node* %40, null, !dbg !74, !verifier.code !14
  br i1 %42, label %forwarder, label %._crit_edge, !dbg !74, !llvm.loop !81, !verifier.code !14

._crit_edge:                                      ; preds = %38
  br label %43, !dbg !74, !verifier.code !14

43:                                               ; preds = %._crit_edge, %33
  br label %44, !dbg !83, !verifier.code !14

44:                                               ; preds = %43, %23
  ret i32 0, !dbg !84, !verifier.code !14

forwarder:                                        ; preds = %38
  br label %38, !verifier.code !14

forwarder15:                                      ; preds = %28
  br label %28, !verifier.code !14

forwarder16:                                      ; preds = %16
  br label %3, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #4

; Function Attrs: noinline nounwind uwtable
define internal void @inspect_before(%struct.list* %0) #0 !dbg !85 {
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !14
  br label %2, !dbg !90, !verifier.code !14

2:                                                ; preds = %1
  %3 = icmp ne %struct.list* %0, null, !dbg !91, !verifier.code !14
  br i1 %3, label %5, label %4, !dbg !94, !verifier.code !14

4:                                                ; preds = %2
  call void @fail(), !dbg !91, !verifier.code !14
  br label %5, !dbg !91, !verifier.code !14

5:                                                ; preds = %4, %2
  br label %6, !dbg !94, !verifier.code !14

6:                                                ; preds = %5
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !14
  %7 = getelementptr inbounds %struct.list, %struct.list* %0, i32 0, i32 1, !dbg !95, !verifier.code !14
  %8 = load %struct.list*, %struct.list** %7, align 8, !dbg !95, !verifier.code !14
  %9 = icmp ne %struct.list* %8, null, !dbg !98, !verifier.code !14
  br i1 %9, label %.lr.ph, label %45, !dbg !98, !verifier.code !14

.lr.ph:                                           ; preds = %6
  br label %10, !dbg !98, !verifier.code !14

10:                                               ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.list* [ %0, %.lr.ph ], [ %41, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.01, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !14
  br label %11, !dbg !99, !verifier.code !14

11:                                               ; preds = %10
  %12 = icmp ne %struct.list* %.01, null, !dbg !101, !verifier.code !14
  br i1 %12, label %14, label %13, !dbg !104, !verifier.code !14

13:                                               ; preds = %11
  call void @fail(), !dbg !101, !verifier.code !14
  br label %14, !dbg !101, !verifier.code !14

14:                                               ; preds = %13, %11
  br label %15, !dbg !104, !verifier.code !14

15:                                               ; preds = %14
  br label %16, !dbg !105, !verifier.code !14

16:                                               ; preds = %15
  %17 = getelementptr inbounds %struct.list, %struct.list* %.01, i32 0, i32 1, !dbg !106, !verifier.code !14
  %18 = load %struct.list*, %struct.list** %17, align 8, !dbg !106, !verifier.code !14
  %19 = icmp ne %struct.list* %18, null, !dbg !106, !verifier.code !14
  br i1 %19, label %21, label %20, !dbg !109, !verifier.code !14

20:                                               ; preds = %16
  call void @fail(), !dbg !106, !verifier.code !14
  br label %21, !dbg !106, !verifier.code !14

21:                                               ; preds = %20, %16
  br label %22, !dbg !109, !verifier.code !14

22:                                               ; preds = %21
  br label %23, !dbg !110, !verifier.code !14

23:                                               ; preds = %22
  %24 = getelementptr inbounds %struct.list, %struct.list* %.01, i32 0, i32 0, !dbg !111, !verifier.code !14
  %25 = load %struct.node*, %struct.node** %24, align 8, !dbg !111, !verifier.code !14
  %26 = icmp ne %struct.node* %25, null, !dbg !111, !verifier.code !14
  br i1 %26, label %28, label %27, !dbg !114, !verifier.code !14

27:                                               ; preds = %23
  call void @fail(), !dbg !111, !verifier.code !14
  br label %28, !dbg !111, !verifier.code !14

28:                                               ; preds = %27, %23
  br label %29, !dbg !114, !verifier.code !14

29:                                               ; preds = %28
  br label %30, !dbg !115, !verifier.code !14

30:                                               ; preds = %29
  %31 = getelementptr inbounds %struct.list, %struct.list* %.01, i32 0, i32 0, !dbg !116, !verifier.code !14
  %32 = load %struct.node*, %struct.node** %31, align 8, !dbg !116, !verifier.code !14
  %33 = getelementptr inbounds %struct.node, %struct.node* %32, i32 0, i32 0, !dbg !116, !verifier.code !14
  %34 = load %struct.node*, %struct.node** %33, align 8, !dbg !116, !verifier.code !14
  %35 = icmp eq %struct.node* %34, null, !dbg !116, !verifier.code !14
  br i1 %35, label %37, label %36, !dbg !119, !verifier.code !14

36:                                               ; preds = %30
  call void @fail(), !dbg !116, !verifier.code !14
  br label %37, !dbg !116, !verifier.code !14

37:                                               ; preds = %36, %30
  br label %38, !dbg !119, !verifier.code !14

38:                                               ; preds = %37
  br label %39, !dbg !120, !verifier.code !14

39:                                               ; preds = %38
  %40 = getelementptr inbounds %struct.list, %struct.list* %.01, i32 0, i32 1, !dbg !121, !verifier.code !14
  %41 = load %struct.list*, %struct.list** %40, align 8, !dbg !121, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %41, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !14
  %42 = getelementptr inbounds %struct.list, %struct.list* %41, i32 0, i32 1, !dbg !95, !verifier.code !14
  %43 = load %struct.list*, %struct.list** %42, align 8, !dbg !95, !verifier.code !14
  %44 = icmp ne %struct.list* %43, null, !dbg !98, !verifier.code !14
  br i1 %44, label %forwarder, label %._crit_edge, !dbg !98, !llvm.loop !122, !verifier.code !14

._crit_edge:                                      ; preds = %39
  %split = phi %struct.list* [ %41, %39 ], !verifier.code !14
  br label %45, !dbg !98, !verifier.code !14

45:                                               ; preds = %._crit_edge, %6
  %.0.lcssa = phi %struct.list* [ %split, %._crit_edge ], [ %0, %6 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.0.lcssa, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !14
  br label %46, !dbg !124, !verifier.code !14

46:                                               ; preds = %45
  %47 = icmp ne %struct.list* %.0.lcssa, null, !dbg !125, !verifier.code !14
  br i1 %47, label %49, label %48, !dbg !128, !verifier.code !14

48:                                               ; preds = %46
  call void @fail(), !dbg !125, !verifier.code !14
  br label %49, !dbg !125, !verifier.code !14

49:                                               ; preds = %48, %46
  br label %50, !dbg !128, !verifier.code !14

50:                                               ; preds = %49
  br label %51, !dbg !129, !verifier.code !14

51:                                               ; preds = %50
  %52 = getelementptr inbounds %struct.list, %struct.list* %.0.lcssa, i32 0, i32 1, !dbg !130, !verifier.code !14
  %53 = load %struct.list*, %struct.list** %52, align 8, !dbg !130, !verifier.code !14
  %54 = icmp eq %struct.list* %53, null, !dbg !130, !verifier.code !14
  br i1 %54, label %56, label %55, !dbg !133, !verifier.code !14

55:                                               ; preds = %51
  call void @fail(), !dbg !130, !verifier.code !14
  br label %56, !dbg !130, !verifier.code !14

56:                                               ; preds = %55, %51
  br label %57, !dbg !133, !verifier.code !14

57:                                               ; preds = %56
  br label %58, !dbg !134, !verifier.code !14

58:                                               ; preds = %57
  %59 = getelementptr inbounds %struct.list, %struct.list* %.0.lcssa, i32 0, i32 0, !dbg !135, !verifier.code !14
  %60 = load %struct.node*, %struct.node** %59, align 8, !dbg !135, !verifier.code !14
  %61 = icmp ne %struct.node* %60, null, !dbg !135, !verifier.code !14
  br i1 %61, label %63, label %62, !dbg !138, !verifier.code !14

62:                                               ; preds = %58
  call void @fail(), !dbg !135, !verifier.code !14
  br label %63, !dbg !135, !verifier.code !14

63:                                               ; preds = %62, %58
  br label %64, !dbg !138, !verifier.code !14

64:                                               ; preds = %63
  br label %65, !dbg !139, !verifier.code !14

65:                                               ; preds = %64
  %66 = getelementptr inbounds %struct.list, %struct.list* %.0.lcssa, i32 0, i32 0, !dbg !140, !verifier.code !14
  %67 = load %struct.node*, %struct.node** %66, align 8, !dbg !140, !verifier.code !14
  %68 = getelementptr inbounds %struct.node, %struct.node* %67, i32 0, i32 0, !dbg !140, !verifier.code !14
  %69 = load %struct.node*, %struct.node** %68, align 8, !dbg !140, !verifier.code !14
  %70 = icmp eq %struct.node* %69, null, !dbg !140, !verifier.code !14
  br i1 %70, label %72, label %71, !dbg !143, !verifier.code !14

71:                                               ; preds = %65
  call void @fail(), !dbg !140, !verifier.code !14
  br label %72, !dbg !140, !verifier.code !14

72:                                               ; preds = %71, %65
  br label %73, !dbg !143, !verifier.code !14

73:                                               ; preds = %72
  ret void, !dbg !144, !verifier.code !14

forwarder:                                        ; preds = %39
  br label %10, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal %struct.list* @seq_sort_core(%struct.list* %0) #0 !dbg !145 {
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !148, metadata !DIExpression()), !dbg !149, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* null, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  %2 = icmp ne %struct.list* %0, null, !dbg !151, !verifier.code !14
  br i1 %2, label %.lr.ph, label %.loopexit, !dbg !151, !verifier.code !14

.lr.ph:                                           ; preds = %1
  br label %3, !dbg !151, !verifier.code !14

3:                                                ; preds = %forwarder, %.lr.ph
  %.05 = phi %struct.list* [ %0, %.lr.ph ], [ %17, %forwarder ], !verifier.code !14
  %.014 = phi %struct.list* [ null, %.lr.ph ], [ %.05, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.05, metadata !148, metadata !DIExpression()), !dbg !149, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.014, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  %4 = getelementptr inbounds %struct.list, %struct.list* %.05, i32 0, i32 1, !dbg !152, !verifier.code !14
  %5 = load %struct.list*, %struct.list** %4, align 8, !dbg !152, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %5, metadata !154, metadata !DIExpression()), !dbg !155, !verifier.code !14
  %6 = icmp ne %struct.list* %5, null, !dbg !156, !verifier.code !14
  br i1 %6, label %9, label %7, !dbg !158, !verifier.code !14

7:                                                ; preds = %3
  %.01.lcssa3 = phi %struct.list* [ %.014, %3 ], !dbg !149, !verifier.code !14
  %.0.lcssa2 = phi %struct.list* [ %.05, %3 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.01.lcssa3, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.0.lcssa2, metadata !148, metadata !DIExpression()), !dbg !149, !verifier.code !14
  %8 = getelementptr inbounds %struct.list, %struct.list* %.0.lcssa2, i32 0, i32 1, !dbg !159, !verifier.code !14
  store %struct.list* %.01.lcssa3, %struct.list** %8, align 8, !dbg !161, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.0.lcssa2, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  br label %20, !dbg !162, !verifier.code !14

9:                                                ; preds = %3
  %10 = getelementptr inbounds %struct.list, %struct.list* %.05, i32 0, i32 0, !dbg !163, !verifier.code !14
  %11 = getelementptr inbounds %struct.list, %struct.list* %.05, i32 0, i32 0, !dbg !164, !verifier.code !14
  %12 = load %struct.node*, %struct.node** %11, align 8, !dbg !164, !verifier.code !14
  %13 = getelementptr inbounds %struct.list, %struct.list* %5, i32 0, i32 0, !dbg !165, !verifier.code !14
  %14 = load %struct.node*, %struct.node** %13, align 8, !dbg !165, !verifier.code !14
  call void @merge_pair(%struct.node** %10, %struct.node* %12, %struct.node* %14), !dbg !166, !verifier.code !14
  %15 = getelementptr inbounds %struct.list, %struct.list* %.05, i32 0, i32 1, !dbg !167, !verifier.code !14
  store %struct.list* %.014, %struct.list** %15, align 8, !dbg !168, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.05, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  %16 = getelementptr inbounds %struct.list, %struct.list* %5, i32 0, i32 1, !dbg !169, !verifier.code !14
  %17 = load %struct.list*, %struct.list** %16, align 8, !dbg !169, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %17, metadata !148, metadata !DIExpression()), !dbg !149, !verifier.code !14
  %18 = bitcast %struct.list* %5 to i8*, !dbg !170, !verifier.code !14
  call void @free(i8* %18) #5, !dbg !171, !verifier.code !14
  %19 = icmp ne %struct.list* %17, null, !dbg !151, !verifier.code !14
  br i1 %19, label %forwarder, label %..loopexit_crit_edge, !dbg !151, !llvm.loop !172, !verifier.code !14

..loopexit_crit_edge:                             ; preds = %9
  %split = phi %struct.list* [ %.05, %9 ], !verifier.code !14
  br label %.loopexit, !dbg !151, !verifier.code !14

.loopexit:                                        ; preds = %..loopexit_crit_edge, %1
  %.01.lcssa = phi %struct.list* [ %split, %..loopexit_crit_edge ], [ null, %1 ], !dbg !149, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.01.lcssa, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  br label %20, !dbg !174, !verifier.code !14

20:                                               ; preds = %.loopexit, %7
  %.1 = phi %struct.list* [ %.0.lcssa2, %7 ], [ %.01.lcssa, %.loopexit ], !dbg !149, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.list* %.1, metadata !150, metadata !DIExpression()), !dbg !149, !verifier.code !14
  ret %struct.list* %.1, !dbg !174, !verifier.code !14

forwarder:                                        ; preds = %9
  br label %3, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @inspect_after(%struct.list* %0) #0 !dbg !175 {
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !176, metadata !DIExpression()), !dbg !177, !verifier.code !14
  br label %2, !dbg !178, !verifier.code !14

2:                                                ; preds = %1
  %3 = icmp ne %struct.list* %0, null, !dbg !179, !verifier.code !14
  br i1 %3, label %5, label %4, !dbg !182, !verifier.code !14

4:                                                ; preds = %2
  call void @fail(), !dbg !179, !verifier.code !14
  br label %5, !dbg !179, !verifier.code !14

5:                                                ; preds = %4, %2
  br label %6, !dbg !182, !verifier.code !14

6:                                                ; preds = %5
  br label %7, !dbg !183, !verifier.code !14

7:                                                ; preds = %6
  %8 = getelementptr inbounds %struct.list, %struct.list* %0, i32 0, i32 1, !dbg !184, !verifier.code !14
  %9 = load %struct.list*, %struct.list** %8, align 8, !dbg !184, !verifier.code !14
  %10 = icmp eq %struct.list* %9, null, !dbg !184, !verifier.code !14
  br i1 %10, label %12, label %11, !dbg !187, !verifier.code !14

11:                                               ; preds = %7
  call void @fail(), !dbg !184, !verifier.code !14
  br label %12, !dbg !184, !verifier.code !14

12:                                               ; preds = %11, %7
  br label %13, !dbg !187, !verifier.code !14

13:                                               ; preds = %12
  br label %14, !dbg !188, !verifier.code !14

14:                                               ; preds = %13
  %15 = getelementptr inbounds %struct.list, %struct.list* %0, i32 0, i32 0, !dbg !189, !verifier.code !14
  %16 = load %struct.node*, %struct.node** %15, align 8, !dbg !189, !verifier.code !14
  %17 = icmp ne %struct.node* %16, null, !dbg !189, !verifier.code !14
  br i1 %17, label %19, label %18, !dbg !192, !verifier.code !14

18:                                               ; preds = %14
  call void @fail(), !dbg !189, !verifier.code !14
  br label %19, !dbg !189, !verifier.code !14

19:                                               ; preds = %18, %14
  br label %20, !dbg !192, !verifier.code !14

20:                                               ; preds = %19
  %21 = getelementptr inbounds %struct.list, %struct.list* %0, i32 0, i32 0, !dbg !193, !verifier.code !14
  %22 = load %struct.node*, %struct.node** %21, align 8, !dbg !193, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %22, metadata !195, metadata !DIExpression()), !dbg !177, !verifier.code !14
  %23 = getelementptr inbounds %struct.node, %struct.node* %22, i32 0, i32 0, !dbg !196, !verifier.code !14
  %24 = load %struct.node*, %struct.node** %23, align 8, !dbg !196, !verifier.code !14
  %25 = icmp ne %struct.node* %24, null, !dbg !198, !verifier.code !14
  br i1 %25, label %.lr.ph, label %33, !dbg !198, !verifier.code !14

.lr.ph:                                           ; preds = %20
  br label %26, !dbg !198, !verifier.code !14

26:                                               ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %22, %.lr.ph ], [ %29, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !195, metadata !DIExpression()), !dbg !177, !verifier.code !14
  br label %27, !dbg !198, !verifier.code !14

27:                                               ; preds = %26
  %28 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !199, !verifier.code !14
  %29 = load %struct.node*, %struct.node** %28, align 8, !dbg !199, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %29, metadata !195, metadata !DIExpression()), !dbg !177, !verifier.code !14
  %30 = getelementptr inbounds %struct.node, %struct.node* %29, i32 0, i32 0, !dbg !196, !verifier.code !14
  %31 = load %struct.node*, %struct.node** %30, align 8, !dbg !196, !verifier.code !14
  %32 = icmp ne %struct.node* %31, null, !dbg !198, !verifier.code !14
  br i1 %32, label %forwarder, label %._crit_edge, !dbg !198, !llvm.loop !200, !verifier.code !14

._crit_edge:                                      ; preds = %27
  %split = phi %struct.node* [ %29, %27 ], !verifier.code !14
  br label %33, !dbg !198, !verifier.code !14

33:                                               ; preds = %._crit_edge, %20
  %.0.lcssa = phi %struct.node* [ %split, %._crit_edge ], [ %22, %20 ], !dbg !202, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %.0.lcssa, metadata !195, metadata !DIExpression()), !dbg !177, !verifier.code !14
  br label %34, !dbg !203, !verifier.code !14

34:                                               ; preds = %33
  %35 = getelementptr inbounds %struct.node, %struct.node* %.0.lcssa, i32 0, i32 0, !dbg !204, !verifier.code !14
  %36 = load %struct.node*, %struct.node** %35, align 8, !dbg !204, !verifier.code !14
  %37 = icmp ne %struct.node* %36, null, !dbg !204, !verifier.code !14
  br i1 %37, label %38, label %39, !dbg !207, !verifier.code !14

38:                                               ; preds = %34
  call void @fail(), !dbg !204, !verifier.code !14
  br label %39, !dbg !204, !verifier.code !14

39:                                               ; preds = %38, %34
  br label %40, !dbg !207, !verifier.code !14

40:                                               ; preds = %39
  ret void, !dbg !208, !verifier.code !14

forwarder:                                        ; preds = %27
  br label %26, !verifier.code !14
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal void @fail() #0 !dbg !209 {
  br label %1, !dbg !210, !verifier.code !14

1:                                                ; preds = %0
  call void @llvm.dbg.label(metadata !211), !dbg !212, !verifier.code !14
  call void @reach_error(), !dbg !213, !verifier.code !14
  call void @abort() #6, !dbg !215, !verifier.code !14
  unreachable, !dbg !215, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @merge_pair(%struct.node** %0, %struct.node* %1, %struct.node* %2) #0 !dbg !216 {
  %4 = alloca %struct.node**, align 8, !verifier.code !14
  %5 = alloca %struct.node*, align 8, !verifier.code !14
  %6 = alloca %struct.node*, align 8, !verifier.code !14
  store %struct.node** %0, %struct.node*** %4, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.node*** %4, metadata !220, metadata !DIExpression()), !dbg !221, !verifier.code !14
  store %struct.node* %1, %struct.node** %5, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.node** %5, metadata !222, metadata !DIExpression()), !dbg !223, !verifier.code !14
  store %struct.node* %2, %struct.node** %6, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.node** %6, metadata !224, metadata !DIExpression()), !dbg !225, !verifier.code !14
  br label %7, !dbg !226, !verifier.code !14

7:                                                ; preds = %31, %3
  %8 = load %struct.node*, %struct.node** %5, align 8, !dbg !227, !verifier.code !14
  %9 = icmp ne %struct.node* %8, null, !dbg !227, !verifier.code !14
  br i1 %9, label %13, label %10, !dbg !228, !verifier.code !14

10:                                               ; preds = %7
  %11 = load %struct.node*, %struct.node** %6, align 8, !dbg !229, !verifier.code !14
  %12 = icmp ne %struct.node* %11, null, !dbg !228, !verifier.code !14
  br label %13, !dbg !228, !verifier.code !14

13:                                               ; preds = %10, %7
  %14 = phi i1 [ true, %7 ], [ %12, %10 ], !verifier.code !14
  br i1 %14, label %15, label %32, !dbg !226, !verifier.code !14

15:                                               ; preds = %13
  %16 = load %struct.node*, %struct.node** %6, align 8, !dbg !230, !verifier.code !14
  %17 = icmp ne %struct.node* %16, null, !dbg !230, !verifier.code !14
  br i1 %17, label %18, label %29, !dbg !233, !verifier.code !14

18:                                               ; preds = %15
  %19 = load %struct.node*, %struct.node** %5, align 8, !dbg !234, !verifier.code !14
  %20 = icmp ne %struct.node* %19, null, !dbg !234, !verifier.code !14
  br i1 %20, label %21, label %30, !dbg !235, !verifier.code !14

21:                                               ; preds = %18
  %22 = load %struct.node*, %struct.node** %5, align 8, !dbg !236, !verifier.code !14
  %23 = getelementptr inbounds %struct.node, %struct.node* %22, i32 0, i32 1, !dbg !237, !verifier.code !14
  %24 = load i32, i32* %23, align 8, !dbg !237, !verifier.code !14
  %25 = load %struct.node*, %struct.node** %6, align 8, !dbg !238, !verifier.code !14
  %26 = getelementptr inbounds %struct.node, %struct.node* %25, i32 0, i32 1, !dbg !239, !verifier.code !14
  %27 = load i32, i32* %26, align 8, !dbg !239, !verifier.code !14
  %28 = icmp slt i32 %24, %27, !dbg !240, !verifier.code !14
  br i1 %28, label %29, label %30, !dbg !241, !verifier.code !14

29:                                               ; preds = %21, %15
  call void @merge_single_node(%struct.node*** %4, %struct.node** %5), !dbg !242, !verifier.code !14
  br label %31, !dbg !242, !verifier.code !14

30:                                               ; preds = %21, %18
  call void @merge_single_node(%struct.node*** %4, %struct.node** %6), !dbg !243, !verifier.code !14
  br label %31, !verifier.code !14

31:                                               ; preds = %30, %29
  br label %7, !dbg !226, !llvm.loop !244, !verifier.code !14

32:                                               ; preds = %13
  ret void, !dbg !246, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @merge_single_node(%struct.node*** %0, %struct.node** %1) #0 !dbg !247 {
  call void @llvm.dbg.value(metadata %struct.node*** %0, metadata !251, metadata !DIExpression()), !dbg !252, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node** %1, metadata !253, metadata !DIExpression()), !dbg !252, !verifier.code !14
  %3 = load %struct.node*, %struct.node** %1, align 8, !dbg !254, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !255, metadata !DIExpression()), !dbg !252, !verifier.code !14
  %4 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !256, !verifier.code !14
  %5 = load %struct.node*, %struct.node** %4, align 8, !dbg !256, !verifier.code !14
  store %struct.node* %5, %struct.node** %1, align 8, !dbg !257, !verifier.code !14
  %6 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !258, !verifier.code !14
  store %struct.node* null, %struct.node** %6, align 8, !dbg !259, !verifier.code !14
  %7 = load %struct.node**, %struct.node*** %0, align 8, !dbg !260, !verifier.code !14
  store %struct.node* %3, %struct.node** %7, align 8, !dbg !261, !verifier.code !14
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !262, !verifier.code !14
  store %struct.node** %8, %struct.node*** %0, align 8, !dbg !263, !verifier.code !14
  ret void, !dbg !264, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/merge_sort-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !10, file: !10, line: 2, type: !11, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//merge_sort-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 2, column: 20, scope: !9)
!14 = !{i1 false}
!15 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 111, type: !16, scopeLine: 112, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "data", scope: !15, file: !10, line: 113, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list", file: !10, line: 22, size: 128, elements: !22)
!22 = !{!23, !29}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "slist", scope: !21, file: !10, line: 23, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !10, line: 17, size: 128, elements: !26)
!26 = !{!27, !28}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !25, file: !10, line: 18, baseType: !24, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !25, file: !10, line: 19, baseType: !18, size: 32, offset: 64)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !21, file: !10, line: 24, baseType: !20, size: 64, offset: 64)
!30 = !DILocation(line: 0, scope: !15)
!31 = !DILocation(line: 114, column: 12, scope: !15)
!32 = !{i1 true}
!33 = !DILocation(line: 114, column: 5, scope: !15)
!34 = !DILocation(line: 115, column: 29, scope: !35)
!35 = distinct !DILexicalBlock(scope: !15, file: !10, line: 114, column: 37)
!36 = !DILocalVariable(name: "node", scope: !35, file: !10, line: 115, type: !24)
!37 = !DILocation(line: 0, scope: !35)
!38 = !DILocation(line: 116, column: 14, scope: !39)
!39 = distinct !DILexicalBlock(scope: !35, file: !10, line: 116, column: 13)
!40 = !DILocation(line: 116, column: 13, scope: !35)
!41 = !DILocation(line: 117, column: 13, scope: !39)
!42 = !DILocation(line: 119, column: 15, scope: !35)
!43 = !DILocation(line: 119, column: 20, scope: !35)
!44 = !DILocation(line: 120, column: 23, scope: !35)
!45 = !DILocation(line: 120, column: 15, scope: !35)
!46 = !DILocation(line: 120, column: 21, scope: !35)
!47 = !DILocation(line: 122, column: 29, scope: !35)
!48 = !DILocalVariable(name: "item", scope: !35, file: !10, line: 122, type: !20)
!49 = !DILocation(line: 123, column: 14, scope: !50)
!50 = distinct !DILexicalBlock(scope: !35, file: !10, line: 123, column: 13)
!51 = !DILocation(line: 123, column: 13, scope: !35)
!52 = !DILocation(line: 124, column: 13, scope: !50)
!53 = !DILocation(line: 126, column: 15, scope: !35)
!54 = !DILocation(line: 126, column: 21, scope: !35)
!55 = !DILocation(line: 127, column: 15, scope: !35)
!56 = !DILocation(line: 127, column: 20, scope: !35)
!57 = distinct !{!57, !33, !58}
!58 = !DILocation(line: 129, column: 5, scope: !15)
!59 = !DILocation(line: 131, column: 10, scope: !60)
!60 = distinct !DILexicalBlock(scope: !15, file: !10, line: 131, column: 9)
!61 = !DILocation(line: 131, column: 9, scope: !15)
!62 = !DILocation(line: 132, column: 9, scope: !60)
!63 = !DILocation(line: 134, column: 5, scope: !15)
!64 = !DILocation(line: 137, column: 18, scope: !15)
!65 = !DILocation(line: 137, column: 5, scope: !15)
!66 = !DILocation(line: 138, column: 16, scope: !15)
!67 = distinct !{!67, !65, !68}
!68 = !DILocation(line: 138, column: 34, scope: !15)
!69 = !DILocation(line: 140, column: 5, scope: !15)
!70 = !DILocation(line: 142, column: 31, scope: !15)
!71 = !DILocalVariable(name: "node", scope: !15, file: !10, line: 142, type: !24)
!72 = !DILocation(line: 143, column: 10, scope: !15)
!73 = !DILocation(line: 143, column: 5, scope: !15)
!74 = !DILocation(line: 145, column: 5, scope: !15)
!75 = !DILocation(line: 146, column: 36, scope: !76)
!76 = distinct !DILexicalBlock(scope: !15, file: !10, line: 145, column: 18)
!77 = !DILocalVariable(name: "snext", scope: !76, file: !10, line: 146, type: !24)
!78 = !DILocation(line: 0, scope: !76)
!79 = !DILocation(line: 147, column: 14, scope: !76)
!80 = !DILocation(line: 147, column: 9, scope: !76)
!81 = distinct !{!81, !74, !82}
!82 = !DILocation(line: 149, column: 5, scope: !15)
!83 = !DILocation(line: 151, column: 5, scope: !15)
!84 = !DILocation(line: 152, column: 1, scope: !15)
!85 = distinct !DISubprogram(name: "inspect_before", scope: !10, file: !10, line: 79, type: !86, scopeLine: 80, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !20}
!88 = !DILocalVariable(name: "shape", arg: 1, scope: !85, file: !10, line: 79, type: !20)
!89 = !DILocation(line: 0, scope: !85)
!90 = !DILocation(line: 82, column: 5, scope: !85)
!91 = !DILocation(line: 82, column: 5, scope: !92)
!92 = distinct !DILexicalBlock(scope: !93, file: !10, line: 82, column: 5)
!93 = distinct !DILexicalBlock(scope: !85, file: !10, line: 82, column: 5)
!94 = !DILocation(line: 82, column: 5, scope: !93)
!95 = !DILocation(line: 84, column: 19, scope: !96)
!96 = distinct !DILexicalBlock(scope: !97, file: !10, line: 84, column: 5)
!97 = distinct !DILexicalBlock(scope: !85, file: !10, line: 84, column: 5)
!98 = !DILocation(line: 84, column: 5, scope: !97)
!99 = !DILocation(line: 85, column: 9, scope: !100)
!100 = distinct !DILexicalBlock(scope: !96, file: !10, line: 84, column: 46)
!101 = !DILocation(line: 85, column: 9, scope: !102)
!102 = distinct !DILexicalBlock(scope: !103, file: !10, line: 85, column: 9)
!103 = distinct !DILexicalBlock(scope: !100, file: !10, line: 85, column: 9)
!104 = !DILocation(line: 85, column: 9, scope: !103)
!105 = !DILocation(line: 86, column: 9, scope: !100)
!106 = !DILocation(line: 86, column: 9, scope: !107)
!107 = distinct !DILexicalBlock(scope: !108, file: !10, line: 86, column: 9)
!108 = distinct !DILexicalBlock(scope: !100, file: !10, line: 86, column: 9)
!109 = !DILocation(line: 86, column: 9, scope: !108)
!110 = !DILocation(line: 87, column: 9, scope: !100)
!111 = !DILocation(line: 87, column: 9, scope: !112)
!112 = distinct !DILexicalBlock(scope: !113, file: !10, line: 87, column: 9)
!113 = distinct !DILexicalBlock(scope: !100, file: !10, line: 87, column: 9)
!114 = !DILocation(line: 87, column: 9, scope: !113)
!115 = !DILocation(line: 88, column: 9, scope: !100)
!116 = !DILocation(line: 88, column: 9, scope: !117)
!117 = distinct !DILexicalBlock(scope: !118, file: !10, line: 88, column: 9)
!118 = distinct !DILexicalBlock(scope: !100, file: !10, line: 88, column: 9)
!119 = !DILocation(line: 88, column: 9, scope: !118)
!120 = !DILocation(line: 89, column: 5, scope: !100)
!121 = !DILocation(line: 84, column: 40, scope: !96)
!122 = distinct !{!122, !98, !123}
!123 = !DILocation(line: 89, column: 5, scope: !97)
!124 = !DILocation(line: 92, column: 5, scope: !85)
!125 = !DILocation(line: 92, column: 5, scope: !126)
!126 = distinct !DILexicalBlock(scope: !127, file: !10, line: 92, column: 5)
!127 = distinct !DILexicalBlock(scope: !85, file: !10, line: 92, column: 5)
!128 = !DILocation(line: 92, column: 5, scope: !127)
!129 = !DILocation(line: 93, column: 5, scope: !85)
!130 = !DILocation(line: 93, column: 5, scope: !131)
!131 = distinct !DILexicalBlock(scope: !132, file: !10, line: 93, column: 5)
!132 = distinct !DILexicalBlock(scope: !85, file: !10, line: 93, column: 5)
!133 = !DILocation(line: 93, column: 5, scope: !132)
!134 = !DILocation(line: 94, column: 5, scope: !85)
!135 = !DILocation(line: 94, column: 5, scope: !136)
!136 = distinct !DILexicalBlock(scope: !137, file: !10, line: 94, column: 5)
!137 = distinct !DILexicalBlock(scope: !85, file: !10, line: 94, column: 5)
!138 = !DILocation(line: 94, column: 5, scope: !137)
!139 = !DILocation(line: 95, column: 5, scope: !85)
!140 = !DILocation(line: 95, column: 5, scope: !141)
!141 = distinct !DILexicalBlock(scope: !142, file: !10, line: 95, column: 5)
!142 = distinct !DILexicalBlock(scope: !85, file: !10, line: 95, column: 5)
!143 = !DILocation(line: 95, column: 5, scope: !142)
!144 = !DILocation(line: 96, column: 1, scope: !85)
!145 = distinct !DISubprogram(name: "seq_sort_core", scope: !10, file: !10, line: 53, type: !146, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!146 = !DISubroutineType(types: !147)
!147 = !{!20, !20}
!148 = !DILocalVariable(name: "data", arg: 1, scope: !145, file: !10, line: 53, type: !20)
!149 = !DILocation(line: 0, scope: !145)
!150 = !DILocalVariable(name: "dst", scope: !145, file: !10, line: 55, type: !20)
!151 = !DILocation(line: 57, column: 5, scope: !145)
!152 = !DILocation(line: 58, column: 35, scope: !153)
!153 = distinct !DILexicalBlock(scope: !145, file: !10, line: 57, column: 18)
!154 = !DILocalVariable(name: "next", scope: !153, file: !10, line: 58, type: !20)
!155 = !DILocation(line: 0, scope: !153)
!156 = !DILocation(line: 59, column: 14, scope: !157)
!157 = distinct !DILexicalBlock(scope: !153, file: !10, line: 59, column: 13)
!158 = !DILocation(line: 59, column: 13, scope: !153)
!159 = !DILocation(line: 61, column: 19, scope: !160)
!160 = distinct !DILexicalBlock(scope: !157, file: !10, line: 59, column: 20)
!161 = !DILocation(line: 61, column: 24, scope: !160)
!162 = !DILocation(line: 63, column: 13, scope: !160)
!163 = !DILocation(line: 67, column: 27, scope: !153)
!164 = !DILocation(line: 67, column: 40, scope: !153)
!165 = !DILocation(line: 67, column: 53, scope: !153)
!166 = !DILocation(line: 67, column: 9, scope: !153)
!167 = !DILocation(line: 68, column: 15, scope: !153)
!168 = !DILocation(line: 68, column: 20, scope: !153)
!169 = !DILocation(line: 72, column: 22, scope: !153)
!170 = !DILocation(line: 73, column: 14, scope: !153)
!171 = !DILocation(line: 73, column: 9, scope: !153)
!172 = distinct !{!172, !151, !173}
!173 = !DILocation(line: 74, column: 5, scope: !145)
!174 = !DILocation(line: 76, column: 5, scope: !145)
!175 = distinct !DISubprogram(name: "inspect_after", scope: !10, file: !10, line: 98, type: !86, scopeLine: 99, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!176 = !DILocalVariable(name: "shape", arg: 1, scope: !175, file: !10, line: 98, type: !20)
!177 = !DILocation(line: 0, scope: !175)
!178 = !DILocation(line: 101, column: 5, scope: !175)
!179 = !DILocation(line: 101, column: 5, scope: !180)
!180 = distinct !DILexicalBlock(scope: !181, file: !10, line: 101, column: 5)
!181 = distinct !DILexicalBlock(scope: !175, file: !10, line: 101, column: 5)
!182 = !DILocation(line: 101, column: 5, scope: !181)
!183 = !DILocation(line: 102, column: 5, scope: !175)
!184 = !DILocation(line: 102, column: 5, scope: !185)
!185 = distinct !DILexicalBlock(scope: !186, file: !10, line: 102, column: 5)
!186 = distinct !DILexicalBlock(scope: !175, file: !10, line: 102, column: 5)
!187 = !DILocation(line: 102, column: 5, scope: !186)
!188 = !DILocation(line: 103, column: 5, scope: !175)
!189 = !DILocation(line: 103, column: 5, scope: !190)
!190 = distinct !DILexicalBlock(scope: !191, file: !10, line: 103, column: 5)
!191 = distinct !DILexicalBlock(scope: !175, file: !10, line: 103, column: 5)
!192 = !DILocation(line: 103, column: 5, scope: !191)
!193 = !DILocation(line: 107, column: 23, scope: !194)
!194 = distinct !DILexicalBlock(scope: !175, file: !10, line: 107, column: 5)
!195 = !DILocalVariable(name: "pos", scope: !175, file: !10, line: 106, type: !24)
!196 = !DILocation(line: 107, column: 35, scope: !197)
!197 = distinct !DILexicalBlock(scope: !194, file: !10, line: 107, column: 5)
!198 = !DILocation(line: 107, column: 5, scope: !194)
!199 = !DILocation(line: 107, column: 52, scope: !197)
!200 = distinct !{!200, !198, !201}
!201 = !DILocation(line: 107, column: 57, scope: !194)
!202 = !DILocation(line: 0, scope: !194)
!203 = !DILocation(line: 108, column: 5, scope: !175)
!204 = !DILocation(line: 108, column: 5, scope: !205)
!205 = distinct !DILexicalBlock(scope: !206, file: !10, line: 108, column: 5)
!206 = distinct !DILexicalBlock(scope: !175, file: !10, line: 108, column: 5)
!207 = !DILocation(line: 108, column: 5, scope: !206)
!208 = !DILocation(line: 109, column: 1, scope: !175)
!209 = distinct !DISubprogram(name: "fail", scope: !10, file: !10, line: 8, type: !11, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!210 = !DILocation(line: 8, column: 24, scope: !209)
!211 = !DILabel(scope: !209, name: "ERROR", file: !10, line: 9)
!212 = !DILocation(line: 9, column: 1, scope: !209)
!213 = !DILocation(line: 9, column: 9, scope: !214)
!214 = distinct !DILexicalBlock(scope: !209, file: !10, line: 9, column: 8)
!215 = !DILocation(line: 9, column: 23, scope: !214)
!216 = distinct !DISubprogram(name: "merge_pair", scope: !10, file: !10, line: 40, type: !217, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!217 = !DISubroutineType(types: !218)
!218 = !{null, !219, !24, !24}
!219 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!220 = !DILocalVariable(name: "dst", arg: 1, scope: !216, file: !10, line: 40, type: !219)
!221 = !DILocation(line: 40, column: 38, scope: !216)
!222 = !DILocalVariable(name: "sub1", arg: 2, scope: !216, file: !10, line: 41, type: !24)
!223 = !DILocation(line: 41, column: 37, scope: !216)
!224 = !DILocalVariable(name: "sub2", arg: 3, scope: !216, file: !10, line: 42, type: !24)
!225 = !DILocation(line: 42, column: 37, scope: !216)
!226 = !DILocation(line: 45, column: 5, scope: !216)
!227 = !DILocation(line: 45, column: 12, scope: !216)
!228 = !DILocation(line: 45, column: 17, scope: !216)
!229 = !DILocation(line: 45, column: 20, scope: !216)
!230 = !DILocation(line: 46, column: 14, scope: !231)
!231 = distinct !DILexicalBlock(scope: !232, file: !10, line: 46, column: 13)
!232 = distinct !DILexicalBlock(scope: !216, file: !10, line: 45, column: 26)
!233 = !DILocation(line: 46, column: 19, scope: !231)
!234 = !DILocation(line: 46, column: 23, scope: !231)
!235 = !DILocation(line: 46, column: 28, scope: !231)
!236 = !DILocation(line: 46, column: 31, scope: !231)
!237 = !DILocation(line: 46, column: 37, scope: !231)
!238 = !DILocation(line: 46, column: 45, scope: !231)
!239 = !DILocation(line: 46, column: 51, scope: !231)
!240 = !DILocation(line: 46, column: 43, scope: !231)
!241 = !DILocation(line: 46, column: 13, scope: !232)
!242 = !DILocation(line: 47, column: 13, scope: !231)
!243 = !DILocation(line: 49, column: 13, scope: !231)
!244 = distinct !{!244, !226, !245}
!245 = !DILocation(line: 50, column: 5, scope: !216)
!246 = !DILocation(line: 51, column: 1, scope: !216)
!247 = distinct !DISubprogram(name: "merge_single_node", scope: !10, file: !10, line: 27, type: !248, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!248 = !DISubroutineType(types: !249)
!249 = !{null, !250, !219}
!250 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !219, size: 64)
!251 = !DILocalVariable(name: "dst", arg: 1, scope: !247, file: !10, line: 27, type: !250)
!252 = !DILocation(line: 0, scope: !247)
!253 = !DILocalVariable(name: "data", arg: 2, scope: !247, file: !10, line: 28, type: !219)
!254 = !DILocation(line: 31, column: 25, scope: !247)
!255 = !DILocalVariable(name: "node", scope: !247, file: !10, line: 31, type: !24)
!256 = !DILocation(line: 32, column: 19, scope: !247)
!257 = !DILocation(line: 32, column: 11, scope: !247)
!258 = !DILocation(line: 33, column: 11, scope: !247)
!259 = !DILocation(line: 33, column: 16, scope: !247)
!260 = !DILocation(line: 36, column: 6, scope: !247)
!261 = !DILocation(line: 36, column: 11, scope: !247)
!262 = !DILocation(line: 37, column: 19, scope: !247)
!263 = !DILocation(line: 37, column: 10, scope: !247)
!264 = !DILocation(line: 38, column: 1, scope: !247)
