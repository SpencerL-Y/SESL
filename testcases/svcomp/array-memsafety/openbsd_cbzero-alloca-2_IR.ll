; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-zwwhzhpx.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define internal void @cbzero(i8* %0, i32 %1) #0 !dbg !10 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !16, metadata !DIExpression()), !dbg !17, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %1, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %0, metadata !20, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %3 = add i32 %1, -1, !dbg !21, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %3, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %4 = icmp ne i32 %1, 0, !dbg !24, !verifier.code !18
  br i1 %4, label %.lr.ph, label %10, !dbg !24, !verifier.code !18

.lr.ph:                                           ; preds = %2
  br label %5, !dbg !24, !verifier.code !18

5:                                                ; preds = %forwarder, %.lr.ph
  %6 = phi i32 [ %3, %.lr.ph ], [ %8, %forwarder ], !verifier.code !18
  %.02 = phi i8* [ %0, %.lr.ph ], [ %7, %forwarder ], !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %.02, metadata !20, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %7 = getelementptr inbounds i8, i8* %.02, i32 1, !dbg !25, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %7, metadata !20, metadata !DIExpression()), !dbg !17, !verifier.code !18
  store i8 0, i8* %.02, align 1, !dbg !26, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %6, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %8 = add i32 %6, -1, !dbg !21, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %8, metadata !19, metadata !DIExpression()), !dbg !17, !verifier.code !18
  %9 = icmp ne i32 %6, 0, !dbg !24, !verifier.code !18
  br i1 %9, label %forwarder, label %._crit_edge, !dbg !24, !llvm.loop !27, !verifier.code !18

._crit_edge:                                      ; preds = %5
  br label %10, !dbg !24, !verifier.code !18

10:                                               ; preds = %._crit_edge, %2
  ret void, !dbg !29, !verifier.code !18

forwarder:                                        ; preds = %5
  br label %5, !verifier.code !18
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !30 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !34, !verifier.code !35
  call void @llvm.dbg.value(metadata i32 %1, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !18
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !38, !verifier.code !35
  call void @llvm.dbg.value(metadata i32 %2, metadata !39, metadata !DIExpression()), !dbg !37, !verifier.code !18
  %3 = icmp slt i32 %1, 1, !dbg !40, !verifier.code !18
  br i1 %3, label %4, label %5, !dbg !42, !verifier.code !18

4:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 1, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !18
  br label %5, !dbg !43, !verifier.code !18

5:                                                ; preds = %4, %0
  %.01 = phi i32 [ 1, %4 ], [ %1, %0 ], !dbg !37, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %.01, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !18
  %6 = icmp slt i32 %2, 1, !dbg !45, !verifier.code !18
  br i1 %6, label %7, label %8, !dbg !47, !verifier.code !18

7:                                                ; preds = %5
  call void @llvm.dbg.value(metadata i32 1, metadata !39, metadata !DIExpression()), !dbg !37, !verifier.code !18
  br label %8, !dbg !48, !verifier.code !18

8:                                                ; preds = %7, %5
  %.02 = phi i32 [ 1, %7 ], [ %2, %5 ], !dbg !37, !verifier.code !18
  call void @llvm.dbg.value(metadata i32 %.02, metadata !39, metadata !DIExpression()), !dbg !37, !verifier.code !18
  %9 = icmp sgt i32 %.02, %.01, !dbg !50, !verifier.code !18
  br i1 %9, label %10, label %11, !dbg !52, !verifier.code !18

10:                                               ; preds = %8
  br label %15, !dbg !53, !verifier.code !18

11:                                               ; preds = %8
  %12 = sext i32 %.01 to i64, !dbg !54, !verifier.code !18
  %13 = mul i64 %12, 1, !dbg !55, !verifier.code !18
  %14 = alloca i8, i64 %13, align 16, !dbg !56, !verifier.code !18
  call void @llvm.dbg.value(metadata i8* %14, metadata !57, metadata !DIExpression()), !dbg !37, !verifier.code !18
  call void @cbzero(i8* %14, i32 %.02), !dbg !58, !verifier.code !18
  br label %15, !dbg !59, !verifier.code !18

15:                                               ; preds = %11, %10
  ret i32 0, !dbg !60, !verifier.code !18
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
!1 = !DIFile(filename: "../testcases/svcomp/array-memsafety/openbsd_cbzero-alloca-2.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "cbzero", scope: !1, file: !1, line: 513, type: !11, scopeLine: 514, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{null, !13, !14}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1, line: 1, baseType: !15)
!15 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!16 = !DILocalVariable(name: "b", arg: 1, scope: !10, file: !1, line: 513, type: !13)
!17 = !DILocation(line: 0, scope: !10)
!18 = !{i1 false}
!19 = !DILocalVariable(name: "length", arg: 2, scope: !10, file: !1, line: 513, type: !14)
!20 = !DILocalVariable(name: "p", scope: !10, file: !1, line: 515, type: !4)
!21 = !DILocation(line: 516, column: 20, scope: !22)
!22 = distinct !DILexicalBlock(scope: !23, file: !1, line: 516, column: 2)
!23 = distinct !DILexicalBlock(scope: !10, file: !1, line: 516, column: 2)
!24 = !DILocation(line: 516, column: 2, scope: !23)
!25 = !DILocation(line: 517, column: 5, scope: !22)
!26 = !DILocation(line: 517, column: 8, scope: !22)
!27 = distinct !{!27, !24, !28}
!28 = !DILocation(line: 517, column: 10, scope: !23)
!29 = !DILocation(line: 518, column: 1, scope: !10)
!30 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 519, type: !31, scopeLine: 519, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!33}
!33 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!34 = !DILocation(line: 520, column: 16, scope: !30)
!35 = !{i1 true}
!36 = !DILocalVariable(name: "length", scope: !30, file: !1, line: 520, type: !33)
!37 = !DILocation(line: 0, scope: !30)
!38 = !DILocation(line: 521, column: 11, scope: !30)
!39 = !DILocalVariable(name: "n", scope: !30, file: !1, line: 521, type: !33)
!40 = !DILocation(line: 522, column: 14, scope: !41)
!41 = distinct !DILexicalBlock(scope: !30, file: !1, line: 522, column: 7)
!42 = !DILocation(line: 522, column: 7, scope: !30)
!43 = !DILocation(line: 524, column: 3, scope: !44)
!44 = distinct !DILexicalBlock(scope: !41, file: !1, line: 522, column: 19)
!45 = !DILocation(line: 525, column: 9, scope: !46)
!46 = distinct !DILexicalBlock(scope: !30, file: !1, line: 525, column: 7)
!47 = !DILocation(line: 525, column: 7, scope: !30)
!48 = !DILocation(line: 527, column: 3, scope: !49)
!49 = distinct !DILexicalBlock(scope: !46, file: !1, line: 525, column: 14)
!50 = !DILocation(line: 528, column: 9, scope: !51)
!51 = distinct !DILexicalBlock(scope: !30, file: !1, line: 528, column: 7)
!52 = !DILocation(line: 528, column: 7, scope: !30)
!53 = !DILocation(line: 528, column: 19, scope: !51)
!54 = !DILocation(line: 529, column: 48, scope: !30)
!55 = !DILocation(line: 529, column: 55, scope: !30)
!56 = !DILocation(line: 529, column: 30, scope: !30)
!57 = !DILocalVariable(name: "nondetArea", scope: !30, file: !1, line: 529, type: !4)
!58 = !DILocation(line: 530, column: 3, scope: !30)
!59 = !DILocation(line: 531, column: 3, scope: !30)
!60 = !DILocation(line: 532, column: 1, scope: !30)
