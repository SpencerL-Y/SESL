; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-jzzcddno.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list = type { i32, %struct.list* }

@head = internal global %struct.list* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !21 {
  ret void, !dbg !24, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal void @__VERIFIER_assert(i32 %0) #0 !dbg !26 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !29, metadata !DIExpression()), !dbg !30, !verifier.code !25
  %2 = icmp ne i32 %0, 0, !dbg !31, !verifier.code !25
  br i1 %2, label %5, label %3, !dbg !33, !verifier.code !25

3:                                                ; preds = %1
  br label %4, !dbg !34, !verifier.code !25

4:                                                ; preds = %3
  call void @llvm.dbg.label(metadata !35), !dbg !37, !verifier.code !25
  call void @reach_error(), !dbg !38, !verifier.code !25
  call void @abort() #4, !dbg !40, !verifier.code !25
  unreachable, !dbg !40, !verifier.code !25

5:                                                ; preds = %1
  ret void, !dbg !41, !verifier.code !25
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noreturn
declare dso_local void @abort() #2

; Function Attrs: noinline nounwind uwtable
define internal %struct.list* @search_list(%struct.list* %0, i32 %1) #0 !dbg !42 {
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %1, metadata !47, metadata !DIExpression()), !dbg !46, !verifier.code !25
  %3 = load %struct.list*, %struct.list** @head, align 8, !dbg !48, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %3, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !25
  br label %4, !dbg !49, !verifier.code !25

4:                                                ; preds = %12, %2
  %.0 = phi %struct.list* [ %3, %2 ], [ %14, %12 ], !dbg !46, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.0, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !25
  %5 = icmp ne %struct.list* %.0, null, !dbg !50, !verifier.code !25
  br i1 %5, label %6, label %10, !dbg !51, !verifier.code !25

6:                                                ; preds = %4
  %7 = getelementptr inbounds %struct.list, %struct.list* %.0, i32 0, i32 0, !dbg !52, !verifier.code !25
  %8 = load i32, i32* %7, align 8, !dbg !52, !verifier.code !25
  %9 = icmp ne i32 %8, %1, !dbg !53, !verifier.code !25
  br label %10, !verifier.code !25

10:                                               ; preds = %6, %4
  %11 = phi i1 [ false, %4 ], [ %9, %6 ], !dbg !46, !verifier.code !25
  br i1 %11, label %12, label %15, !dbg !49, !verifier.code !25

12:                                               ; preds = %10
  %13 = getelementptr inbounds %struct.list, %struct.list* %.0, i32 0, i32 1, !dbg !54, !verifier.code !25
  %14 = load %struct.list*, %struct.list** %13, align 8, !dbg !54, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %14, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !25
  br label %4, !dbg !49, !llvm.loop !56, !verifier.code !25

15:                                               ; preds = %10
  %.0.lcssa = phi %struct.list* [ %.0, %10 ], !dbg !46, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.0.lcssa, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !25
  ret %struct.list* %.0.lcssa, !dbg !58, !verifier.code !25
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @delete_list(%struct.list* %0) #0 !dbg !59 {
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !62, metadata !DIExpression()), !dbg !63, !verifier.code !25
  %2 = load %struct.list*, %struct.list** @head, align 8, !dbg !64, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %2, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !25
  %3 = load %struct.list*, %struct.list** @head, align 8, !dbg !66, !verifier.code !25
  %4 = icmp ne %struct.list* %3, %0, !dbg !68, !verifier.code !25
  br i1 %4, label %5, label %16, !dbg !69, !verifier.code !25

