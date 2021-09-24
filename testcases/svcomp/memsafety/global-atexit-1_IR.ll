; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-t9v4cedw.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@g = internal global i32** null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @free_g1() #0 !dbg !15 {
  %1 = load i32**, i32*** @g, align 8, !dbg !18, !verifier.code !19
  %2 = bitcast i32** %1 to i8*, !dbg !18, !verifier.code !19
  call void @free(i8* %2) #4, !dbg !20, !verifier.code !19
  store i32** null, i32*** @g, align 8, !dbg !21, !verifier.code !19
  ret void, !dbg !22, !verifier.code !19
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @free_g2() #0 !dbg !23 {
  %1 = load i32**, i32*** @g, align 8, !dbg !24, !verifier.code !19
  %2 = icmp ne i32** %1, null, !dbg !26, !verifier.code !19
  br i1 %2, label %3, label %7, !dbg !27, !verifier.code !19

3:                                                ; preds = %0
  %4 = load i32**, i32*** @g, align 8, !dbg !28, !verifier.code !19
  %5 = load i32*, i32** %4, align 8, !dbg !29, !verifier.code !19
  %6 = bitcast i32* %5 to i8*, !dbg !29, !verifier.code !19
  call void @free(i8* %6) #4, !dbg !30, !verifier.code !19
  br label %7, !dbg !30, !verifier.code !19

7:                                                ; preds = %3, %0
  ret void, !dbg !31, !verifier.code !19
}

; Function Attrs: noinline nounwind uwtable
define internal void @h() #0 !dbg !32 {
  %1 = call zeroext i1 (...) @__VERIFIER_nondet_bool(), !dbg !33, !verifier.code !35
  br i1 %1, label %2, label %3, !dbg !36, !verifier.code !19

2:                                                ; preds = %0
  call void @_Exit(i32 1) #5, !dbg !37, !verifier.code !19
  unreachable, !dbg !37, !verifier.code !19

3:                                                ; preds = %0
  ret void, !dbg !38, !verifier.code !19
}

declare dso_local zeroext i1 @__VERIFIER_nondet_bool(...) #2

; Function Attrs: noreturn nounwind
declare dso_local void @_Exit(i32) #3

; Function Attrs: noinline nounwind uwtable
define internal void @f() #0 !dbg !39 {
  %1 = call noalias i8* @malloc(i64 4) #4, !dbg !40, !verifier.code !19
  %2 = bitcast i8* %1 to i32*, !dbg !41, !verifier.code !19
  %3 = load i32**, i32*** @g, align 8, !dbg !42, !verifier.code !19
  store i32* %2, i32** %3, align 8, !dbg !43, !verifier.code !19
  %4 = call i32 @atexit(void ()* @free_g2) #4, !dbg !44, !verifier.code !19
  call void @h(), !dbg !45, !verifier.code !19
  ret void, !dbg !46, !verifier.code !19
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local i32 @atexit(void ()*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !47 {
  %1 = call noalias i8* @malloc(i64 8) #4, !dbg !50, !verifier.code !19
  %2 = bitcast i8* %1 to i32**, !dbg !51, !verifier.code !19
  store i32** %2, i32*** @g, align 8, !dbg !52, !verifier.code !19
  %3 = call i32 @atexit(void ()* @free_g1) #4, !dbg !53, !verifier.code !19
  %4 = call zeroext i1 (...) @__VERIFIER_nondet_bool(), !dbg !54, !verifier.code !35
  br i1 %4, label %5, label %6, !dbg !56, !verifier.code !19

5:                                                ; preds = %0
  call void @exit(i32 1) #5, !dbg !57, !verifier.code !19
  unreachable, !dbg !57, !verifier.code !19

6:                                                ; preds = %0
  call void @f(), !dbg !58, !verifier.code !19
  ret i32 0, !dbg !59, !verifier.code !19
}

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

define void @__SMACK_static_init() {
entry:
  store i32** null, i32*** @g
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!11}
!llvm.module.flags = !{!12, !13, !14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g", scope: !2, file: !3, line: 7, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !10, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/global-atexit-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !{}
!5 = !{!6, !7, !9}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!10 = !{!0}
!11 = !{!"clang version 10.0.0-4ubuntu1 "}
!12 = !{i32 7, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = distinct !DISubprogram(name: "free_g1", scope: !3, file: !3, line: 9, type: !16, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{null}
!18 = !DILocation(line: 10, column: 7, scope: !15)
!19 = !{i1 false}
!20 = !DILocation(line: 10, column: 2, scope: !15)
!21 = !DILocation(line: 11, column: 4, scope: !15)
!22 = !DILocation(line: 12, column: 1, scope: !15)
!23 = distinct !DISubprogram(name: "free_g2", scope: !3, file: !3, line: 14, type: !16, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!24 = !DILocation(line: 15, column: 6, scope: !25)
!25 = distinct !DILexicalBlock(scope: !23, file: !3, line: 15, column: 6)
!26 = !DILocation(line: 15, column: 8, scope: !25)
!27 = !DILocation(line: 15, column: 6, scope: !23)
!28 = !DILocation(line: 16, column: 9, scope: !25)
!29 = !DILocation(line: 16, column: 8, scope: !25)
!30 = !DILocation(line: 16, column: 3, scope: !25)
!31 = !DILocation(line: 17, column: 1, scope: !23)
!32 = distinct !DISubprogram(name: "h", scope: !3, file: !3, line: 19, type: !16, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!33 = !DILocation(line: 20, column: 6, scope: !34)
!34 = distinct !DILexicalBlock(scope: !32, file: !3, line: 20, column: 6)
!35 = !{i1 true}
!36 = !DILocation(line: 20, column: 6, scope: !32)
!37 = !DILocation(line: 20, column: 32, scope: !34)
!38 = !DILocation(line: 21, column: 1, scope: !32)
!39 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 23, type: !16, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!40 = !DILocation(line: 24, column: 15, scope: !39)
!41 = !DILocation(line: 24, column: 7, scope: !39)
!42 = !DILocation(line: 24, column: 3, scope: !39)
!43 = !DILocation(line: 24, column: 5, scope: !39)
!44 = !DILocation(line: 25, column: 2, scope: !39)
!45 = !DILocation(line: 26, column: 2, scope: !39)
!46 = !DILocation(line: 27, column: 1, scope: !39)
!47 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 30, type: !48, scopeLine: 30, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!48 = !DISubroutineType(types: !49)
!49 = !{!8}
!50 = !DILocation(line: 31, column: 15, scope: !47)
!51 = !DILocation(line: 31, column: 6, scope: !47)
!52 = !DILocation(line: 31, column: 4, scope: !47)
!53 = !DILocation(line: 32, column: 2, scope: !47)
!54 = !DILocation(line: 33, column: 6, scope: !55)
!55 = distinct !DILexicalBlock(scope: !47, file: !3, line: 33, column: 6)
!56 = !DILocation(line: 33, column: 6, scope: !47)
!57 = !DILocation(line: 33, column: 32, scope: !55)
!58 = !DILocation(line: 34, column: 2, scope: !47)
!59 = !DILocation(line: 35, column: 2, scope: !47)
