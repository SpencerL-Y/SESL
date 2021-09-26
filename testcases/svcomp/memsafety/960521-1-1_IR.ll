; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-d07gb4og.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@n = internal global i32 0, align 4, !dbg !0
@a = internal global i32* null, align 8, !dbg !6
@b = internal global i32* null, align 8, !dbg !11
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [34 x i8] c"../svcomp/memsafety//960521-1-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !17 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !20, !verifier.code !23
  unreachable, !dbg !20, !verifier.code !23
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @foo() #0 !dbg !24 {
  call void @llvm.dbg.value(metadata i32 0, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  %1 = load i32, i32* @n, align 4, !dbg !27, !verifier.code !23
  %2 = icmp slt i32 0, %1, !dbg !30, !verifier.code !23
  br i1 %2, label %.lr.ph, label %11, !dbg !31, !verifier.code !23

.lr.ph:                                           ; preds = %0
  br label %3, !dbg !31, !verifier.code !23

3:                                                ; preds = %forwarder3, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %8, %forwarder3 ], !verifier.code !23
  call void @llvm.dbg.value(metadata i32 %.02, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  %4 = load i32*, i32** @a, align 8, !dbg !32, !verifier.code !23
  %5 = sext i32 %.02 to i64, !dbg !32, !verifier.code !23
  %6 = getelementptr inbounds i32, i32* %4, i64 %5, !dbg !32, !verifier.code !23
  store i32 -1, i32* %6, align 4, !dbg !33, !verifier.code !23
  br label %7, !dbg !32, !verifier.code !23

7:                                                ; preds = %3
  %8 = add nsw i32 %.02, 1, !dbg !34, !verifier.code !23
  call void @llvm.dbg.value(metadata i32 %8, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  %9 = load i32, i32* @n, align 4, !dbg !27, !verifier.code !23
  %10 = icmp slt i32 %8, %9, !dbg !30, !verifier.code !23
  br i1 %10, label %forwarder3, label %._crit_edge, !dbg !31, !llvm.loop !35, !verifier.code !23

._crit_edge:                                      ; preds = %7
  br label %11, !dbg !31, !verifier.code !23

11:                                               ; preds = %._crit_edge, %0
  call void @llvm.dbg.value(metadata i32 0, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  br label %12, !dbg !37, !verifier.code !23

12:                                               ; preds = %forwarder, %11
  %.11 = phi i32 [ 0, %11 ], [ %17, %forwarder ], !verifier.code !23
  call void @llvm.dbg.value(metadata i32 %.11, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  %13 = load i32*, i32** @b, align 8, !dbg !39, !verifier.code !23
  %14 = sext i32 %.11 to i64, !dbg !39, !verifier.code !23
  %15 = getelementptr inbounds i32, i32* %13, i64 %14, !dbg !39, !verifier.code !23
  store i32 -1, i32* %15, align 4, !dbg !41, !verifier.code !23
  br label %16, !dbg !39, !verifier.code !23

16:                                               ; preds = %12
  %17 = add nsw i32 %.11, 1, !dbg !42, !verifier.code !23
  call void @llvm.dbg.value(metadata i32 %17, metadata !25, metadata !DIExpression()), !dbg !26, !verifier.code !23
  %18 = icmp slt i32 %17, 127, !dbg !43, !verifier.code !23
  br i1 %18, label %forwarder, label %19, !dbg !37, !llvm.loop !44, !verifier.code !23

19:                                               ; preds = %16
  ret void, !dbg !46, !verifier.code !23

forwarder:                                        ; preds = %16
  br label %12, !verifier.code !23

forwarder3:                                       ; preds = %7
  br label %3, !verifier.code !23
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !47 {
  store i32 128, i32* @n, align 4, !dbg !50, !verifier.code !23
  %1 = load i32, i32* @n, align 4, !dbg !51, !verifier.code !23
  %2 = sext i32 %1 to i64, !dbg !51, !verifier.code !23
  %3 = mul i64 %2, 4, !dbg !52, !verifier.code !23
  %4 = call noalias i8* @malloc(i64 %3) #5, !dbg !53, !verifier.code !23
  %5 = bitcast i8* %4 to i32*, !dbg !53, !verifier.code !23
  store i32* %5, i32** @a, align 8, !dbg !54, !verifier.code !23
  %6 = load i32, i32* @n, align 4, !dbg !55, !verifier.code !23
  %7 = sext i32 %6 to i64, !dbg !55, !verifier.code !23
  %8 = mul i64 %7, 4, !dbg !56, !verifier.code !23
  %9 = call noalias i8* @malloc(i64 %8) #5, !dbg !57, !verifier.code !23
  %10 = bitcast i8* %9 to i32*, !dbg !57, !verifier.code !23
  store i32* %10, i32** @b, align 8, !dbg !58, !verifier.code !23
  %11 = load i32*, i32** @b, align 8, !dbg !59, !verifier.code !23
  %12 = getelementptr inbounds i32, i32* %11, i32 1, !dbg !59, !verifier.code !23
  store i32* %12, i32** @b, align 8, !dbg !59, !verifier.code !23
  store i32 0, i32* %11, align 4, !dbg !60, !verifier.code !23
  call void @foo(), !dbg !61, !verifier.code !23
  %13 = load i32*, i32** @b, align 8, !dbg !62, !verifier.code !23
  %14 = getelementptr inbounds i32, i32* %13, i64 -1, !dbg !62, !verifier.code !23
  %15 = load i32, i32* %14, align 4, !dbg !62, !verifier.code !23
  %16 = icmp ne i32 %15, 0, !dbg !62, !verifier.code !23
  br i1 %16, label %17, label %22, !dbg !64, !verifier.code !23

17:                                               ; preds = %0
  %18 = load i32*, i32** @a, align 8, !dbg !65, !verifier.code !23
  %19 = bitcast i32* %18 to i8*, !dbg !65, !verifier.code !23
  call void @free(i8* %19) #5, !dbg !67, !verifier.code !23
  %20 = load i32*, i32** @b, align 8, !dbg !68, !verifier.code !23
  %21 = bitcast i32* %20 to i8*, !dbg !68, !verifier.code !23
  call void @free(i8* %21) #5, !dbg !69, !verifier.code !23
  br label %27, !dbg !70, !verifier.code !23

22:                                               ; preds = %0
  %23 = load i32*, i32** @a, align 8, !dbg !71, !verifier.code !23
  %24 = bitcast i32* %23 to i8*, !dbg !71, !verifier.code !23
  call void @free(i8* %24) #5, !dbg !73, !verifier.code !23
  %25 = load i32*, i32** @b, align 8, !dbg !74, !verifier.code !23
  %26 = bitcast i32* %25 to i8*, !dbg !74, !verifier.code !23
  call void @free(i8* %26) #5, !dbg !75, !verifier.code !23
  br label %27, !verifier.code !23

27:                                               ; preds = %22, %17
  ret i32 0, !dbg !76, !verifier.code !23
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

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
!llvm.ident = !{!13}
!llvm.module.flags = !{!14, !15, !16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "n", scope: !2, file: !8, line: 8, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../svcomp/memsafety/960521-1-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !{}
!5 = !{!6, !11, !0}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !8, line: 7, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "../svcomp/memsafety//960521-1-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !8, line: 7, type: !9, isLocal: false, isDefinition: true)
!13 = !{!"clang version 10.0.0-4ubuntu1 "}
!14 = !{i32 7, !"Dwarf Version", i32 4}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = distinct !DISubprogram(name: "reach_error", scope: !8, file: !8, line: 3, type: !18, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!18 = !DISubroutineType(types: !19)
!19 = !{null}
!20 = !DILocation(line: 3, column: 22, scope: !21)
!21 = distinct !DILexicalBlock(scope: !22, file: !8, line: 3, column: 22)
!22 = distinct !DILexicalBlock(scope: !17, file: !8, line: 3, column: 22)
!23 = !{i1 false}
!24 = distinct !DISubprogram(name: "foo", scope: !8, file: !8, line: 12, type: !18, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!25 = !DILocalVariable(name: "i", scope: !24, file: !8, line: 14, type: !10)
!26 = !DILocation(line: 0, scope: !24)
!27 = !DILocation(line: 15, column: 19, scope: !28)
!28 = distinct !DILexicalBlock(scope: !29, file: !8, line: 15, column: 3)
!29 = distinct !DILexicalBlock(scope: !24, file: !8, line: 15, column: 3)
!30 = !DILocation(line: 15, column: 17, scope: !28)
!31 = !DILocation(line: 15, column: 3, scope: !29)
!32 = !DILocation(line: 16, column: 5, scope: !28)
!33 = !DILocation(line: 16, column: 10, scope: !28)
!34 = !DILocation(line: 15, column: 23, scope: !28)
!35 = distinct !{!35, !31, !36}
!36 = !DILocation(line: 16, column: 13, scope: !29)
!37 = !DILocation(line: 17, column: 3, scope: !38)
!38 = distinct !DILexicalBlock(scope: !24, file: !8, line: 17, column: 3)
!39 = !DILocation(line: 18, column: 5, scope: !40)
!40 = distinct !DILexicalBlock(scope: !38, file: !8, line: 17, column: 3)
!41 = !DILocation(line: 18, column: 10, scope: !40)
!42 = !DILocation(line: 17, column: 36, scope: !40)
!43 = !DILocation(line: 17, column: 17, scope: !40)
!44 = distinct !{!44, !37, !45}
!45 = !DILocation(line: 18, column: 13, scope: !38)
!46 = !DILocation(line: 19, column: 1, scope: !24)
!47 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 21, type: !48, scopeLine: 22, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!48 = !DISubroutineType(types: !49)
!49 = !{!10}
!50 = !DILocation(line: 23, column: 5, scope: !47)
!51 = !DILocation(line: 24, column: 15, scope: !47)
!52 = !DILocation(line: 24, column: 17, scope: !47)
!53 = !DILocation(line: 24, column: 7, scope: !47)
!54 = !DILocation(line: 24, column: 5, scope: !47)
!55 = !DILocation(line: 25, column: 15, scope: !47)
!56 = !DILocation(line: 25, column: 17, scope: !47)
!57 = !DILocation(line: 25, column: 7, scope: !47)
!58 = !DILocation(line: 25, column: 5, scope: !47)
!59 = !DILocation(line: 26, column: 5, scope: !47)
!60 = !DILocation(line: 26, column: 8, scope: !47)
!61 = !DILocation(line: 27, column: 3, scope: !47)
!62 = !DILocation(line: 28, column: 7, scope: !63)
!63 = distinct !DILexicalBlock(scope: !47, file: !8, line: 28, column: 7)
!64 = !DILocation(line: 28, column: 7, scope: !47)
!65 = !DILocation(line: 29, column: 10, scope: !66)
!66 = distinct !DILexicalBlock(scope: !63, file: !8, line: 29, column: 3)
!67 = !DILocation(line: 29, column: 5, scope: !66)
!68 = !DILocation(line: 29, column: 19, scope: !66)
!69 = !DILocation(line: 29, column: 14, scope: !66)
!70 = !DILocation(line: 29, column: 23, scope: !66)
!71 = !DILocation(line: 31, column: 10, scope: !72)
!72 = distinct !DILexicalBlock(scope: !63, file: !8, line: 31, column: 3)
!73 = !DILocation(line: 31, column: 5, scope: !72)
!74 = !DILocation(line: 31, column: 19, scope: !72)
!75 = !DILocation(line: 31, column: 14, scope: !72)
!76 = !DILocation(line: 33, column: 3, scope: !47)
