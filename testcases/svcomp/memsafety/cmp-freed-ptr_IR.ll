; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-s9dyrt8m.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.T = type { %struct.T* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !11 {
  call void @llvm.dbg.value(metadata %struct.T* null, metadata !16, metadata !DIExpression()), !dbg !21, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.T* null, metadata !23, metadata !DIExpression()), !dbg !21, !verifier.code !22
  %1 = call noalias i8* @malloc(i64 8) #3, !dbg !24, !verifier.code !22
  %2 = bitcast i8* %1 to %struct.T*, !dbg !24, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.T* %2, metadata !23, metadata !DIExpression()), !dbg !21, !verifier.code !22
  %3 = ptrtoint %struct.T* %2 to i64, !dbg !25, !verifier.code !22
  call void @llvm.dbg.value(metadata i64 %3, metadata !26, metadata !DIExpression()), !dbg !21, !verifier.code !22
  %4 = bitcast %struct.T* %2 to i8*, !dbg !27, !verifier.code !22
  call void @free(i8* %4) #3, !dbg !28, !verifier.code !22
  %5 = call noalias i8* @malloc(i64 8) #3, !dbg !29, !verifier.code !22
  %6 = bitcast i8* %5 to %struct.T*, !dbg !29, !verifier.code !22
  call void @llvm.dbg.value(metadata %struct.T* %6, metadata !16, metadata !DIExpression()), !dbg !21, !verifier.code !22
  %7 = ptrtoint %struct.T* %6 to i64, !dbg !30, !verifier.code !22
  call void @llvm.dbg.value(metadata i64 %7, metadata !31, metadata !DIExpression()), !dbg !21, !verifier.code !22
  %8 = icmp eq i64 %7, %3, !dbg !32, !verifier.code !22
  br i1 %8, label %9, label %11, !dbg !34, !verifier.code !22

9:                                                ; preds = %0
  %10 = bitcast %struct.T* %6 to i8*, !dbg !35, !verifier.code !22
  call void @free(i8* %10) #3, !dbg !37, !verifier.code !22
  br label %11, !dbg !38, !verifier.code !22

11:                                               ; preds = %9, %0
  %12 = bitcast %struct.T* %6 to i8*, !dbg !39, !verifier.code !22
  call void @free(i8* %12) #3, !dbg !40, !verifier.code !22
  ret i32 0, !dbg !41, !verifier.code !22
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
!llvm.ident = !{!7}
!llvm.module.flags = !{!8, !9, !10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/memsafety/cmp-freed-ptr.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !5, line: 87, baseType: !6)
!5 = !DIFile(filename: "/usr/include/stdint.h", directory: "")
!6 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 4, type: !13, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DIFile(filename: "../svcomp/memsafety//cmp-freed-ptr.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!13 = !DISubroutineType(types: !14)
!14 = !{!15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "x", scope: !11, file: !12, line: 10, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "T", scope: !11, file: !12, line: 6, size: 64, elements: !19)
!19 = !{!20}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !18, file: !12, line: 7, baseType: !17, size: 64)
!21 = !DILocation(line: 0, scope: !11)
!22 = !{i1 false}
!23 = !DILocalVariable(name: "y", scope: !11, file: !12, line: 11, type: !17)
!24 = !DILocation(line: 13, column: 9, scope: !11)
!25 = !DILocation(line: 14, column: 24, scope: !11)
!26 = !DILocalVariable(name: "adressY", scope: !11, file: !12, line: 14, type: !4)
!27 = !DILocation(line: 16, column: 10, scope: !11)
!28 = !DILocation(line: 16, column: 5, scope: !11)
!29 = !DILocation(line: 18, column: 9, scope: !11)
!30 = !DILocation(line: 19, column: 24, scope: !11)
!31 = !DILocalVariable(name: "adressX", scope: !11, file: !12, line: 19, type: !4)
!32 = !DILocation(line: 21, column: 17, scope: !33)
!33 = distinct !DILexicalBlock(scope: !11, file: !12, line: 21, column: 9)
!34 = !DILocation(line: 21, column: 9, scope: !11)
!35 = !DILocation(line: 23, column: 14, scope: !36)
!36 = distinct !DILexicalBlock(scope: !33, file: !12, line: 22, column: 5)
!37 = !DILocation(line: 23, column: 9, scope: !36)
!38 = !DILocation(line: 24, column: 5, scope: !36)
!39 = !DILocation(line: 26, column: 10, scope: !11)
!40 = !DILocation(line: 26, column: 5, scope: !11)
!41 = !DILocation(line: 28, column: 5, scope: !11)
