; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-nxlux1xg.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"test-0019-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #4, !dbg !12, !verifier.code !15
  unreachable, !dbg !12, !verifier.code !15
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !16 {
  %1 = alloca %struct.TData, align 8, !verifier.code !15
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !20, metadata !DIExpression()), !dbg !26, !verifier.code !15
  call void @alloc_data(%struct.TData* %1), !dbg !27, !verifier.code !15
  call void @free_data(%struct.TData* %1), !dbg !28, !verifier.code !15
  ret i32 0, !dbg !29, !verifier.code !15
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal void @alloc_data(%struct.TData* %0) #0 !dbg !30 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !34, metadata !DIExpression()), !dbg !35, !verifier.code !15
  %2 = call noalias i8* @malloc(i32 16) #5, !dbg !36, !verifier.code !15
  %3 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !37, !verifier.code !15
  store i8* %2, i8** %3, align 8, !dbg !38, !verifier.code !15
  %4 = call noalias i8* @malloc(i32 24) #5, !dbg !39, !verifier.code !15
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !40, !verifier.code !15
  store i8* %4, i8** %5, align 8, !dbg !41, !verifier.code !15
  ret void, !dbg !42, !verifier.code !15
}

; Function Attrs: noinline nounwind uwtable
define internal void @free_data(%struct.TData* %0) #0 !dbg !43 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !44, metadata !DIExpression()), !dbg !45, !verifier.code !15
  %2 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !46, !verifier.code !15
  %3 = load i8*, i8** %2, align 8, !dbg !46, !verifier.code !15
  call void @llvm.dbg.value(metadata i8* %3, metadata !47, metadata !DIExpression()), !dbg !45, !verifier.code !15
  %4 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !48, !verifier.code !15
  %5 = load i8*, i8** %4, align 8, !dbg !48, !verifier.code !15
  call void @llvm.dbg.value(metadata i8* %5, metadata !49, metadata !DIExpression()), !dbg !45, !verifier.code !15
  %6 = icmp eq i8* %3, %5, !dbg !50, !verifier.code !15
  br i1 %6, label %7, label %8, !dbg !52, !verifier.code !15

7:                                                ; preds = %1
  call void @free(i8* %3) #5, !dbg !53, !verifier.code !15
  call void @free(i8* %5) #5, !dbg !55, !verifier.code !15
  br label %8, !dbg !56, !verifier.code !15

8:                                                ; preds = %7, %1
  %9 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !57, !verifier.code !15
  store i8* null, i8** %9, align 8, !dbg !58, !verifier.code !15
  %10 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !59, !verifier.code !15
  store i8* null, i8** %10, align 8, !dbg !60, !verifier.code !15
  ret void, !dbg !61, !verifier.code !15
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0019-2.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !1, file: !1, line: 12, type: !10, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null}
!12 = !DILocation(line: 12, column: 83, scope: !13)
!13 = distinct !DILexicalBlock(scope: !14, file: !1, line: 12, column: 73)
!14 = distinct !DILexicalBlock(scope: !9, file: !1, line: 12, column: 67)
!15 = !{i1 false}
!16 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 543, type: !17, scopeLine: 543, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocalVariable(name: "data", scope: !16, file: !1, line: 544, type: !21)
!21 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !1, line: 526, baseType: !22)
!22 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 523, size: 128, elements: !23)
!23 = !{!24, !25}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !22, file: !1, line: 524, baseType: !4, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !22, file: !1, line: 525, baseType: !4, size: 64, offset: 64)
!26 = !DILocation(line: 544, column: 11, scope: !16)
!27 = !DILocation(line: 545, column: 5, scope: !16)
!28 = !DILocation(line: 546, column: 5, scope: !16)
!29 = !DILocation(line: 547, column: 5, scope: !16)
!30 = distinct !DISubprogram(name: "alloc_data", scope: !1, file: !1, line: 527, type: !31, scopeLine: 528, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{null, !33}
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!34 = !DILocalVariable(name: "pdata", arg: 1, scope: !30, file: !1, line: 527, type: !33)
!35 = !DILocation(line: 0, scope: !30)
!36 = !DILocation(line: 529, column: 17, scope: !30)
!37 = !DILocation(line: 529, column: 12, scope: !30)
!38 = !DILocation(line: 529, column: 15, scope: !30)
!39 = !DILocation(line: 530, column: 17, scope: !30)
!40 = !DILocation(line: 530, column: 12, scope: !30)
!41 = !DILocation(line: 530, column: 15, scope: !30)
!42 = !DILocation(line: 531, column: 1, scope: !30)
!43 = distinct !DISubprogram(name: "free_data", scope: !1, file: !1, line: 532, type: !31, scopeLine: 533, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!44 = !DILocalVariable(name: "data", arg: 1, scope: !43, file: !1, line: 532, type: !33)
!45 = !DILocation(line: 0, scope: !43)
!46 = !DILocation(line: 534, column: 22, scope: !43)
!47 = !DILocalVariable(name: "lo", scope: !43, file: !1, line: 534, type: !4)
!48 = !DILocation(line: 535, column: 22, scope: !43)
!49 = !DILocalVariable(name: "hi", scope: !43, file: !1, line: 535, type: !4)
!50 = !DILocation(line: 536, column: 12, scope: !51)
!51 = distinct !DILexicalBlock(scope: !43, file: !1, line: 536, column: 9)
!52 = !DILocation(line: 536, column: 9, scope: !43)
!53 = !DILocation(line: 537, column: 9, scope: !54)
!54 = distinct !DILexicalBlock(scope: !51, file: !1, line: 536, column: 19)
!55 = !DILocation(line: 538, column: 9, scope: !54)
!56 = !DILocation(line: 539, column: 5, scope: !54)
!57 = !DILocation(line: 540, column: 11, scope: !43)
!58 = !DILocation(line: 540, column: 14, scope: !43)
!59 = !DILocation(line: 541, column: 11, scope: !43)
!60 = !DILocation(line: 541, column: 14, scope: !43)
!61 = !DILocation(line: 542, column: 1, scope: !43)
