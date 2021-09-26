; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-4qtybks3.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@g = internal global i32** null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @free_g1() #0 !dbg !16 {
  %1 = load i32**, i32*** @g, align 8, !dbg !19, !verifier.code !20
  %2 = bitcast i32** %1 to i8*, !dbg !19, !verifier.code !20
  call void @free(i8* %2) #4, !dbg !21, !verifier.code !20
  store i32** null, i32*** @g, align 8, !dbg !22, !verifier.code !20
  ret void, !dbg !23, !verifier.code !20
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @free_g2() #0 !dbg !24 {
  %1 = load i32**, i32*** @g, align 8, !dbg !25, !verifier.code !20
  %2 = icmp ne i32** %1, null, !dbg !27, !verifier.code !20
  br i1 %2, label %3, label %7, !dbg !28, !verifier.code !20

3:                                                ; preds = %0
  %4 = load i32**, i32*** @g, align 8, !dbg !29, !verifier.code !20
  %5 = load i32*, i32** %4, align 8, !dbg !30, !verifier.code !20
  %6 = bitcast i32* %5 to i8*, !dbg !30, !verifier.code !20
  call void @free(i8* %6) #4, !dbg !31, !verifier.code !20
  br label %7, !dbg !31, !verifier.code !20

7:                                                ; preds = %3, %0
  ret void, !dbg !32, !verifier.code !20
}

; Function Attrs: noinline nounwind uwtable
define internal void @h() #0 !dbg !33 {
  %1 = call zeroext i1 (...) @__VERIFIER_nondet_bool(), !dbg !34, !verifier.code !36
  br i1 %1, label %2, label %3, !dbg !37, !verifier.code !20

2:                                                ; preds = %0
  call void @exit(i32 1) #5, !dbg !38, !verifier.code !20
  unreachable, !dbg !38, !verifier.code !20

3:                                                ; preds = %0
  ret void, !dbg !39, !verifier.code !20
}

declare dso_local zeroext i1 @__VERIFIER_nondet_bool(...) #2

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

