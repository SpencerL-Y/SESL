; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-zmqi3_r9.bc'
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
  %1 = call noalias i8* @malloc(i32 32) #4, !dbg !36, !verifier.code !13
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
  %7 = call i32 @__VERIFIER_nondet_int(), !dbg !44, !verifier.code !45
  %8 = icmp ne i32 %7, 0, !dbg !46, !verifier.code !13
  br i1 %8, label %.lr.ph4, label %26, !dbg !46, !verifier.code !13

.lr.ph4:                                          ; preds = %0
  br label %9, !dbg !46, !verifier.code !13

9:                                                ; preds = %forwarder6, %.lr.ph4
  %.02 = phi %struct.TNode* [ %2, %.lr.ph4 ], [ %11, %forwarder6 ], !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %.02, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %10 = call noalias i8* @malloc(i32 32) #4, !dbg !47, !verifier.code !13
  %11 = bitcast i8* %10 to %struct.TNode*, !dbg !47, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %11, metadata !35, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %12 = getelementptr inbounds %struct.TNode, %struct.TNode* %11, i32 0, i32 0, !dbg !49, !verifier.code !13
  store %struct.TNode* %.02, %struct.TNode** %12, align 8, !dbg !50, !verifier.code !13
  %13 = getelementptr inbounds %struct.TNode, %struct.TNode* %.02, i32 0, i32 1, !dbg !51, !verifier.code !13
  store %struct.TNode* %11, %struct.TNode** %13, align 8, !dbg !52, !verifier.code !13
  %14 = call i32 @__VERIFIER_nondet_int(), !dbg !53, !verifier.code !45
  %15 = icmp ne i32 %14, 0, !dbg !53, !verifier.code !13
  br i1 %15, label %16, label %20, !dbg !55, !verifier.code !13

16:                                               ; preds = %9
  %17 = call noalias i8* @malloc(i32 1) #4, !dbg !56, !verifier.code !13
  %18 = bitcast i8* %17 to %struct.TData*, !dbg !56, !verifier.code !13
  %19 = getelementptr inbounds %struct.TNode, %struct.TNode* %11, i32 0, i32 2, !dbg !58, !verifier.code !13
  store %struct.TData* %18, %struct.TData** %19, align 8, !dbg !59, !verifier.code !13
  br label %23, !dbg !60, !verifier.code !13

20:                                               ; preds = %9
  %21 = getelementptr inbounds %struct.TNode, %struct.TNode* %11, i32 0, i32 3, !dbg !61, !verifier.code !13
  %22 = getelementptr inbounds %struct.TNode, %struct.TNode* %11, i32 0, i32 2, !dbg !63, !verifier.code !13
  store %struct.TData* %21, %struct.TData** %22, align 8, !dbg !64, !verifier.code !13
  br label %23, !verifier.code !13

23:                                               ; preds = %20, %16
  call void @llvm.dbg.value(metadata %struct.TNode* %11, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %24 = call i32 @__VERIFIER_nondet_int(), !dbg !44, !verifier.code !45
  %25 = icmp ne i32 %24, 0, !dbg !46, !verifier.code !13
  br i1 %25, label %forwarder6, label %._crit_edge5, !dbg !46, !llvm.loop !65, !verifier.code !13

._crit_edge5:                                     ; preds = %23
  %split = phi %struct.TNode* [ %11, %23 ], !verifier.code !13
  br label %26, !dbg !46, !verifier.code !13

26:                                               ; preds = %._crit_edge5, %0
  %.0.lcssa = phi %struct.TNode* [ %split, %._crit_edge5 ], [ %2, %0 ], !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %.0.lcssa, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %27 = icmp ne %struct.TNode* null, %.0.lcssa, !dbg !67, !verifier.code !13
  br i1 %27, label %.lr.ph, label %42, !dbg !68, !verifier.code !13

.lr.ph:                                           ; preds = %26
  br label %28, !dbg !68, !verifier.code !13

28:                                               ; preds = %forwarder, %.lr.ph
  %.11 = phi %struct.TNode* [ %.0.lcssa, %.lr.ph ], [ %30, %forwarder ], !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %.11, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %.11, metadata !35, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %29 = getelementptr inbounds %struct.TNode, %struct.TNode* %.11, i32 0, i32 0, !dbg !69, !verifier.code !13
  %30 = load %struct.TNode*, %struct.TNode** %29, align 8, !dbg !69, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %30, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %31 = getelementptr inbounds %struct.TNode, %struct.TNode* %.11, i32 0, i32 3, !dbg !71, !verifier.code !13
  %32 = getelementptr inbounds %struct.TNode, %struct.TNode* %.11, i32 0, i32 2, !dbg !73, !verifier.code !13
  %33 = load %struct.TData*, %struct.TData** %32, align 8, !dbg !73, !verifier.code !13
  %34 = icmp ne %struct.TData* %31, %33, !dbg !74, !verifier.code !13
  br i1 %34, label %35, label %39, !dbg !75, !verifier.code !13

35:                                               ; preds = %28
  %36 = getelementptr inbounds %struct.TNode, %struct.TNode* %.11, i32 0, i32 2, !dbg !76, !verifier.code !13
  %37 = load %struct.TData*, %struct.TData** %36, align 8, !dbg !76, !verifier.code !13
  %38 = bitcast %struct.TData* %37 to i8*, !dbg !78, !verifier.code !13
  call void @free(i8* %38) #4, !dbg !79, !verifier.code !13
  br label %39, !dbg !80, !verifier.code !13

39:                                               ; preds = %35, %28
  %40 = bitcast %struct.TNode* %.11 to i8*, !dbg !81, !verifier.code !13
  call void @free(i8* %40) #4, !dbg !82, !verifier.code !13
  call void @llvm.dbg.value(metadata %struct.TNode* %30, metadata !18, metadata !DIExpression()), !dbg !34, !verifier.code !13
  %41 = icmp ne %struct.TNode* null, %30, !dbg !67, !verifier.code !13
  br i1 %41, label %forwarder, label %._crit_edge, !dbg !68, !llvm.loop !83, !verifier.code !13

._crit_edge:                                      ; preds = %39
  br label %42, !dbg !68, !verifier.code !13

42:                                               ; preds = %._crit_edge, %26
  ret i32 0, !dbg !85, !verifier.code !13

forwarder:                                        ; preds = %39
  br label %28, !verifier.code !13

forwarder6:                                       ; preds = %23
  br label %9, !verifier.code !13
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i32) #2

