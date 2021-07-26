; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-9ntot7ie.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define internal void @foo(i8* %0, i8* %1, i32 %2) #0 !dbg !11 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !16, metadata !DIExpression()), !dbg !17, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %1, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %2, metadata !20, metadata !DIExpression()), !dbg !17, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %4 = icmp slt i32 0, %2, !dbg !22, !verifier.code !18
  br i1 %4, label %.lr.ph, label %11, !dbg !25, !verifier.code !18

.lr.ph:                                           ; preds = %3
  br label %5, !dbg !25, !verifier.code !18

5:                                                ; preds = %forwarder, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %9, %forwarder ], !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %.02, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %6 = sext i32 %.02 to i64, !dbg !26, !verifier.code !18
  %7 = getelementptr inbounds i8, i8* %0, i64 %6, !dbg !26, !verifier.code !18
  store i8 -1, i8* %7, align 1, !dbg !27, !verifier.code !18
  br label %8, !dbg !26, !verifier.code !18

8:                                                ; preds = %5
  %9 = add nsw i32 %.02, 1, !dbg !28, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %9, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %10 = icmp slt i32 %9, %2, !dbg !22, !verifier.code !18
  br i1 %10, label %forwarder, label %._crit_edge, !dbg !25, !llvm.loop !29, !verifier.code !18

._crit_edge:                                      ; preds = %8
  br label %11, !dbg !25, !verifier.code !18

11:                                               ; preds = %._crit_edge, %3
  call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !18
  br label %12, !dbg !31, !verifier.code !18

12:                                               ; preds = %11
  call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !18
  store i8 -1, i8* %1, align 1, !dbg !33, !verifier.code !18
  br label %13, !dbg !35, !verifier.code !18

13:                                               ; preds = %12
  call void @llvm.dbg.value(metadata i32 1, metadata !21, metadata !DIExpression()), !dbg !17, !verifier.code !18
  ret void, !dbg !36, !verifier.code !18

forwarder:                                        ; preds = %8
  br label %5, !verifier.code !18
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @test_1() #0 !dbg !37 {
  call void @llvm.dbg.value(metadata i32 2, metadata !40, metadata !DIExpression()), !dbg !41, !verifier.code !18
  %1 = sext i32 2 to i64, !dbg !42, !verifier.code !18
  %2 = mul i64 %1, 1, !dbg !43, !verifier.code !18
  %3 = call noalias i8* @malloc(i64 %2) #3, !dbg !44, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %3, metadata !45, metadata !DIExpression()), !dbg !41, !verifier.code !18
  %4 = sext i32 2 to i64, !dbg !46, !verifier.code !18
  %5 = mul i64 %4, 1, !dbg !47, !verifier.code !18
  %6 = call noalias i8* @malloc(i64 %5) #3, !dbg !48, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %6, metadata !49, metadata !DIExpression()), !dbg !41, !verifier.code !18
  %7 = getelementptr inbounds i8, i8* %6, i32 1, !dbg !50, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %7, metadata !49, metadata !DIExpression()), !dbg !41, !verifier.code !18
  store i8 0, i8* %6, align 1, !dbg !51, !verifier.code !18
  call void @foo(i8* %3, i8* %7, i32 2), !dbg !52, !verifier.code !18
  %8 = getelementptr inbounds i8, i8* %7, i64 -1, !dbg !53, !verifier.code !18
  %9 = load i8, i8* %8, align 1, !dbg !53, !verifier.code !18
  %10 = icmp ne i8 %9, 0, !dbg !53, !verifier.code !18
  br i1 %10, label %11, label %12, !dbg !55, !verifier.code !18

11:                                               ; preds = %0
  call void @free(i8* %3) #3, !dbg !56, !verifier.code !18
  call void @free(i8* %7) #3, !dbg !58, !verifier.code !18
  br label %13, !dbg !59, !verifier.code !18

12:                                               ; preds = %0
  call void @free(i8* %3) #3, !dbg !60, !verifier.code !18
  call void @free(i8* %7) #3, !dbg !62, !verifier.code !18
  br label %13, !verifier.code !18

