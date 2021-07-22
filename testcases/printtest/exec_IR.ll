; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-swomlwo3.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@n = internal global i32 0, align 4, !dbg !0
@a = internal global i32* null, align 8, !dbg !6
@b = internal global i32* null, align 8, !dbg !10

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !21 {
  store i32 4, i32* @n, align 4, !dbg !24, !verifier.code !25
  %1 = load i32, i32* @n, align 4, !dbg !26, !verifier.code !25
  %2 = sext i32 %1 to i64, !dbg !26, !verifier.code !25
  %3 = mul i64 %2, 4, !dbg !27, !verifier.code !25
  %4 = call noalias i8* @malloc(i64 %3) #3, !dbg !28, !verifier.code !25
  %5 = bitcast i8* %4 to i32*, !dbg !28, !verifier.code !25
  store i32* %5, i32** @a, align 8, !dbg !29, !verifier.code !25
  %6 = load i32, i32* @n, align 4, !dbg !30, !verifier.code !25
  %7 = sext i32 %6 to i64, !dbg !30, !verifier.code !25
  %8 = mul i64 %7, 4, !dbg !31, !verifier.code !25
  %9 = call noalias i8* @malloc(i64 %8) #3, !dbg !32, !verifier.code !25
  %10 = bitcast i8* %9 to i32*, !dbg !32, !verifier.code !25
  store i32* %10, i32** @b, align 8, !dbg !33, !verifier.code !25
  %11 = load i32*, i32** @b, align 8, !dbg !34, !verifier.code !25
  %12 = getelementptr inbounds i32, i32* %11, i32 1, !dbg !34, !verifier.code !25
  store i32* %12, i32** @b, align 8, !dbg !34, !verifier.code !25
  store i32 0, i32* %11, align 4, !dbg !35, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 0, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %13 = load i32, i32* @n, align 4, !dbg !38, !verifier.code !25
  %14 = icmp slt i32 0, %13, !dbg !41, !verifier.code !25
  br i1 %14, label %.lr.ph, label %23, !dbg !42, !verifier.code !25

.lr.ph:                                           ; preds = %0
  br label %15, !dbg !42, !verifier.code !25

15:                                               ; preds = %forwarder, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %20, %forwarder ], !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %.02, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %16 = load i32*, i32** @a, align 8, !dbg !43, !verifier.code !25
  %17 = sext i32 %.02 to i64, !dbg !43, !verifier.code !25
  %18 = getelementptr inbounds i32, i32* %16, i64 %17, !dbg !43, !verifier.code !25
  store i32 -1, i32* %18, align 4, !dbg !44, !verifier.code !25
  br label %19, !dbg !43, !verifier.code !25

