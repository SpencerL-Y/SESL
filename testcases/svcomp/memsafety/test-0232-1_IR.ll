; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/b-e9pio3d4.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.item = type { %struct.item*, %struct.item* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [31 x i8] c"svcomp/memsafety/test-0232-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !7 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !10, !verifier.code !13
  unreachable, !dbg !10, !verifier.code !13
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !14 {
  %1 = alloca %struct.item*, align 8, !verifier.code !13
  call void @llvm.dbg.declare(metadata %struct.item** %1, metadata !18, metadata !DIExpression()), !dbg !24, !verifier.code !13
  store %struct.item* null, %struct.item** %1, align 8, !dbg !24, !verifier.code !13
  br label %2, !dbg !25, !verifier.code !13

2:                                                ; preds = %3, %0
  call void @append(%struct.item** %1), !dbg !26, !verifier.code !13
  br label %3, !dbg !26, !verifier.code !13

3:                                                ; preds = %2
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !27, !verifier.code !28
  %5 = icmp ne i32 %4, 0, !dbg !26, !verifier.code !13
  br i1 %5, label %2, label %6, !dbg !26, !llvm.loop !29, !verifier.code !13

6:                                                ; preds = %3
  %7 = load %struct.item*, %struct.item** %1, align 8, !dbg !31, !verifier.code !13
  %8 = icmp ne %struct.item* %7, null, !dbg !31, !verifier.code !13
  br i1 %8, label %9, label %15, !dbg !33, !verifier.code !13

9:                                                ; preds = %6
  %10 = load %struct.item*, %struct.item** %1, align 8, !dbg !34, !verifier.code !13
  %11 = getelementptr inbounds %struct.item, %struct.item* %10, i32 0, i32 0, !dbg !36, !verifier.code !13
  %12 = load %struct.item*, %struct.item** %11, align 8, !dbg !36, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.item* %12, metadata !37, metadata !DIExpression()), !dbg !38, !verifier.code !13
  %13 = load %struct.item*, %struct.item** %1, align 8, !dbg !39, !verifier.code !13
  %14 = bitcast %struct.item* %13 to i8*, !dbg !39, !verifier.code !13
  call void @free(i8* %14) #6, !dbg !40, !verifier.code !13
  store %struct.item* %12, %struct.item** %1, align 8, !dbg !41, !verifier.code !13
  br label %15, !dbg !42, !verifier.code !13

15:                                               ; preds = %9, %6
  %16 = load %struct.item*, %struct.item** %1, align 8, !dbg !43, !verifier.code !13
  %17 = icmp ne %struct.item* %16, null, !dbg !44, !verifier.code !13
  br i1 %17, label %.lr.ph, label %26, !dbg !44, !verifier.code !13

.lr.ph:                                           ; preds = %15
  br label %18, !dbg !44, !verifier.code !13

18:                                               ; preds = %.lr.ph, %18
  %19 = load %struct.item*, %struct.item** %1, align 8, !dbg !45, !verifier.code !13
  %20 = getelementptr inbounds %struct.item, %struct.item* %19, i32 0, i32 0, !dbg !47, !verifier.code !13
  %21 = load %struct.item*, %struct.item** %20, align 8, !dbg !47, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.item* %21, metadata !48, metadata !DIExpression()), !dbg !49, !verifier.code !13
  %22 = load %struct.item*, %struct.item** %1, align 8, !dbg !50, !verifier.code !13
  %23 = bitcast %struct.item* %22 to i8*, !dbg !50, !verifier.code !13
  call void @free(i8* %23) #6, !dbg !51, !verifier.code !13
  store %struct.item* %21, %struct.item** %1, align 8, !dbg !52, !verifier.code !13
  %24 = load %struct.item*, %struct.item** %1, align 8, !dbg !43, !verifier.code !13
  %25 = icmp ne %struct.item* %24, null, !dbg !44, !verifier.code !13
  br i1 %25, label %18, label %._crit_edge, !dbg !44, !llvm.loop !53, !verifier.code !13

._crit_edge:                                      ; preds = %18
  br label %26, !dbg !44, !verifier.code !13

26:                                               ; preds = %._crit_edge, %15
  ret i32 0, !dbg !55, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal void @append(%struct.item** %0) #0 !dbg !56 {
  call void @llvm.dbg.value(metadata %struct.item** %0, metadata !60, metadata !DIExpression()), !dbg !61, !verifier.code !13
  %2 = call noalias i8* @malloc(i64 16) #6, !dbg !62, !verifier.code !13
  %3 = bitcast i8* %2 to %struct.item*, !dbg !62, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.item* %3, metadata !63, metadata !DIExpression()), !dbg !61, !verifier.code !13
  %4 = load %struct.item*, %struct.item** %0, align 8, !dbg !64, !verifier.code !13
  %5 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 0, !dbg !65, !verifier.code !13
  store %struct.item* %4, %struct.item** %5, align 8, !dbg !66, !verifier.code !13
  %6 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 0, !dbg !67, !verifier.code !13
  %7 = load %struct.item*, %struct.item** %6, align 8, !dbg !67, !verifier.code !13
  %8 = icmp ne %struct.item* %7, null, !dbg !68, !verifier.code !13
  br i1 %8, label %9, label %15, !dbg !68, !verifier.code !13

