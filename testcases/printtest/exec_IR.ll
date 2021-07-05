; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-ba9e41vd.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@n = internal global i32 0, align 4, !dbg !0
@a = internal global i32* null, align 8, !dbg !6
@b = internal global i32* null, align 8, !dbg !10

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !29 {
  store i32 128, i32* @n, align 4, !dbg !32, !verifier.code !33
  %1 = load i32, i32* @n, align 4, !dbg !34, !verifier.code !33
  %2 = sext i32 %1 to i64, !dbg !34, !verifier.code !33
  %3 = mul i64 %2, 4, !dbg !35, !verifier.code !33
  %4 = call noalias i8* @malloc(i64 %3) #3, !dbg !36, !verifier.code !33
  %5 = bitcast i8* %4 to i32*, !dbg !36, !verifier.code !33
  store i32* %5, i32** @a, align 8, !dbg !37, !verifier.code !33
  %6 = load i32, i32* @n, align 4, !dbg !38, !verifier.code !33
  %7 = sext i32 %6 to i64, !dbg !38, !verifier.code !33
  %8 = mul i64 %7, 4, !dbg !39, !verifier.code !33
  %9 = call noalias i8* @malloc(i64 %8) #3, !dbg !40, !verifier.code !33
  %10 = bitcast i8* %9 to i32*, !dbg !40, !verifier.code !33
  store i32* %10, i32** @b, align 8, !dbg !41, !verifier.code !33
  %11 = load i32*, i32** @b, align 8, !dbg !42, !verifier.code !33
  %12 = getelementptr inbounds i32, i32* %11, i32 1, !dbg !42, !verifier.code !33
  store i32* %12, i32** @b, align 8, !dbg !42, !verifier.code !33
  store i32 0, i32* %11, align 4, !dbg !43, !verifier.code !33
  call void @llvm.dbg.value(metadata i32 0, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !33
  %13 = load i32, i32* @n, align 4, !dbg !46, !verifier.code !33
  %14 = icmp slt i32 0, %13, !dbg !49, !verifier.code !33
  br i1 %14, label %.lr.ph, label %23, !dbg !50, !verifier.code !33

.lr.ph:                                           ; preds = %0
  br label %15, !dbg !50, !verifier.code !33

15:                                               ; preds = %forwarder3, %.lr.ph
  %.02 = phi i32 [ 0, %.lr.ph ], [ %20, %forwarder3 ], !verifier.code !33
  call void @llvm.dbg.value(metadata i32 %.02, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !33
  %16 = load i32*, i32** @a, align 8, !dbg !51, !verifier.code !33
  %17 = sext i32 %.02 to i64, !dbg !51, !verifier.code !33
  %18 = getelementptr inbounds i32, i32* %16, i64 %17, !dbg !51, !verifier.code !33
  store i32 -1, i32* %18, align 4, !dbg !52, !verifier.code !33
  br label %19, !dbg !51, !verifier.code !33

19:                                               ; preds = %15
  %20 = add nsw i32 %.02, 1, !dbg !53, !verifier.code !33
  call void @llvm.dbg.value(metadata i32 %20, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !33
  %21 = load i32, i32* @n, align 4, !dbg !46, !verifier.code !33
  %22 = icmp slt i32 %20, %21, !dbg !49, !verifier.code !33
  br i1 %22, label %forwarder3, label %._crit_edge, !dbg !50, !llvm.loop !54, !verifier.code !33

._crit_edge:                                      ; preds = %19
  br label %23, !dbg !50, !verifier.code !33

23:                                               ; preds = %._crit_edge, %0
  call void @llvm.dbg.value(metadata i32 0, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !33
  br label %24, !dbg !56, !verifier.code !33

24:                                               ; preds = %forwarder, %23
  %.11 = phi i32 [ 0, %23 ], [ %29, %forwarder ], !verifier.code !33
  call void @llvm.dbg.value(metadata i32 %.11, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !33
  %25 = load i32*, i32** @b, align 8, !dbg !58, !verifier.code !33
  %26 = sext i32 %.11 to i64, !dbg !58, !verifier.code !33
  %27 = getelementptr inbounds i32, i32* %25, i64 %26, !dbg !58, !verifier.code !33
  store i32 -1, i32* %27, align 4, !dbg !60, !verifier.code !33
  br label %28, !dbg !58, !verifier.code !33

28:                                               ; preds = %24
  %29 = add nsw i32 %.11, 1, !dbg !61, !verifier.code !33
  call void @llvm.dbg.value(metadata i32 %29, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !33
  %30 = icmp slt i32 %29, 127, !dbg !62, !verifier.code !33
  br i1 %30, label %forwarder, label %31, !dbg !56, !llvm.loop !63, !verifier.code !33

31:                                               ; preds = %28
  %32 = load i32*, i32** @b, align 8, !dbg !65, !verifier.code !33
  %33 = getelementptr inbounds i32, i32* %32, i64 -2, !dbg !65, !verifier.code !33
  %34 = load i32, i32* %33, align 4, !dbg !65, !verifier.code !33
  %35 = icmp ne i32 %34, 0, !dbg !65, !verifier.code !33
  br i1 %35, label %36, label %42, !dbg !67, !verifier.code !33

36:                                               ; preds = %31
  %37 = load i32*, i32** @a, align 8, !dbg !68, !verifier.code !33
  %38 = bitcast i32* %37 to i8*, !dbg !68, !verifier.code !33
  call void @free(i8* %38) #3, !dbg !70, !verifier.code !33
  %39 = load i32*, i32** @b, align 8, !dbg !71, !verifier.code !33
  %40 = getelementptr inbounds i32, i32* %39, i64 -1, !dbg !72, !verifier.code !33
  %41 = bitcast i32* %40 to i8*, !dbg !71, !verifier.code !33
  call void @free(i8* %41) #3, !dbg !73, !verifier.code !33
  br label %48, !dbg !74, !verifier.code !33

42:                                               ; preds = %31
  %43 = load i32*, i32** @a, align 8, !dbg !75, !verifier.code !33
  %44 = bitcast i32* %43 to i8*, !dbg !75, !verifier.code !33
  call void @free(i8* %44) #3, !dbg !77, !verifier.code !33
  %45 = load i32*, i32** @b, align 8, !dbg !78, !verifier.code !33
  %46 = getelementptr inbounds i32, i32* %45, i64 -1, !dbg !79, !verifier.code !33
  %47 = bitcast i32* %46 to i8*, !dbg !78, !verifier.code !33
  call void @free(i8* %47) #3, !dbg !80, !verifier.code !33
  br label %48, !verifier.code !33

48:                                               ; preds = %42, %36
  ret i32 0, !dbg !81, !verifier.code !33

forwarder:                                        ; preds = %28
  br label %24, !verifier.code !33

forwarder3:                                       ; preds = %19
  br label %15, !verifier.code !33
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
!llvm.ident = !{!25}
!llvm.module.flags = !{!26, !27, !28}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "n", scope: !2, file: !3, line: 16, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!4 = !{}
!5 = !{!6, !10, !0, !12, !20}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 15, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 15, type: !8, isLocal: false, isDefinition: true)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "whatthefuck", scope: !2, file: !3, line: 18, type: !14, isLocal: false, isDefinition: true)
!14 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !3, line: 13, baseType: !15)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 10, size: 128, elements: !16)
!16 = !{!17, !19}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !15, file: !3, line: 11, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !15, file: !3, line: 12, baseType: !18, size: 64, offset: 64)
!20 = !DIGlobalVariableExpression(var: !21, expr: !DIExpression())
!21 = distinct !DIGlobalVariable(name: "c", scope: !2, file: !3, line: 20, type: !22, isLocal: false, isDefinition: true)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 320, elements: !23)
!23 = !{!24}
!24 = !DISubrange(count: 10)
!25 = !{!"clang version 10.0.0-4ubuntu1 "}
!26 = !{i32 7, !"Dwarf Version", i32 4}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 23, type: !30, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{!9}
!32 = !DILocation(line: 66, column: 7, scope: !29)
!33 = !{i1 false}
!34 = !DILocation(line: 67, column: 17, scope: !29)
!35 = !DILocation(line: 67, column: 19, scope: !29)
!36 = !DILocation(line: 67, column: 9, scope: !29)
!37 = !DILocation(line: 67, column: 7, scope: !29)
!38 = !DILocation(line: 68, column: 17, scope: !29)
!39 = !DILocation(line: 68, column: 19, scope: !29)
!40 = !DILocation(line: 68, column: 9, scope: !29)
!41 = !DILocation(line: 68, column: 7, scope: !29)
!42 = !DILocation(line: 69, column: 7, scope: !29)
!43 = !DILocation(line: 69, column: 10, scope: !29)
!44 = !DILocalVariable(name: "i", scope: !29, file: !3, line: 70, type: !9)
!45 = !DILocation(line: 0, scope: !29)
!46 = !DILocation(line: 71, column: 21, scope: !47)
!47 = distinct !DILexicalBlock(scope: !48, file: !3, line: 71, column: 5)
!48 = distinct !DILexicalBlock(scope: !29, file: !3, line: 71, column: 5)
!49 = !DILocation(line: 71, column: 19, scope: !47)
!50 = !DILocation(line: 71, column: 5, scope: !48)
!51 = !DILocation(line: 72, column: 9, scope: !47)
!52 = !DILocation(line: 72, column: 14, scope: !47)
!53 = !DILocation(line: 71, column: 25, scope: !47)
!54 = distinct !{!54, !50, !55}
!55 = !DILocation(line: 72, column: 17, scope: !48)
!56 = !DILocation(line: 73, column: 5, scope: !57)
!57 = distinct !DILexicalBlock(scope: !29, file: !3, line: 73, column: 5)
!58 = !DILocation(line: 74, column: 9, scope: !59)
!59 = distinct !DILexicalBlock(scope: !57, file: !3, line: 73, column: 5)
!60 = !DILocation(line: 74, column: 14, scope: !59)
!61 = !DILocation(line: 73, column: 31, scope: !59)
!62 = !DILocation(line: 73, column: 19, scope: !59)
!63 = distinct !{!63, !56, !64}
!64 = !DILocation(line: 74, column: 17, scope: !57)
!65 = !DILocation(line: 75, column: 9, scope: !66)
!66 = distinct !DILexicalBlock(scope: !29, file: !3, line: 75, column: 9)
!67 = !DILocation(line: 75, column: 9, scope: !29)
!68 = !DILocation(line: 76, column: 12, scope: !69)
!69 = distinct !DILexicalBlock(scope: !66, file: !3, line: 76, column: 5)
!70 = !DILocation(line: 76, column: 7, scope: !69)
!71 = !DILocation(line: 76, column: 21, scope: !69)
!72 = !DILocation(line: 76, column: 22, scope: !69)
!73 = !DILocation(line: 76, column: 16, scope: !69)
!74 = !DILocation(line: 76, column: 27, scope: !69)
!75 = !DILocation(line: 78, column: 12, scope: !76)
!76 = distinct !DILexicalBlock(scope: !66, file: !3, line: 78, column: 5)
!77 = !DILocation(line: 78, column: 7, scope: !76)
!78 = !DILocation(line: 78, column: 21, scope: !76)
!79 = !DILocation(line: 78, column: 22, scope: !76)
!80 = !DILocation(line: 78, column: 16, scope: !76)
!81 = !DILocation(line: 80, column: 5, scope: !29)