19:                                               ; preds = %15
  %20 = add nsw i32 %.02, 1, !dbg !45, !verifier.code !25
  call void @llvm.dbg.value(metadata i32 %20, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %21 = load i32, i32* @n, align 4, !dbg !38, !verifier.code !25
  %22 = icmp slt i32 %20, %21, !dbg !41, !verifier.code !25
  br i1 %22, label %forwarder, label %._crit_edge, !dbg !42, !llvm.loop !46, !verifier.code !25

._crit_edge:                                      ; preds = %19
  br label %23, !dbg !42, !verifier.code !25

23:                                               ; preds = %._crit_edge, %0
  call void @llvm.dbg.value(metadata i32 0, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  br label %24, !dbg !48, !verifier.code !25

24:                                               ; preds = %23
  call void @llvm.dbg.value(metadata i32 0, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %25 = load i32*, i32** @b, align 8, !dbg !50, !verifier.code !25
  store i32 -1, i32* %25, align 4, !dbg !52, !verifier.code !25
  br label %26, !dbg !50, !verifier.code !25

26:                                               ; preds = %24
  call void @llvm.dbg.value(metadata i32 1, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %27 = load i32*, i32** @b, align 8, !dbg !50, !verifier.code !25
  %28 = getelementptr inbounds i32, i32* %27, i64 1, !dbg !50, !verifier.code !25
  store i32 -1, i32* %28, align 4, !dbg !52, !verifier.code !25
  br label %42, !dbg !50, !verifier.code !25

29:                                               ; preds = %45
  %30 = load i32*, i32** @a, align 8, !dbg !53, !verifier.code !25
  %31 = bitcast i32* %30 to i8*, !dbg !53, !verifier.code !25
  call void @free(i8* %31) #3, !dbg !56, !verifier.code !25
  %32 = load i32*, i32** @b, align 8, !dbg !57, !verifier.code !25
  %33 = getelementptr inbounds i32, i32* %32, i64 -1, !dbg !58, !verifier.code !25
  %34 = bitcast i32* %33 to i8*, !dbg !57, !verifier.code !25
  call void @free(i8* %34) #3, !dbg !59, !verifier.code !25
  br label %41, !dbg !60, !verifier.code !25

35:                                               ; preds = %45
  %36 = load i32*, i32** @a, align 8, !dbg !61, !verifier.code !25
  %37 = bitcast i32* %36 to i8*, !dbg !61, !verifier.code !25
  call void @free(i8* %37) #3, !dbg !63, !verifier.code !25
  %38 = load i32*, i32** @b, align 8, !dbg !64, !verifier.code !25
  %39 = getelementptr inbounds i32, i32* %38, i64 -1, !dbg !65, !verifier.code !25
  %40 = bitcast i32* %39 to i8*, !dbg !64, !verifier.code !25
  call void @free(i8* %40) #3, !dbg !66, !verifier.code !25
  br label %41, !verifier.code !25

41:                                               ; preds = %35, %29
  ret i32 0, !dbg !67, !verifier.code !25

42:                                               ; preds = %26
  call void @llvm.dbg.value(metadata i32 2, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %43 = load i32*, i32** @b, align 8, !dbg !50, !verifier.code !25
  %44 = getelementptr inbounds i32, i32* %43, i64 2, !dbg !50, !verifier.code !25
  store i32 -1, i32* %44, align 4, !dbg !52, !verifier.code !25
  br label %45, !dbg !50, !verifier.code !25

45:                                               ; preds = %42
  call void @llvm.dbg.value(metadata i32 3, metadata !36, metadata !DIExpression()), !dbg !37, !verifier.code !25
  %46 = load i32*, i32** @b, align 8, !dbg !68, !verifier.code !25
  %47 = getelementptr inbounds i32, i32* %46, i64 -2, !dbg !68, !verifier.code !25
  %48 = load i32, i32* %47, align 4, !dbg !68, !verifier.code !25
  %49 = icmp ne i32 %48, 0, !dbg !68, !verifier.code !25
  br i1 %49, label %29, label %35, !dbg !69, !verifier.code !25

forwarder:                                        ; preds = %19
  br label %15, !verifier.code !25
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

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
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!17}
!llvm.module.flags = !{!18, !19, !20}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "n", scope: !2, file: !3, line: 15, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !10, !0, !12}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 14, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 14, type: !8, isLocal: false, isDefinition: true)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !3, line: 17, type: !14, isLocal: false, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 320, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 10)
!17 = !{!"clang version 10.0.0-4ubuntu1 "}
!18 = !{i32 7, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 20, type: !22, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!22 = !DISubroutineType(types: !23)
!23 = !{!9}
!24 = !DILocation(line: 67, column: 7, scope: !21)
!25 = !{i1 false}
!26 = !DILocation(line: 68, column: 17, scope: !21)
!27 = !DILocation(line: 68, column: 19, scope: !21)
!28 = !DILocation(line: 68, column: 9, scope: !21)
!29 = !DILocation(line: 68, column: 7, scope: !21)
!30 = !DILocation(line: 69, column: 17, scope: !21)
!31 = !DILocation(line: 69, column: 19, scope: !21)
!32 = !DILocation(line: 69, column: 9, scope: !21)
!33 = !DILocation(line: 69, column: 7, scope: !21)
!34 = !DILocation(line: 70, column: 7, scope: !21)
!35 = !DILocation(line: 70, column: 10, scope: !21)
!36 = !DILocalVariable(name: "i", scope: !21, file: !3, line: 71, type: !9)
!37 = !DILocation(line: 0, scope: !21)
!38 = !DILocation(line: 72, column: 21, scope: !39)
!39 = distinct !DILexicalBlock(scope: !40, file: !3, line: 72, column: 5)
!40 = distinct !DILexicalBlock(scope: !21, file: !3, line: 72, column: 5)
!41 = !DILocation(line: 72, column: 19, scope: !39)
!42 = !DILocation(line: 72, column: 5, scope: !40)
!43 = !DILocation(line: 73, column: 9, scope: !39)
!44 = !DILocation(line: 73, column: 14, scope: !39)
!45 = !DILocation(line: 72, column: 25, scope: !39)
!46 = distinct !{!46, !42, !47}
!47 = !DILocation(line: 73, column: 17, scope: !40)
!48 = !DILocation(line: 74, column: 5, scope: !49)
!49 = distinct !DILexicalBlock(scope: !21, file: !3, line: 74, column: 5)
!50 = !DILocation(line: 75, column: 9, scope: !51)
!51 = distinct !DILexicalBlock(scope: !49, file: !3, line: 74, column: 5)
!52 = !DILocation(line: 75, column: 14, scope: !51)
!53 = !DILocation(line: 77, column: 12, scope: !54)
!54 = distinct !DILexicalBlock(scope: !55, file: !3, line: 77, column: 5)
!55 = distinct !DILexicalBlock(scope: !21, file: !3, line: 76, column: 9)
!56 = !DILocation(line: 77, column: 7, scope: !54)
!57 = !DILocation(line: 77, column: 21, scope: !54)
!58 = !DILocation(line: 77, column: 22, scope: !54)
!59 = !DILocation(line: 77, column: 16, scope: !54)
!60 = !DILocation(line: 77, column: 27, scope: !54)
!61 = !DILocation(line: 79, column: 12, scope: !62)
!62 = distinct !DILexicalBlock(scope: !55, file: !3, line: 79, column: 5)
!63 = !DILocation(line: 79, column: 7, scope: !62)
!64 = !DILocation(line: 79, column: 21, scope: !62)
!65 = !DILocation(line: 79, column: 22, scope: !62)
!66 = !DILocation(line: 79, column: 16, scope: !62)
!67 = !DILocation(line: 117, column: 1, scope: !21)
!68 = !DILocation(line: 76, column: 9, scope: !55)
!69 = !DILocation(line: 76, column: 9, scope: !21)
