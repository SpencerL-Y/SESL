; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-bm3mrjyf.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@n = internal global i32 0, align 4, !dbg !0
@a = internal global i32* null, align 8, !dbg !6
@b = internal global i32* null, align 8, !dbg !10
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"960521-1-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !16 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !19, !verifier.code !22
  unreachable, !dbg !19, !verifier.code !22
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @foo() #0 !dbg !23 {
  call void @llvm.dbg.value(metadata i32 0, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !22
  %1 = load i32, i32* @n, align 4, !dbg !26, !verifier.code !22
  %2 = icmp slt i32 0, %1, !dbg !29, !verifier.code !22
  br i1 %2, label %.lr.ph, label %11, !dbg !30, !verifier.code !22

.lr.ph:                                           ; preds = %0
  br label %3, !dbg !30, !verifier.code !22

3:                                                ; preds = %forwarder3, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %8, %forwarder3 ], !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.02, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !22
  %4 = load i32*, i32** @a, align 8, !dbg !31, !verifier.code !22
  %5 = sext i32 %.02 to i64, !dbg !31, !verifier.code !22
  %6 = getelementptr inbounds i32, i32* %4, i64 %5, !dbg !31, !verifier.code !22
  store i32 -1, i32* %6, align 4, !dbg !32, !verifier.code !22
  br label %7, !dbg !31, !verifier.code !22

7:                                                ; preds = %3
  %8 = add nsw i32 %.02, 1, !dbg !33, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %8, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !22
  %9 = load i32, i32* @n, align 4, !dbg !26, !verifier.code !22
  %10 = icmp slt i32 %8, %9, !dbg !29, !verifier.code !22
  br i1 %10, label %forwarder3, label %._crit_edge, !dbg !30, !llvm.loop !34, !verifier.code !22

._crit_edge:                                      ; preds = %7
  br label %11, !dbg !30, !verifier.code !22

