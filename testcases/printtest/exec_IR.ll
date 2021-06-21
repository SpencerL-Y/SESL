; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build/b-md4_hwe8.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.test_type = type { i32, i8 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !10 {
  %1 = alloca [2 x [3 x i32]], align 16, !verifier.code !13
  %2 = alloca %struct.test_type, align 4, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 5, metadata !14, metadata !DIExpression()), !dbg !15, !verifier.code !13
  %3 = sext i32 5 to i64, !dbg !16, !verifier.code !13
  %4 = mul i64 %3, 4, !dbg !17, !verifier.code !13
  %5 = call noalias i8* @malloc(i64 %4) #3, !dbg !18, !verifier.code !13
  %6 = bitcast i8* %5 to i32*, !dbg !19, !verifier.code !13
  call void @llvm.dbg.value(metadata i32* %6, metadata !20, metadata !DIExpression()), !dbg !15, !verifier.code !13
  %7 = getelementptr inbounds i32, i32* %6, i64 1, !dbg !21, !verifier.code !13
  store i32 1110, i32* %7, align 4, !dbg !22, !verifier.code !13
  %8 = getelementptr inbounds i32, i32* %6, i64 2, !dbg !23, !verifier.code !13
  %9 = load i32, i32* %8, align 4, !dbg !24, !verifier.code !13
  %10 = add nsw i32 %9, -1, !dbg !25, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 %10, metadata !26, metadata !DIExpression()), !dbg !15, !verifier.code !13
  call void @llvm.dbg.declare(metadata [2 x [3 x i32]]* %1, metadata !27, metadata !DIExpression()), !dbg !32, !verifier.code !13
  %11 = getelementptr inbounds [2 x [3 x i32]], [2 x [3 x i32]]* %1, i64 0, i64 1, !dbg !33, !verifier.code !13
  %12 = getelementptr inbounds [2 x [3 x i32]], [2 x [3 x i32]]* %1, i64 0, i64 1, i64 2
  store i32 5, i32* %12, align 4, !dbg !34, !verifier.code !13
  call void @llvm.dbg.declare(metadata %struct.test_type* %2, metadata !35, metadata !DIExpression()), !dbg !42, !verifier.code !13
  %13 = getelementptr inbounds %struct.test_type, %struct.test_type* %2, i32 0, i32 1, !dbg !43, !verifier.code !13
  store i8 97, i8* %13, align 4, !dbg !44, !verifier.code !13
  ret i32 0, !dbg !45, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

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
!llvm.ident = !{!6}
!llvm.module.flags = !{!7, !8, !9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/smack/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = !{i32 7, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 9, type: !11, scopeLine: 9, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5}
!13 = !{i1 false}
!14 = !DILocalVariable(name: "num", scope: !10, file: !1, line: 10, type: !5)
!15 = !DILocation(line: 0, scope: !10)
!16 = !DILocation(line: 15, column: 27, scope: !10)
!17 = !DILocation(line: 15, column: 30, scope: !10)
!18 = !DILocation(line: 15, column: 20, scope: !10)
!19 = !DILocation(line: 15, column: 14, scope: !10)
!20 = !DILocalVariable(name: "j", scope: !10, file: !1, line: 15, type: !4)
!21 = !DILocation(line: 19, column: 8, scope: !10)
!22 = !DILocation(line: 19, column: 12, scope: !10)
!23 = !DILocation(line: 20, column: 19, scope: !10)
!24 = !DILocation(line: 20, column: 16, scope: !10)
!25 = !DILocation(line: 20, column: 23, scope: !10)
!26 = !DILocalVariable(name: "nnum", scope: !10, file: !1, line: 20, type: !5)
!27 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 24, type: !28)
!28 = !DICompositeType(tag: DW_TAG_array_type, baseType: !5, size: 192, elements: !29)
!29 = !{!30, !31}
!30 = !DISubrange(count: 2)
!31 = !DISubrange(count: 3)
!32 = !DILocation(line: 24, column: 9, scope: !10)
!33 = !DILocation(line: 25, column: 5, scope: !10)
!34 = !DILocation(line: 25, column: 13, scope: !10)
!35 = !DILocalVariable(name: "my", scope: !10, file: !1, line: 26, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "test_type", file: !1, line: 7, baseType: !37)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 4, size: 64, elements: !38)
!38 = !{!39, !40}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !37, file: !1, line: 5, baseType: !5, size: 32)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !37, file: !1, line: 6, baseType: !41, size: 8, offset: 32)
!41 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!42 = !DILocation(line: 26, column: 15, scope: !10)
!43 = !DILocation(line: 27, column: 8, scope: !10)
!44 = !DILocation(line: 27, column: 10, scope: !10)
!45 = !DILocation(line: 31, column: 1, scope: !10)
