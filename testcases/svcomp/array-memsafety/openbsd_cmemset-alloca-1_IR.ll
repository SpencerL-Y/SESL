; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-g5vu2qtp.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define internal i8* @cmemset(i8* %0, i32 %1, i32 %2) #0 !dbg !11 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !18, metadata !DIExpression()), !dbg !19, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %1, metadata !21, metadata !DIExpression()), !dbg !19, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %2, metadata !22, metadata !DIExpression()), !dbg !19, !verifier.code !20
  %4 = icmp ne i32 %2, 0, !dbg !23, !verifier.code !20
  br i1 %4, label %5, label %13, !dbg !25, !verifier.code !20

5:                                                ; preds = %3
  call void @llvm.dbg.value(metadata i8* %0, metadata !26, metadata !DIExpression()), !dbg !29, !verifier.code !20
  br label %6, !dbg !30, !verifier.code !20

6:                                                ; preds = %forwarder, %5
  %.01 = phi i32 [ %2, %5 ], [ %10, %forwarder ], !verifier.code !20
  %.0 = phi i8* [ %0, %5 ], [ %8, %forwarder ], !dbg !29, !verifier.code !20
  call void @llvm.dbg.value(metadata i8* %.0, metadata !26, metadata !DIExpression()), !dbg !29, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %.01, metadata !22, metadata !DIExpression()), !dbg !19, !verifier.code !20
  %7 = trunc i32 %1 to i8, !dbg !31, !verifier.code !20
  %8 = getelementptr inbounds i8, i8* %.0, i32 1, !dbg !32, !verifier.code !20
  call void @llvm.dbg.value(metadata i8* %8, metadata !26, metadata !DIExpression()), !dbg !29, !verifier.code !20
  store i8 %7, i8* %.0, align 1, !dbg !33, !verifier.code !20
  br label %9, !dbg !34, !verifier.code !20

9:                                                ; preds = %6
  %10 = add i32 %.01, -1, !dbg !35, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %10, metadata !22, metadata !DIExpression()), !dbg !19, !verifier.code !20
  %11 = icmp ne i32 %10, 0, !dbg !36, !verifier.code !20
  br i1 %11, label %forwarder, label %12, !dbg !34, !llvm.loop !37, !verifier.code !20

12:                                               ; preds = %9
  br label %13, !dbg !39, !verifier.code !20

13:                                               ; preds = %12, %3
  ret i8* %0, !dbg !40, !verifier.code !20

forwarder:                                        ; preds = %9
  br label %6, !verifier.code !20
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !41 {
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !44, !verifier.code !45
  call void @llvm.dbg.value(metadata i32 %1, metadata !46, metadata !DIExpression()), !dbg !47, !verifier.code !20
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !48, !verifier.code !45
  call void @llvm.dbg.value(metadata i32 %2, metadata !49, metadata !DIExpression()), !dbg !47, !verifier.code !20
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !50, !verifier.code !45
  call void @llvm.dbg.value(metadata i32 %3, metadata !51, metadata !DIExpression()), !dbg !47, !verifier.code !20
  %4 = icmp slt i32 %1, 1, !dbg !52, !verifier.code !20
  br i1 %4, label %5, label %6, !dbg !54, !verifier.code !20

5:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 1, metadata !46, metadata !DIExpression()), !dbg !47, !verifier.code !20
  br label %6, !dbg !55, !verifier.code !20

6:                                                ; preds = %5, %0
  %7 = icmp slt i32 %2, 1, !dbg !57, !verifier.code !20
  br i1 %7, label %8, label %9, !dbg !59, !verifier.code !20

8:                                                ; preds = %6
  call void @llvm.dbg.value(metadata i32 1, metadata !49, metadata !DIExpression()), !dbg !47, !verifier.code !20
  br label %9, !dbg !60, !verifier.code !20

