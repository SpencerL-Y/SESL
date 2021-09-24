; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-598t1mkj.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.L1 = type { %struct.L1*, %struct.L2* }
%struct.L2 = type { i8*, %struct.L2* }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [42 x i8] c"../testcases/svcomp/memsafety/test-0220.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@main.list = internal global %struct.L1* null, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !25 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #6, !dbg !28, !verifier.code !31
  unreachable, !dbg !28, !verifier.code !31
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !2 {
  br label %1, !dbg !32, !verifier.code !31

1:                                                ; preds = %2, %0
  call void @l1_insert(%struct.L1** @main.list), !dbg !33, !verifier.code !31
  br label %2, !dbg !33, !verifier.code !31

2:                                                ; preds = %1
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !34, !verifier.code !35
  %4 = icmp ne i32 %3, 0, !dbg !33, !verifier.code !31
  br i1 %4, label %1, label %5, !dbg !33, !llvm.loop !36, !verifier.code !31

5:                                                ; preds = %2
  br label %6, !dbg !38, !verifier.code !31

6:                                                ; preds = %15, %5
  %7 = load %struct.L1*, %struct.L1** @main.list, align 8, !dbg !39, !verifier.code !31
  %8 = getelementptr inbounds %struct.L1, %struct.L1* %7, i32 0, i32 0, !dbg !41, !verifier.code !31
  %9 = load %struct.L1*, %struct.L1** %8, align 8, !dbg !41, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.L1* %9, metadata !42, metadata !DIExpression()), !dbg !43, !verifier.code !31
  %10 = load %struct.L1*, %struct.L1** @main.list, align 8, !dbg !44, !verifier.code !31
  %11 = getelementptr inbounds %struct.L1, %struct.L1* %10, i32 0, i32 1, !dbg !45, !verifier.code !31
  %12 = load %struct.L2*, %struct.L2** %11, align 8, !dbg !45, !verifier.code !31
  call void @l2_destroy(%struct.L2* %12), !dbg !46, !verifier.code !31
  %13 = load %struct.L1*, %struct.L1** @main.list, align 8, !dbg !47, !verifier.code !31
  %14 = bitcast %struct.L1* %13 to i8*, !dbg !47, !verifier.code !31
  call void @free(i8* %14) #7, !dbg !48, !verifier.code !31
  store %struct.L1* %9, %struct.L1** @main.list, align 8, !dbg !49, !verifier.code !31
  br label %15, !dbg !50, !verifier.code !31

15:                                               ; preds = %6
  %16 = load %struct.L1*, %struct.L1** @main.list, align 8, !dbg !51, !verifier.code !31
  %17 = icmp ne %struct.L1* %16, null, !dbg !50, !verifier.code !31
  br i1 %17, label %6, label %18, !dbg !50, !llvm.loop !52, !verifier.code !31

18:                                               ; preds = %15
  ret i32 0, !dbg !54, !verifier.code !31
}

; Function Attrs: noinline nounwind uwtable
define internal void @l1_insert(%struct.L1** %0) #0 !dbg !55 {
  call void @llvm.dbg.value(metadata %struct.L1** %0, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !31
  %2 = call i8* @calloc_model(i64 1, i64 16), !dbg !61, !verifier.code !31
  %3 = bitcast i8* %2 to %struct.L1*, !dbg !61, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.L1* %3, metadata !62, metadata !DIExpression()), !dbg !60, !verifier.code !31
  %4 = icmp ne %struct.L1* %3, null, !dbg !63, !verifier.code !31
  br i1 %4, label %6, label %5, !dbg !65, !verifier.code !31

5:                                                ; preds = %1
  call void @abort() #6, !dbg !66, !verifier.code !31
  unreachable, !dbg !66, !verifier.code !31

6:                                                ; preds = %1
  br label %7, !dbg !67, !verifier.code !31

7:                                                ; preds = %9, %6
  %8 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 1, !dbg !68, !verifier.code !31
  call void @l2_insert(%struct.L2** %8), !dbg !69, !verifier.code !31
  br label %9, !dbg !69, !verifier.code !31

9:                                                ; preds = %7
  %10 = call i32 @__VERIFIER_nondet_int(), !dbg !70, !verifier.code !35
  %11 = icmp ne i32 %10, 0, !dbg !69, !verifier.code !31
  br i1 %11, label %7, label %12, !dbg !69, !llvm.loop !71, !verifier.code !31

12:                                               ; preds = %9
  %13 = load %struct.L1*, %struct.L1** %0, align 8, !dbg !73, !verifier.code !31
  %14 = getelementptr inbounds %struct.L1, %struct.L1* %3, i32 0, i32 0, !dbg !74, !verifier.code !31
  store %struct.L1* %13, %struct.L1** %14, align 8, !dbg !75, !verifier.code !31
  store %struct.L1* %3, %struct.L1** %0, align 8, !dbg !76, !verifier.code !31
  ret void, !dbg !77, !verifier.code !31
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #3

