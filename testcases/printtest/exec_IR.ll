; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-uxgqww1o.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !10 {
  call void @llvm.dbg.value(metadata i32 2, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %1 = sext i32 2 to i64, !dbg !16, !verifier.code !15
  %2 = mul i64 %1, 4, !dbg !17, !verifier.code !15
  %3 = call noalias i8* @malloc(i64 %2) #3, !dbg !18, !verifier.code !15
  %4 = bitcast i8* %3 to i32*, !dbg !19, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %4, metadata !20, metadata !DIExpression()), !dbg !14, !verifier.code !15
  store i32 1110, i32* %4, align 4, !dbg !21, !verifier.code !15
  %5 = load i32, i32* %4, align 4, !dbg !22, !verifier.code !15
  %6 = add nsw i32 %5, -1, !dbg !23, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %6, metadata !24, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %7 = add nsw i32 2, 1, !dbg !25, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %7, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  ret i32 0, !dbg !26, !verifier.code !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

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
!llvm.ident = !{!6}
!llvm.module.flags = !{!7, !8, !9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !11, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5}
!13 = !DILocalVariable(name: "num", scope: !10, file: !1, line: 17, type: !5)
!14 = !DILocation(line: 0, scope: !10)
!15 = !{i1 false}
!16 = !DILocation(line: 18, column: 27, scope: !10)
!17 = !DILocation(line: 18, column: 30, scope: !10)
!18 = !DILocation(line: 18, column: 20, scope: !10)
!19 = !DILocation(line: 18, column: 14, scope: !10)
!20 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 18, type: !4)
!21 = !DILocation(line: 19, column: 10, scope: !10)
!22 = !DILocation(line: 20, column: 16, scope: !10)
!23 = !DILocation(line: 20, column: 21, scope: !10)
!24 = !DILocalVariable(name: "nnum", scope: !10, file: !1, line: 20, type: !5)
!25 = !DILocation(line: 21, column: 15, scope: !10)
!26 = !DILocation(line: 39, column: 1, scope: !10)
