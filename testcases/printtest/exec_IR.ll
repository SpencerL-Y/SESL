; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SESL/SESL/build/b-u4m106z0.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = call noalias i8* @malloc(i64 4) #3, !dbg !11, !verifier.code !12
  %2 = bitcast i8* %1 to i32*, !dbg !11, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* %2, metadata !13, metadata !DIExpression()), !dbg !15, !verifier.code !12
  store i32 0, i32* %2, align 4, !dbg !16, !verifier.code !12
  %3 = call noalias i8* @malloc(i64 8) #3, !dbg !17, !verifier.code !12
  %4 = bitcast i8* %3 to i32*, !dbg !17, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* %4, metadata !13, metadata !DIExpression()), !dbg !15, !verifier.code !12
  %5 = getelementptr inbounds i32, i32* %4, i64 1, !dbg !18, !verifier.code !12
  store i32 0, i32* %5, align 4, !dbg !19, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* null, metadata !13, metadata !DIExpression()), !dbg !15, !verifier.code !12
  %6 = call i32 @foo(), !dbg !20, !verifier.code !12
  %7 = call i32 @foo(), !dbg !21, !verifier.code !12
  %8 = call i32 @foo(), !dbg !22, !verifier.code !12
  %9 = call i32 @foo(), !dbg !23, !verifier.code !12
  ret i32 0, !dbg !24, !verifier.code !12
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal i32 @foo() #0 !dbg !25 {
  %1 = call noalias i8* @malloc(i64 4) #3, !dbg !26, !verifier.code !12
  %2 = bitcast i8* %1 to i32*, !dbg !26, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* %2, metadata !27, metadata !DIExpression()), !dbg !28, !verifier.code !12
  store i32 0, i32* %2, align 4, !dbg !29, !verifier.code !12
  call void @llvm.dbg.value(metadata i32* null, metadata !27, metadata !DIExpression()), !dbg !28, !verifier.code !12
  %3 = ptrtoint i32* null to i32, !dbg !30, !verifier.code !12
  ret i32 %3, !dbg !31, !verifier.code !12
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
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 4, column: 14, scope: !7)
!12 = !{i1 false}
!13 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 4, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!15 = !DILocation(line: 0, scope: !7)
!16 = !DILocation(line: 5, column: 8, scope: !7)
!17 = !DILocation(line: 6, column: 9, scope: !7)
!18 = !DILocation(line: 7, column: 9, scope: !7)
!19 = !DILocation(line: 7, column: 14, scope: !7)
!20 = !DILocation(line: 9, column: 5, scope: !7)
!21 = !DILocation(line: 10, column: 5, scope: !7)
!22 = !DILocation(line: 11, column: 5, scope: !7)
!23 = !DILocation(line: 12, column: 5, scope: !7)
!24 = !DILocation(line: 13, column: 5, scope: !7)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 15, type: !8, scopeLine: 15, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!26 = !DILocation(line: 16, column: 14, scope: !25)
!27 = !DILocalVariable(name: "j", scope: !25, file: !1, line: 16, type: !14)
!28 = !DILocation(line: 0, scope: !25)
!29 = !DILocation(line: 17, column: 8, scope: !25)
!30 = !DILocation(line: 19, column: 12, scope: !25)
!31 = !DILocation(line: 19, column: 5, scope: !25)
