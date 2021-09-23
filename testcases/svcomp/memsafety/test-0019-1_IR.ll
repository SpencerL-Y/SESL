; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-qvlcbaqp.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0019-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !7 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !11, !verifier.code !14
  unreachable, !dbg !11, !verifier.code !14
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !15 {
  %1 = alloca %struct.TData, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !19, metadata !DIExpression()), !dbg !26, !verifier.code !14
  call void @alloc_data(%struct.TData* %1), !dbg !27, !verifier.code !14
  %2 = bitcast %struct.TData* %1 to { i8*, i8* }*, !dbg !28, !verifier.code !14
  %3 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 0, !dbg !28, !verifier.code !14
  %4 = load i8*, i8** %3, align 8, !dbg !28, !verifier.code !14
  %5 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %2, i32 0, i32 1, !dbg !28, !verifier.code !14
  %6 = load i8*, i8** %5, align 8, !dbg !28, !verifier.code !14
  call void @free_data(i8* %4, i8* %6), !dbg !28, !verifier.code !14
  ret i32 0, !dbg !29, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal void @alloc_data(%struct.TData* %0) #0 !dbg !30 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !34, metadata !DIExpression()), !dbg !35, !verifier.code !14
  %2 = call noalias i8* @malloc(i64 16) #5, !dbg !36, !verifier.code !14
  %3 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !37, !verifier.code !14
  store i8* %2, i8** %3, align 8, !dbg !38, !verifier.code !14
  %4 = call noalias i8* @malloc(i64 24) #5, !dbg !39, !verifier.code !14
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !40, !verifier.code !14
  store i8* %4, i8** %5, align 8, !dbg !41, !verifier.code !14
  ret void, !dbg !42, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @free_data(i8* %0, i8* %1) #0 !dbg !43 {
  %3 = alloca %struct.TData, align 8, !verifier.code !14
  %4 = bitcast %struct.TData* %3 to { i8*, i8* }*, !verifier.code !14
  %5 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %4, i32 0, i32 0, !verifier.code !14
  store i8* %0, i8** %5, align 8, !verifier.code !14
  %6 = getelementptr inbounds { i8*, i8* }, { i8*, i8* }* %4, i32 0, i32 1, !verifier.code !14
  store i8* %1, i8** %6, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.TData* %3, metadata !46, metadata !DIExpression()), !dbg !47, !verifier.code !14
  %7 = getelementptr inbounds %struct.TData, %struct.TData* %3, i32 0, i32 0, !dbg !48, !verifier.code !14
  %8 = load i8*, i8** %7, align 8, !dbg !48, !verifier.code !14
  call void @llvm.dbg.value(metadata i8* %8, metadata !49, metadata !DIExpression()), !dbg !50, !verifier.code !14
  %9 = getelementptr inbounds %struct.TData, %struct.TData* %3, i32 0, i32 1, !dbg !51, !verifier.code !14
  %10 = load i8*, i8** %9, align 8, !dbg !51, !verifier.code !14
  call void @llvm.dbg.value(metadata i8* %10, metadata !52, metadata !DIExpression()), !dbg !50, !verifier.code !14
  %11 = icmp eq i8* %8, %10, !dbg !53, !verifier.code !14
  br i1 %11, label %12, label %13, !dbg !55, !verifier.code !14

12:                                               ; preds = %2
  br label %14, !dbg !56, !verifier.code !14

13:                                               ; preds = %2
  call void @free(i8* %8) #5, !dbg !57, !verifier.code !14
  call void @free(i8* %10) #5, !dbg !58, !verifier.code !14
  br label %14, !dbg !59, !verifier.code !14

14:                                               ; preds = %13, %12
  ret void, !dbg !59, !verifier.code !14
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/memsafety/test-0019-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "reach_error", scope: !8, file: !8, line: 3, type: !9, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "../svcomp/memsafety//test-0019-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !DISubroutineType(types: !10)
!10 = !{null}
!11 = !DILocation(line: 3, column: 22, scope: !12)
!12 = distinct !DILexicalBlock(scope: !13, file: !8, line: 3, column: 22)
!13 = distinct !DILexicalBlock(scope: !7, file: !8, line: 3, column: 22)
!14 = !{i1 false}
!15 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 30, type: !16, scopeLine: 30, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "data", scope: !15, file: !8, line: 31, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !8, line: 10, baseType: !21)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !8, line: 7, size: 128, elements: !22)
!22 = !{!23, !25}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !21, file: !8, line: 8, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !21, file: !8, line: 9, baseType: !24, size: 64, offset: 64)
!26 = !DILocation(line: 31, column: 11, scope: !15)
!27 = !DILocation(line: 32, column: 5, scope: !15)
!28 = !DILocation(line: 33, column: 5, scope: !15)
!29 = !DILocation(line: 34, column: 5, scope: !15)
!30 = distinct !DISubprogram(name: "alloc_data", scope: !8, file: !8, line: 12, type: !31, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{null, !33}
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!34 = !DILocalVariable(name: "pdata", arg: 1, scope: !30, file: !8, line: 12, type: !33)
!35 = !DILocation(line: 0, scope: !30)
!36 = !DILocation(line: 14, column: 17, scope: !30)
!37 = !DILocation(line: 14, column: 12, scope: !30)
!38 = !DILocation(line: 14, column: 15, scope: !30)
!39 = !DILocation(line: 15, column: 17, scope: !30)
!40 = !DILocation(line: 15, column: 12, scope: !30)
!41 = !DILocation(line: 15, column: 15, scope: !30)
!42 = !DILocation(line: 16, column: 1, scope: !30)
!43 = distinct !DISubprogram(name: "free_data", scope: !8, file: !8, line: 18, type: !44, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!44 = !DISubroutineType(types: !45)
!45 = !{null, !20}
!46 = !DILocalVariable(name: "data", arg: 1, scope: !43, file: !8, line: 18, type: !20)
!47 = !DILocation(line: 18, column: 29, scope: !43)
!48 = !DILocation(line: 20, column: 21, scope: !43)
!49 = !DILocalVariable(name: "lo", scope: !43, file: !8, line: 20, type: !24)
!50 = !DILocation(line: 0, scope: !43)
!51 = !DILocation(line: 21, column: 21, scope: !43)
!52 = !DILocalVariable(name: "hi", scope: !43, file: !8, line: 21, type: !24)
!53 = !DILocation(line: 23, column: 12, scope: !54)
!54 = distinct !DILexicalBlock(scope: !43, file: !8, line: 23, column: 9)
!55 = !DILocation(line: 23, column: 9, scope: !43)
!56 = !DILocation(line: 24, column: 9, scope: !54)
!57 = !DILocation(line: 26, column: 5, scope: !43)
!58 = !DILocation(line: 27, column: 5, scope: !43)
!59 = !DILocation(line: 28, column: 1, scope: !43)
