; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-u39_cujf.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define internal void @insertionSort(i32* %0, i32 %1) #0 !dbg !10 {
  call void @llvm.dbg.value(metadata i32* %0, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %1, metadata !16, metadata !DIExpression()), !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 1, metadata !17, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %3 = icmp slt i32 1, %1, !dbg !18, !verifier.code !15
  br i1 %3, label %.lr.ph, label %33, !dbg !21, !verifier.code !15

.lr.ph:                                           ; preds = %2
  br label %4, !dbg !21, !verifier.code !15

4:                                                ; preds = %forwarder, %.lr.ph
  %.012 = phi i32 [ 1, %.lr.ph ], [ %31, %forwarder ], !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.012, metadata !17, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %5 = sext i32 %.012 to i64, !dbg !22, !verifier.code !15
  %6 = getelementptr inbounds i32, i32* %0, i64 %5, !dbg !22, !verifier.code !15
  %7 = load i32, i32* %6, align 4, !dbg !22, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %7, metadata !24, metadata !DIExpression()), !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.012, metadata !25, metadata !DIExpression()), !dbg !14, !verifier.code !15
  br label %8, !dbg !26, !verifier.code !15

8:                                                ; preds = %25, %4
  %.0 = phi i32 [ %.012, %4 ], [ %26, %25 ], !dbg !28, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.0, metadata !25, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %9 = icmp sgt i32 %.0, 0, !dbg !29, !verifier.code !15
  br i1 %9, label %10, label %16, !dbg !31, !verifier.code !15

10:                                               ; preds = %8
  %11 = sub nsw i32 %.0, 1, !dbg !32, !verifier.code !15
  %12 = sext i32 %11 to i64, !dbg !33, !verifier.code !15
  %13 = getelementptr inbounds i32, i32* %0, i64 %12, !dbg !33, !verifier.code !15
  %14 = load i32, i32* %13, align 4, !dbg !33, !verifier.code !15
  %15 = icmp sgt i32 %14, %7, !dbg !34, !verifier.code !15
  br label %16, !verifier.code !15

16:                                               ; preds = %10, %8
  %17 = phi i1 [ false, %8 ], [ %15, %10 ], !dbg !35, !verifier.code !15
  br i1 %17, label %18, label %27, !dbg !36, !verifier.code !15

18:                                               ; preds = %16
  %19 = sub nsw i32 %.0, 1, !dbg !37, !verifier.code !15
  %20 = sext i32 %19 to i64, !dbg !38, !verifier.code !15
  %21 = getelementptr inbounds i32, i32* %0, i64 %20, !dbg !38, !verifier.code !15
  %22 = load i32, i32* %21, align 4, !dbg !38, !verifier.code !15
  %23 = sext i32 %.0 to i64, !dbg !39, !verifier.code !15
  %24 = getelementptr inbounds i32, i32* %0, i64 %23, !dbg !39, !verifier.code !15
  store i32 %22, i32* %24, align 4, !dbg !40, !verifier.code !15
  br label %25, !dbg !39, !verifier.code !15

25:                                               ; preds = %18
  %26 = add nsw i32 %.0, -1, !dbg !41, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %26, metadata !25, metadata !DIExpression()), !dbg !14, !verifier.code !15
  br label %8, !dbg !42, !llvm.loop !43, !verifier.code !15

27:                                               ; preds = %16
  %.0.lcssa = phi i32 [ %.0, %16 ], !dbg !28, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.0.lcssa, metadata !25, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %28 = sext i32 %.0.lcssa to i64, !dbg !45, !verifier.code !15
  %29 = getelementptr inbounds i32, i32* %0, i64 %28, !dbg !45, !verifier.code !15
  store i32 %7, i32* %29, align 4, !dbg !46, !verifier.code !15
  br label %30, !dbg !47, !verifier.code !15

30:                                               ; preds = %27
  %31 = add nsw i32 %.012, 1, !dbg !48, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %31, metadata !17, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %32 = icmp slt i32 %31, %1, !dbg !18, !verifier.code !15
  br i1 %32, label %forwarder, label %._crit_edge, !dbg !21, !llvm.loop !49, !verifier.code !15

._crit_edge:                                      ; preds = %30
  br label %33, !dbg !21, !verifier.code !15

33:                                               ; preds = %._crit_edge, %2
  ret void, !dbg !51, !verifier.code !15

