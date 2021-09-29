; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-43u1epek.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.anon = type { %struct.anon }
%struct.anon = type { [2 x i8], i8*, i8* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [44 x i8] c"../testcases/svcomp/memsafety/test-0158-3.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !7 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !10, !verifier.code !13
  unreachable, !dbg !10, !verifier.code !13
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !14 {
  %1 = alloca %union.anon, align 8, !verifier.code !13
  call void @llvm.dbg.declare(metadata %union.anon* %1, metadata !18, metadata !DIExpression()), !dbg !33, !verifier.code !13
  %2 = call noalias i8* @malloc(i64 37) #5, !dbg !34, !verifier.code !13
  %3 = bitcast %union.anon* %1 to i8**, !dbg !35, !verifier.code !13
  store i8* %2, i8** %3, align 8, !dbg !36, !verifier.code !13
  %4 = bitcast %union.anon* %1 to i8*, !dbg !37, !verifier.code !13
  %5 = bitcast %union.anon* %1 to %struct.anon*, !dbg !38, !verifier.code !13
  %6 = getelementptr inbounds %struct.anon, %struct.anon* %5, i32 0, i32 2, !dbg !39, !verifier.code !13
  store i8* %4, i8** %6, align 8, !dbg !40, !verifier.code !13
  %7 = bitcast %union.anon* %1 to i8**, !dbg !41, !verifier.code !13
  %8 = load i8*, i8** %7, align 8, !dbg !41, !verifier.code !13
  call void @llvm.dbg.value(metadata i8* %8, metadata !42, metadata !DIExpression()), !dbg !43, !verifier.code !13
  %9 = bitcast %union.anon* %1 to %struct.anon*, !dbg !44, !verifier.code !13
  %10 = getelementptr inbounds %struct.anon, %struct.anon* %9, i32 0, i32 0, !dbg !45, !verifier.code !13
  %11 = getelementptr inbounds %struct.anon, %struct.anon* %9, i32 0, i32 0, i64 1
  store i8 8, i8* %11, align 1, !dbg !46, !verifier.code !13
  %12 = bitcast %union.anon* %1 to i8**, !dbg !47, !verifier.code !13
  %13 = load i8*, i8** %12, align 8, !dbg !47, !verifier.code !13
  call void @free(i8* %13) #5, !dbg !48, !verifier.code !13
  call void @free(i8* %8) #5, !dbg !49, !verifier.code !13
  ret i32 0, !dbg !50, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

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
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0158-3.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
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
!14 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !15, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocalVariable(name: "data", scope: !14, file: !1, line: 19, type: !19)
!19 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !14, file: !1, line: 10, size: 192, elements: !20)
!20 = !{!21, !23}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "p0", scope: !19, file: !1, line: 11, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "str", scope: !19, file: !1, line: 17, baseType: !24, size: 192)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !19, file: !1, line: 13, size: 192, elements: !25)
!25 = !{!26, !31, !32}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !24, file: !1, line: 14, baseType: !27, size: 16)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 16, elements: !29)
!28 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!29 = !{!30}
!30 = !DISubrange(count: 2)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "p1", scope: !24, file: !1, line: 15, baseType: !22, size: 64, offset: 64)
!32 = !DIDerivedType(tag: DW_TAG_member, name: "p2", scope: !24, file: !1, line: 16, baseType: !22, size: 64, offset: 128)
!33 = !DILocation(line: 19, column: 7, scope: !14)
!34 = !DILocation(line: 22, column: 15, scope: !14)
!35 = !DILocation(line: 22, column: 10, scope: !14)
!36 = !DILocation(line: 22, column: 13, scope: !14)
!37 = !DILocation(line: 25, column: 19, scope: !14)
!38 = !DILocation(line: 25, column: 10, scope: !14)
!39 = !DILocation(line: 25, column: 14, scope: !14)
!40 = !DILocation(line: 25, column: 17, scope: !14)
!41 = !DILocation(line: 28, column: 22, scope: !14)
!42 = !DILocalVariable(name: "ptr", scope: !14, file: !1, line: 28, type: !22)
!43 = !DILocation(line: 0, scope: !14)
!44 = !DILocation(line: 31, column: 10, scope: !14)
!45 = !DILocation(line: 31, column: 14, scope: !14)
!46 = !DILocation(line: 31, column: 19, scope: !14)
!47 = !DILocation(line: 32, column: 15, scope: !14)
!48 = !DILocation(line: 32, column: 5, scope: !14)
!49 = !DILocation(line: 34, column: 5, scope: !14)
!50 = !DILocation(line: 35, column: 5, scope: !14)
