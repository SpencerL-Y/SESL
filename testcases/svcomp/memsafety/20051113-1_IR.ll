; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-lozwffyl.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Struct3 = type { i32, [0 x %union.Union] }
%union.Union = type { %struct.Struct2 }
%struct.Struct2 = type <{ i16, i16, i16, i64, i64, i64 }>
%struct.Struct1 = type <{ i16, i16, i16, i64, i64 }>

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"20051113-1.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !7 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !10, !verifier.code !13
  unreachable, !dbg !10, !verifier.code !13
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal i64 @Sum(%struct.Struct3* %0) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata %struct.Struct3* %0, metadata !53, metadata !DIExpression()), !dbg !54, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 0, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 0, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !13
  %2 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %0, i32 0, i32 0, !dbg !57, !verifier.code !13
  %3 = load i32, i32* %2, align 1, !dbg !57, !verifier.code !13
  %4 = icmp slt i32 0, %3, !dbg !60, !verifier.code !13
  br i1 %4, label %.lr.ph, label %17, !dbg !61, !verifier.code !13

.lr.ph:                                           ; preds = %1
  br label %5, !dbg !61, !verifier.code !13

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ 0, %.lr.ph ], [ %14, %forwarder ], !verifier.code !13
  %.012 = phi i64 [ 0, %.lr.ph ], [ %12, %forwarder ], !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.03, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %.012, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !13
  %6 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %0, i32 0, i32 1, !dbg !62, !verifier.code !13
  %7 = sext i32 %.03 to i64, !dbg !64, !verifier.code !13
  %8 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %0, i32 0, i32 1, i64 %7
  %9 = bitcast %union.Union* %8 to %struct.Struct1*, !dbg !65, !verifier.code !13
  %10 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %9, i32 0, i32 3, !dbg !66, !verifier.code !13
  %11 = load i64, i64* %10, align 1, !dbg !66, !verifier.code !13
  %12 = add i64 %.012, %11, !dbg !67, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %12, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !13
  br label %13, !dbg !68, !verifier.code !13

13:                                               ; preds = %5
  %14 = add nsw i32 %.03, 1, !dbg !69, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %14, metadata !56, metadata !DIExpression()), !dbg !54, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %12, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !13
  %15 = load i32, i32* %2, align 1, !dbg !57, !verifier.code !13
  %16 = icmp slt i32 %14, %15, !dbg !60, !verifier.code !13
  br i1 %16, label %forwarder, label %._crit_edge, !dbg !61, !llvm.loop !70, !verifier.code !13

._crit_edge:                                      ; preds = %13
  %split = phi i64 [ %12, %13 ], !verifier.code !13
  br label %17, !dbg !61, !verifier.code !13

17:                                               ; preds = %._crit_edge, %1
  %.01.lcssa = phi i64 [ %split, %._crit_edge ], [ 0, %1 ], !dbg !54, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %.01.lcssa, metadata !55, metadata !DIExpression()), !dbg !54, !verifier.code !13
  ret i64 %.01.lcssa, !dbg !72, !verifier.code !13

forwarder:                                        ; preds = %13
  br label %5, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: noinline nounwind uwtable
define internal i64 @Sum2(%struct.Struct3* %0) #0 !dbg !73 {
  call void @llvm.dbg.value(metadata %struct.Struct3* %0, metadata !76, metadata !DIExpression()), !dbg !77, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 0, metadata !78, metadata !DIExpression()), !dbg !77, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 0, metadata !79, metadata !DIExpression()), !dbg !77, !verifier.code !13
  %2 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %0, i32 0, i32 0, !dbg !80, !verifier.code !13
  %3 = load i32, i32* %2, align 1, !dbg !80, !verifier.code !13
  %4 = icmp slt i32 0, %3, !dbg !83, !verifier.code !13
  br i1 %4, label %.lr.ph, label %17, !dbg !84, !verifier.code !13

.lr.ph:                                           ; preds = %1
  br label %5, !dbg !84, !verifier.code !13