; Function Attrs: noinline nounwind uwtable
define internal void @l2_destroy(%struct.L2* %0) #0 !dbg !78 {
  call void @llvm.dbg.value(metadata %struct.L2* %0, metadata !81, metadata !DIExpression()), !dbg !82, !verifier.code !31
  %2 = getelementptr inbounds %struct.L2, %struct.L2* %0, i32 0, i32 0, !dbg !83, !verifier.code !31
  %3 = load i8*, i8** %2, align 8, !dbg !83, !verifier.code !31
  call void @free(i8* %3) #7, !dbg !84, !verifier.code !31
  br label %4, !dbg !85, !verifier.code !31

4:                                                ; preds = %forwarder, %1
  %.0 = phi %struct.L2* [ %0, %1 ], [ %6, %forwarder ], !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.L2* %.0, metadata !81, metadata !DIExpression()), !dbg !82, !verifier.code !31
  %5 = getelementptr inbounds %struct.L2, %struct.L2* %.0, i32 0, i32 1, !dbg !86, !verifier.code !31
  %6 = load %struct.L2*, %struct.L2** %5, align 8, !dbg !86, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !88, metadata !DIExpression()), !dbg !89, !verifier.code !31
  %7 = bitcast %struct.L2* %.0 to i8*, !dbg !90, !verifier.code !31
  call void @free(i8* %7) #7, !dbg !91, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.L2* %6, metadata !81, metadata !DIExpression()), !dbg !82, !verifier.code !31
  br label %8, !dbg !92, !verifier.code !31

8:                                                ; preds = %4
  %9 = icmp ne %struct.L2* %6, null, !dbg !92, !verifier.code !31
  br i1 %9, label %forwarder, label %10, !dbg !92, !llvm.loop !93, !verifier.code !31

10:                                               ; preds = %8
  ret void, !dbg !95, !verifier.code !31

forwarder:                                        ; preds = %8
  br label %4, !verifier.code !31
}

; Function Attrs: nounwind
declare dso_local void @free(i8*) #4

; Function Attrs: noinline nounwind uwtable
define internal i8* @calloc_model(i64 %0, i64 %1) #0 !dbg !96 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !31
  call void @llvm.dbg.value(metadata i64 %1, metadata !104, metadata !DIExpression()), !dbg !103, !verifier.code !31
  %3 = mul i64 %0, %1, !dbg !105, !verifier.code !31
  %4 = call noalias i8* @malloc(i64 %3) #7, !dbg !106, !verifier.code !31
  call void @llvm.dbg.value(metadata i8* %4, metadata !107, metadata !DIExpression()), !dbg !103, !verifier.code !31
  %5 = mul i64 %0, %1, !dbg !108, !verifier.code !31
  call void @llvm.memset.p0i8.i64(i8* align 1 %4, i8 0, i64 %5, i1 false), !dbg !109, !verifier.code !31
  ret i8* %4, !dbg !110, !verifier.code !31
}

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define internal void @l2_insert(%struct.L2** %0) #0 !dbg !111 {
  call void @llvm.dbg.value(metadata %struct.L2** %0, metadata !115, metadata !DIExpression()), !dbg !116, !verifier.code !31
  %2 = call i8* @calloc_model(i64 1, i64 16), !dbg !117, !verifier.code !31
  %3 = bitcast i8* %2 to %struct.L2*, !dbg !117, !verifier.code !31
  call void @llvm.dbg.value(metadata %struct.L2* %3, metadata !118, metadata !DIExpression()), !dbg !116, !verifier.code !31
  %4 = icmp ne %struct.L2* %3, null, !dbg !119, !verifier.code !31
  br i1 %4, label %6, label %5, !dbg !121, !verifier.code !31

5:                                                ; preds = %1
  call void @abort() #6, !dbg !122, !verifier.code !31
  unreachable, !dbg !122, !verifier.code !31

6:                                                ; preds = %1
  %7 = call noalias i8* @malloc(i64 119) #7, !dbg !123, !verifier.code !31
  %8 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !124, !verifier.code !31
  store i8* %7, i8** %8, align 8, !dbg !125, !verifier.code !31
  %9 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 0, !dbg !126, !verifier.code !31
  %10 = load i8*, i8** %9, align 8, !dbg !126, !verifier.code !31
  %11 = icmp ne i8* %10, null, !dbg !128, !verifier.code !31
  br i1 %11, label %13, label %12, !dbg !129, !verifier.code !31

12:                                               ; preds = %6
  call void @abort() #6, !dbg !130, !verifier.code !31
  unreachable, !dbg !130, !verifier.code !31