forwarder:                                        ; preds = %30
  br label %4, !verifier.code !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !52 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !55, !verifier.code !56
  call void @llvm.dbg.value(metadata i32 %1, metadata !57, metadata !DIExpression()), !dbg !58, !verifier.code !15
  %2 = icmp slt i32 %1, 1, !dbg !59, !verifier.code !15
  br i1 %2, label %6, label %3, !dbg !61, !verifier.code !15

3:                                                ; preds = %0
  %4 = sext i32 %1 to i64, !dbg !62, !verifier.code !15
  %5 = icmp uge i64 %4, 536870911, !dbg !63, !verifier.code !15
  br i1 %5, label %6, label %7, !dbg !64, !verifier.code !15

6:                                                ; preds = %3, %0
  call void @llvm.dbg.value(metadata i32 1, metadata !57, metadata !DIExpression()), !dbg !58, !verifier.code !15
  br label %7, !dbg !65, !verifier.code !15

7:                                                ; preds = %6, %3
  %.01 = phi i32 [ 1, %6 ], [ %1, %3 ], !dbg !58, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.01, metadata !57, metadata !DIExpression()), !dbg !58, !verifier.code !15
  %8 = sext i32 %.01 to i64, !dbg !67, !verifier.code !15
  %9 = mul i64 %8, 4, !dbg !68, !verifier.code !15
  %10 = alloca i8, i64 %9, align 16, !dbg !69, !verifier.code !15
  %11 = bitcast i8* %10 to i32*, !dbg !70, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %11, metadata !71, metadata !DIExpression()), !dbg !58, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 0, metadata !72, metadata !DIExpression()), !dbg !74, !verifier.code !15
  %12 = icmp slt i32 0, %.01, !dbg !75, !verifier.code !15
  br i1 %12, label %.lr.ph, label %20, !dbg !77, !verifier.code !15

.lr.ph:                                           ; preds = %7
  br label %13, !dbg !77, !verifier.code !15

13:                                               ; preds = %forwarder, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %18, %forwarder ], !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.02, metadata !72, metadata !DIExpression()), !dbg !74, !verifier.code !15
  %14 = call i32 @__VERIFIER_nondet_int(), !dbg !78, !verifier.code !56
  %15 = sext i32 %.02 to i64, !dbg !80, !verifier.code !15
  %16 = getelementptr inbounds i32, i32* %11, i64 %15, !dbg !80, !verifier.code !15
  store i32 %14, i32* %16, align 4, !dbg !81, !verifier.code !15
  br label %17, !dbg !82, !verifier.code !15

17:                                               ; preds = %13
  %18 = add nsw i32 %.02, 1, !dbg !83, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %18, metadata !72, metadata !DIExpression()), !dbg !74, !verifier.code !15
  %19 = icmp slt i32 %18, %.01, !dbg !75, !verifier.code !15
  br i1 %19, label %forwarder, label %._crit_edge, !dbg !77, !llvm.loop !84, !verifier.code !15

._crit_edge:                                      ; preds = %17
  br label %20, !dbg !77, !verifier.code !15

20:                                               ; preds = %._crit_edge, %7
  call void @insertionSort(i32* %11, i32 %.01), !dbg !86, !verifier.code !15
  ret i32 0, !dbg !87, !verifier.code !15