5:                                                ; preds = %forwarder, %.lr.ph
  %.03 = phi i32 [ 0, %.lr.ph ], [ %14, %forwarder ], !verifier.code !13
  %.012 = phi i64 [ 0, %.lr.ph ], [ %12, %forwarder ], !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %.03, metadata !79, metadata !DIExpression()), !dbg !77, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %.012, metadata !78, metadata !DIExpression()), !dbg !77, !verifier.code !13
  %6 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %0, i32 0, i32 1, !dbg !85, !verifier.code !13
  %7 = sext i32 %.03 to i64, !dbg !87, !verifier.code !13
  %8 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %0, i32 0, i32 1, i64 %7
  %9 = bitcast %union.Union* %8 to %struct.Struct1*, !dbg !88, !verifier.code !13
  %10 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %9, i32 0, i32 4, !dbg !89, !verifier.code !13
  %11 = load i64, i64* %10, align 1, !dbg !89, !verifier.code !13
  %12 = add nsw i64 %.012, %11, !dbg !90, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %12, metadata !78, metadata !DIExpression()), !dbg !77, !verifier.code !13
  br label %13, !dbg !91, !verifier.code !13

13:                                               ; preds = %5
  %14 = add nsw i32 %.03, 1, !dbg !92, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %14, metadata !79, metadata !DIExpression()), !dbg !77, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %12, metadata !78, metadata !DIExpression()), !dbg !77, !verifier.code !13
  %15 = load i32, i32* %2, align 1, !dbg !80, !verifier.code !13
  %16 = icmp slt i32 %14, %15, !dbg !83, !verifier.code !13
  br i1 %16, label %forwarder, label %._crit_edge, !dbg !84, !llvm.loop !93, !verifier.code !13

._crit_edge:                                      ; preds = %13
  %split = phi i64 [ %12, %13 ], !verifier.code !13
  br label %17, !dbg !84, !verifier.code !13

17:                                               ; preds = %._crit_edge, %1
  %.01.lcssa = phi i64 [ %split, %._crit_edge ], [ 0, %1 ], !dbg !77, !verifier.code !13
  call void @llvm.dbg.value(metadata i64 %.01.lcssa, metadata !78, metadata !DIExpression()), !dbg !77, !verifier.code !13
  ret i64 %.01.lcssa, !dbg !95, !verifier.code !13

forwarder:                                        ; preds = %13
  br label %5, !verifier.code !13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !96 {
  %1 = call noalias i8* @malloc(i32 94) #6, !dbg !99, !verifier.code !13
  %2 = bitcast i8* %1 to %struct.Struct3*, !dbg !99, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.Struct3* %2, metadata !100, metadata !DIExpression()), !dbg !101, !verifier.code !13
  %3 = bitcast %struct.Struct3* %2 to i8*, !dbg !102, !verifier.code !13
  %4 = call i8* @memset(i8* %3, i32 0, i32 94), !dbg !103, !verifier.code !13
  %5 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 0, !dbg !104, !verifier.code !13
  store i32 3, i32* %5, align 1, !dbg !105, !verifier.code !13
  %6 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, !dbg !106, !verifier.code !13
  %7 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, i64 0
  %8 = bitcast %union.Union* %7 to %struct.Struct1*, !dbg !107, !verifier.code !13
  %9 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %8, i32 0, i32 3, !dbg !108, !verifier.code !13
  store i64 555, i64* %9, align 1, !dbg !109, !verifier.code !13
  %10 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, !dbg !110, !verifier.code !13
  %11 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, i64 1
  %12 = bitcast %union.Union* %11 to %struct.Struct1*, !dbg !111, !verifier.code !13
  %13 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %12, i32 0, i32 3, !dbg !112, !verifier.code !13
  store i64 999, i64* %13, align 1, !dbg !113, !verifier.code !13
  %14 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, !dbg !114, !verifier.code !13
  %15 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, i64 2
  %16 = bitcast %union.Union* %15 to %struct.Struct1*, !dbg !115, !verifier.code !13
  %17 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %16, i32 0, i32 3, !dbg !116, !verifier.code !13
  store i64 4311810305, i64* %17, align 1, !dbg !117, !verifier.code !13
  %18 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, !dbg !118, !verifier.code !13
  %19 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, i64 0
  %20 = bitcast %union.Union* %19 to %struct.Struct1*, !dbg !119, !verifier.code !13
  %21 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %20, i32 0, i32 4, !dbg !120, !verifier.code !13
  store i64 555, i64* %21, align 1, !dbg !121, !verifier.code !13
  %22 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, !dbg !122, !verifier.code !13
  %23 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, i64 1
  %24 = bitcast %union.Union* %23 to %struct.Struct1*, !dbg !123, !verifier.code !13
  %25 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %24, i32 0, i32 4, !dbg !124, !verifier.code !13
  store i64 999, i64* %25, align 1, !dbg !125, !verifier.code !13
  %26 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, !dbg !126, !verifier.code !13
  %27 = getelementptr inbounds %struct.Struct3, %struct.Struct3* %2, i32 0, i32 1, i64 2
  %28 = bitcast %union.Union* %27 to %struct.Struct1*, !dbg !127, !verifier.code !13
  %29 = getelementptr inbounds %struct.Struct1, %struct.Struct1* %28, i32 0, i32 4, !dbg !128, !verifier.code !13
  store i64 4311810305, i64* %29, align 1, !dbg !129, !verifier.code !13
  %30 = call i64 @Sum(%struct.Struct3* %2), !dbg !130, !verifier.code !13
  %31 = icmp ne i64 %30, 4311811859, !dbg !132, !verifier.code !13
  br i1 %31, label %32, label %33, !dbg !133, !verifier.code !13

