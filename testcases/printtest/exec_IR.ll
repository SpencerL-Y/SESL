; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-096ogdw0.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @add_1(i32* %0) #2 !dbg !11 {
  call void @llvm.dbg.value(metadata i32* %0, metadata !14, metadata !DIExpression()), !dbg !15, !verifier.code !16
  %2 = load i32, i32* %0, align 4, !dbg !17, !verifier.code !16
  %3 = add nsw i32 %2, 1, !dbg !17, !verifier.code !16
  store i32 %3, i32* %0, align 4, !dbg !17, !verifier.code !16
  ret void, !dbg !18, !verifier.code !16
}

; Function Attrs: noinline nounwind uwtable
define internal void @add_2(i32* %0) #2 !dbg !19 {
  call void @llvm.dbg.value(metadata i32* %0, metadata !20, metadata !DIExpression()), !dbg !21, !verifier.code !16
  %2 = load i32, i32* %0, align 4, !dbg !22, !verifier.code !16
  %3 = add nsw i32 %2, 2, !dbg !22, !verifier.code !16
  store i32 %3, i32* %0, align 4, !dbg !22, !verifier.code !16
  ret void, !dbg !23, !verifier.code !16
}

; Function Attrs: noinline nounwind uwtable
define internal void @test_3() #2 !dbg !24 {
  %1 = call noalias i8* @malloc(i64 8) #3, !dbg !27, !verifier.code !16
  %2 = bitcast i8* %1 to i32*, !dbg !28, !verifier.code !16
  call void @llvm.dbg.value(metadata i32* %2, metadata !29, metadata !DIExpression()), !dbg !30, !verifier.code !16
  %3 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !31, !verifier.code !16
  store i32 0, i32* %3, align 4, !dbg !32, !verifier.code !16
  %4 = getelementptr inbounds i32, i32* %2, i64 0, !dbg !33, !verifier.code !16
  store i32 0, i32* %4, align 4, !dbg !34, !verifier.code !16
  call void @add_1(i32* %2), !dbg !35, !verifier.code !16
  %5 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !36, !verifier.code !16
  call void @add_2(i32* %5), !dbg !37, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 0, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  %6 = call noalias i8* @malloc(i64 12) #3, !dbg !39, !verifier.code !16
  %7 = bitcast i8* %6 to i32*, !dbg !40, !verifier.code !16
  call void @llvm.dbg.value(metadata i32* %7, metadata !41, metadata !DIExpression()), !dbg !30, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !44, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 0, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  br label %8, !dbg !45, !verifier.code !16

8:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !42, metadata !DIExpression()), !dbg !44, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 0, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  %9 = load i32, i32* %2, align 4, !dbg !46, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 %9, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  br label %10, !dbg !49, !verifier.code !16

10:                                               ; preds = %8
  call void @llvm.dbg.value(metadata i32 1, metadata !42, metadata !DIExpression()), !dbg !44, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 %9, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  %11 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !46, !verifier.code !16
  %12 = load i32, i32* %11, align 4, !dbg !46, !verifier.code !16
  %13 = add nsw i32 %9, %12, !dbg !50, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 %13, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  br label %18, !dbg !49, !verifier.code !16

14:                                               ; preds = %18
  %15 = bitcast i32* %7 to i8*, !dbg !51, !verifier.code !16
  call void @free(i8* %15) #3, !dbg !54, !verifier.code !16
  br label %16, !dbg !55, !verifier.code !16

16:                                               ; preds = %14, %18
  %17 = bitcast i32* %2 to i8*, !dbg !56, !verifier.code !16
  call void @free(i8* %17) #3, !dbg !57, !verifier.code !16
  ret void, !dbg !58, !verifier.code !16

