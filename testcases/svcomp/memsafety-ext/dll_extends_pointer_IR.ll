; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-1_ucn7q1.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TNode = type { %struct.TNode*, %struct.TNode*, %struct.TData*, %struct.TData }
%struct.TData = type { i8 }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  ret void, !dbg !12, !verifier.code !13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !14 {
  call void @llvm.dbg.value(metadata %struct.TNode* null, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* null, metadata !35, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %1 = call noalias i8* @malloc(i32 32) #3, !dbg !36, !verifier.code !13
  %2 = bitcast i8* %1 to %struct.TNode*, !dbg !36, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %2, metadata !35, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %3 = getelementptr inbounds %struct.TNode, %struct.TNode* %2, i32 0, i32 0, !dbg !37, !verifier.code !13
  store %struct.TNode* null, %struct.TNode** %3, align 8, !dbg !38, !verifier.code !13
  %4 = getelementptr inbounds %struct.TNode, %struct.TNode* %2, i32 0, i32 1, !dbg !39, !verifier.code !13
  store %struct.TNode* null, %struct.TNode** %4, align 8, !dbg !40, !verifier.code !13
  %5 = getelementptr inbounds %struct.TNode, %struct.TNode* %2, i32 0, i32 3, !dbg !41, !verifier.code !13
  %6 = getelementptr inbounds %struct.TNode, %struct.TNode* %2, i32 0, i32 2, !dbg !42, !verifier.code !13
  store %struct.TData* %5, %struct.TData** %6, align 8, !dbg !43, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %2, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 0, metadata !44, metadata !DIExpression()), !dbg !34, !verifier.code !13
  br label %7, !dbg !45, !verifier.code !13

7:                                                ; preds = %0
  call void @llvm.dbg.value(metadata i32 0, metadata !44, metadata !DIExpression()), !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %2, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %8 = call noalias i8* @malloc(i32 32) #3, !dbg !46, !verifier.code !13
  %9 = bitcast i8* %8 to %struct.TNode*, !dbg !46, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %9, metadata !35, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %10 = getelementptr inbounds %struct.TNode, %struct.TNode* %9, i32 0, i32 0, !dbg !48, !verifier.code !13
  store %struct.TNode* %2, %struct.TNode** %10, align 8, !dbg !49, !verifier.code !13
  %11 = getelementptr inbounds %struct.TNode, %struct.TNode* %2, i32 0, i32 1, !dbg !50, !verifier.code !13
  store %struct.TNode* %9, %struct.TNode** %11, align 8, !dbg !51, !verifier.code !13
  %12 = call noalias i8* @malloc(i32 1) #3, !dbg !52, !verifier.code !13
  %13 = bitcast i8* %12 to %struct.TData*, !dbg !52, !verifier.code !13
  %14 = getelementptr inbounds %struct.TNode, %struct.TNode* %9, i32 0, i32 2, !dbg !55, !verifier.code !13
  store %struct.TData* %13, %struct.TData** %14, align 8, !dbg !56, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %9, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata i32 1, metadata !44, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %15 = icmp ne %struct.TNode* null, %9, !dbg !57, !verifier.code !13
  br i1 %15, label %.lr.ph, label %30, !dbg !58, !verifier.code !13

.lr.ph:                                           ; preds = %7
  br label %16, !dbg !58, !verifier.code !13

16:                                               ; preds = %forwarder, %.lr.ph
  %.12 = phi %struct.TNode* [ %9, %.lr.ph ], [ %18, %forwarder ], !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %.12, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %.12, metadata !35, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %17 = getelementptr inbounds %struct.TNode, %struct.TNode* %.12, i32 0, i32 0, !dbg !59, !verifier.code !13
  %18 = load %struct.TNode*, %struct.TNode** %17, align 8, !dbg !59, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %18, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %19 = getelementptr inbounds %struct.TNode, %struct.TNode* %.12, i32 0, i32 3, !dbg !61, !verifier.code !13
  %20 = getelementptr inbounds %struct.TNode, %struct.TNode* %.12, i32 0, i32 2, !dbg !63, !verifier.code !13
  %21 = load %struct.TData*, %struct.TData** %20, align 8, !dbg !63, !verifier.code !13
  %22 = icmp ne %struct.TData* %19, %21, !dbg !64, !verifier.code !13
  br i1 %22, label %23, label %27, !dbg !65, !verifier.code !13

23:                                               ; preds = %16
  %24 = getelementptr inbounds %struct.TNode, %struct.TNode* %.12, i32 0, i32 2, !dbg !66, !verifier.code !13
  %25 = load %struct.TData*, %struct.TData** %24, align 8, !dbg !66, !verifier.code !13
  %26 = bitcast %struct.TData* %25 to i8*, !dbg !68, !verifier.code !13
  call void @free(i8* %26) #3, !dbg !69, !verifier.code !13
  br label %27, !dbg !70, !verifier.code !13

27:                                               ; preds = %23, %16
  %28 = bitcast %struct.TNode* %.12 to i8*, !dbg !71, !verifier.code !13
  call void @free(i8* %28) #3, !dbg !72, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %18, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %29 = icmp ne %struct.TNode* null, %18, !dbg !57, !verifier.code !13
  br i1 %29, label %forwarder, label %._crit_edge, !dbg !58, !llvm.loop !73, !verifier.code !13

._crit_edge:                                      ; preds = %27
  br label %30, !dbg !58, !verifier.code !13

30:                                               ; preds = %._crit_edge, %7
  ret i32 0, !dbg !75, !verifier.code !13

forwarder:                                        ; preds = %27
  br label %16, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #2

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
!1 = !DIFile(filename: "../testcases/svcomp/memsafety-ext/dll_extends_pointer.i", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !1, file: !1, line: 3, type: !10, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null}
!12 = !DILocation(line: 3, column: 20, scope: !9)
!13 = !{i1 false}
!14 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 525, type: !15, scopeLine: 526, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{!17}
!17 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!18 = !DILocalVariable(name: "list", scope: !14, file: !1, line: 527, type: !19)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "Node", file: !1, line: 524, baseType: !21)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TNode", file: !1, line: 518, size: 256, elements: !22)
!22 = !{!23, !25, !26, !33}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !21, file: !1, line: 520, baseType: !24, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !21, file: !1, line: 521, baseType: !24, size: 64, offset: 64)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "pData", scope: !21, file: !1, line: 522, baseType: !27, size: 64, offset: 128)
!27 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !28, size: 64)
!28 = !DIDerivedType(tag: DW_TAG_typedef, name: "Data", file: !1, line: 517, baseType: !29)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TData", file: !1, line: 514, size: 8, elements: !30)
!30 = !{!31}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !29, file: !1, line: 516, baseType: !32, size: 8)
!32 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !21, file: !1, line: 523, baseType: !28, size: 8, offset: 192)
!34 = !DILocation(line: 0, scope: !14)
!35 = !DILocalVariable(name: "y", scope: !14, file: !1, line: 528, type: !19)
!36 = !DILocation(line: 529, column: 6, scope: !14)
!37 = !DILocation(line: 530, column: 5, scope: !14)
!38 = !DILocation(line: 530, column: 10, scope: !14)
!39 = !DILocation(line: 531, column: 5, scope: !14)
!40 = !DILocation(line: 531, column: 10, scope: !14)
!41 = !DILocation(line: 532, column: 17, scope: !14)
!42 = !DILocation(line: 532, column: 5, scope: !14)
!43 = !DILocation(line: 532, column: 11, scope: !14)
!44 = !DILocalVariable(name: "i", scope: !14, file: !1, line: 535, type: !17)
!45 = !DILocation(line: 536, column: 1, scope: !14)
!46 = !DILocation(line: 538, column: 7, scope: !47)
!47 = distinct !DILexicalBlock(scope: !14, file: !1, line: 537, column: 2)
!48 = !DILocation(line: 539, column: 6, scope: !47)
!49 = !DILocation(line: 539, column: 11, scope: !47)
!50 = !DILocation(line: 540, column: 9, scope: !47)
!51 = !DILocation(line: 540, column: 14, scope: !47)
!52 = !DILocation(line: 544, column: 15, scope: !53)
!53 = distinct !DILexicalBlock(scope: !54, file: !1, line: 543, column: 3)
!54 = distinct !DILexicalBlock(scope: !47, file: !1, line: 542, column: 5)
!55 = !DILocation(line: 544, column: 7, scope: !53)
!56 = !DILocation(line: 544, column: 13, scope: !53)
!57 = !DILocation(line: 553, column: 21, scope: !14)
!58 = !DILocation(line: 553, column: 2, scope: !14)
!59 = !DILocation(line: 556, column: 16, scope: !60)
!60 = distinct !DILexicalBlock(scope: !14, file: !1, line: 554, column: 2)
!61 = !DILocation(line: 557, column: 11, scope: !62)
!62 = distinct !DILexicalBlock(scope: !60, file: !1, line: 557, column: 7)
!63 = !DILocation(line: 557, column: 22, scope: !62)
!64 = !DILocation(line: 557, column: 16, scope: !62)
!65 = !DILocation(line: 557, column: 7, scope: !60)
!66 = !DILocation(line: 559, column: 12, scope: !67)
!67 = distinct !DILexicalBlock(scope: !62, file: !1, line: 558, column: 3)
!68 = !DILocation(line: 559, column: 9, scope: !67)
!69 = !DILocation(line: 559, column: 4, scope: !67)
!70 = !DILocation(line: 560, column: 3, scope: !67)
!71 = !DILocation(line: 561, column: 8, scope: !60)
!72 = !DILocation(line: 561, column: 3, scope: !60)
!73 = distinct !{!73, !58, !74}
!74 = !DILocation(line: 562, column: 2, scope: !14)
!75 = !DILocation(line: 563, column: 2, scope: !14)