32:                                               ; preds = %0
  call void @dummy_abort(), !dbg !134, !verifier.code !13
  br label %33, !dbg !134, !verifier.code !13

33:                                               ; preds = %32, %0
  %34 = call i64 @Sum2(%struct.Struct3* %2), !dbg !135, !verifier.code !13
  %35 = icmp ne i64 %34, 4311811859, !dbg !137, !verifier.code !13
  br i1 %35, label %36, label %37, !dbg !138, !verifier.code !13

36:                                               ; preds = %33
  call void @dummy_abort(), !dbg !139, !verifier.code !13
  br label %37, !dbg !139, !verifier.code !13

37:                                               ; preds = %36, %33
  call void @llvm.dbg.value(metadata %struct.Struct3* null, metadata !100, metadata !DIExpression()), !dbg !101, !verifier.code !13
  ret i32 0, !dbg !140, !verifier.code !13
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #3

declare dso_local i8* @memset(i8*, i32, i32) #4

; Function Attrs: noinline nounwind uwtable
define internal void @dummy_abort() #0 !dbg !141 {
  ret void, !dbg !142, !verifier.code !13
}

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
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/20051113-1.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "reach_error", scope: !1, file: !1, line: 12, type: !8, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 12, column: 83, scope: !11)
!11 = distinct !DILexicalBlock(scope: !12, file: !1, line: 12, column: 73)
!12 = distinct !DILexicalBlock(scope: !7, file: !1, line: 12, column: 67)
!13 = !{i1 false}
!14 = distinct !DISubprogram(name: "Sum", scope: !1, file: !1, line: 552, type: !15, scopeLine: 553, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!17, !18}
!17 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "Struct3", file: !1, line: 550, baseType: !20)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 546, size: 32, elements: !21)
!21 = !{!22, !24}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "Count", scope: !20, file: !1, line: 548, baseType: !23, size: 32)
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "List", scope: !20, file: !1, line: 549, baseType: !25, offset: 32)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !26, elements: !51)
!26 = !DIDerivedType(tag: DW_TAG_typedef, name: "Union", file: !1, line: 545, baseType: !27)
!27 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !1, line: 541, size: 240, elements: !28)
!28 = !{!29, !41}
!29 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !27, file: !1, line: 543, baseType: !30, size: 176)
!30 = !DIDerivedType(tag: DW_TAG_typedef, name: "Struct1", file: !1, line: 531, baseType: !31)
!31 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 524, size: 176, elements: !32)
!32 = !{!33, !35, !37, !38, !39}
!33 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !31, file: !1, line: 526, baseType: !34, size: 16)
!34 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !31, file: !1, line: 527, baseType: !36, size: 16, offset: 16)
!36 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !31, file: !1, line: 528, baseType: !36, size: 16, offset: 32)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "Count", scope: !31, file: !1, line: 529, baseType: !17, size: 64, offset: 48)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "Count2", scope: !31, file: !1, line: 530, baseType: !40, size: 64, offset: 112)
!40 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !27, file: !1, line: 544, baseType: !42, size: 240)
!42 = !DIDerivedType(tag: DW_TAG_typedef, name: "Struct2", file: !1, line: 540, baseType: !43)
!43 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 532, size: 240, elements: !44)
!44 = !{!45, !46, !47, !48, !49, !50}
!45 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !43, file: !1, line: 534, baseType: !34, size: 16)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !43, file: !1, line: 535, baseType: !36, size: 16, offset: 16)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !43, file: !1, line: 536, baseType: !36, size: 16, offset: 32)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !43, file: !1, line: 537, baseType: !17, size: 64, offset: 48)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "e", scope: !43, file: !1, line: 538, baseType: !40, size: 64, offset: 112)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !43, file: !1, line: 539, baseType: !40, size: 64, offset: 176)
!51 = !{!52}
!52 = !DISubrange(count: -1)
!53 = !DILocalVariable(name: "instrs", arg: 1, scope: !14, file: !1, line: 552, type: !18)
!54 = !DILocation(line: 0, scope: !14)
!55 = !DILocalVariable(name: "count", scope: !14, file: !1, line: 554, type: !17)
!56 = !DILocalVariable(name: "i", scope: !14, file: !1, line: 555, type: !23)
!57 = !DILocation(line: 556, column: 29, scope: !58)
!58 = distinct !DILexicalBlock(scope: !59, file: !1, line: 556, column: 5)
!59 = distinct !DILexicalBlock(scope: !14, file: !1, line: 556, column: 5)
!60 = !DILocation(line: 556, column: 19, scope: !58)
!61 = !DILocation(line: 556, column: 5, scope: !59)
!62 = !DILocation(line: 557, column: 26, scope: !63)
!63 = distinct !DILexicalBlock(scope: !58, file: !1, line: 556, column: 41)
!64 = !DILocation(line: 557, column: 18, scope: !63)
!65 = !DILocation(line: 557, column: 34, scope: !63)
!66 = !DILocation(line: 557, column: 36, scope: !63)
!67 = !DILocation(line: 557, column: 15, scope: !63)
!68 = !DILocation(line: 558, column: 5, scope: !63)
!69 = !DILocation(line: 556, column: 37, scope: !58)
!70 = distinct !{!70, !61, !71}
!71 = !DILocation(line: 558, column: 5, scope: !59)
!72 = !DILocation(line: 559, column: 5, scope: !14)
!73 = distinct !DISubprogram(name: "Sum2", scope: !1, file: !1, line: 562, type: !74, scopeLine: 563, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!74 = !DISubroutineType(types: !75)
!75 = !{!40, !18}
!76 = !DILocalVariable(name: "instrs", arg: 1, scope: !73, file: !1, line: 562, type: !18)
!77 = !DILocation(line: 0, scope: !73)
!78 = !DILocalVariable(name: "count", scope: !73, file: !1, line: 564, type: !40)
!79 = !DILocalVariable(name: "i", scope: !73, file: !1, line: 565, type: !23)
!80 = !DILocation(line: 566, column: 29, scope: !81)
!81 = distinct !DILexicalBlock(scope: !82, file: !1, line: 566, column: 5)
!82 = distinct !DILexicalBlock(scope: !73, file: !1, line: 566, column: 5)
!83 = !DILocation(line: 566, column: 19, scope: !81)
!84 = !DILocation(line: 566, column: 5, scope: !82)
!85 = !DILocation(line: 567, column: 26, scope: !86)
!86 = distinct !DILexicalBlock(scope: !81, file: !1, line: 566, column: 41)
!87 = !DILocation(line: 567, column: 18, scope: !86)
!88 = !DILocation(line: 567, column: 34, scope: !86)
!89 = !DILocation(line: 567, column: 36, scope: !86)
!90 = !DILocation(line: 567, column: 15, scope: !86)
!91 = !DILocation(line: 568, column: 5, scope: !86)
!92 = !DILocation(line: 566, column: 37, scope: !81)
!93 = distinct !{!93, !84, !94}
!94 = !DILocation(line: 568, column: 5, scope: !82)
!95 = !DILocation(line: 569, column: 5, scope: !73)
!96 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 574, type: !97, scopeLine: 574, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!97 = !DISubroutineType(types: !98)
!98 = !{!23}
!99 = !DILocation(line: 575, column: 16, scope: !96)
!100 = !DILocalVariable(name: "p", scope: !96, file: !1, line: 575, type: !18)
!101 = !DILocation(line: 0, scope: !96)
!102 = !DILocation(line: 576, column: 10, scope: !96)
!103 = !DILocation(line: 576, column: 3, scope: !96)
!104 = !DILocation(line: 577, column: 6, scope: !96)
!105 = !DILocation(line: 577, column: 12, scope: !96)
!106 = !DILocation(line: 578, column: 6, scope: !96)
!107 = !DILocation(line: 578, column: 14, scope: !96)
!108 = !DILocation(line: 578, column: 16, scope: !96)
!109 = !DILocation(line: 578, column: 22, scope: !96)
!110 = !DILocation(line: 579, column: 6, scope: !96)
!111 = !DILocation(line: 579, column: 14, scope: !96)
!112 = !DILocation(line: 579, column: 16, scope: !96)
!113 = !DILocation(line: 579, column: 22, scope: !96)
!114 = !DILocation(line: 580, column: 6, scope: !96)
!115 = !DILocation(line: 580, column: 14, scope: !96)
!116 = !DILocation(line: 580, column: 16, scope: !96)
!117 = !DILocation(line: 580, column: 22, scope: !96)
!118 = !DILocation(line: 581, column: 6, scope: !96)
!119 = !DILocation(line: 581, column: 14, scope: !96)
!120 = !DILocation(line: 581, column: 16, scope: !96)
!121 = !DILocation(line: 581, column: 23, scope: !96)
!122 = !DILocation(line: 582, column: 6, scope: !96)
!123 = !DILocation(line: 582, column: 14, scope: !96)
!124 = !DILocation(line: 582, column: 16, scope: !96)
!125 = !DILocation(line: 582, column: 23, scope: !96)
!126 = !DILocation(line: 583, column: 6, scope: !96)
!127 = !DILocation(line: 583, column: 14, scope: !96)
!128 = !DILocation(line: 583, column: 16, scope: !96)
!129 = !DILocation(line: 583, column: 23, scope: !96)
!130 = !DILocation(line: 584, column: 7, scope: !131)
!131 = distinct !DILexicalBlock(scope: !96, file: !1, line: 584, column: 7)
!132 = !DILocation(line: 584, column: 14, scope: !131)
!133 = !DILocation(line: 584, column: 7, scope: !96)
!134 = !DILocation(line: 585, column: 5, scope: !131)
!135 = !DILocation(line: 586, column: 7, scope: !136)
!136 = distinct !DILexicalBlock(scope: !96, file: !1, line: 586, column: 7)
!137 = !DILocation(line: 586, column: 15, scope: !136)
!138 = !DILocation(line: 586, column: 7, scope: !96)
!139 = !DILocation(line: 587, column: 5, scope: !136)
!140 = !DILocation(line: 589, column: 3, scope: !96)
!141 = distinct !DISubprogram(name: "dummy_abort", scope: !1, file: !1, line: 571, type: !8, scopeLine: 572, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!142 = !DILocation(line: 573, column: 1, scope: !141)
