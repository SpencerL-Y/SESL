; ModuleID = '/home/center/Documents/SmackBasedPrj/build/b-6cg8w7nv.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define internal void @fun_call() #0 !dbg !10 {
  call void @llvm.dbg.value(metadata i32 21, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  ret void, !dbg !16, !verifier.code !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @test_function_call() #0 !dbg !17 {
  call void @llvm.dbg.value(metadata i32 3, metadata !18, metadata !DIExpression()), !dbg !19, !verifier.code !15
  %1 = icmp slt i32 3, 3, !dbg !20, !verifier.code !15
  br i1 %1, label %2, label %3, !dbg !22, !verifier.code !15

2:                                                ; preds = %0
  call void @fun_call(), !dbg !23, !verifier.code !15
  br label %4, !dbg !25, !verifier.code !15

3:                                                ; preds = %0
  br label %4, !dbg !26, !verifier.code !15

4:                                                ; preds = %3, %2
  ret void, !dbg !27, !verifier.code !15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !28 {
  %1 = call noalias i8* @malloc(i64 4) #3, !dbg !31, !verifier.code !15
  %2 = bitcast i8* %1 to i32*, !dbg !32, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %2, metadata !33, metadata !DIExpression()), !dbg !34, !verifier.code !15
  %3 = icmp eq i32* %2, null, !dbg !35, !verifier.code !15
  br i1 %3, label %4, label %9, !dbg !37, !verifier.code !15

4:                                                ; preds = %0
  %5 = bitcast i32* %2 to i8*, !dbg !38, !verifier.code !15
  call void @free(i8* %5) #3, !dbg !40, !verifier.code !15
  %6 = icmp ne i32* %2, null, !dbg !41, !verifier.code !15
  br i1 %6, label %7, label %8, !dbg !43, !verifier.code !15

7:                                                ; preds = %4
  br label %10, !dbg !44, !verifier.code !15

8:                                                ; preds = %4
  br label %9, !dbg !46, !verifier.code !15

9:                                                ; preds = %8, %0
  call void @test_function_call(), !dbg !47, !verifier.code !15
  br label %10, !dbg !48, !verifier.code !15

10:                                               ; preds = %9, %7
  %.0 = phi i32 [ 1, %7 ], [ 0, %9 ], !dbg !34, !verifier.code !15
  ret i32 %.0, !dbg !49, !verifier.code !15
}

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
!llvm.ident = !{!6}
!llvm.module.flags = !{!7, !8, !9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Ubuntu clang version 10.0.1-++20210313014558+ef32c611aa21-1~exp1~20210313125203.63", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/test2.c", directory: "/home/center/Documents/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"Ubuntu clang version 10.0.1-++20210313014558+ef32c611aa21-1~exp1~20210313125203.63"}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "fun_call", scope: !1, file: !1, line: 5, type: !11, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 6, type: !5)
!14 = !DILocation(line: 0, scope: !10)
!15 = !{i1 false}
!16 = !DILocation(line: 7, column: 5, scope: !10)
!17 = distinct !DISubprogram(name: "test_function_call", scope: !1, file: !1, line: 10, type: !11, scopeLine: 10, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!18 = !DILocalVariable(name: "a", scope: !17, file: !1, line: 11, type: !5)
!19 = !DILocation(line: 0, scope: !17)
!20 = !DILocation(line: 13, column: 11, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 13, column: 9)
!22 = !DILocation(line: 13, column: 9, scope: !17)
!23 = !DILocation(line: 14, column: 9, scope: !24)
!24 = distinct !DILexicalBlock(scope: !21, file: !1, line: 13, column: 16)
!25 = !DILocation(line: 15, column: 9, scope: !24)
!26 = !DILocation(line: 17, column: 5, scope: !17)
!27 = !DILocation(line: 18, column: 1, scope: !17)
!28 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !29, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!5}
!31 = !DILocation(line: 21, column: 20, scope: !28)
!32 = !DILocation(line: 21, column: 14, scope: !28)
!33 = !DILocalVariable(name: "i", scope: !28, file: !1, line: 21, type: !4)
!34 = !DILocation(line: 0, scope: !28)
!35 = !DILocation(line: 22, column: 10, scope: !36)
!36 = distinct !DILexicalBlock(scope: !28, file: !1, line: 22, column: 8)
!37 = !DILocation(line: 22, column: 8, scope: !28)
!38 = !DILocation(line: 23, column: 14, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !1, line: 22, column: 15)
!40 = !DILocation(line: 23, column: 9, scope: !39)
!41 = !DILocation(line: 24, column: 13, scope: !42)
!42 = distinct !DILexicalBlock(scope: !39, file: !1, line: 24, column: 13)
!43 = !DILocation(line: 24, column: 13, scope: !39)
!44 = !DILocation(line: 25, column: 13, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !1, line: 24, column: 16)
!46 = !DILocation(line: 27, column: 5, scope: !39)
!47 = !DILocation(line: 28, column: 5, scope: !28)
!48 = !DILocation(line: 29, column: 5, scope: !28)
!49 = !DILocation(line: 30, column: 1, scope: !28)
