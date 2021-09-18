; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-q4an4ucp.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal i32 @test_6() #2 !dbg !11 {
  %1 = alloca %struct.TData, align 8, !verifier.code !14
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !15, metadata !DIExpression()), !dbg !21, !verifier.code !14
  call void @alloc_data(%struct.TData* %1), !dbg !22, !verifier.code !14
  call void @free_data(%struct.TData* %1), !dbg !23, !verifier.code !14
  ret i32 0, !dbg !24, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @alloc_data(%struct.TData* %0) #2 !dbg !25 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !29, metadata !DIExpression()), !dbg !30, !verifier.code !14
  %2 = call noalias i8* @malloc(i64 16) #3, !dbg !31, !verifier.code !14
  %3 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !32, !verifier.code !14
  store i8* %2, i8** %3, align 8, !dbg !33, !verifier.code !14
  %4 = call noalias i8* @malloc(i64 24) #3, !dbg !34, !verifier.code !14
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !35, !verifier.code !14
  store i8* %4, i8** %5, align 8, !dbg !36, !verifier.code !14
  ret void, !dbg !37, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define internal void @free_data(%struct.TData* %0) #2 !dbg !38 {
  call void @llvm.dbg.value(metadata %struct.TData* %0, metadata !39, metadata !DIExpression()), !dbg !40, !verifier.code !14
  %2 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 0, !dbg !41, !verifier.code !14
  %3 = load i8*, i8** %2, align 8, !dbg !41, !verifier.code !14
  call void @llvm.dbg.value(metadata i8* %3, metadata !42, metadata !DIExpression()), !dbg !40, !verifier.code !14
  %4 = getelementptr inbounds %struct.TData, %struct.TData* %0, i32 0, i32 1, !dbg !43, !verifier.code !14
  %5 = load i8*, i8** %4, align 8, !dbg !43, !verifier.code !14
  call void @llvm.dbg.value(metadata i8* %5, metadata !44, metadata !DIExpression()), !dbg !40, !verifier.code !14
  %6 = icmp eq i8* %3, %5, !dbg !45, !verifier.code !14
  br i1 %6, label %7, label %8, !dbg !47, !verifier.code !14

7:                                                ; preds = %1
  call void @free(i8* %3) #3, !dbg !48, !verifier.code !14
  call void @free(i8* %5) #3, !dbg !50, !verifier.code !14
  br label %8, !dbg !51, !verifier.code !14

8:                                                ; preds = %7, %1
  call void @llvm.dbg.value(metadata i8* null, metadata !42, metadata !DIExpression()), !dbg !40, !verifier.code !14
  call void @llvm.dbg.value(metadata i8* null, metadata !44, metadata !DIExpression()), !dbg !40, !verifier.code !14
  ret void, !dbg !52, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #2 !dbg !53 {
  %1 = call i32 @test_6(), !dbg !54, !verifier.code !14
  ret i32 0, !dbg !55, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #0

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!7}
!llvm.module.flags = !{!8, !9, !10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !6}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "test_6", scope: !1, file: !1, line: 126, type: !12, scopeLine: 126, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{!5}
!14 = !{i1 false}
!15 = !DILocalVariable(name: "data", scope: !11, file: !1, line: 127, type: !16)
!16 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !1, line: 104, baseType: !17)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 101, size: 128, elements: !18)
!18 = !{!19, !20}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !17, file: !1, line: 102, baseType: !6, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !17, file: !1, line: 103, baseType: !6, size: 64, offset: 64)
!21 = !DILocation(line: 127, column: 11, scope: !11)
!22 = !DILocation(line: 128, column: 5, scope: !11)
!23 = !DILocation(line: 129, column: 5, scope: !11)
!24 = !DILocation(line: 130, column: 5, scope: !11)
!25 = distinct !DISubprogram(name: "alloc_data", scope: !1, file: !1, line: 106, type: !26, scopeLine: 107, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{null, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!29 = !DILocalVariable(name: "pdata", arg: 1, scope: !25, file: !1, line: 106, type: !28)
!30 = !DILocation(line: 0, scope: !25)
!31 = !DILocation(line: 108, column: 17, scope: !25)
!32 = !DILocation(line: 108, column: 12, scope: !25)
!33 = !DILocation(line: 108, column: 15, scope: !25)
!34 = !DILocation(line: 109, column: 17, scope: !25)
!35 = !DILocation(line: 109, column: 12, scope: !25)
!36 = !DILocation(line: 109, column: 15, scope: !25)
!37 = !DILocation(line: 110, column: 1, scope: !25)
!38 = distinct !DISubprogram(name: "free_data", scope: !1, file: !1, line: 112, type: !26, scopeLine: 113, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!39 = !DILocalVariable(name: "data", arg: 1, scope: !38, file: !1, line: 112, type: !28)
!40 = !DILocation(line: 0, scope: !38)
!41 = !DILocation(line: 114, column: 22, scope: !38)
!42 = !DILocalVariable(name: "lo", scope: !38, file: !1, line: 114, type: !6)
!43 = !DILocation(line: 115, column: 22, scope: !38)
!44 = !DILocalVariable(name: "hi", scope: !38, file: !1, line: 115, type: !6)
!45 = !DILocation(line: 117, column: 12, scope: !46)
!46 = distinct !DILexicalBlock(scope: !38, file: !1, line: 117, column: 9)
!47 = !DILocation(line: 117, column: 9, scope: !38)
!48 = !DILocation(line: 118, column: 9, scope: !49)
!49 = distinct !DILexicalBlock(scope: !46, file: !1, line: 117, column: 19)
!50 = !DILocation(line: 119, column: 9, scope: !49)
!51 = !DILocation(line: 120, column: 5, scope: !49)
!52 = !DILocation(line: 124, column: 1, scope: !38)
!53 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 140, type: !12, scopeLine: 140, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!54 = !DILocation(line: 148, column: 5, scope: !53)
!55 = !DILocation(line: 149, column: 5, scope: !53)
