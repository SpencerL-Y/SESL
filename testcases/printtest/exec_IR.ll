; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-7tzei0iz.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@main.b = internal global [10 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  %1 = alloca [2 x i32*], align 16, !verifier.code !26
  call void @llvm.dbg.declare(metadata [2 x i32*]* %1, metadata !27, metadata !DIExpression()), !dbg !31, !verifier.code !26
  call void @llvm.dbg.value(metadata i32 10, metadata !32, metadata !DIExpression()), !dbg !33, !verifier.code !26
  %2 = call noalias i8* @malloc(i64 4) #3, !dbg !34, !verifier.code !26
  %3 = bitcast i8* %2 to i32*, !dbg !34, !verifier.code !26
  %4 = getelementptr inbounds [2 x i32*], [2 x i32*]* %1, i64 0, i64 0, !dbg !35, !verifier.code !26
  store i32* %3, i32** %4, align 16, !dbg !36, !verifier.code !26
  %5 = getelementptr inbounds [2 x i32*], [2 x i32*]* %1, i64 0, i64 0, !dbg !37, !verifier.code !26
  store i32* inttoptr (i64 9 to i32*), i32** %5, align 16, !dbg !38, !verifier.code !26
  %6 = getelementptr inbounds [2 x i32*], [2 x i32*]* %1, i64 0, i64 0, !dbg !39, !verifier.code !26
  store i32* inttoptr (i64 10 to i32*), i32** %6, align 16, !dbg !40, !verifier.code !26
  %7 = getelementptr inbounds [2 x i32*], [2 x i32*]* %1, i64 0, i64 0, !dbg !41, !verifier.code !26
  %8 = load i32*, i32** %7, align 16, !dbg !41, !verifier.code !26
  %9 = icmp ugt i32* %8, inttoptr (i64 10 to i32*), !dbg !43, !verifier.code !26
  br i1 %9, label %10, label %16, !dbg !44, !verifier.code !26

10:                                               ; preds = %0
  %11 = load i32, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i64 0, i64 0), align 16, !dbg !45, !verifier.code !26
  %12 = icmp eq i32 %11, 10, !dbg !46, !verifier.code !26
  br i1 %12, label %13, label %16, !dbg !47, !verifier.code !26

13:                                               ; preds = %10
  %14 = getelementptr inbounds [2 x i32*], [2 x i32*]* %1, i64 0, i64 0, !dbg !48, !verifier.code !26
  %15 = bitcast i32** %14 to i8*, !dbg !48, !verifier.code !26
  call void @free(i8* %15) #3, !dbg !50, !verifier.code !26
  br label %16, !dbg !51, !verifier.code !26

16:                                               ; preds = %13, %10, %0
  ret i32 0, !dbg !52, !verifier.code !26
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 0)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 1)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 2)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 3)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 4)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 5)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 6)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 7)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 8)
  store i32 0, i32* getelementptr inbounds ([10 x i32], [10 x i32]* @main.b, i32 0, i64 9)
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!22}
!llvm.module.flags = !{!23, !24, !25}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 117, type: !19, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 20, type: !4, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, globals: !9, splitDebugInlining: false, nameTableKind: None)
!8 = !{}
!9 = !{!0, !10, !13, !15, !17}
!10 = !DIGlobalVariableExpression(var: !11, expr: !DIExpression())
!11 = distinct !DIGlobalVariable(name: "a", scope: !7, file: !3, line: 14, type: !12, isLocal: false, isDefinition: true)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(name: "b", scope: !7, file: !3, line: 14, type: !12, isLocal: false, isDefinition: true)
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "n", scope: !7, file: !3, line: 15, type: !6, isLocal: false, isDefinition: true)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "c", scope: !7, file: !3, line: 17, type: !19, isLocal: false, isDefinition: true)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 320, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 10)
!22 = !{!"clang version 10.0.0-4ubuntu1 "}
!23 = !{i32 7, !"Dwarf Version", i32 4}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{i32 1, !"wchar_size", i32 4}
!26 = !{i1 false}
!27 = !DILocalVariable(name: "j", scope: !2, file: !3, line: 118, type: !28)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 128, elements: !29)
!29 = !{!30}
!30 = !DISubrange(count: 2)
!31 = !DILocation(line: 118, column: 10, scope: !2)
!32 = !DILocalVariable(name: "a", scope: !2, file: !3, line: 119, type: !6)
!33 = !DILocation(line: 0, scope: !2)
!34 = !DILocation(line: 120, column: 12, scope: !2)
!35 = !DILocation(line: 120, column: 5, scope: !2)
!36 = !DILocation(line: 120, column: 10, scope: !2)
!37 = !DILocation(line: 121, column: 5, scope: !2)
!38 = !DILocation(line: 121, column: 8, scope: !2)
!39 = !DILocation(line: 122, column: 5, scope: !2)
!40 = !DILocation(line: 122, column: 8, scope: !2)
!41 = !DILocation(line: 125, column: 8, scope: !42)
!42 = distinct !DILexicalBlock(scope: !2, file: !3, line: 125, column: 8)
!43 = !DILocation(line: 125, column: 11, scope: !42)
!44 = !DILocation(line: 125, column: 16, scope: !42)
!45 = !DILocation(line: 125, column: 19, scope: !42)
!46 = !DILocation(line: 125, column: 24, scope: !42)
!47 = !DILocation(line: 125, column: 8, scope: !2)
!48 = !DILocation(line: 126, column: 14, scope: !49)
!49 = distinct !DILexicalBlock(scope: !42, file: !3, line: 125, column: 30)
!50 = !DILocation(line: 126, column: 9, scope: !49)
!51 = !DILocation(line: 127, column: 5, scope: !49)
!52 = !DILocation(line: 128, column: 1, scope: !2)