5:                                                ; preds = %1
  call void @llvm.dbg.value(metadata %struct.list* %2, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !25
  %6 = getelementptr inbounds %struct.list, %struct.list* %2, i32 0, i32 1, !dbg !70, !verifier.code !25
  %7 = load %struct.list*, %struct.list** %6, align 8, !dbg !70, !verifier.code !25
  %8 = icmp ne %struct.list* %7, %0, !dbg !72, !verifier.code !25
  br i1 %8, label %.lr.ph, label %15, !dbg !73, !verifier.code !25

.lr.ph:                                           ; preds = %5
  br label %9, !dbg !73, !verifier.code !25

9:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.list* [ %2, %.lr.ph ], [ %11, %forwarder ], !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.01, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !25
  %10 = getelementptr inbounds %struct.list, %struct.list* %.01, i32 0, i32 1, !dbg !74, !verifier.code !25
  %11 = load %struct.list*, %struct.list** %10, align 8, !dbg !74, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %11, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !25
  %12 = getelementptr inbounds %struct.list, %struct.list* %11, i32 0, i32 1, !dbg !70, !verifier.code !25
  %13 = load %struct.list*, %struct.list** %12, align 8, !dbg !70, !verifier.code !25
  %14 = icmp ne %struct.list* %13, %0, !dbg !72, !verifier.code !25
  br i1 %14, label %forwarder, label %._crit_edge, !dbg !73, !llvm.loop !76, !verifier.code !25

._crit_edge:                                      ; preds = %9
  %split = phi %struct.list* [ %11, %9 ], !verifier.code !25
  br label %15, !dbg !73, !verifier.code !25

15:                                               ; preds = %._crit_edge, %5
  %.0.lcssa = phi %struct.list* [ %split, %._crit_edge ], [ %2, %5 ], !dbg !63, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.0.lcssa, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !25
  br label %19, !dbg !78, !verifier.code !25

16:                                               ; preds = %1
  %17 = getelementptr inbounds %struct.list, %struct.list* %0, i32 0, i32 1, !dbg !79, !verifier.code !25
  %18 = load %struct.list*, %struct.list** %17, align 8, !dbg !79, !verifier.code !25
  store %struct.list* %18, %struct.list** @head, align 8, !dbg !81, !verifier.code !25
  br label %19, !verifier.code !25

19:                                               ; preds = %16, %15
  %.1 = phi %struct.list* [ %.0.lcssa, %15 ], [ %2, %16 ], !dbg !82, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.1, metadata !65, metadata !DIExpression()), !dbg !63, !verifier.code !25
  %20 = getelementptr inbounds %struct.list, %struct.list* %0, i32 0, i32 1, !dbg !83, !verifier.code !25
  %21 = load %struct.list*, %struct.list** %20, align 8, !dbg !83, !verifier.code !25
  %22 = getelementptr inbounds %struct.list, %struct.list* %.1, i32 0, i32 1, !dbg !84, !verifier.code !25
  store %struct.list* %21, %struct.list** %22, align 8, !dbg !85, !verifier.code !25
  %23 = bitcast %struct.list* %0 to i8*, !dbg !86, !verifier.code !25
  call void @free(i8* %23) #5, !dbg !87, !verifier.code !25
  ret i32 0, !dbg !88, !verifier.code !25

forwarder:                                        ; preds = %9
  br label %9, !verifier.code !25
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal i32 @insert_list(%struct.list* %0, i32 %1) #0 !dbg !89 {
  call void @llvm.dbg.value(metadata %struct.list* %0, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %1, metadata !94, metadata !DIExpression()), !dbg !93, !verifier.code !25
  %3 = call noalias i8* @malloc(i64 16) #5, !dbg !95, !verifier.code !25
  %4 = bitcast i8* %3 to %struct.list*, !dbg !96, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %4, metadata !92, metadata !DIExpression()), !dbg !93, !verifier.code !25
  %5 = load %struct.list*, %struct.list** @head, align 8, !dbg !97, !verifier.code !25
  %6 = icmp eq %struct.list* %5, null, !dbg !99, !verifier.code !25
  br i1 %6, label %7, label %10, !dbg !100, !verifier.code !25

7:                                                ; preds = %2
  %8 = getelementptr inbounds %struct.list, %struct.list* %4, i32 0, i32 0, !dbg !101, !verifier.code !25
  store i32 %1, i32* %8, align 8, !dbg !103, !verifier.code !25
  %9 = getelementptr inbounds %struct.list, %struct.list* %4, i32 0, i32 1, !dbg !104, !verifier.code !25
  store %struct.list* null, %struct.list** %9, align 8, !dbg !105, !verifier.code !25
  br label %14, !dbg !106, !verifier.code !25

10:                                               ; preds = %2
  %11 = getelementptr inbounds %struct.list, %struct.list* %4, i32 0, i32 0, !dbg !107, !verifier.code !25
  store i32 %1, i32* %11, align 8, !dbg !109, !verifier.code !25
  %12 = load %struct.list*, %struct.list** @head, align 8, !dbg !110, !verifier.code !25
  %13 = getelementptr inbounds %struct.list, %struct.list* %4, i32 0, i32 1, !dbg !111, !verifier.code !25
  store %struct.list* %12, %struct.list** %13, align 8, !dbg !112, !verifier.code !25
  br label %14, !verifier.code !25

