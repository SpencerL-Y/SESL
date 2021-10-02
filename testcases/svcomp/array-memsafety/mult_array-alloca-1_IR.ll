; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-bb7v16_g.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !11, !verifier.code !12
  call void @llvm.dbg.value(metadata i32 %1, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %2 = icmp slt i32 %1, 1, !dbg !16, !verifier.code !15
  br i1 %2, label %6, label %3, !dbg !18, !verifier.code !15

3:                                                ; preds = %0
  %4 = sext i32 %1 to i64, !dbg !19, !verifier.code !15
  %5 = icmp uge i64 %4, 536870911, !dbg !20, !verifier.code !15
  br i1 %5, label %6, label %7, !dbg !21, !verifier.code !15

6:                                                ; preds = %3, %0
  call void @llvm.dbg.value(metadata i32 1, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  br label %7, !dbg !22, !verifier.code !15

7:                                                ; preds = %6, %3
  %.03 = phi i32 [ 1, %6 ], [ %1, %3 ], !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.03, metadata !13, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !23, !verifier.code !12
  call void @llvm.dbg.value(metadata i32 %8, metadata !24, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %9 = icmp slt i32 %8, 1, !dbg !25, !verifier.code !15
  br i1 %9, label %16, label %10, !dbg !27, !verifier.code !15

10:                                               ; preds = %7
  %11 = sext i32 %8 to i64, !dbg !28, !verifier.code !15
  %12 = sext i32 %.03 to i64, !dbg !29, !verifier.code !15
  %13 = mul i64 4, %12, !dbg !30, !verifier.code !15
  %14 = udiv i64 2147483647, %13, !dbg !31, !verifier.code !15
  %15 = icmp uge i64 %11, %14, !dbg !32, !verifier.code !15
  br i1 %15, label %16, label %17, !dbg !33, !verifier.code !15

16:                                               ; preds = %10, %7
  call void @llvm.dbg.value(metadata i32 1, metadata !24, metadata !DIExpression()), !dbg !14, !verifier.code !15
  br label %17, !dbg !34, !verifier.code !15

17:                                               ; preds = %16, %10
  %.04 = phi i32 [ 1, %16 ], [ %8, %10 ], !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.04, metadata !24, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %18 = sext i32 %.03 to i64, !dbg !35, !verifier.code !15
  %19 = mul i64 %18, 4, !dbg !36, !verifier.code !15
  %20 = alloca i8, i64 %19, align 16, !dbg !37, !verifier.code !15
  %21 = bitcast i8* %20 to i32*, !dbg !37, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %21, metadata !38, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %22 = mul nsw i32 %.04, %.03, !dbg !40, !verifier.code !15
  %23 = sext i32 %22 to i64, !dbg !41, !verifier.code !15
  %24 = mul i64 %23, 4, !dbg !42, !verifier.code !15
  %25 = alloca i8, i64 %24, align 16, !dbg !43, !verifier.code !15
  %26 = bitcast i8* %25 to i32*, !dbg !43, !verifier.code !15
  call void @llvm.dbg.value(metadata i32* %26, metadata !44, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %27 = icmp ne i32* %21, null, !dbg !45, !verifier.code !15
  br i1 %27, label %28, label %30, !dbg !47, !verifier.code !15

28:                                               ; preds = %17
  %29 = icmp ne i32* %26, null, !dbg !48, !verifier.code !15
  br i1 %29, label %31, label %30, !dbg !49, !verifier.code !15

30:                                               ; preds = %28, %17
  br label %54, !dbg !50, !verifier.code !15

31:                                               ; preds = %28
  call void @llvm.dbg.value(metadata i32 0, metadata !51, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %32 = icmp slt i32 0, %.03, !dbg !52, !verifier.code !15
  br i1 %32, label %.lr.ph8, label %40, !dbg !55, !verifier.code !15

.lr.ph8:                                          ; preds = %31
  br label %33, !dbg !55, !verifier.code !15

33:                                               ; preds = %forwarder10, %.lr.ph8
  %.016 = phi i32 [ 0, %.lr.ph8 ], [ %38, %forwarder10 ], !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.016, metadata !51, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %34 = call i32 @__VERIFIER_nondet_int(), !dbg !56, !verifier.code !12
  %35 = sext i32 %.016 to i64, !dbg !58, !verifier.code !15
  %36 = getelementptr inbounds i32, i32* %21, i64 %35, !dbg !58, !verifier.code !15
  store i32 %34, i32* %36, align 4, !dbg !59, !verifier.code !15
  br label %37, !dbg !60, !verifier.code !15

37:                                               ; preds = %33
  %38 = add nsw i32 %.016, 1, !dbg !61, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %38, metadata !51, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %39 = icmp slt i32 %38, %.03, !dbg !52, !verifier.code !15
  br i1 %39, label %forwarder10, label %._crit_edge9, !dbg !55, !llvm.loop !62, !verifier.code !15

._crit_edge9:                                     ; preds = %37
  %split = phi i32 [ %38, %37 ], !verifier.code !15
  br label %40, !dbg !55, !verifier.code !15

40:                                               ; preds = %._crit_edge9, %31
  %.01.lcssa = phi i32 [ %split, %._crit_edge9 ], [ 0, %31 ], !dbg !64, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.01.lcssa, metadata !51, metadata !DIExpression()), !dbg !14, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 0, metadata !65, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %41 = mul nsw i32 %.03, %.04, !dbg !66, !verifier.code !15
  %42 = icmp slt i32 0, %41, !dbg !69, !verifier.code !15
  br i1 %42, label %.lr.ph, label %53, !dbg !70, !verifier.code !15

.lr.ph:                                           ; preds = %40
  br label %43, !dbg !70, !verifier.code !15

43:                                               ; preds = %forwarder, %.lr.ph
  %.025 = phi i32 [ 0, %.lr.ph ], [ %51, %forwarder ], !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %.025, metadata !65, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %44 = srem i32 %.01.lcssa, %.03, !dbg !71, !verifier.code !15
  %45 = sext i32 %44 to i64, !dbg !73, !verifier.code !15
  %46 = getelementptr inbounds i32, i32* %21, i64 %45, !dbg !73, !verifier.code !15
  %47 = load i32, i32* %46, align 4, !dbg !73, !verifier.code !15
  %48 = sext i32 %.025 to i64, !dbg !74, !verifier.code !15
  %49 = getelementptr inbounds i32, i32* %26, i64 %48, !dbg !74, !verifier.code !15
  store i32 %47, i32* %49, align 4, !dbg !75, !verifier.code !15
  br label %50, !dbg !76, !verifier.code !15

50:                                               ; preds = %43
  %51 = add nsw i32 %.025, 1, !dbg !77, !verifier.code !15
  call void @llvm.dbg.value(metadata i32 %51, metadata !65, metadata !DIExpression()), !dbg !14, !verifier.code !15
  %52 = icmp slt i32 %51, %41, !dbg !69, !verifier.code !15
  br i1 %52, label %forwarder, label %._crit_edge, !dbg !70, !llvm.loop !78, !verifier.code !15

._crit_edge:                                      ; preds = %50
  br label %53, !dbg !70, !verifier.code !15

53:                                               ; preds = %._crit_edge, %40
  br label %54, !dbg !80, !verifier.code !15

54:                                               ; preds = %53, %30
  ret i32 0, !dbg !81, !verifier.code !15

forwarder:                                        ; preds = %50
  br label %43, !verifier.code !15

forwarder10:                                      ; preds = %37
  br label %33, !verifier.code !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

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
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/array-memsafety/mult_array-alloca-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 512, type: !8, scopeLine: 512, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 514, column: 16, scope: !7)
!12 = !{i1 true}
!13 = !DILocalVariable(name: "length", scope: !7, file: !1, line: 514, type: !10)
!14 = !DILocation(line: 0, scope: !7)
!15 = !{i1 false}
!16 = !DILocation(line: 515, column: 14, scope: !17)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 515, column: 7)
!18 = !DILocation(line: 515, column: 18, scope: !17)
!19 = !DILocation(line: 515, column: 21, scope: !17)
!20 = !DILocation(line: 515, column: 28, scope: !17)
!21 = !DILocation(line: 515, column: 7, scope: !7)
!22 = !DILocation(line: 515, column: 57, scope: !17)
!23 = !DILocation(line: 516, column: 13, scope: !7)
!24 = !DILocalVariable(name: "fac", scope: !7, file: !1, line: 516, type: !10)
!25 = !DILocation(line: 517, column: 11, scope: !26)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 517, column: 7)
!27 = !DILocation(line: 517, column: 15, scope: !26)
!28 = !DILocation(line: 517, column: 18, scope: !26)
!29 = !DILocation(line: 517, column: 53, scope: !26)
!30 = !DILocation(line: 517, column: 51, scope: !26)
!31 = !DILocation(line: 517, column: 36, scope: !26)
!32 = !DILocation(line: 517, column: 22, scope: !26)
!33 = !DILocation(line: 517, column: 7, scope: !7)
!34 = !DILocation(line: 517, column: 62, scope: !26)
!35 = !DILocation(line: 518, column: 32, scope: !7)
!36 = !DILocation(line: 518, column: 38, scope: !7)
!37 = !DILocation(line: 518, column: 14, scope: !7)
!38 = !DILocalVariable(name: "arr", scope: !7, file: !1, line: 518, type: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!40 = !DILocation(line: 519, column: 36, scope: !7)
!41 = !DILocation(line: 519, column: 33, scope: !7)
!42 = !DILocation(line: 519, column: 43, scope: !7)
!43 = !DILocation(line: 519, column: 15, scope: !7)
!44 = !DILocalVariable(name: "arr2", scope: !7, file: !1, line: 519, type: !39)
!45 = !DILocation(line: 520, column: 8, scope: !46)
!46 = distinct !DILexicalBlock(scope: !7, file: !1, line: 520, column: 7)
!47 = !DILocation(line: 520, column: 12, scope: !46)
!48 = !DILocation(line: 520, column: 16, scope: !46)
!49 = !DILocation(line: 520, column: 7, scope: !7)
!50 = !DILocation(line: 520, column: 22, scope: !46)
!51 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 513, type: !10)
!52 = !DILocation(line: 521, column: 14, scope: !53)
!53 = distinct !DILexicalBlock(scope: !54, file: !1, line: 521, column: 3)
!54 = distinct !DILexicalBlock(scope: !7, file: !1, line: 521, column: 3)
!55 = !DILocation(line: 521, column: 3, scope: !54)
!56 = !DILocation(line: 522, column: 14, scope: !57)
!57 = distinct !DILexicalBlock(scope: !53, file: !1, line: 521, column: 28)
!58 = !DILocation(line: 522, column: 5, scope: !57)
!59 = !DILocation(line: 522, column: 12, scope: !57)
!60 = !DILocation(line: 523, column: 3, scope: !57)
!61 = !DILocation(line: 521, column: 24, scope: !53)
!62 = distinct !{!62, !55, !63}
!63 = !DILocation(line: 523, column: 3, scope: !54)
!64 = !DILocation(line: 0, scope: !54)
!65 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 513, type: !10)
!66 = !DILocation(line: 524, column: 21, scope: !67)
!67 = distinct !DILexicalBlock(scope: !68, file: !1, line: 524, column: 3)
!68 = distinct !DILexicalBlock(scope: !7, file: !1, line: 524, column: 3)
!69 = !DILocation(line: 524, column: 14, scope: !67)
!70 = !DILocation(line: 524, column: 3, scope: !68)
!71 = !DILocation(line: 525, column: 21, scope: !72)
!72 = distinct !DILexicalBlock(scope: !67, file: !1, line: 524, column: 32)
!73 = !DILocation(line: 525, column: 15, scope: !72)
!74 = !DILocation(line: 525, column: 5, scope: !72)
!75 = !DILocation(line: 525, column: 13, scope: !72)
!76 = !DILocation(line: 526, column: 3, scope: !72)
!77 = !DILocation(line: 524, column: 28, scope: !67)
!78 = distinct !{!78, !70, !79}
!79 = !DILocation(line: 526, column: 3, scope: !68)
!80 = !DILocation(line: 527, column: 3, scope: !7)
!81 = !DILocation(line: 528, column: 1, scope: !7)