13:                                               ; preds = %6
  %14 = load %struct.L2*, %struct.L2** %0, align 8, !dbg !131, !verifier.code !31
  %15 = getelementptr inbounds %struct.L2, %struct.L2* %3, i32 0, i32 1, !dbg !132, !verifier.code !31
  store %struct.L2* %14, %struct.L2** %15, align 8, !dbg !133, !verifier.code !31
  store %struct.L2* %3, %struct.L2** %0, align 8, !dbg !134, !verifier.code !31
  ret void, !dbg !135, !verifier.code !31
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #4

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

define void @__SMACK_static_init() {
entry:
  store %struct.L1* null, %struct.L1** @main.list
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone speculatable willreturn }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind willreturn }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!7}
!llvm.ident = !{!21}
!llvm.module.flags = !{!22, !23, !24}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "list", scope: !2, file: !3, line: 68, type: !10, isLocal: true, isDefinition: true)
!2 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 66, type: !4, scopeLine: 67, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!3 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0220.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!4 = !DISubroutineType(types: !5)
!5 = !{!6}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !8, globals: !9, splitDebugInlining: false, nameTableKind: None)
!8 = !{}
!9 = !{!0}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L1", file: !3, line: 20, size: 128, elements: !12)
!12 = !{!13, !14}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !11, file: !3, line: 21, baseType: !10, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "l2", scope: !11, file: !3, line: 22, baseType: !15, size: 64, offset: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "L2", file: !3, line: 15, size: 128, elements: !17)
!17 = !{!18, !20}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "proto", scope: !16, file: !3, line: 16, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !16, file: !3, line: 17, baseType: !15, size: 64, offset: 64)
!21 = !{!"clang version 10.0.0-4ubuntu1 "}
!22 = !{i32 7, !"Dwarf Version", i32 4}
!23 = !{i32 2, !"Debug Info Version", i32 3}
!24 = !{i32 1, !"wchar_size", i32 4}
!25 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !26, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !8)
!26 = !DISubroutineType(types: !27)
!27 = !{null}
!28 = !DILocation(line: 3, column: 22, scope: !29)
!29 = distinct !DILexicalBlock(scope: !30, file: !3, line: 3, column: 22)
!30 = distinct !DILexicalBlock(scope: !25, file: !3, line: 3, column: 22)
!31 = !{i1 false}
!32 = !DILocation(line: 70, column: 5, scope: !2)
!33 = !DILocation(line: 71, column: 9, scope: !2)
!34 = !DILocation(line: 72, column: 12, scope: !2)
!35 = !{i1 true}
!36 = distinct !{!36, !32, !37}
!37 = !DILocation(line: 72, column: 35, scope: !2)
!38 = !DILocation(line: 74, column: 5, scope: !2)
!39 = !DILocation(line: 75, column: 27, scope: !40)
!40 = distinct !DILexicalBlock(scope: !2, file: !3, line: 74, column: 8)
!41 = !DILocation(line: 75, column: 33, scope: !40)
!42 = !DILocalVariable(name: "next", scope: !40, file: !3, line: 75, type: !10)
!43 = !DILocation(line: 0, scope: !40)
!44 = !DILocation(line: 77, column: 20, scope: !40)
!45 = !DILocation(line: 77, column: 26, scope: !40)
!46 = !DILocation(line: 77, column: 9, scope: !40)
!47 = !DILocation(line: 79, column: 14, scope: !40)
!48 = !DILocation(line: 79, column: 9, scope: !40)
!49 = !DILocation(line: 80, column: 14, scope: !40)
!50 = !DILocation(line: 81, column: 5, scope: !40)
!51 = !DILocation(line: 82, column: 12, scope: !2)
!52 = distinct !{!52, !38, !53}
!53 = !DILocation(line: 82, column: 16, scope: !2)
!54 = !DILocation(line: 83, column: 1, scope: !2)
!55 = distinct !DISubprogram(name: "l1_insert", scope: !3, file: !3, line: 52, type: !56, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!56 = !DISubroutineType(types: !57)
!57 = !{null, !58}
!58 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!59 = !DILocalVariable(name: "list", arg: 1, scope: !55, file: !3, line: 52, type: !58)
!60 = !DILocation(line: 0, scope: !55)
!61 = !DILocation(line: 54, column: 23, scope: !55)
!62 = !DILocalVariable(name: "item", scope: !55, file: !3, line: 54, type: !10)
!63 = !DILocation(line: 55, column: 10, scope: !64)
!64 = distinct !DILexicalBlock(scope: !55, file: !3, line: 55, column: 9)
!65 = !DILocation(line: 55, column: 9, scope: !55)
!66 = !DILocation(line: 56, column: 9, scope: !64)
!67 = !DILocation(line: 58, column: 5, scope: !55)
!68 = !DILocation(line: 59, column: 26, scope: !55)
!69 = !DILocation(line: 59, column: 9, scope: !55)
!70 = !DILocation(line: 60, column: 12, scope: !55)
!71 = distinct !{!71, !67, !72}
!72 = !DILocation(line: 60, column: 35, scope: !55)
!73 = !DILocation(line: 62, column: 18, scope: !55)
!74 = !DILocation(line: 62, column: 11, scope: !55)
!75 = !DILocation(line: 62, column: 16, scope: !55)
!76 = !DILocation(line: 63, column: 11, scope: !55)
!77 = !DILocation(line: 64, column: 1, scope: !55)
!78 = distinct !DISubprogram(name: "l2_destroy", scope: !3, file: !3, line: 39, type: !79, scopeLine: 40, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!79 = !DISubroutineType(types: !80)
!80 = !{null, !15}
!81 = !DILocalVariable(name: "list", arg: 1, scope: !78, file: !3, line: 39, type: !15)
!82 = !DILocation(line: 0, scope: !78)
!83 = !DILocation(line: 42, column: 16, scope: !78)
!84 = !DILocation(line: 42, column: 5, scope: !78)
!85 = !DILocation(line: 44, column: 5, scope: !78)
!86 = !DILocation(line: 45, column: 33, scope: !87)
!87 = distinct !DILexicalBlock(scope: !78, file: !3, line: 44, column: 8)
!88 = !DILocalVariable(name: "next", scope: !87, file: !3, line: 45, type: !15)
!89 = !DILocation(line: 0, scope: !87)
!90 = !DILocation(line: 46, column: 14, scope: !87)
!91 = !DILocation(line: 46, column: 9, scope: !87)
!92 = !DILocation(line: 48, column: 5, scope: !87)
!93 = distinct !{!93, !85, !94}
!94 = !DILocation(line: 49, column: 16, scope: !78)
!95 = !DILocation(line: 50, column: 1, scope: !78)
!96 = distinct !DISubprogram(name: "calloc_model", scope: !3, file: !3, line: 8, type: !97, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!97 = !DISubroutineType(types: !98)
!98 = !{!19, !99, !99}
!99 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !100, line: 46, baseType: !101)
!100 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!101 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!102 = !DILocalVariable(name: "nmemb", arg: 1, scope: !96, file: !3, line: 8, type: !99)
!103 = !DILocation(line: 0, scope: !96)
!104 = !DILocalVariable(name: "size", arg: 2, scope: !96, file: !3, line: 8, type: !99)
!105 = !DILocation(line: 9, column: 30, scope: !96)
!106 = !DILocation(line: 9, column: 17, scope: !96)
!107 = !DILocalVariable(name: "ptr", scope: !96, file: !3, line: 9, type: !19)
!108 = !DILocation(line: 10, column: 33, scope: !96)
!109 = !DILocation(line: 10, column: 12, scope: !96)
!110 = !DILocation(line: 10, column: 5, scope: !96)
!111 = distinct !DISubprogram(name: "l2_insert", scope: !3, file: !3, line: 25, type: !112, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !7, retainedNodes: !8)
!112 = !DISubroutineType(types: !113)
!113 = !{null, !114}
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!115 = !DILocalVariable(name: "list", arg: 1, scope: !111, file: !3, line: 25, type: !114)
!116 = !DILocation(line: 0, scope: !111)
!117 = !DILocation(line: 27, column: 23, scope: !111)
!118 = !DILocalVariable(name: "item", scope: !111, file: !3, line: 27, type: !15)
!119 = !DILocation(line: 28, column: 10, scope: !120)
!120 = distinct !DILexicalBlock(scope: !111, file: !3, line: 28, column: 9)
!121 = !DILocation(line: 28, column: 9, scope: !111)
!122 = !DILocation(line: 29, column: 9, scope: !120)
!123 = !DILocation(line: 31, column: 19, scope: !111)
!124 = !DILocation(line: 31, column: 11, scope: !111)
!125 = !DILocation(line: 31, column: 17, scope: !111)
!126 = !DILocation(line: 32, column: 16, scope: !127)
!127 = distinct !DILexicalBlock(scope: !111, file: !3, line: 32, column: 9)
!128 = !DILocation(line: 32, column: 10, scope: !127)
!129 = !DILocation(line: 32, column: 9, scope: !111)
!130 = !DILocation(line: 33, column: 9, scope: !127)
!131 = !DILocation(line: 35, column: 18, scope: !111)
!132 = !DILocation(line: 35, column: 11, scope: !111)
!133 = !DILocation(line: 35, column: 16, scope: !111)
!134 = !DILocation(line: 36, column: 11, scope: !111)
!135 = !DILocation(line: 37, column: 1, scope: !111)
