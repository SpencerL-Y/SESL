; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/b-31ikvufh.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = internal global [8 x i8] zeroinitializer, align 1, !dbg !0
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [41 x i8] c"svcomp/memsafety/test-memleak_nexttime.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !17 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !20, !verifier.code !23
  unreachable, !dbg !20, !verifier.code !23
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @foo() #0 !dbg !24 {
  %1 = alloca i32*, align 8, !verifier.code !23
  call void @llvm.dbg.declare(metadata i32** %1, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  %2 = call noalias i8* @malloc(i64 10) #6, !dbg !27, !verifier.code !23
  %3 = bitcast i8* %2 to i32*, !dbg !28, !verifier.code !23
  store i32* %3, i32** %1, align 8, !dbg !26, !verifier.code !23
  %4 = bitcast i32** %1 to i8*, !dbg !29, !verifier.code !23
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 getelementptr inbounds ([8 x i8], [8 x i8]* @a, i64 0, i64 0), i8* align 8 %4, i64 8, i1 false), !dbg !29, !verifier.code !23
  ret void, !dbg !30, !verifier.code !23
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #4

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !31 {
  %1 = alloca i8*, align 8, !verifier.code !23
  call void @foo(), !dbg !34, !verifier.code !23
  call void @llvm.dbg.declare(metadata i8** %1, metadata !35, metadata !DIExpression()), !dbg !37, !verifier.code !23
  %2 = bitcast i8** %1 to i8*, !dbg !38, !verifier.code !23
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %2, i8* align 1 getelementptr inbounds ([8 x i8], [8 x i8]* @a, i64 0, i64 0), i64 8, i1 false), !dbg !38, !verifier.code !23
  %3 = load i8*, i8** %1, align 8, !dbg !39, !verifier.code !23
  call void @free(i8* %3) #6, !dbg !40, !verifier.code !23
  ret i32 0, !dbg !41, !verifier.code !23
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

define void @__SMACK_static_init() {
entry:
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 0)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 1)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 2)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 3)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 4)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 5)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 6)
  store i8 0, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @a, i32 0, i64 7)
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind willreturn }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!13}
!llvm.module.flags = !{!14, !15, !16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 11, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !8, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "svcomp/memsafety/test-memleak_nexttime.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!8 = !{!0}
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 64, elements: !11)
!10 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!11 = !{!12}
!12 = !DISubrange(count: 8)
!13 = !{!"clang version 10.0.0-4ubuntu1 "}
!14 = !{i32 7, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !18, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{null}
!20 = !DILocation(line: 3, column: 22, scope: !21)
!21 = distinct !DILexicalBlock(scope: !22, file: !3, line: 3, column: 22)
!22 = distinct !DILexicalBlock(scope: !17, file: !3, line: 3, column: 22)
!23 = !{i1 false}
!24 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 12, type: !18, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!25 = !DILocalVariable(name: "p", scope: !24, file: !3, line: 14, type: !6)
!26 = !DILocation(line: 14, column: 9, scope: !24)
!27 = !DILocation(line: 14, column: 20, scope: !24)
!28 = !DILocation(line: 14, column: 13, scope: !24)
!29 = !DILocation(line: 15, column: 4, scope: !24)
!30 = !DILocation(line: 16, column: 1, scope: !24)
!31 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 18, type: !32, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!32 = !DISubroutineType(types: !33)
!33 = !{!7}
!34 = !DILocation(line: 20, column: 4, scope: !31)
!35 = !DILocalVariable(name: "p", scope: !31, file: !3, line: 21, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!37 = !DILocation(line: 21, column: 10, scope: !31)
!38 = !DILocation(line: 22, column: 4, scope: !31)
!39 = !DILocation(line: 23, column: 9, scope: !31)
!40 = !DILocation(line: 23, column: 4, scope: !31)
!41 = !DILocation(line: 24, column: 1, scope: !31)
