; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-32c91vbt.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TData = type { i8*, i8* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !9 {
  %1 = alloca %struct.TData, align 8, !verifier.code !13
  call void @llvm.dbg.declare(metadata %struct.TData* %1, metadata !14, metadata !DIExpression()), !dbg !20, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TData* %1, metadata !21, metadata !DIExpression()), !dbg !23, !verifier.code !13
  %2 = call noalias i8* @malloc(i64 16) #3, !dbg !24, !verifier.code !13
  %3 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 0, !dbg !25, !verifier.code !13
  store i8* %2, i8** %3, align 8, !dbg !26, !verifier.code !13
  %4 = call noalias i8* @malloc(i64 24) #3, !dbg !27, !verifier.code !13
  %5 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 1, !dbg !28, !verifier.code !13
  store i8* %4, i8** %5, align 8, !dbg !29, !verifier.code !13
  %6 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 0, !dbg !30, !verifier.code !13
  %7 = load i8*, i8** %6, align 8, !dbg !30, !verifier.code !13
  call void @llvm.dbg.value(metadata i8* %7, metadata !31, metadata !DIExpression()), !dbg !23, !verifier.code !13
  %8 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 1, !dbg !32, !verifier.code !13
  %9 = load i8*, i8** %8, align 8, !dbg !32, !verifier.code !13
  call void @llvm.dbg.value(metadata i8* %9, metadata !33, metadata !DIExpression()), !dbg !23, !verifier.code !13
  %10 = icmp eq i8* %7, %9, !dbg !34, !verifier.code !13
  br i1 %10, label %11, label %12, !dbg !36, !verifier.code !13

11:                                               ; preds = %0
  call void @free(i8* %7) #3, !dbg !37, !verifier.code !13
  call void @free(i8* %9) #3, !dbg !39, !verifier.code !13
  br label %12, !dbg !40, !verifier.code !13

12:                                               ; preds = %11, %0
  %13 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 0, !dbg !41, !verifier.code !13
  store i8* null, i8** %13, align 8, !dbg !42, !verifier.code !13
  %14 = getelementptr inbounds %struct.TData, %struct.TData* %1, i32 0, i32 1, !dbg !43, !verifier.code !13
  store i8* null, i8** %14, align 8, !dbg !44, !verifier.code !13
  ret i32 0, !dbg !45, !verifier.code !13
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
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 16, type: !10, scopeLine: 16, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !{i1 false}
!14 = !DILocalVariable(name: "data", scope: !9, file: !1, line: 49, type: !15)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "TData", file: !1, line: 13, baseType: !16)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 10, size: 128, elements: !17)
!17 = !{!18, !19}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "lo", scope: !16, file: !1, line: 11, baseType: !4, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "hi", scope: !16, file: !1, line: 12, baseType: !4, size: 64, offset: 64)
!20 = !DILocation(line: 49, column: 11, scope: !9)
!21 = !DILocalVariable(name: "pdata", scope: !9, file: !1, line: 50, type: !22)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!23 = !DILocation(line: 0, scope: !9)
!24 = !DILocation(line: 51, column: 17, scope: !9)
!25 = !DILocation(line: 51, column: 12, scope: !9)
!26 = !DILocation(line: 51, column: 15, scope: !9)
!27 = !DILocation(line: 52, column: 17, scope: !9)
!28 = !DILocation(line: 52, column: 12, scope: !9)
!29 = !DILocation(line: 52, column: 15, scope: !9)
!30 = !DILocation(line: 53, column: 23, scope: !9)
!31 = !DILocalVariable(name: "lo", scope: !9, file: !1, line: 53, type: !4)
!32 = !DILocation(line: 54, column: 23, scope: !9)
!33 = !DILocalVariable(name: "hi", scope: !9, file: !1, line: 54, type: !4)
!34 = !DILocation(line: 56, column: 12, scope: !35)
!35 = distinct !DILexicalBlock(scope: !9, file: !1, line: 56, column: 9)
!36 = !DILocation(line: 56, column: 9, scope: !9)
!37 = !DILocation(line: 57, column: 9, scope: !38)
!38 = distinct !DILexicalBlock(scope: !35, file: !1, line: 56, column: 19)
!39 = !DILocation(line: 58, column: 9, scope: !38)
!40 = !DILocation(line: 59, column: 5, scope: !38)
!41 = !DILocation(line: 61, column: 12, scope: !9)
!42 = !DILocation(line: 61, column: 15, scope: !9)
!43 = !DILocation(line: 62, column: 12, scope: !9)
!44 = !DILocation(line: 62, column: 15, scope: !9)
!45 = !DILocation(line: 72, column: 1, scope: !9)