14:                                               ; preds = %10, %7
  store %struct.list* %4, %struct.list** @head, align 8, !dbg !113, !verifier.code !25
  ret i32 0, !dbg !114, !verifier.code !25
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !115 {
  call void @llvm.dbg.declare(metadata !4, metadata !118, metadata !DIExpression()), !dbg !119, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* null, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %1 = call i32 @insert_list(%struct.list* null, i32 2), !dbg !122, !verifier.code !25
  %2 = call i32 @insert_list(%struct.list* null, i32 5), !dbg !123, !verifier.code !25
  %3 = call i32 @insert_list(%struct.list* null, i32 1), !dbg !124, !verifier.code !25
  %4 = call i32 @insert_list(%struct.list* null, i32 3), !dbg !125, !verifier.code !25
  %5 = load %struct.list*, %struct.list** @head, align 8, !dbg !126, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %5, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %6 = icmp ne %struct.list* %5, null, !dbg !127, !verifier.code !25
  br i1 %6, label %.lr.ph4, label %11, !dbg !127, !verifier.code !25

.lr.ph4:                                          ; preds = %0
  br label %7, !dbg !127, !verifier.code !25

7:                                                ; preds = %forwarder6, %.lr.ph4
  %.02 = phi %struct.list* [ %5, %.lr.ph4 ], [ %9, %forwarder6 ], !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.02, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %8 = getelementptr inbounds %struct.list, %struct.list* %.02, i32 0, i32 1, !dbg !128, !verifier.code !25
  %9 = load %struct.list*, %struct.list** %8, align 8, !dbg !128, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %9, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %10 = icmp ne %struct.list* %9, null, !dbg !127, !verifier.code !25
  br i1 %10, label %forwarder6, label %._crit_edge5, !dbg !127, !llvm.loop !130, !verifier.code !25

._crit_edge5:                                     ; preds = %7
  %split = phi %struct.list* [ %9, %7 ], !verifier.code !25
  br label %11, !dbg !127, !verifier.code !25

11:                                               ; preds = %._crit_edge5, %0
  %.0.lcssa = phi %struct.list* [ %split, %._crit_edge5 ], [ %5, %0 ], !dbg !121, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.0.lcssa, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %12 = call %struct.list* @search_list(%struct.list* %.0.lcssa, i32 2), !dbg !132, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %12, metadata !133, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %13 = getelementptr inbounds %struct.list, %struct.list* %12, i32 0, i32 0, !dbg !134, !verifier.code !135
  %14 = load i32, i32* %13, align 8, !dbg !134, !verifier.code !135
  %15 = icmp eq i32 %14, 2, !dbg !136, !verifier.code !135
  %16 = zext i1 %15 to i32, !dbg !136, !verifier.code !135
  call void @__VERIFIER_assert(i32 %16), !dbg !137, !verifier.code !135
  %17 = call i32 @delete_list(%struct.list* %12), !dbg !138, !verifier.code !25
  %18 = load %struct.list*, %struct.list** @head, align 8, !dbg !139, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %18, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %19 = icmp ne %struct.list* %18, null, !dbg !140, !verifier.code !25
  br i1 %19, label %.lr.ph, label %24, !dbg !140, !verifier.code !25

.lr.ph:                                           ; preds = %11
  br label %20, !dbg !140, !verifier.code !25

20:                                               ; preds = %forwarder, %.lr.ph
  %.11 = phi %struct.list* [ %18, %.lr.ph ], [ %22, %forwarder ], !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %.11, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %21 = getelementptr inbounds %struct.list, %struct.list* %.11, i32 0, i32 1, !dbg !141, !verifier.code !25
  %22 = load %struct.list*, %struct.list** %21, align 8, !dbg !141, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.list* %22, metadata !120, metadata !DIExpression()), !dbg !121, !verifier.code !25
  %23 = icmp ne %struct.list* %22, null, !dbg !140, !verifier.code !25
  br i1 %23, label %forwarder, label %._crit_edge, !dbg !140, !llvm.loop !143, !verifier.code !25

._crit_edge:                                      ; preds = %20
  br label %24, !dbg !140, !verifier.code !25

24:                                               ; preds = %._crit_edge, %11
  ret i32 0, !dbg !145, !verifier.code !25

forwarder:                                        ; preds = %20
  br label %20, !verifier.code !25

