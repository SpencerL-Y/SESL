; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-272xcx86.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca %struct.TData, align 8, !verifier.code !11
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !12, metadata !DIExpression()), !dbg !19, !verifier.code !11
  call void @llvm.dbg.value(metadata %struct.TData* %1, metadata !20, metadata !DIExpression()), !dbg !22, !verifier.code !11
  %2 = call noalias i8* @malloc(i64 16) #3, !dbg !23, !verifier.code !11
  %3 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 0, !dbg !24, !verifier.code !11
  store i8* %2, i8** %3, align 8, !dbg !25, !verifier.code !11
  %4 = call noalias i8* @malloc(i64 24) #3, !dbg !26, !verifier.code !11
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 1, !dbg !27, !verifier.code !11
  store i8* %4, i8** %5, align 8, !dbg !28, !verifier.code !11
  %6 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 0, !dbg !29, !verifier.code !11
  %7 = load i8*, i8** %6, align 8, !dbg !29, !verifier.code !11
  call void @llvm.dbg.value(metadata i8* %7, metadata !30, metadata !DIExpression()), !dbg !22, !verifier.code !11
  %8 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 1, !dbg !31, !verifier.code !11
  %9 = load i8*, i8** %8, align 8, !dbg !31, !verifier.code !11
  call void @llvm.dbg.value(metadata i8* %9, metadata !32, metadata !DIExpression()), !dbg !22, !verifier.code !11
  call void @free(i8* %7) #3, !dbg !33, !verifier.code !11
  call void @free(i8* %9) #3, !dbg !34, !verifier.code !11
  ret i32 0, !dbg !35, !verifier.code !11
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
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !8, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i1 false}
!12 = !DILocalVariable(name: "data", scope: !7, file: !1, line: 23, type: !13)
!13 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !1, line: 13, baseType: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 10, size: 128, elements: !15)
!15 = !{!16, !18}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !14, file: !1, line: 11, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !14, file: !1, line: 12, baseType: !17, size: 64, offset: 64)
!19 = !DILocation(line: 23, column: 11, scope: !7)
!20 = !DILocalVariable(name: "pdata", scope: !7, file: !1, line: 24, type: !21)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!22 = !DILocation(line: 0, scope: !7)
!23 = !DILocation(line: 27, column: 17, scope: !7)
!24 = !DILocation(line: 27, column: 12, scope: !7)
!25 = !DILocation(line: 27, column: 15, scope: !7)
!26 = !DILocation(line: 28, column: 17, scope: !7)
!27 = !DILocation(line: 28, column: 12, scope: !7)
!28 = !DILocation(line: 28, column: 15, scope: !7)
!29 = !DILocation(line: 29, column: 23, scope: !7)
!30 = !DILocalVariable(name: "lo", scope: !7, file: !1, line: 29, type: !17)
!31 = !DILocation(line: 30, column: 23, scope: !7)
!32 = !DILocalVariable(name: "hi", scope: !7, file: !1, line: 30, type: !17)
!33 = !DILocation(line: 31, column: 5, scope: !7)
!34 = !DILocation(line: 32, column: 5, scope: !7)
!35 = !DILocation(line: 52, column: 1, scope: !7)
