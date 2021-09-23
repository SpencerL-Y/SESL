; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-0_75bc2g.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.anon = type { %struct.anon }
%struct.anon = type { [2 x i8], i8*, i8* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0158-2.c\00", align 1
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
  %1 = alloca %union.anon, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %union.anon* %1, metadata !19, metadata !DIExpression()), !dbg !34, !verifier.code !14
  %2 = call noalias i8* @malloc(i64 37) #5, !dbg !35, !verifier.code !14
  %3 = bitcast %union.anon* %1 to i8**, !dbg !36, !verifier.code !14
  store i8* %2, i8** %3, align 8, !dbg !37, !verifier.code !14
  %4 = bitcast %union.anon* %1 to i8*, !dbg !38, !verifier.code !14
  %5 = bitcast %union.anon* %1 to %struct.anon*, !dbg !39, !verifier.code !14
  %6 = getelementptr inbounds %struct.anon, %struct.anon* %5, i32 0, i32 2, !dbg !40, !verifier.code !14
  store i8* %4, i8** %6, align 8, !dbg !41, !verifier.code !14
  %7 = bitcast %union.anon* %1 to %struct.anon*, !dbg !42, !verifier.code !14
  %8 = getelementptr inbounds %struct.anon, %struct.anon* %7, i32 0, i32 0, !dbg !43, !verifier.code !14
  %9 = getelementptr inbounds %struct.anon, %struct.anon* %7, i32 0, i32 0, i64 1
  store i8 8, i8* %9, align 1, !dbg !44, !verifier.code !14
  ret i32 0, !dbg !45, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

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
!1 = !DIFile(filename: "../svcomp/memsafety/test-0158-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "reach_error", scope: !8, file: !8, line: 3, type: !9, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "../svcomp/memsafety//test-0158-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !DISubroutineType(types: !10)
!10 = !{null}
!11 = !DILocation(line: 3, column: 22, scope: !12)
!12 = distinct !DILexicalBlock(scope: !13, file: !8, line: 3, column: 22)
!13 = distinct !DILexicalBlock(scope: !7, file: !8, line: 3, column: 22)
!14 = !{i1 false}
!15 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 7, type: !16, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "data", scope: !15, file: !8, line: 18, type: !20)
!20 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !15, file: !8, line: 9, size: 192, elements: !21)
!21 = !{!22, !24}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "p0", scope: !20, file: !8, line: 10, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "str", scope: !20, file: !8, line: 16, baseType: !25, size: 192)
!25 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !20, file: !8, line: 12, size: 192, elements: !26)
!26 = !{!27, !32, !33}
!27 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !25, file: !8, line: 13, baseType: !28, size: 16)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 16, elements: !30)
!29 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!30 = !{!31}
!31 = !DISubrange(count: 2)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "p1", scope: !25, file: !8, line: 14, baseType: !23, size: 64, offset: 64)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "p2", scope: !25, file: !8, line: 15, baseType: !23, size: 64, offset: 128)
!34 = !DILocation(line: 18, column: 7, scope: !15)
!35 = !DILocation(line: 21, column: 15, scope: !15)
!36 = !DILocation(line: 21, column: 10, scope: !15)
!37 = !DILocation(line: 21, column: 13, scope: !15)
!38 = !DILocation(line: 24, column: 19, scope: !15)
!39 = !DILocation(line: 24, column: 10, scope: !15)
!40 = !DILocation(line: 24, column: 14, scope: !15)
!41 = !DILocation(line: 24, column: 17, scope: !15)
!42 = !DILocation(line: 27, column: 10, scope: !15)
!43 = !DILocation(line: 27, column: 14, scope: !15)
!44 = !DILocation(line: 27, column: 19, scope: !15)
!45 = !DILocation(line: 29, column: 5, scope: !15)