forwarder:                                        ; preds = %17
  br label %13, !verifier.code !15
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!6}
!llvm.module.flags = !{!7, !8, !9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/array-memsafety/insertionsort-alloca-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "insertionSort", scope: !1, file: !1, line: 512, type: !11, scopeLine: 513, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !4, !5}
!13 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 512, type: !4)
!14 = !DILocation(line: 0, scope: !10)
!15 = !{i1 false}
!16 = !DILocalVariable(name: "array_size", arg: 2, scope: !10, file: !1, line: 512, type: !5)
!17 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 514, type: !5)
!18 = !DILocation(line: 515, column: 19, scope: !19)
!19 = distinct !DILexicalBlock(scope: !20, file: !1, line: 515, column: 5)
!20 = distinct !DILexicalBlock(scope: !10, file: !1, line: 515, column: 5)
!21 = !DILocation(line: 515, column: 5, scope: !20)
!22 = !DILocation(line: 517, column: 17, scope: !23)
!23 = distinct !DILexicalBlock(scope: !19, file: !1, line: 516, column: 5)
!24 = !DILocalVariable(name: "index", scope: !10, file: !1, line: 514, type: !5)
!25 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 514, type: !5)
!26 = !DILocation(line: 518, column: 14, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 518, column: 9)
!28 = !DILocation(line: 0, scope: !27)
!29 = !DILocation(line: 518, column: 23, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 518, column: 9)
!31 = !DILocation(line: 518, column: 27, scope: !30)
!32 = !DILocation(line: 518, column: 33, scope: !30)
!33 = !DILocation(line: 518, column: 30, scope: !30)
!34 = !DILocation(line: 518, column: 37, scope: !30)
!35 = !DILocation(line: 0, scope: !30)
!36 = !DILocation(line: 518, column: 9, scope: !27)
!37 = !DILocation(line: 519, column: 23, scope: !30)
!38 = !DILocation(line: 519, column: 20, scope: !30)
!39 = !DILocation(line: 519, column: 13, scope: !30)
!40 = !DILocation(line: 519, column: 18, scope: !30)
!41 = !DILocation(line: 518, column: 47, scope: !30)
!42 = !DILocation(line: 518, column: 9, scope: !30)
!43 = distinct !{!43, !36, !44}
!44 = !DILocation(line: 519, column: 25, scope: !27)
!45 = !DILocation(line: 520, column: 9, scope: !23)
!46 = !DILocation(line: 520, column: 14, scope: !23)
!47 = !DILocation(line: 521, column: 5, scope: !23)
!48 = !DILocation(line: 515, column: 33, scope: !19)
!49 = distinct !{!49, !21, !50}
!50 = !DILocation(line: 521, column: 5, scope: !20)
!51 = !DILocation(line: 522, column: 1, scope: !10)
!52 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 523, type: !53, scopeLine: 523, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!53 = !DISubroutineType(types: !54)
!54 = !{!5}
!55 = !DILocation(line: 524, column: 20, scope: !52)
!56 = !{i1 true}
!57 = !DILocalVariable(name: "array_size", scope: !52, file: !1, line: 524, type: !5)
!58 = !DILocation(line: 0, scope: !52)
!59 = !DILocation(line: 525, column: 18, scope: !60)
!60 = distinct !DILexicalBlock(scope: !52, file: !1, line: 525, column: 7)
!61 = !DILocation(line: 525, column: 22, scope: !60)
!62 = !DILocation(line: 525, column: 25, scope: !60)
!63 = !DILocation(line: 525, column: 36, scope: !60)
!64 = !DILocation(line: 525, column: 7, scope: !52)
!65 = !DILocation(line: 527, column: 3, scope: !66)
!66 = distinct !DILexicalBlock(scope: !60, file: !1, line: 525, column: 65)
!67 = !DILocation(line: 528, column: 37, scope: !52)
!68 = !DILocation(line: 528, column: 48, scope: !52)
!69 = !DILocation(line: 528, column: 19, scope: !52)
!70 = !DILocation(line: 528, column: 12, scope: !52)
!71 = !DILocalVariable(name: "a", scope: !52, file: !1, line: 528, type: !4)
!72 = !DILocalVariable(name: "i", scope: !73, file: !1, line: 530, type: !5)
!73 = distinct !DILexicalBlock(scope: !52, file: !1, line: 530, column: 2)
!74 = !DILocation(line: 0, scope: !73)
!75 = !DILocation(line: 530, column: 19, scope: !76)
!76 = distinct !DILexicalBlock(scope: !73, file: !1, line: 530, column: 2)
!77 = !DILocation(line: 530, column: 2, scope: !73)
!78 = !DILocation(line: 532, column: 13, scope: !79)
!79 = distinct !DILexicalBlock(scope: !76, file: !1, line: 531, column: 2)
!80 = !DILocation(line: 532, column: 6, scope: !79)
!81 = !DILocation(line: 532, column: 11, scope: !79)
!82 = !DILocation(line: 533, column: 2, scope: !79)
!83 = !DILocation(line: 530, column: 34, scope: !76)
!84 = distinct !{!84, !77, !85}
!85 = !DILocation(line: 533, column: 2, scope: !73)
!86 = !DILocation(line: 535, column: 3, scope: !52)
!87 = !DILocation(line: 536, column: 3, scope: !52)
