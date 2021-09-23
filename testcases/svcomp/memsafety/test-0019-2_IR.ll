; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-6rqx6wpf.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0019-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.1, i64 0, i64 0), i32 4, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !13, !verifier.code !16
  unreachable, !dbg !13, !verifier.code !16
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !17 {
  %1 = alloca %struct.TData, align 8, !verifier.code !16
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !21, metadata !DIExpression()), !dbg !27, !verifier.code !16
  call void @alloc_data(%struct.TData* %1), !dbg !28, !verifier.code !16
  call void @free_data(%struct.TData* %1), !dbg !29, !verifier.code !16
  ret i32 0, !dbg !30, !verifier.code !16
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal void @alloc_data(%struct.TData* %0) #0 !dbg !31 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !35, metadata !DIExpression()), !dbg !36, !verifier.code !16
  %2 = call noalias i8* @malloc(i64 16) #5, !dbg !37, !verifier.code !16
  %3 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !38, !verifier.code !16
  store i8* %2, i8** %3, align 8, !dbg !39, !verifier.code !16
  %4 = call noalias i8* @malloc(i64 24) #5, !dbg !40, !verifier.code !16
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !41, !verifier.code !16
  store i8* %4, i8** %5, align 8, !dbg !42, !verifier.code !16
  ret void, !dbg !43, !verifier.code !16
}

; Function Attrs: noinline nounwind uwtable
define internal void @free_data(%struct.TData* %0) #0 !dbg !44 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !16
  %2 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !47, !verifier.code !16
  %3 = load i8*, i8** %2, align 8, !dbg !47, !verifier.code !16
  call void @llvm.dbg.value(metadata i8* %3, metadata !48, metadata !DIExpression()), !dbg !46, !verifier.code !16
  %4 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !49, !verifier.code !16
  %5 = load i8*, i8** %4, align 8, !dbg !49, !verifier.code !16
  call void @llvm.dbg.value(metadata i8* %5, metadata !50, metadata !DIExpression()), !dbg !46, !verifier.code !16
  %6 = icmp eq i8* %3, %5, !dbg !51, !verifier.code !16
  br i1 %6, label %7, label %8, !dbg !53, !verifier.code !16

7:                                                ; preds = %1
  call void @free(i8* %3) #5, !dbg !54, !verifier.code !16
  call void @free(i8* %5) #5, !dbg !56, !verifier.code !16
  br label %8, !dbg !57, !verifier.code !16

8:                                                ; preds = %7, %1
  %9 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !58, !verifier.code !16
  store i8* null, i8** %9, align 8, !dbg !59, !verifier.code !16
  %10 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !60, !verifier.code !16
  store i8* null, i8** %10, align 8, !dbg !61, !verifier.code !16
  ret void, !dbg !62, !verifier.code !16
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
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/memsafety/test-0019-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !10, file: !10, line: 4, type: !11, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DIFile(filename: "../svcomp/memsafety//test-0019-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 4, column: 22, scope: !14)
!14 = distinct !DILexicalBlock(scope: !15, file: !10, line: 4, column: 22)
!15 = distinct !DILexicalBlock(scope: !9, file: !10, line: 4, column: 22)
!16 = !{i1 false}
!17 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 33, type: !18, scopeLine: 33, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DISubroutineType(types: !19)
!19 = !{!20}
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DILocalVariable(name: "data", scope: !17, file: !10, line: 34, type: !22)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !10, line: 11, baseType: !23)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !10, line: 8, size: 128, elements: !24)
!24 = !{!25, !26}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !23, file: !10, line: 9, baseType: !4, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !23, file: !10, line: 10, baseType: !4, size: 64, offset: 64)
!27 = !DILocation(line: 34, column: 11, scope: !17)
!28 = !DILocation(line: 35, column: 5, scope: !17)
!29 = !DILocation(line: 36, column: 5, scope: !17)
!30 = !DILocation(line: 37, column: 5, scope: !17)
!31 = distinct !DISubprogram(name: "alloc_data", scope: !10, file: !10, line: 13, type: !32, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !34}
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!35 = !DILocalVariable(name: "pdata", arg: 1, scope: !31, file: !10, line: 13, type: !34)
!36 = !DILocation(line: 0, scope: !31)
!37 = !DILocation(line: 15, column: 17, scope: !31)
!38 = !DILocation(line: 15, column: 12, scope: !31)
!39 = !DILocation(line: 15, column: 15, scope: !31)
!40 = !DILocation(line: 16, column: 17, scope: !31)
!41 = !DILocation(line: 16, column: 12, scope: !31)
!42 = !DILocation(line: 16, column: 15, scope: !31)
!43 = !DILocation(line: 17, column: 1, scope: !31)
!44 = distinct !DISubprogram(name: "free_data", scope: !10, file: !10, line: 19, type: !32, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!45 = !DILocalVariable(name: "data", arg: 1, scope: !44, file: !10, line: 19, type: !34)
!46 = !DILocation(line: 0, scope: !44)
!47 = !DILocation(line: 21, column: 22, scope: !44)
!48 = !DILocalVariable(name: "lo", scope: !44, file: !10, line: 21, type: !4)
!49 = !DILocation(line: 22, column: 22, scope: !44)
!50 = !DILocalVariable(name: "hi", scope: !44, file: !10, line: 22, type: !4)
!51 = !DILocation(line: 24, column: 12, scope: !52)
!52 = distinct !DILexicalBlock(scope: !44, file: !10, line: 24, column: 9)
!53 = !DILocation(line: 24, column: 9, scope: !44)
!54 = !DILocation(line: 25, column: 9, scope: !55)
!55 = distinct !DILexicalBlock(scope: !52, file: !10, line: 24, column: 19)
!56 = !DILocation(line: 26, column: 9, scope: !55)
!57 = !DILocation(line: 27, column: 5, scope: !55)
!58 = !DILocation(line: 29, column: 11, scope: !44)
!59 = !DILocation(line: 29, column: 14, scope: !44)
!60 = !DILocation(line: 30, column: 11, scope: !44)
!61 = !DILocation(line: 30, column: 14, scope: !44)
!62 = !DILocation(line: 31, column: 1, scope: !44)