11:                                               ; preds = %._crit_edge, %0
  call void @llvm.dbg.value(metadata i32 0, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !22
  br label %12, !dbg !36, !verifier.code !22

12:                                               ; preds = %forwarder, %11
  %.11 = phi i32 [ 0, %11 ], [ %17, %forwarder ], !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %.11, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !22
  %13 = load i32*, i32** @b, align 8, !dbg !38, !verifier.code !22
  %14 = sext i32 %.11 to i64, !dbg !38, !verifier.code !22
  %15 = getelementptr inbounds i32, i32* %13, i64 %14, !dbg !38, !verifier.code !22
  store i32 -1, i32* %15, align 4, !dbg !40, !verifier.code !22
  br label %16, !dbg !38, !verifier.code !22

16:                                               ; preds = %12
  %17 = add nsw i32 %.11, 1, !dbg !41, !verifier.code !22
  call void @llvm.dbg.value(metadata i32 %17, metadata !24, metadata !DIExpression()), !dbg !25, !verifier.code !22
  %18 = icmp slt i32 %17, 32767, !dbg !42, !verifier.code !22
  br i1 %18, label %forwarder, label %19, !dbg !36, !llvm.loop !43, !verifier.code !22

19:                                               ; preds = %16
  ret void, !dbg !45, !verifier.code !22

forwarder:                                        ; preds = %16
  br label %12, !verifier.code !22

forwarder3:                                       ; preds = %7
  br label %3, !verifier.code !22
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !46 {
  store i32 32768, i32* @n, align 4, !dbg !49, !verifier.code !22
  %1 = load i32, i32* @n, align 4, !dbg !50, !verifier.code !22
  %2 = sext i32 %1 to i64, !dbg !50, !verifier.code !22
  %3 = mul i64 %2, 4, !dbg !51, !verifier.code !22
  %4 = trunc i64 %3 to i32, !dbg !50, !verifier.code !22
  %5 = call noalias i8* @malloc(i32 %4) #5, !dbg !52, !verifier.code !22
  %6 = bitcast i8* %5 to i32*, !dbg !52, !verifier.code !22
  store i32* %6, i32** @a, align 8, !dbg !53, !verifier.code !22
  %7 = load i32, i32* @n, align 4, !dbg !54, !verifier.code !22
  %8 = sext i32 %7 to i64, !dbg !54, !verifier.code !22
  %9 = mul i64 %8, 4, !dbg !55, !verifier.code !22
  %10 = trunc i64 %9 to i32, !dbg !54, !verifier.code !22
  %11 = call noalias i8* @malloc(i32 %10) #5, !dbg !56, !verifier.code !22
  %12 = bitcast i8* %11 to i32*, !dbg !56, !verifier.code !22
  store i32* %12, i32** @b, align 8, !dbg !57, !verifier.code !22
  %13 = load i32*, i32** @b, align 8, !dbg !58, !verifier.code !22
  %14 = getelementptr inbounds i32, i32* %13, i32 1, !dbg !58, !verifier.code !22
  store i32* %14, i32** @b, align 8, !dbg !58, !verifier.code !22
  store i32 0, i32* %13, align 4, !dbg !59, !verifier.code !22
  call void @foo(), !dbg !60, !verifier.code !22
  %15 = load i32*, i32** @b, align 8, !dbg !61, !verifier.code !22
  %16 = getelementptr inbounds i32, i32* %15, i64 -1, !dbg !61, !verifier.code !22
  %17 = load i32, i32* %16, align 4, !dbg !61, !verifier.code !22
  %18 = icmp ne i32 %17, 0, !dbg !61, !verifier.code !22
  br i1 %18, label %19, label %24, !dbg !63, !verifier.code !22

19:                                               ; preds = %0
  %20 = load i32*, i32** @a, align 8, !dbg !64, !verifier.code !22
  %21 = bitcast i32* %20 to i8*, !dbg !64, !verifier.code !22
  call void @free(i8* %21) #5, !dbg !66, !verifier.code !22
  %22 = load i32*, i32** @b, align 8, !dbg !67, !verifier.code !22
  %23 = bitcast i32* %22 to i8*, !dbg !67, !verifier.code !22
  call void @free(i8* %23) #5, !dbg !68, !verifier.code !22
  br label %30, !dbg !69, !verifier.code !22

24:                                               ; preds = %0
  %25 = load i32*, i32** @a, align 8, !dbg !70, !verifier.code !22
  %26 = bitcast i32* %25 to i8*, !dbg !70, !verifier.code !22
  call void @free(i8* %26) #5, !dbg !72, !verifier.code !22
  %27 = load i32*, i32** @b, align 8, !dbg !73, !verifier.code !22
  %28 = getelementptr inbounds i32, i32* %27, i64 -1, !dbg !74, !verifier.code !22
  %29 = bitcast i32* %28 to i8*, !dbg !73, !verifier.code !22
  call void @free(i8* %29) #5, !dbg !75, !verifier.code !22
  br label %30, !verifier.code !22

30:                                               ; preds = %24, %19
  ret i32 0, !dbg !76, !verifier.code !22
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  store i32 0, i32* @n
  store i32* null, i32** @a
  store i32* null, i32** @b
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!12}
!llvm.module.flags = !{!13, !14, !15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "n", scope: !2, file: !3, line: 524, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/960521-1-2.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !10, !0}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 523, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 523, type: !8, isLocal: false, isDefinition: true)
!12 = !{!"clang version 10.0.0-4ubuntu1 "}
!13 = !{i32 7, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 12, type: !17, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{null}
!19 = !DILocation(line: 12, column: 83, scope: !20)
!20 = distinct !DILexicalBlock(scope: !21, file: !3, line: 12, column: 73)
!21 = distinct !DILexicalBlock(scope: !16, file: !3, line: 12, column: 67)
!22 = !{i1 false}
!23 = distinct !DISubprogram(name: "foo", scope: !3, file: !3, line: 525, type: !17, scopeLine: 526, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!24 = !DILocalVariable(name: "i", scope: !23, file: !3, line: 527, type: !9)
!25 = !DILocation(line: 0, scope: !23)
!26 = !DILocation(line: 528, column: 19, scope: !27)
!27 = distinct !DILexicalBlock(scope: !28, file: !3, line: 528, column: 3)
!28 = distinct !DILexicalBlock(scope: !23, file: !3, line: 528, column: 3)
!29 = !DILocation(line: 528, column: 17, scope: !27)
!30 = !DILocation(line: 528, column: 3, scope: !28)
!31 = !DILocation(line: 529, column: 5, scope: !27)
!32 = !DILocation(line: 529, column: 10, scope: !27)
!33 = !DILocation(line: 528, column: 23, scope: !27)
!34 = distinct !{!34, !30, !35}
!35 = !DILocation(line: 529, column: 13, scope: !28)
!36 = !DILocation(line: 530, column: 3, scope: !37)
!37 = distinct !DILexicalBlock(scope: !23, file: !3, line: 530, column: 3)
!38 = !DILocation(line: 531, column: 5, scope: !39)
!39 = distinct !DILexicalBlock(scope: !37, file: !3, line: 530, column: 3)
!40 = !DILocation(line: 531, column: 10, scope: !39)
!41 = !DILocation(line: 530, column: 31, scope: !39)
!42 = !DILocation(line: 530, column: 17, scope: !39)
!43 = distinct !{!43, !36, !44}
!44 = !DILocation(line: 531, column: 13, scope: !37)
!45 = !DILocation(line: 532, column: 1, scope: !23)
!46 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 533, type: !47, scopeLine: 534, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!47 = !DISubroutineType(types: !48)
!48 = !{!9}
!49 = !DILocation(line: 535, column: 5, scope: !46)
!50 = !DILocation(line: 536, column: 15, scope: !46)
!51 = !DILocation(line: 536, column: 17, scope: !46)
!52 = !DILocation(line: 536, column: 7, scope: !46)
!53 = !DILocation(line: 536, column: 5, scope: !46)
!54 = !DILocation(line: 537, column: 15, scope: !46)
!55 = !DILocation(line: 537, column: 17, scope: !46)
!56 = !DILocation(line: 537, column: 7, scope: !46)
!57 = !DILocation(line: 537, column: 5, scope: !46)
!58 = !DILocation(line: 538, column: 5, scope: !46)
!59 = !DILocation(line: 538, column: 8, scope: !46)
!60 = !DILocation(line: 539, column: 3, scope: !46)
!61 = !DILocation(line: 540, column: 7, scope: !62)
!62 = distinct !DILexicalBlock(scope: !46, file: !3, line: 540, column: 7)
!63 = !DILocation(line: 540, column: 7, scope: !46)
!64 = !DILocation(line: 541, column: 10, scope: !65)
!65 = distinct !DILexicalBlock(scope: !62, file: !3, line: 541, column: 3)
!66 = !DILocation(line: 541, column: 5, scope: !65)
!67 = !DILocation(line: 541, column: 19, scope: !65)
!68 = !DILocation(line: 541, column: 14, scope: !65)
!69 = !DILocation(line: 541, column: 23, scope: !65)
!70 = !DILocation(line: 543, column: 10, scope: !71)
!71 = distinct !DILexicalBlock(scope: !62, file: !3, line: 543, column: 3)
!72 = !DILocation(line: 543, column: 5, scope: !71)
!73 = !DILocation(line: 543, column: 19, scope: !71)
!74 = !DILocation(line: 543, column: 20, scope: !71)
!75 = !DILocation(line: 543, column: 14, scope: !71)
!76 = !DILocation(line: 544, column: 3, scope: !46)
