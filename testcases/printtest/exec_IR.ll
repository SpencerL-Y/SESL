; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-iu6c_ppn.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@n = internal global i32 0, align 4, !dbg !0
@a = internal global i32* null, align 8, !dbg !6
@b = internal global i32* null, align 8, !dbg !10

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !16 {
  store i32 128, i32* @n, align 4, !dbg !19, !verifier.code !20
  %1 = load i32, i32* @n, align 4, !dbg !21, !verifier.code !20
  %2 = sext i32 %1 to i64, !dbg !21, !verifier.code !20
  %3 = mul i64 %2, 4, !dbg !22, !verifier.code !20
  %4 = call noalias i8* @malloc(i64 %3) #3, !dbg !23, !verifier.code !20
  %5 = bitcast i8* %4 to i32*, !dbg !23, !verifier.code !20
  store i32* %5, i32** @a, align 8, !dbg !24, !verifier.code !20
  %6 = load i32, i32* @n, align 4, !dbg !25, !verifier.code !20
  %7 = sext i32 %6 to i64, !dbg !25, !verifier.code !20
  %8 = mul i64 %7, 4, !dbg !26, !verifier.code !20
  %9 = call noalias i8* @malloc(i64 %8) #3, !dbg !27, !verifier.code !20
  %10 = bitcast i8* %9 to i32*, !dbg !27, !verifier.code !20
  store i32* %10, i32** @b, align 8, !dbg !28, !verifier.code !20
  %11 = load i32*, i32** @b, align 8, !dbg !29, !verifier.code !20
  %12 = getelementptr inbounds i32, i32* %11, i32 1, !dbg !29, !verifier.code !20
  store i32* %12, i32** @b, align 8, !dbg !29, !verifier.code !20
  store i32 0, i32* %11, align 4, !dbg !30, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 0, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !20
  %13 = load i32, i32* @n, align 4, !dbg !33, !verifier.code !20
  %14 = icmp slt i32 0, %13, !dbg !36, !verifier.code !20
  br i1 %14, label %.lr.ph, label %23, !dbg !37, !verifier.code !20

.lr.ph:                                           ; preds = %0
  br label %15, !dbg !37, !verifier.code !20

15:                                               ; preds = %forwarder3, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %20, %forwarder3 ], !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %.02, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !20
  %16 = load i32*, i32** @a, align 8, !dbg !38, !verifier.code !20
  %17 = sext i32 %.02 to i64, !dbg !38, !verifier.code !20
  %18 = getelementptr inbounds i32, i32* %16, i64 %17, !dbg !38, !verifier.code !20
  store i32 -1, i32* %18, align 4, !dbg !39, !verifier.code !20
  br label %19, !dbg !38, !verifier.code !20

19:                                               ; preds = %15
  %20 = add nsw i32 %.02, 1, !dbg !40, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %20, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !20
  %21 = load i32, i32* @n, align 4, !dbg !33, !verifier.code !20
  %22 = icmp slt i32 %20, %21, !dbg !36, !verifier.code !20
  br i1 %22, label %forwarder3, label %._crit_edge, !dbg !37, !llvm.loop !41, !verifier.code !20

._crit_edge:                                      ; preds = %19
  br label %23, !dbg !37, !verifier.code !20

