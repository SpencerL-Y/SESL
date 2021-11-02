; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build/b-6p6mw4ok.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { i32, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = call i32 @foo(), !dbg !11, !verifier.code !12
  ret i32 0, !dbg !13, !verifier.code !12
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @foo() #0 !dbg !14 {
  %1 = alloca %struct.node, align 4, !verifier.code !12
  %2 = call noalias i8* @malloc(i64 4) #3, !dbg !15, !verifier.code !12
  %3 = bitcast i8* %2 to i32*, !dbg !15, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* %3, metadata !16, metadata !DIExpression()), !dbg !18, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* null, metadata !16, metadata !DIExpression()), !dbg !18, !verifier.code !12
  call void @llvm.dbg.declare(metadata %struct.node* %1, metadata !19, metadata !DIExpression()), !dbg !25, !verifier.code !12
  %4 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 0, !dbg !26, !verifier.code !12
  store i32 10, i32* %4, align 4, !dbg !27, !verifier.code !12
  %5 = getelementptr inbounds %struct.node, %struct.node* %1, i32 0, i32 0, !dbg !28, !verifier.code !12
  %6 = load i32, i32* %5, align 4, !dbg !28, !verifier.code !12
  call void @none(i32 %6), !dbg !29, !verifier.code !12
  ret i32 0, !dbg !30, !verifier.code !12
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal void @none(i32 %0) #0 !dbg !31 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !34, metadata !DIExpression()), !dbg !35, !verifier.code !12
  ret void, !dbg !36, !verifier.code !12
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

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
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !8, scopeLine: 8, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 9, column: 5, scope: !7)
!12 = !{i1 false}
!13 = !DILocation(line: 10, column: 5, scope: !7)
!14 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 16, type: !8, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DILocation(line: 17, column: 14, scope: !14)
!16 = !DILocalVariable(name: "j", scope: !14, file: !1, line: 17, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!18 = !DILocation(line: 0, scope: !14)
!19 = !DILocalVariable(name: "node", scope: !14, file: !1, line: 19, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "node_t", file: !1, line: 6, baseType: !21)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !1, line: 3, size: 64, elements: !22)
!22 = !{!23, !24}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !21, file: !1, line: 4, baseType: !10, size: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !21, file: !1, line: 5, baseType: !10, size: 32, offset: 32)
!25 = !DILocation(line: 19, column: 12, scope: !14)
!26 = !DILocation(line: 20, column: 10, scope: !14)
!27 = !DILocation(line: 20, column: 12, scope: !14)
!28 = !DILocation(line: 21, column: 15, scope: !14)
!29 = !DILocation(line: 21, column: 5, scope: !14)
!30 = !DILocation(line: 22, column: 5, scope: !14)
!31 = distinct !DISubprogram(name: "none", scope: !1, file: !1, line: 12, type: !32, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !10}
!34 = !DILocalVariable(name: "a", arg: 1, scope: !31, file: !1, line: 12, type: !10)
!35 = !DILocation(line: 0, scope: !31)
!36 = !DILocation(line: 14, column: 1, scope: !31)
