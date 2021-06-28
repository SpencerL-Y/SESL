; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-zlu73utw.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.test = type { i32, i8, %struct.test* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca %struct.test, align 8, !verifier.code !11
  call void @llvm.dbg.declare(metadata %struct.test* %1, metadata !12, metadata !DIExpression()), !dbg !21, !verifier.code !11
  %2 = getelementptr inbounds %struct.test, %struct.test* %1, i32 0, i32 0, !dbg !22, !verifier.code !11
  store i32 0, i32* %2, align 8, !dbg !23, !verifier.code !11
  %3 = getelementptr inbounds %struct.test, %struct.test* %1, i32 0, i32 1, !dbg !24, !verifier.code !11
  store i8 100, i8* %3, align 4, !dbg !25, !verifier.code !11
  %4 = getelementptr inbounds %struct.test, %struct.test* %1, i32 0, i32 1, !dbg !26, !verifier.code !11
  %5 = load i8, i8* %4, align 4, !dbg !26, !verifier.code !11
  %6 = sext i8 %5 to i32, !dbg !27, !verifier.code !11
  call void @llvm.dbg.value(metadata i32 %6, metadata !28, metadata !DIExpression()), !dbg !29, !verifier.code !11
  ret i32 0, !dbg !30, !verifier.code !11
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !8, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i1 false}
!12 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 35, type: !13)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "test_type", file: !1, line: 8, baseType: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "test", file: !1, line: 4, size: 128, elements: !15)
!15 = !{!16, !17, !19}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !14, file: !1, line: 5, baseType: !10, size: 32)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !14, file: !1, line: 6, baseType: !18, size: 8, offset: 32)
!18 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !1, line: 7, baseType: !20, size: 64, offset: 64)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!21 = !DILocation(line: 35, column: 15, scope: !7)
!22 = !DILocation(line: 36, column: 7, scope: !7)
!23 = !DILocation(line: 36, column: 9, scope: !7)
!24 = !DILocation(line: 37, column: 7, scope: !7)
!25 = !DILocation(line: 37, column: 9, scope: !7)
!26 = !DILocation(line: 38, column: 15, scope: !7)
!27 = !DILocation(line: 38, column: 13, scope: !7)
!28 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 38, type: !10)
!29 = !DILocation(line: 0, scope: !7)
!30 = !DILocation(line: 46, column: 1, scope: !7)