23:                                               ; preds = %._crit_edge, %0
  call void @llvm.dbg.value(metadata i32 0, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !20
  br label %24, !dbg !43, !verifier.code !20

24:                                               ; preds = %forwarder, %23
  %.11 = phi i32 [ 0, %23 ], [ %29, %forwarder ], !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %.11, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !20
  %25 = load i32*, i32** @b, align 8, !dbg !45, !verifier.code !20
  %26 = sext i32 %.11 to i64, !dbg !45, !verifier.code !20
  %27 = getelementptr inbounds i32, i32* %25, i64 %26, !dbg !45, !verifier.code !20
  store i32 -1, i32* %27, align 4, !dbg !47, !verifier.code !20
  br label %28, !dbg !45, !verifier.code !20

28:                                               ; preds = %24
  %29 = add nsw i32 %.11, 1, !dbg !48, !verifier.code !20
  call void @llvm.dbg.value(metadata i32 %29, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !20
  %30 = icmp slt i32 %29, 127, !dbg !49, !verifier.code !20
  br i1 %30, label %forwarder, label %31, !dbg !43, !llvm.loop !50, !verifier.code !20

31:                                               ; preds = %28
  %32 = load i32*, i32** @b, align 8, !dbg !52, !verifier.code !20
  %33 = getelementptr inbounds i32, i32* %32, i64 -2, !dbg !52, !verifier.code !20
  %34 = load i32, i32* %33, align 4, !dbg !52, !verifier.code !20
  %35 = icmp ne i32 %34, 0, !dbg !52, !verifier.code !20
  br i1 %35, label %36, label %42, !dbg !54, !verifier.code !20

36:                                               ; preds = %31
  %37 = load i32*, i32** @a, align 8, !dbg !55, !verifier.code !20
  %38 = bitcast i32* %37 to i8*, !dbg !55, !verifier.code !20
  call void @free(i8* %38) #3, !dbg !57, !verifier.code !20
  %39 = load i32*, i32** @b, align 8, !dbg !58, !verifier.code !20
  %40 = getelementptr inbounds i32, i32* %39, i64 -1, !dbg !59, !verifier.code !20
  %41 = bitcast i32* %40 to i8*, !dbg !58, !verifier.code !20
  call void @free(i8* %41) #3, !dbg !60, !verifier.code !20
  br label %48, !dbg !61, !verifier.code !20

42:                                               ; preds = %31
  %43 = load i32*, i32** @a, align 8, !dbg !62, !verifier.code !20
  %44 = bitcast i32* %43 to i8*, !dbg !62, !verifier.code !20
  call void @free(i8* %44) #3, !dbg !64, !verifier.code !20
  %45 = load i32*, i32** @b, align 8, !dbg !65, !verifier.code !20
  %46 = getelementptr inbounds i32, i32* %45, i64 -1, !dbg !66, !verifier.code !20
  %47 = bitcast i32* %46 to i8*, !dbg !65, !verifier.code !20
  call void @free(i8* %47) #3, !dbg !67, !verifier.code !20
  br label %48, !verifier.code !20

48:                                               ; preds = %42, %36
  ret i32 0, !dbg !68, !verifier.code !20

forwarder:                                        ; preds = %28
  br label %24, !verifier.code !20

forwarder3:                                       ; preds = %19
  br label %15, !verifier.code !20
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
!llvm.ident = !{!12}
!llvm.module.flags = !{!13, !14, !15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "n", scope: !2, file: !3, line: 16, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!4 = !{}
!5 = !{!6, !10, !0}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 15, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 15, type: !8, isLocal: false, isDefinition: true)
!12 = !{!"clang version 10.0.0-4ubuntu1 "}
!13 = !{i32 7, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 20, type: !17, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!9}
!19 = !DILocation(line: 63, column: 7, scope: !16)
!20 = !{i1 false}
!21 = !DILocation(line: 64, column: 17, scope: !16)
!22 = !DILocation(line: 64, column: 19, scope: !16)
!23 = !DILocation(line: 64, column: 9, scope: !16)
!24 = !DILocation(line: 64, column: 7, scope: !16)
!25 = !DILocation(line: 65, column: 17, scope: !16)
!26 = !DILocation(line: 65, column: 19, scope: !16)
!27 = !DILocation(line: 65, column: 9, scope: !16)
!28 = !DILocation(line: 65, column: 7, scope: !16)
!29 = !DILocation(line: 66, column: 7, scope: !16)
!30 = !DILocation(line: 66, column: 10, scope: !16)
!31 = !DILocalVariable(name: "i", scope: !16, file: !3, line: 67, type: !9)
!32 = !DILocation(line: 0, scope: !16)
!33 = !DILocation(line: 68, column: 21, scope: !34)
!34 = distinct !DILexicalBlock(scope: !35, file: !3, line: 68, column: 5)
!35 = distinct !DILexicalBlock(scope: !16, file: !3, line: 68, column: 5)
!36 = !DILocation(line: 68, column: 19, scope: !34)
!37 = !DILocation(line: 68, column: 5, scope: !35)
!38 = !DILocation(line: 69, column: 9, scope: !34)
!39 = !DILocation(line: 69, column: 14, scope: !34)
!40 = !DILocation(line: 68, column: 25, scope: !34)
!41 = distinct !{!41, !37, !42}
!42 = !DILocation(line: 69, column: 17, scope: !35)
!43 = !DILocation(line: 70, column: 5, scope: !44)
!44 = distinct !DILexicalBlock(scope: !16, file: !3, line: 70, column: 5)
!45 = !DILocation(line: 71, column: 9, scope: !46)
!46 = distinct !DILexicalBlock(scope: !44, file: !3, line: 70, column: 5)
!47 = !DILocation(line: 71, column: 14, scope: !46)
!48 = !DILocation(line: 70, column: 31, scope: !46)
!49 = !DILocation(line: 70, column: 19, scope: !46)
!50 = distinct !{!50, !43, !51}
!51 = !DILocation(line: 71, column: 17, scope: !44)
!52 = !DILocation(line: 72, column: 9, scope: !53)
!53 = distinct !DILexicalBlock(scope: !16, file: !3, line: 72, column: 9)
!54 = !DILocation(line: 72, column: 9, scope: !16)
!55 = !DILocation(line: 73, column: 12, scope: !56)
!56 = distinct !DILexicalBlock(scope: !53, file: !3, line: 73, column: 5)
!57 = !DILocation(line: 73, column: 7, scope: !56)
!58 = !DILocation(line: 73, column: 21, scope: !56)
!59 = !DILocation(line: 73, column: 22, scope: !56)
!60 = !DILocation(line: 73, column: 16, scope: !56)
!61 = !DILocation(line: 73, column: 27, scope: !56)
!62 = !DILocation(line: 75, column: 12, scope: !63)
!63 = distinct !DILexicalBlock(scope: !53, file: !3, line: 75, column: 5)
!64 = !DILocation(line: 75, column: 7, scope: !63)
!65 = !DILocation(line: 75, column: 21, scope: !63)
!66 = !DILocation(line: 75, column: 22, scope: !63)
!67 = !DILocation(line: 75, column: 16, scope: !63)
!68 = !DILocation(line: 77, column: 5, scope: !16)