declare dso_local i32 @__VERIFIER_nondet_int() #3

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
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

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
!44 = !DILocation(line: 534, column: 9, scope: !14)
!45 = !{i1 true}
!46 = !DILocation(line: 534, column: 2, scope: !14)
!47 = !DILocation(line: 536, column: 7, scope: !48)
!48 = distinct !DILexicalBlock(scope: !14, file: !1, line: 535, column: 2)
!49 = !DILocation(line: 537, column: 6, scope: !48)
!50 = !DILocation(line: 537, column: 11, scope: !48)
!51 = !DILocation(line: 538, column: 9, scope: !48)
!52 = !DILocation(line: 538, column: 14, scope: !48)
!53 = !DILocation(line: 539, column: 7, scope: !54)
!54 = distinct !DILexicalBlock(scope: !48, file: !1, line: 539, column: 7)
!55 = !DILocation(line: 539, column: 7, scope: !48)
!56 = !DILocation(line: 541, column: 15, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 540, column: 3)
!58 = !DILocation(line: 541, column: 7, scope: !57)
!59 = !DILocation(line: 541, column: 13, scope: !57)
!60 = !DILocation(line: 542, column: 3, scope: !57)
!61 = !DILocation(line: 545, column: 19, scope: !62)
!62 = distinct !DILexicalBlock(scope: !54, file: !1, line: 544, column: 3)
!63 = !DILocation(line: 545, column: 7, scope: !62)
!64 = !DILocation(line: 545, column: 13, scope: !62)
!65 = distinct !{!65, !46, !66}
!66 = !DILocation(line: 548, column: 2, scope: !14)
!67 = !DILocation(line: 549, column: 21, scope: !14)
!68 = !DILocation(line: 549, column: 2, scope: !14)
!69 = !DILocation(line: 552, column: 16, scope: !70)
!70 = distinct !DILexicalBlock(scope: !14, file: !1, line: 550, column: 2)
!71 = !DILocation(line: 553, column: 11, scope: !72)
!72 = distinct !DILexicalBlock(scope: !70, file: !1, line: 553, column: 7)
!73 = !DILocation(line: 553, column: 22, scope: !72)
!74 = !DILocation(line: 553, column: 16, scope: !72)
!75 = !DILocation(line: 553, column: 7, scope: !70)
!76 = !DILocation(line: 555, column: 12, scope: !77)
!77 = distinct !DILexicalBlock(scope: !72, file: !1, line: 554, column: 3)
!78 = !DILocation(line: 555, column: 9, scope: !77)
!79 = !DILocation(line: 555, column: 4, scope: !77)
!80 = !DILocation(line: 556, column: 3, scope: !77)
!81 = !DILocation(line: 557, column: 8, scope: !70)
!82 = !DILocation(line: 557, column: 3, scope: !70)
!83 = distinct !{!83, !68, !84}
!84 = !DILocation(line: 558, column: 2, scope: !14)
!85 = !DILocation(line: 559, column: 2, scope: !14)