forwarder6:                                       ; preds = %7
  br label %7, !verifier.code !25
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  store %struct.list* null, %struct.list** @head
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!17}
!llvm.module.flags = !{!18, !19, !20}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "head", scope: !2, file: !9, line: 18, type: !7, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !16, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/list_search-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !{}
!5 = !{!6, !7}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "mlist", file: !9, line: 16, baseType: !10)
!9 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//list_search-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list", file: !9, line: 13, size: 128, elements: !11)
!11 = !{!12, !14}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !10, file: !9, line: 14, baseType: !13, size: 32)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !10, file: !9, line: 15, baseType: !15, size: 64, offset: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!16 = !{!0}
!17 = !{!"clang version 10.0.0-4ubuntu1 "}
!18 = !{i32 7, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = distinct !DISubprogram(name: "reach_error", scope: !9, file: !9, line: 2, type: !22, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!22 = !DISubroutineType(types: !23)
!23 = !{null}
!24 = !DILocation(line: 2, column: 20, scope: !21)
!25 = !{i1 false}
!26 = distinct !DISubprogram(name: "__VERIFIER_assert", scope: !9, file: !9, line: 4, type: !27, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!27 = !DISubroutineType(types: !28)
!28 = !{null, !13}
!29 = !DILocalVariable(name: "cond", arg: 1, scope: !26, file: !9, line: 4, type: !13)
!30 = !DILocation(line: 0, scope: !26)
!31 = !DILocation(line: 5, column: 8, scope: !32)
!32 = distinct !DILexicalBlock(scope: !26, file: !9, line: 5, column: 7)
!33 = !DILocation(line: 5, column: 7, scope: !26)
!34 = !DILocation(line: 5, column: 16, scope: !32)
!35 = !DILabel(scope: !36, name: "ERROR", file: !9, line: 6)
!36 = distinct !DILexicalBlock(scope: !32, file: !9, line: 5, column: 16)
!37 = !DILocation(line: 6, column: 5, scope: !36)
!38 = !DILocation(line: 6, column: 13, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !9, line: 6, column: 12)
!40 = !DILocation(line: 6, column: 27, scope: !39)
!41 = !DILocation(line: 8, column: 3, scope: !26)
!42 = distinct !DISubprogram(name: "search_list", scope: !9, file: !9, line: 20, type: !43, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!43 = !DISubroutineType(types: !44)
!44 = !{!7, !7, !13}
!45 = !DILocalVariable(name: "l", arg: 1, scope: !42, file: !9, line: 20, type: !7)
!46 = !DILocation(line: 0, scope: !42)
!47 = !DILocalVariable(name: "k", arg: 2, scope: !42, file: !9, line: 20, type: !13)
!48 = !DILocation(line: 21, column: 6, scope: !42)
!49 = !DILocation(line: 22, column: 2, scope: !42)
!50 = !DILocation(line: 22, column: 9, scope: !42)
!51 = !DILocation(line: 22, column: 16, scope: !42)
!52 = !DILocation(line: 22, column: 22, scope: !42)
!53 = !DILocation(line: 22, column: 25, scope: !42)
!54 = !DILocation(line: 23, column: 10, scope: !55)
!55 = distinct !DILexicalBlock(scope: !42, file: !9, line: 22, column: 30)
!56 = distinct !{!56, !49, !57}
!57 = !DILocation(line: 24, column: 2, scope: !42)
!58 = !DILocation(line: 25, column: 2, scope: !42)
!59 = distinct !DISubprogram(name: "delete_list", scope: !9, file: !9, line: 28, type: !60, scopeLine: 28, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!60 = !DISubroutineType(types: !61)
!61 = !{!13, !7}
!62 = !DILocalVariable(name: "l", arg: 1, scope: !59, file: !9, line: 28, type: !7)
!63 = !DILocation(line: 0, scope: !59)
!64 = !DILocation(line: 30, column: 8, scope: !59)
!65 = !DILocalVariable(name: "tmp", scope: !59, file: !9, line: 29, type: !7)
!66 = !DILocation(line: 31, column: 6, scope: !67)
!67 = distinct !DILexicalBlock(scope: !59, file: !9, line: 31, column: 6)
!68 = !DILocation(line: 31, column: 11, scope: !67)
!69 = !DILocation(line: 31, column: 6, scope: !59)
!70 = !DILocation(line: 32, column: 14, scope: !71)
!71 = distinct !DILexicalBlock(scope: !67, file: !9, line: 31, column: 17)
!72 = !DILocation(line: 32, column: 18, scope: !71)
!73 = !DILocation(line: 32, column: 3, scope: !71)
!74 = !DILocation(line: 33, column: 15, scope: !75)
!75 = distinct !DILexicalBlock(scope: !71, file: !9, line: 32, column: 23)
!76 = distinct !{!76, !73, !77}
!77 = !DILocation(line: 34, column: 3, scope: !71)
!78 = !DILocation(line: 35, column: 2, scope: !71)
!79 = !DILocation(line: 36, column: 13, scope: !80)
!80 = distinct !DILexicalBlock(scope: !67, file: !9, line: 35, column: 9)
!81 = !DILocation(line: 36, column: 8, scope: !80)
!82 = !DILocation(line: 30, column: 6, scope: !59)
!83 = !DILocation(line: 38, column: 17, scope: !59)
!84 = !DILocation(line: 38, column: 7, scope: !59)
!85 = !DILocation(line: 38, column: 12, scope: !59)
!86 = !DILocation(line: 39, column: 7, scope: !59)
!87 = !DILocation(line: 39, column: 2, scope: !59)
!88 = !DILocation(line: 40, column: 2, scope: !59)
!89 = distinct !DISubprogram(name: "insert_list", scope: !9, file: !9, line: 43, type: !90, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!90 = !DISubroutineType(types: !91)
!91 = !{!13, !7, !13}
!92 = !DILocalVariable(name: "l", arg: 1, scope: !89, file: !9, line: 43, type: !7)
!93 = !DILocation(line: 0, scope: !89)
!94 = !DILocalVariable(name: "k", arg: 2, scope: !89, file: !9, line: 43, type: !13)
!95 = !DILocation(line: 45, column: 14, scope: !89)
!96 = !DILocation(line: 45, column: 6, scope: !89)
!97 = !DILocation(line: 47, column: 6, scope: !98)
!98 = distinct !DILexicalBlock(scope: !89, file: !9, line: 47, column: 6)
!99 = !DILocation(line: 47, column: 10, scope: !98)
!100 = !DILocation(line: 47, column: 6, scope: !89)
!101 = !DILocation(line: 48, column: 6, scope: !102)
!102 = distinct !DILexicalBlock(scope: !98, file: !9, line: 47, column: 18)
!103 = !DILocation(line: 48, column: 10, scope: !102)
!104 = !DILocation(line: 49, column: 6, scope: !102)
!105 = !DILocation(line: 49, column: 11, scope: !102)
!106 = !DILocation(line: 50, column: 2, scope: !102)
!107 = !DILocation(line: 51, column: 6, scope: !108)
!108 = distinct !DILexicalBlock(scope: !98, file: !9, line: 50, column: 9)
!109 = !DILocation(line: 51, column: 10, scope: !108)
!110 = !DILocation(line: 52, column: 13, scope: !108)
!111 = !DILocation(line: 52, column: 6, scope: !108)
!112 = !DILocation(line: 52, column: 11, scope: !108)
!113 = !DILocation(line: 54, column: 7, scope: !89)
!114 = !DILocation(line: 56, column: 2, scope: !89)
!115 = distinct !DISubprogram(name: "main", scope: !9, file: !9, line: 59, type: !116, scopeLine: 59, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!116 = !DISubroutineType(types: !117)
!117 = !{!13}
!118 = !DILocalVariable(name: "i", scope: !115, file: !9, line: 61, type: !13)
!119 = !DILocation(line: 61, column: 6, scope: !115)
!120 = !DILocalVariable(name: "mylist", scope: !115, file: !9, line: 62, type: !7)
!121 = !DILocation(line: 0, scope: !115)
!122 = !DILocation(line: 65, column: 2, scope: !115)
!123 = !DILocation(line: 66, column: 2, scope: !115)
!124 = !DILocation(line: 67, column: 2, scope: !115)
!125 = !DILocation(line: 68, column: 2, scope: !115)
!126 = !DILocation(line: 70, column: 11, scope: !115)
!127 = !DILocation(line: 72, column: 2, scope: !115)
!128 = !DILocation(line: 73, column: 20, scope: !129)
!129 = distinct !DILexicalBlock(scope: !115, file: !9, line: 72, column: 16)
!130 = distinct !{!130, !127, !131}
!131 = !DILocation(line: 74, column: 2, scope: !115)
!132 = !DILocation(line: 76, column: 9, scope: !115)
!133 = !DILocalVariable(name: "temp", scope: !115, file: !9, line: 63, type: !7)
!134 = !DILocation(line: 77, column: 26, scope: !115)
!135 = !{i1 true}
!136 = !DILocation(line: 77, column: 29, scope: !115)
!137 = !DILocation(line: 77, column: 2, scope: !115)
!138 = !DILocation(line: 78, column: 2, scope: !115)
!139 = !DILocation(line: 80, column: 11, scope: !115)
!140 = !DILocation(line: 82, column: 2, scope: !115)
!141 = !DILocation(line: 83, column: 20, scope: !142)
!142 = distinct !DILexicalBlock(scope: !115, file: !9, line: 82, column: 16)
!143 = distinct !{!143, !140, !144}
!144 = !DILocation(line: 84, column: 2, scope: !115)
!145 = !DILocation(line: 85, column: 2, scope: !115)
