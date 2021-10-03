; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-0glp9cwe.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { i32*, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = call noalias i8* @malloc(i64 16) #3, !dbg !11, !verifier.code !12
  %2 = bitcast i8* %1 to %struct.node*, !dbg !11, !verifier.code !12
  call void @llvm.dbg.value(metadata %struct.node* %2, metadata !13, metadata !DIExpression()), !dbg !21, !verifier.code !12
  %3 = call noalias i8* @malloc(i64 1) #3, !dbg !22, !verifier.code !12
  %4 = bitcast i8* %3 to i32*, !dbg !22, !verifier.code !12
  %5 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !23, !verifier.code !12
  store i32* %4, i32** %5, align 8, !dbg !24, !verifier.code !12
  %6 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !25, !verifier.code !12
  %7 = load i32*, i32** %6, align 8, !dbg !25, !verifier.code !12
  %8 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 1, !dbg !27, !verifier.code !12
  %9 = icmp eq i32* %7, %8, !dbg !28, !verifier.code !12
  br i1 %9, label %10, label %13, !dbg !29, !verifier.code !12

10:                                               ; preds = %0
  %11 = call noalias i8* @malloc(i64 1123123) #3, !dbg !30, !verifier.code !12
  %12 = bitcast i8* %11 to i32*, !dbg !30, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* %12, metadata !32, metadata !DIExpression()), !dbg !33, !verifier.code !12
  br label %13, !dbg !34, !verifier.code !12

13:                                               ; preds = %10, %0
  %14 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !35, !verifier.code !12
  %15 = load i32*, i32** %14, align 8, !dbg !35, !verifier.code !12
  %16 = bitcast i32* %15 to i8*, !dbg !36, !verifier.code !12
  call void @free(i8* %16) #3, !dbg !37, !verifier.code !12
  %17 = bitcast %struct.node* %2 to i8*, !dbg !38, !verifier.code !12
  call void @free(i8* %17) #3, !dbg !39, !verifier.code !12
  ret i32 0, !dbg !40, !verifier.code !12
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

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
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 159, type: !8, scopeLine: 159, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 161, column: 20, scope: !7)
!12 = !{i1 false}
!13 = !DILocalVariable(name: "node", scope: !7, file: !1, line: 161, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "Node_t", file: !1, line: 157, baseType: !16)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !1, line: 154, size: 128, elements: !17)
!17 = !{!18, !20}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "p", scope: !16, file: !1, line: 155, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !16, file: !1, line: 156, baseType: !10, size: 32, offset: 64)
!21 = !DILocation(line: 0, scope: !7)
!22 = !DILocation(line: 162, column: 15, scope: !7)
!23 = !DILocation(line: 162, column: 11, scope: !7)
!24 = !DILocation(line: 162, column: 13, scope: !7)
!25 = !DILocation(line: 163, column: 14, scope: !26)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 163, column: 8)
!27 = !DILocation(line: 163, column: 26, scope: !26)
!28 = !DILocation(line: 163, column: 16, scope: !26)
!29 = !DILocation(line: 163, column: 8, scope: !7)
!30 = !DILocation(line: 164, column: 18, scope: !31)
!31 = distinct !DILexicalBlock(scope: !26, file: !1, line: 163, column: 28)
!32 = !DILocalVariable(name: "k", scope: !31, file: !1, line: 164, type: !19)
!33 = !DILocation(line: 0, scope: !31)
!34 = !DILocation(line: 165, column: 5, scope: !31)
!35 = !DILocation(line: 166, column: 16, scope: !7)
!36 = !DILocation(line: 166, column: 10, scope: !7)
!37 = !DILocation(line: 166, column: 5, scope: !7)
!38 = !DILocation(line: 167, column: 10, scope: !7)
!39 = !DILocation(line: 167, column: 5, scope: !7)
!40 = !DILocation(line: 168, column: 5, scope: !7)