9:                                                ; preds = %8, %6
  %.0 = phi i32 [ 1, %8 ], [ %2, %6 ], !dbg !47, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %.0, metadata !49, metadata !DIExpression()), !dbg !47, !verifier.code !20
  %10 = sext i32 %.0 to i64, !dbg !62, !verifier.code !20
  %11 = mul i64 %10, 1, !dbg !63, !verifier.code !20
  %12 = alloca i8, i64 %11, align 16, !dbg !64, !verifier.code !20
  call void @llvm.dbg.value(metadata i8* %12, metadata !65, metadata !DIExpression()), !dbg !47, !verifier.code !20
  %13 = call i8* @cmemset(i8* %12, i32 %3, i32 %.0), !dbg !66, !verifier.code !20
  ret i32 0, !dbg !67, !verifier.code !20
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
!llvm.ident = !{!7}
!llvm.module.flags = !{!8, !9, !10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/array-memsafety/openbsd_cmemset-alloca-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "cmemset", scope: !1, file: !1, line: 513, type: !12, scopeLine: 514, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{!14, !14, !15, !16}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !1, line: 1, baseType: !17)
!17 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!18 = !DILocalVariable(name: "dst", arg: 1, scope: !11, file: !1, line: 513, type: !14)
!19 = !DILocation(line: 0, scope: !11)
!20 = !{i1 false}
!21 = !DILocalVariable(name: "c", arg: 2, scope: !11, file: !1, line: 513, type: !15)
!22 = !DILocalVariable(name: "n", arg: 3, scope: !11, file: !1, line: 513, type: !16)
!23 = !DILocation(line: 515, column: 8, scope: !24)
!24 = distinct !DILexicalBlock(scope: !11, file: !1, line: 515, column: 6)
!25 = !DILocation(line: 515, column: 6, scope: !11)
!26 = !DILocalVariable(name: "d", scope: !27, file: !1, line: 516, type: !28)
!27 = distinct !DILexicalBlock(scope: !24, file: !1, line: 515, column: 14)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !4, size: 64)
!29 = !DILocation(line: 0, scope: !27)
!30 = !DILocation(line: 517, column: 3, scope: !27)
!31 = !DILocation(line: 518, column: 11, scope: !27)
!32 = !DILocation(line: 518, column: 6, scope: !27)
!33 = !DILocation(line: 518, column: 9, scope: !27)
!34 = !DILocation(line: 518, column: 4, scope: !27)
!35 = !DILocation(line: 519, column: 10, scope: !27)
!36 = !DILocation(line: 519, column: 14, scope: !27)
!37 = distinct !{!37, !30, !38}
!38 = !DILocation(line: 519, column: 18, scope: !27)
!39 = !DILocation(line: 520, column: 2, scope: !27)
!40 = !DILocation(line: 521, column: 2, scope: !11)
!41 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 523, type: !42, scopeLine: 523, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!42 = !DISubroutineType(types: !43)
!43 = !{!15}
!44 = !DILocation(line: 524, column: 16, scope: !41)
!45 = !{i1 true}
!46 = !DILocalVariable(name: "length", scope: !41, file: !1, line: 524, type: !15)
!47 = !DILocation(line: 0, scope: !41)
!48 = !DILocation(line: 525, column: 11, scope: !41)
!49 = !DILocalVariable(name: "n", scope: !41, file: !1, line: 525, type: !15)
!50 = !DILocation(line: 526, column: 11, scope: !41)
!51 = !DILocalVariable(name: "c", scope: !41, file: !1, line: 526, type: !15)
!52 = !DILocation(line: 527, column: 14, scope: !53)
!53 = distinct !DILexicalBlock(scope: !41, file: !1, line: 527, column: 7)
!54 = !DILocation(line: 527, column: 7, scope: !41)
!55 = !DILocation(line: 529, column: 3, scope: !56)
!56 = distinct !DILexicalBlock(scope: !53, file: !1, line: 527, column: 19)
!57 = !DILocation(line: 530, column: 9, scope: !58)
!58 = distinct !DILexicalBlock(scope: !41, file: !1, line: 530, column: 7)
!59 = !DILocation(line: 530, column: 7, scope: !41)
!60 = !DILocation(line: 532, column: 3, scope: !61)
!61 = distinct !DILexicalBlock(scope: !58, file: !1, line: 530, column: 14)
!62 = !DILocation(line: 533, column: 48, scope: !41)
!63 = !DILocation(line: 533, column: 50, scope: !41)
!64 = !DILocation(line: 533, column: 30, scope: !41)
!65 = !DILocalVariable(name: "nondetArea", scope: !41, file: !1, line: 533, type: !5)
!66 = !DILocation(line: 534, column: 3, scope: !41)
!67 = !DILocation(line: 535, column: 3, scope: !41)