13:                                               ; preds = %12, %11
  ret void, !dbg !63, !verifier.code !18
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !64 {
  call void @test_1(), !dbg !67, !verifier.code !18
  ret i32 0, !dbg !68, !verifier.code !18
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
!11 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 11, type: !12, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14, !14, !5}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !11, file: !1, line: 11, type: !14)
!17 = !DILocation(line: 0, scope: !11)
!18 = !{i1 false}
!19 = !DILocalVariable(name: "b", arg: 2, scope: !11, file: !1, line: 11, type: !14)
!20 = !DILocalVariable(name: "n", arg: 3, scope: !11, file: !1, line: 11, type: !5)
!21 = !DILocalVariable(name: "i", scope: !11, file: !1, line: 12, type: !5)
!22 = !DILocation(line: 13, column: 19, scope: !23)
!23 = distinct !DILexicalBlock(scope: !24, file: !1, line: 13, column: 5)
!24 = distinct !DILexicalBlock(scope: !11, file: !1, line: 13, column: 5)
!25 = !DILocation(line: 13, column: 5, scope: !24)
!26 = !DILocation(line: 14, column: 9, scope: !23)
!27 = !DILocation(line: 14, column: 14, scope: !23)
!28 = !DILocation(line: 13, column: 25, scope: !23)
!29 = distinct !{!29, !25, !30}
!30 = !DILocation(line: 14, column: 17, scope: !24)
!31 = !DILocation(line: 15, column: 5, scope: !32)
!32 = distinct !DILexicalBlock(scope: !11, file: !1, line: 15, column: 5)
!33 = !DILocation(line: 16, column: 14, scope: !34)
!34 = distinct !DILexicalBlock(scope: !32, file: !1, line: 15, column: 5)
!35 = !DILocation(line: 16, column: 9, scope: !34)
!36 = !DILocation(line: 17, column: 1, scope: !11)
!37 = distinct !DISubprogram(name: "test_1", scope: !1, file: !1, line: 19, type: !38, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!38 = !DISubroutineType(types: !39)
!39 = !{null}
!40 = !DILocalVariable(name: "n", scope: !37, file: !1, line: 21, type: !5)
!41 = !DILocation(line: 0, scope: !37)
!42 = !DILocation(line: 23, column: 16, scope: !37)
!43 = !DILocation(line: 23, column: 18, scope: !37)
!44 = !DILocation(line: 23, column: 9, scope: !37)
!45 = !DILocalVariable(name: "a", scope: !37, file: !1, line: 20, type: !14)
!46 = !DILocation(line: 24, column: 16, scope: !37)
!47 = !DILocation(line: 24, column: 18, scope: !37)
!48 = !DILocation(line: 24, column: 9, scope: !37)
!49 = !DILocalVariable(name: "b", scope: !37, file: !1, line: 20, type: !14)
!50 = !DILocation(line: 25, column: 7, scope: !37)
!51 = !DILocation(line: 25, column: 10, scope: !37)
!52 = !DILocation(line: 26, column: 5, scope: !37)
!53 = !DILocation(line: 27, column: 9, scope: !54)
!54 = distinct !DILexicalBlock(scope: !37, file: !1, line: 27, column: 9)
!55 = !DILocation(line: 27, column: 9, scope: !37)
!56 = !DILocation(line: 28, column: 9, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 27, column: 16)
!58 = !DILocation(line: 29, column: 9, scope: !57)
!59 = !DILocation(line: 30, column: 5, scope: !57)
!60 = !DILocation(line: 32, column: 9, scope: !61)
!61 = distinct !DILexicalBlock(scope: !54, file: !1, line: 31, column: 10)
!62 = !DILocation(line: 33, column: 9, scope: !61)
!63 = !DILocation(line: 35, column: 1, scope: !37)
!64 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 131, type: !65, scopeLine: 131, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!65 = !DISubroutineType(types: !66)
!66 = !{!5}
!67 = !DILocation(line: 133, column: 5, scope: !64)
!68 = !DILocation(line: 139, column: 5, scope: !64)
