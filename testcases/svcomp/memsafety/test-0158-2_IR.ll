; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-o6571nqa.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%union.anon = type { %struct.anon }
%struct.anon = type { [2 x i8], i8*, i8* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca %union.anon, align 8, !verifier.code !11
  call void @llvm.dbg.declare(metadata %union.anon* %1, metadata !12, metadata !DIExpression()), !dbg !27, !verifier.code !11
  %2 = call noalias i8* @malloc(i64 37) #3, !dbg !28, !verifier.code !11
  %3 = bitcast %union.anon* %1 to i8**, !dbg !29, !verifier.code !11
  store i8* %2, i8** %3, align 8, !dbg !30, !verifier.code !11
  %4 = bitcast %union.anon* %1 to i8*, !dbg !31, !verifier.code !11
  %5 = bitcast %union.anon* %1 to %struct.anon*, !dbg !32, !verifier.code !11
  %6 = getelementptr inbounds %struct.anon, %struct.anon* %5, i32 0, i32 2, !dbg !33, !verifier.code !11
  store i8* %4, i8** %6, align 8, !dbg !34, !verifier.code !11
  %7 = bitcast %union.anon* %1 to %struct.anon*, !dbg !35, !verifier.code !11
  %8 = getelementptr inbounds %struct.anon, %struct.anon* %7, i32 0, i32 0, !dbg !36, !verifier.code !11
  %9 = getelementptr inbounds %struct.anon, %struct.anon* %7, i32 0, i32 0, i64 1
  store i8 8, i8* %9, align 1, !dbg !37, !verifier.code !11
  ret i32 0, !dbg !38, !verifier.code !11
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0158-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i1 false}
!12 = !DILocalVariable(name: "data", scope: !7, file: !1, line: 18, type: !13)
!13 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !7, file: !1, line: 9, size: 192, elements: !14)
!14 = !{!15, !17}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "p0", scope: !13, file: !1, line: 10, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "str", scope: !13, file: !1, line: 16, baseType: !18, size: 192)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !13, file: !1, line: 12, size: 192, elements: !19)
!19 = !{!20, !25, !26}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !18, file: !1, line: 13, baseType: !21, size: 16)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 16, elements: !23)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !{!24}
!24 = !DISubrange(count: 2)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "p1", scope: !18, file: !1, line: 14, baseType: !16, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "p2", scope: !18, file: !1, line: 15, baseType: !16, size: 64, offset: 128)
!27 = !DILocation(line: 18, column: 7, scope: !7)
!28 = !DILocation(line: 21, column: 15, scope: !7)
!29 = !DILocation(line: 21, column: 10, scope: !7)
!30 = !DILocation(line: 21, column: 13, scope: !7)
!31 = !DILocation(line: 24, column: 19, scope: !7)
!32 = !DILocation(line: 24, column: 10, scope: !7)
!33 = !DILocation(line: 24, column: 14, scope: !7)
!34 = !DILocation(line: 24, column: 17, scope: !7)
!35 = !DILocation(line: 27, column: 10, scope: !7)
!36 = !DILocation(line: 27, column: 14, scope: !7)
!37 = !DILocation(line: 27, column: 19, scope: !7)
!38 = !DILocation(line: 29, column: 5, scope: !7)
