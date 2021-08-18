; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-5jbr74g7.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !10 {
  %1 = call noalias i8* @malloc(i64 12) #3, !dbg !13, !verifier.code !14
  %2 = bitcast i8* %1 to i32*, !dbg !15, !verifier.code !14
  call void @llvm.dbg.value(metadata i32* %2, metadata !16, metadata !DIExpression()), !dbg !17, !verifier.code !14
  %3 = bitcast i32* %2 to i8*, !dbg !18, !verifier.code !14
  call void @llvm.dbg.value(metadata i8* %3, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !14
  store i32 10, i32* %2, align 4, !dbg !22, !verifier.code !14
  %4 = getelementptr inbounds i8, i8* %3, i64 1, !dbg !23, !verifier.code !14
  store i8 97, i8* %4, align 1, !dbg !24, !verifier.code !14
  ret i32 0, !dbg !25, !verifier.code !14
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
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 133, type: !11, scopeLine: 134, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5}
!13 = !DILocation(line: 135, column: 21, scope: !10)
!14 = !{i1 false}
!15 = !DILocation(line: 135, column: 14, scope: !10)
!16 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 135, type: !4)
!17 = !DILocation(line: 0, scope: !10)
!18 = !DILocation(line: 136, column: 14, scope: !10)
!19 = !DILocalVariable(name: "m", scope: !10, file: !1, line: 136, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!22 = !DILocation(line: 137, column: 7, scope: !10)
!23 = !DILocation(line: 138, column: 8, scope: !10)
!24 = !DILocation(line: 138, column: 13, scope: !10)
!25 = !DILocation(line: 139, column: 1, scope: !10)