9:                                                ; preds = %1
  %10 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 0, !dbg !69, !verifier.code !13
  %11 = load %struct.item*, %struct.item** %10, align 8, !dbg !69, !verifier.code !13
  %12 = getelementptr inbounds %struct.item, %struct.item* %11, i32 0, i32 1, !dbg !70, !verifier.code !13
  %13 = load %struct.item*, %struct.item** %12, align 8, !dbg !70, !verifier.code !13
  %14 = bitcast %struct.item* %13 to i8*, !dbg !71, !verifier.code !13
  br label %17, !dbg !68, !verifier.code !13

15:                                               ; preds = %1
  %16 = call noalias i8* @malloc(i64 16) #6, !dbg !72, !verifier.code !13
  br label %17, !dbg !68, !verifier.code !13

17:                                               ; preds = %15, %9
  %18 = phi i8* [ %14, %9 ], [ %16, %15 ], !dbg !68, !verifier.code !13
  %19 = bitcast i8* %18 to %struct.item*, !dbg !68, !verifier.code !13
  %20 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 1, !dbg !73, !verifier.code !13
  store %struct.item* %19, %struct.item** %20, align 8, !dbg !74, !verifier.code !13
  store %struct.item* %3, %struct.item** %0, align 8, !dbg !75, !verifier.code !13
  ret void, !dbg !76, !verifier.code !13
}

declare dso_local i32 @__VERIFIER_nondet_int() #3

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #4

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "svcomp/memsafety/test-0232-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "reach_error", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 3, column: 22, scope: !11)
!11 = distinct !DILexicalBlock(scope: !12, file: !1, line: 3, column: 22)
!12 = distinct !DILexicalBlock(scope: !7, file: !1, line: 3, column: 22)
!13 = !{i1 false}
!14 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 27, type: !15, scopeLine: 28, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocalVariable(name: "list", scope: !14, file: !1, line: 29, type: !19)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "item", file: !1, line: 9, size: 128, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !20, file: !1, line: 10, baseType: !19, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !20, file: !1, line: 11, baseType: !19, size: 64, offset: 64)
!24 = !DILocation(line: 29, column: 18, scope: !14)
!25 = !DILocation(line: 32, column: 5, scope: !14)
!26 = !DILocation(line: 33, column: 9, scope: !14)
!27 = !DILocation(line: 34, column: 12, scope: !14)
!28 = !{i1 true}
!29 = distinct !{!29, !25, !30}
!30 = !DILocation(line: 34, column: 35, scope: !14)
!31 = !DILocation(line: 37, column: 9, scope: !32)
!32 = distinct !DILexicalBlock(scope: !14, file: !1, line: 37, column: 9)
!33 = !DILocation(line: 37, column: 9, scope: !14)
!34 = !DILocation(line: 38, column: 29, scope: !35)
!35 = distinct !DILexicalBlock(scope: !32, file: !1, line: 37, column: 15)
!36 = !DILocation(line: 38, column: 35, scope: !35)
!37 = !DILocalVariable(name: "next", scope: !35, file: !1, line: 38, type: !19)
!38 = !DILocation(line: 0, scope: !35)
!39 = !DILocation(line: 39, column: 14, scope: !35)
!40 = !DILocation(line: 39, column: 9, scope: !35)
!41 = !DILocation(line: 40, column: 14, scope: !35)
!42 = !DILocation(line: 41, column: 5, scope: !35)
!43 = !DILocation(line: 43, column: 12, scope: !14)
!44 = !DILocation(line: 43, column: 5, scope: !14)
!45 = !DILocation(line: 44, column: 29, scope: !46)
!46 = distinct !DILexicalBlock(scope: !14, file: !1, line: 43, column: 18)
!47 = !DILocation(line: 44, column: 35, scope: !46)
!48 = !DILocalVariable(name: "next", scope: !46, file: !1, line: 44, type: !19)
!49 = !DILocation(line: 0, scope: !46)
!50 = !DILocation(line: 45, column: 14, scope: !46)
!51 = !DILocation(line: 45, column: 9, scope: !46)
!52 = !DILocation(line: 46, column: 14, scope: !46)
!53 = distinct !{!53, !44, !54}
!54 = !DILocation(line: 47, column: 5, scope: !14)
!55 = !DILocation(line: 49, column: 5, scope: !14)
!56 = distinct !DISubprogram(name: "append", scope: !1, file: !1, line: 14, type: !57, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!57 = !DISubroutineType(types: !58)
!58 = !{null, !59}
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!60 = !DILocalVariable(name: "plist", arg: 1, scope: !56, file: !1, line: 14, type: !59)
!61 = !DILocation(line: 0, scope: !56)
!62 = !DILocation(line: 16, column: 25, scope: !56)
!63 = !DILocalVariable(name: "item", scope: !56, file: !1, line: 16, type: !19)
!64 = !DILocation(line: 17, column: 18, scope: !56)
!65 = !DILocation(line: 17, column: 11, scope: !56)
!66 = !DILocation(line: 17, column: 16, scope: !56)
!67 = !DILocation(line: 20, column: 25, scope: !56)
!68 = !DILocation(line: 20, column: 18, scope: !56)
!69 = !DILocation(line: 21, column: 17, scope: !56)
!70 = !DILocation(line: 21, column: 23, scope: !56)
!71 = !DILocation(line: 21, column: 11, scope: !56)
!72 = !DILocation(line: 22, column: 11, scope: !56)
!73 = !DILocation(line: 20, column: 11, scope: !56)
!74 = !DILocation(line: 20, column: 16, scope: !56)
!75 = !DILocation(line: 24, column: 12, scope: !56)
!76 = !DILocation(line: 25, column: 1, scope: !56)
