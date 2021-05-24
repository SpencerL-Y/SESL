; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/bin/b-gvh3alli.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !14 {
  %1 = call noalias i8* @malloc(i64 4) #3, !dbg !17, !verifier.code !18
  %2 = bitcast i8* %1 to i32*, !dbg !19, !verifier.code !18
  call void @llvm.dbg.value(metadata i32* %2, metadata !20, metadata !DIExpression()), !dbg !21, !verifier.code !18
  %3 = bitcast i32* %2 to i8*, !dbg !22, !verifier.code !18
  call void @free(i8* %3) #3, !dbg !23, !verifier.code !18
  ret i32 0, !dbg !24, !verifier.code !18
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
!llvm.ident = !{!10}
!llvm.module.flags = !{!11, !12, !13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, globals: !6, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/test1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/bin")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!7}
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(name: "p", scope: !0, file: !9, line: 2, type: !4, isLocal: false, isDefinition: true)
!9 = !DIFile(filename: "/usr/local/share/smack/include/TestIncl.h", directory: "")
!10 = !{!"clang version 10.0.0-4ubuntu1 "}
!11 = !{i32 7, !"Dwarf Version", i32 4}
!12 = !{i32 2, !"Debug Info Version", i32 3}
!13 = !{i32 1, !"wchar_size", i32 4}
!14 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !15, scopeLine: 7, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!5}
!17 = !DILocation(line: 8, column: 16, scope: !14)
!18 = !{i1 false}
!19 = !DILocation(line: 8, column: 10, scope: !14)
!20 = !DILocalVariable(name: "i", scope: !14, file: !1, line: 8, type: !4)
!21 = !DILocation(line: 0, scope: !14)
!22 = !DILocation(line: 9, column: 6, scope: !14)
!23 = !DILocation(line: 9, column: 1, scope: !14)
!24 = !DILocation(line: 10, column: 1, scope: !14)
