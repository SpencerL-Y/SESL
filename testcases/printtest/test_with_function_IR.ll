; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-ux8nddfn.bc'
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
define internal void @test_4() #2 !dbg !11 {
  %1 = call noalias i8* @malloc(i64 8) #3, !dbg !14, !verifier.code !15
  %2 = bitcast i8* %1 to i32*, !dbg !16, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %2, metadata !17, metadata !DIExpression()), !dbg !18, !verifier.code !15
  %3 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !19, !verifier.code !15
  store i32 0, i32* %3, align 4, !dbg !20, !verifier.code !15
  %4 = getelementptr inbounds i32, i32* %2, i64 0, !dbg !21, !verifier.code !15
  store i32 0, i32* %4, align 4, !dbg !22, !verifier.code !15
  %5 = getelementptr inbounds i32, i32* %2, i64 0, !dbg !23, !verifier.code !15
  %6 = load i32, i32* %5, align 4, !dbg !24, !verifier.code !15
  %7 = add nsw i32 %6, 1, !dbg !24, !verifier.code !15
  store i32 %7, i32* %5, align 4, !dbg !24, !verifier.code !15
  %8 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !25, !verifier.code !15
  %9 = load i32, i32* %8, align 4, !dbg !26, !verifier.code !15
  %10 = add nsw i32 %9, 2, !dbg !26, !verifier.code !15
  store i32 %10, i32* %8, align 4, !dbg !26, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  %11 = call noalias i8* @malloc(i64 12) #3, !dbg !28, !verifier.code !15
  %12 = bitcast i8* %11 to i32*, !dbg !29, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %12, metadata !30, metadata !DIExpression()), !dbg !18, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 0, metadata !31, metadata !DIExpression()), !dbg !33, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  br label %13, !dbg !34, !verifier.code !15

13:                                               ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !31, metadata !DIExpression()), !dbg !33, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 0, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  %14 = load i32, i32* %2, align 4, !dbg !35, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %14, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  br label %15, !dbg !38, !verifier.code !15

15:                                               ; preds = %13
  call void @llvm.dbg.value(metadata i32 1, metadata !31, metadata !DIExpression()), !dbg !33, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %14, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  %16 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !35, !verifier.code !15
  %17 = load i32, i32* %16, align 4, !dbg !35, !verifier.code !15
  %18 = add nsw i32 %14, %17, !dbg !39, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %18, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  br label %22, !dbg !38, !verifier.code !15

19:                                               ; preds = %22
  %20 = bitcast i32* %12 to i8*, !dbg !40, !verifier.code !15
  call void @free(i8* %20) #3, !dbg !43, !verifier.code !15
  br label %21, !dbg !44, !verifier.code !15

21:                                               ; preds = %19, %22
  ret void, !dbg !45, !verifier.code !15

22:                                               ; preds = %15
  call void @llvm.dbg.value(metadata i32 2, metadata !31, metadata !DIExpression()), !dbg !33, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %18, metadata !27, metadata !DIExpression()), !dbg !18, !verifier.code !15
  %23 = icmp eq i32 %18, 3, !dbg !46, !verifier.code !15
  br i1 %23, label %19, label %21, !dbg !47, !verifier.code !15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #2 !dbg !48 {
  call void @test_4(), !dbg !51, !verifier.code !15
  ret i32 0, !dbg !52, !verifier.code !15
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
!1 = !DIFile(filename: "../testcases/printtest/test_with_function.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !6}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "test_4", scope: !1, file: !1, line: 74, type: !12, scopeLine: 74, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{null}
!14 = !DILocation(line: 75, column: 20, scope: !11)
!15 = !{i1 false}
!16 = !DILocation(line: 75, column: 14, scope: !11)
!17 = !DILocalVariable(name: "a", scope: !11, file: !1, line: 75, type: !4)
!18 = !DILocation(line: 0, scope: !11)
!19 = !DILocation(line: 76, column: 12, scope: !11)
!20 = !DILocation(line: 76, column: 17, scope: !11)
!21 = !DILocation(line: 76, column: 5, scope: !11)
!22 = !DILocation(line: 76, column: 10, scope: !11)
!23 = !DILocation(line: 77, column: 5, scope: !11)
!24 = !DILocation(line: 77, column: 10, scope: !11)
!25 = !DILocation(line: 78, column: 5, scope: !11)
!26 = !DILocation(line: 78, column: 10, scope: !11)
!27 = !DILocalVariable(name: "sum", scope: !11, file: !1, line: 79, type: !5)
!28 = !DILocation(line: 80, column: 21, scope: !11)
!29 = !DILocation(line: 80, column: 14, scope: !11)
!30 = !DILocalVariable(name: "p", scope: !11, file: !1, line: 80, type: !4)
!31 = !DILocalVariable(name: "i", scope: !32, file: !1, line: 81, type: !5)
!32 = distinct !DILexicalBlock(scope: !11, file: !1, line: 81, column: 5)
!33 = !DILocation(line: 0, scope: !32)
!34 = !DILocation(line: 81, column: 5, scope: !32)
!35 = !DILocation(line: 82, column: 16, scope: !36)
!36 = distinct !DILexicalBlock(scope: !37, file: !1, line: 81, column: 34)
!37 = distinct !DILexicalBlock(scope: !32, file: !1, line: 81, column: 5)
!38 = !DILocation(line: 83, column: 5, scope: !36)
!39 = !DILocation(line: 82, column: 13, scope: !36)
!40 = !DILocation(line: 85, column: 14, scope: !41)
!41 = distinct !DILexicalBlock(scope: !42, file: !1, line: 84, column: 19)
!42 = distinct !DILexicalBlock(scope: !11, file: !1, line: 84, column: 9)
!43 = !DILocation(line: 85, column: 9, scope: !41)
!44 = !DILocation(line: 86, column: 5, scope: !41)
!45 = !DILocation(line: 87, column: 1, scope: !11)
!46 = !DILocation(line: 84, column: 13, scope: !42)
!47 = !DILocation(line: 84, column: 9, scope: !11)
!48 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 139, type: !49, scopeLine: 139, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!5}
!51 = !DILocation(line: 145, column: 5, scope: !48)
!52 = !DILocation(line: 148, column: 5, scope: !48)