; Function Attrs: noinline nounwind uwtable
define internal void @f() #0 !dbg !40 {
  %1 = call noalias i8* @malloc(i64 4) #4, !dbg !41, !verifier.code !20
  %2 = bitcast i8* %1 to i32*, !dbg !42, !verifier.code !20
  %3 = load i32**, i32*** @g, align 8, !dbg !43, !verifier.code !20
  store i32* %2, i32** %3, align 8, !dbg !44, !verifier.code !20
  %4 = call i32 @atexit(void ()* @free_g2) #4, !dbg !45, !verifier.code !20
  call void @h(), !dbg !46, !verifier.code !20
  ret void, !dbg !47, !verifier.code !20
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local i32 @atexit(void ()*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !48 {
  %1 = call noalias i8* @malloc(i64 8) #4, !dbg !51, !verifier.code !20
  %2 = bitcast i8* %1 to i32**, !dbg !52, !verifier.code !20
  store i32** %2, i32*** @g, align 8, !dbg !53, !verifier.code !20
  %3 = call i32 @atexit(void ()* @free_g1) #4, !dbg !54, !verifier.code !20
  %4 = call zeroext i1 (...) @__VERIFIER_nondet_bool(), !dbg !55, !verifier.code !36
  br i1 %4, label %5, label %6, !dbg !57, !verifier.code !20

5:                                                ; preds = %0
  call void @exit(i32 1) #5, !dbg !58, !verifier.code !20
  unreachable, !dbg !58, !verifier.code !20

6:                                                ; preds = %0
  call void @f(), !dbg !59, !verifier.code !20
  %7 = load i32**, i32*** @g, align 8, !dbg !60, !verifier.code !20
  %8 = load i32*, i32** %7, align 8, !dbg !61, !verifier.code !20
  %9 = bitcast i32* %8 to i8*, !dbg !61, !verifier.code !20
  call void @free(i8* %9) #4, !dbg !62, !verifier.code !20
  %10 = load i32**, i32*** @g, align 8, !dbg !63, !verifier.code !20
  %11 = bitcast i32** %10 to i8*, !dbg !63, !verifier.code !20
  call void @free(i8* %11) #4, !dbg !64, !verifier.code !20
  ret i32 0, !dbg !65, !verifier.code !20
}

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
!llvm.ident = !{!12}
!llvm.module.flags = !{!13, !14, !15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g", scope: !2, file: !11, line: 7, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !10, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../svcomp/memsafety/global-atexit-5.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !{}
!5 = !{!6, !7, !9}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!10 = !{!0}
!11 = !DIFile(filename: "../svcomp/memsafety//global-atexit-5.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!12 = !{!"clang version 10.0.0-4ubuntu1 "}
!13 = !{i32 7, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{i32 1, !"wchar_size", i32 4}
!16 = distinct !DISubprogram(name: "free_g1", scope: !11, file: !11, line: 9, type: !17, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{null}
!19 = !DILocation(line: 10, column: 7, scope: !16)
!20 = !{i1 false}
!21 = !DILocation(line: 10, column: 2, scope: !16)
!22 = !DILocation(line: 11, column: 4, scope: !16)
!23 = !DILocation(line: 12, column: 1, scope: !16)
!24 = distinct !DISubprogram(name: "free_g2", scope: !11, file: !11, line: 14, type: !17, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!25 = !DILocation(line: 15, column: 6, scope: !26)
!26 = distinct !DILexicalBlock(scope: !24, file: !11, line: 15, column: 6)
!27 = !DILocation(line: 15, column: 8, scope: !26)
!28 = !DILocation(line: 15, column: 6, scope: !24)
!29 = !DILocation(line: 16, column: 9, scope: !26)
!30 = !DILocation(line: 16, column: 8, scope: !26)
!31 = !DILocation(line: 16, column: 3, scope: !26)
!32 = !DILocation(line: 17, column: 1, scope: !24)
!33 = distinct !DISubprogram(name: "h", scope: !11, file: !11, line: 19, type: !17, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!34 = !DILocation(line: 20, column: 6, scope: !35)
!35 = distinct !DILexicalBlock(scope: !33, file: !11, line: 20, column: 6)
!36 = !{i1 true}
!37 = !DILocation(line: 20, column: 6, scope: !33)
!38 = !DILocation(line: 20, column: 32, scope: !35)
!39 = !DILocation(line: 21, column: 1, scope: !33)
!40 = distinct !DISubprogram(name: "f", scope: !11, file: !11, line: 23, type: !17, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!41 = !DILocation(line: 24, column: 15, scope: !40)
!42 = !DILocation(line: 24, column: 7, scope: !40)
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 24, column: 5, scope: !40)
!45 = !DILocation(line: 25, column: 2, scope: !40)
!46 = !DILocation(line: 26, column: 2, scope: !40)
!47 = !DILocation(line: 27, column: 1, scope: !40)
!48 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 30, type: !49, scopeLine: 30, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!49 = !DISubroutineType(types: !50)
!50 = !{!8}
!51 = !DILocation(line: 31, column: 15, scope: !48)
!52 = !DILocation(line: 31, column: 6, scope: !48)
!53 = !DILocation(line: 31, column: 4, scope: !48)
!54 = !DILocation(line: 32, column: 2, scope: !48)
!55 = !DILocation(line: 33, column: 6, scope: !56)
!56 = distinct !DILexicalBlock(scope: !48, file: !11, line: 33, column: 6)
!57 = !DILocation(line: 33, column: 6, scope: !48)
!58 = !DILocation(line: 33, column: 32, scope: !56)
!59 = !DILocation(line: 34, column: 2, scope: !48)
!60 = !DILocation(line: 35, column: 8, scope: !48)
!61 = !DILocation(line: 35, column: 7, scope: !48)
!62 = !DILocation(line: 35, column: 2, scope: !48)
!63 = !DILocation(line: 36, column: 7, scope: !48)
!64 = !DILocation(line: 36, column: 2, scope: !48)
!65 = !DILocation(line: 37, column: 2, scope: !48)