18:                                               ; preds = %10
  call void @llvm.dbg.value(metadata i32 2, metadata !42, metadata !DIExpression()), !dbg !44, !verifier.code !16
  call void @llvm.dbg.value(metadata i32 %13, metadata !38, metadata !DIExpression()), !dbg !30, !verifier.code !16
  %19 = icmp eq i32 %13, 3, !dbg !59, !verifier.code !16
  br i1 %19, label %14, label %16, !dbg !60, !verifier.code !16
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #2 !dbg !61 {
  call void @test_3(), !dbg !64, !verifier.code !16
  ret i32 0, !dbg !65, !verifier.code !16
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #0

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!7}
!llvm.module.flags = !{!8, !9, !10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !6}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "add_1", scope: !1, file: !1, line: 50, type: !12, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{null, !4}
!14 = !DILocalVariable(name: "p", arg: 1, scope: !11, file: !1, line: 50, type: !4)
!15 = !DILocation(line: 0, scope: !11)
!16 = !{i1 false}
!17 = !DILocation(line: 51, column: 10, scope: !11)
!18 = !DILocation(line: 52, column: 1, scope: !11)
!19 = distinct !DISubprogram(name: "add_2", scope: !1, file: !1, line: 54, type: !12, scopeLine: 54, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "p", arg: 1, scope: !19, file: !1, line: 54, type: !4)
!21 = !DILocation(line: 0, scope: !19)
!22 = !DILocation(line: 55, column: 8, scope: !19)
!23 = !DILocation(line: 56, column: 1, scope: !19)
!24 = distinct !DISubprogram(name: "test_3", scope: !1, file: !1, line: 58, type: !25, scopeLine: 58, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!25 = !DISubroutineType(types: !26)
!26 = !{null}
!27 = !DILocation(line: 59, column: 20, scope: !24)
!28 = !DILocation(line: 59, column: 14, scope: !24)
!29 = !DILocalVariable(name: "a", scope: !24, file: !1, line: 59, type: !4)
!30 = !DILocation(line: 0, scope: !24)
!31 = !DILocation(line: 60, column: 12, scope: !24)
!32 = !DILocation(line: 60, column: 17, scope: !24)
!33 = !DILocation(line: 60, column: 5, scope: !24)
!34 = !DILocation(line: 60, column: 10, scope: !24)
!35 = !DILocation(line: 61, column: 5, scope: !24)
!36 = !DILocation(line: 62, column: 13, scope: !24)
!37 = !DILocation(line: 62, column: 5, scope: !24)
!38 = !DILocalVariable(name: "sum", scope: !24, file: !1, line: 63, type: !5)
!39 = !DILocation(line: 64, column: 21, scope: !24)
!40 = !DILocation(line: 64, column: 14, scope: !24)
!41 = !DILocalVariable(name: "p", scope: !24, file: !1, line: 64, type: !4)
!42 = !DILocalVariable(name: "i", scope: !43, file: !1, line: 65, type: !5)
!43 = distinct !DILexicalBlock(scope: !24, file: !1, line: 65, column: 5)
!44 = !DILocation(line: 0, scope: !43)
!45 = !DILocation(line: 65, column: 5, scope: !43)
!46 = !DILocation(line: 66, column: 16, scope: !47)
!47 = distinct !DILexicalBlock(scope: !48, file: !1, line: 65, column: 34)
!48 = distinct !DILexicalBlock(scope: !43, file: !1, line: 65, column: 5)
!49 = !DILocation(line: 67, column: 5, scope: !47)
!50 = !DILocation(line: 66, column: 13, scope: !47)
!51 = !DILocation(line: 69, column: 14, scope: !52)
!52 = distinct !DILexicalBlock(scope: !53, file: !1, line: 68, column: 19)
!53 = distinct !DILexicalBlock(scope: !24, file: !1, line: 68, column: 9)
!54 = !DILocation(line: 69, column: 9, scope: !52)
!55 = !DILocation(line: 70, column: 5, scope: !52)
!56 = !DILocation(line: 71, column: 10, scope: !24)
!57 = !DILocation(line: 71, column: 5, scope: !24)
!58 = !DILocation(line: 72, column: 1, scope: !24)
!59 = !DILocation(line: 68, column: 13, scope: !53)
!60 = !DILocation(line: 68, column: 9, scope: !24)
!61 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 133, type: !62, scopeLine: 133, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!62 = !DISubroutineType(types: !63)
!63 = !{!5}
!64 = !DILocation(line: 137, column: 5, scope: !61)
!65 = !DILocation(line: 141, column: 5, scope: !61)
