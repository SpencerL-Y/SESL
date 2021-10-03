; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-2sbl23hd.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.node = type { %struct.node*, %struct.node*, i32*, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !9 {
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* null, metadata !26, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %1 = call noalias i8* @malloc(i64 32) #3, !dbg !27, !verifier.code !25
  %2 = bitcast i8* %1 to %struct.node*, !dbg !27, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %2, metadata !26, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %3 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 0, !dbg !28, !verifier.code !25
  store %struct.node* null, %struct.node** %3, align 8, !dbg !29, !verifier.code !25
  %4 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 1, !dbg !30, !verifier.code !25
  store %struct.node* null, %struct.node** %4, align 8, !dbg !31, !verifier.code !25
  %5 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 3, !dbg !32, !verifier.code !25
  %6 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 2, !dbg !33, !verifier.code !25
  store i32* %5, i32** %6, align 8, !dbg !34, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %2, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %7 = call noalias i8* @malloc(i64 32) #3, !dbg !35, !verifier.code !25
  %8 = bitcast i8* %7 to %struct.node*, !dbg !35, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %8, metadata !26, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %9 = getelementptr inbounds %struct.node, %struct.node* %8, i32 0, i32 0, !dbg !36, !verifier.code !25
  store %struct.node* %2, %struct.node** %9, align 8, !dbg !37, !verifier.code !25
  %10 = getelementptr inbounds %struct.node, %struct.node* %2, i32 0, i32 1, !dbg !38, !verifier.code !25
  store %struct.node* %8, %struct.node** %10, align 8, !dbg !39, !verifier.code !25
  %11 = call noalias i8* @malloc(i64 4) #3, !dbg !40, !verifier.code !25
  %12 = bitcast i8* %11 to i32*, !dbg !40, !verifier.code !25
  %13 = getelementptr inbounds %struct.node, %struct.node* %8, i32 0, i32 2, !dbg !41, !verifier.code !25
  store i32* %12, i32** %13, align 8, !dbg !42, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %8, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %14 = call noalias i8* @malloc(i64 32) #3, !dbg !43, !verifier.code !25
  %15 = bitcast i8* %14 to %struct.node*, !dbg !43, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %15, metadata !26, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %16 = getelementptr inbounds %struct.node, %struct.node* %15, i32 0, i32 0, !dbg !44, !verifier.code !25
  store %struct.node* %8, %struct.node** %16, align 8, !dbg !45, !verifier.code !25
  %17 = getelementptr inbounds %struct.node, %struct.node* %8, i32 0, i32 1, !dbg !46, !verifier.code !25
  store %struct.node* %15, %struct.node** %17, align 8, !dbg !47, !verifier.code !25
  %18 = call noalias i8* @malloc(i64 4) #3, !dbg !48, !verifier.code !25
  %19 = bitcast i8* %18 to i32*, !dbg !48, !verifier.code !25
  %20 = getelementptr inbounds %struct.node, %struct.node* %15, i32 0, i32 2, !dbg !49, !verifier.code !25
  store i32* %19, i32** %20, align 8, !dbg !50, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %15, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %21 = call noalias i8* @malloc(i64 32) #3, !dbg !51, !verifier.code !25
  %22 = bitcast i8* %21 to %struct.node*, !dbg !51, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %22, metadata !26, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %23 = getelementptr inbounds %struct.node, %struct.node* %22, i32 0, i32 0, !dbg !52, !verifier.code !25
  store %struct.node* %15, %struct.node** %23, align 8, !dbg !53, !verifier.code !25
  %24 = getelementptr inbounds %struct.node, %struct.node* %15, i32 0, i32 1, !dbg !54, !verifier.code !25
  store %struct.node* %22, %struct.node** %24, align 8, !dbg !55, !verifier.code !25
  %25 = call noalias i8* @malloc(i64 4) #3, !dbg !56, !verifier.code !25
  %26 = bitcast i8* %25 to i32*, !dbg !56, !verifier.code !25
  %27 = getelementptr inbounds %struct.node, %struct.node* %22, i32 0, i32 2, !dbg !57, !verifier.code !25
  store i32* %26, i32** %27, align 8, !dbg !58, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %22, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %28 = icmp ne %struct.node* null, %22, !dbg !59, !verifier.code !25
  br i1 %28, label %.lr.ph, label %43, !dbg !60, !verifier.code !25

.lr.ph:                                           ; preds = %0
  br label %29, !dbg !60, !verifier.code !25

29:                                               ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.node* [ %22, %.lr.ph ], [ %31, %forwarder ], !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %.01, metadata !26, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %30 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 0, !dbg !61, !verifier.code !25
  %31 = load %struct.node*, %struct.node** %30, align 8, !dbg !61, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %31, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %32 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 3, !dbg !63, !verifier.code !25
  %33 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 2, !dbg !65, !verifier.code !25
  %34 = load i32*, i32** %33, align 8, !dbg !65, !verifier.code !25
  %35 = icmp ne i32* %32, %34, !dbg !66, !verifier.code !25
  br i1 %35, label %36, label %40, !dbg !67, !verifier.code !25

36:                                               ; preds = %29
  %37 = getelementptr inbounds %struct.node, %struct.node* %.01, i32 0, i32 2, !dbg !68, !verifier.code !25
  %38 = load i32*, i32** %37, align 8, !dbg !68, !verifier.code !25
  %39 = bitcast i32* %38 to i8*, !dbg !70, !verifier.code !25
  call void @free(i8* %39) #3, !dbg !71, !verifier.code !25
  br label %40, !dbg !72, !verifier.code !25

40:                                               ; preds = %36, %29
  %41 = bitcast %struct.node* %.01 to i8*, !dbg !73, !verifier.code !25
  call void @free(i8* %41) #3, !dbg !74, !verifier.code !25
  call void @llvm.dbg.value(metadata %struct.node* %31, metadata !13, metadata !DIExpression()), !dbg !24, !verifier.code !25
  %42 = icmp ne %struct.node* null, %31, !dbg !59, !verifier.code !25
  br i1 %42, label %forwarder, label %._crit_edge, !dbg !60, !llvm.loop !75, !verifier.code !25

._crit_edge:                                      ; preds = %40
  br label %43, !dbg !60, !verifier.code !25

43:                                               ; preds = %._crit_edge, %0
  ret i32 0, !dbg !77, !verifier.code !25

forwarder:                                        ; preds = %40
  br label %29, !verifier.code !25
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
!1 = !DIFile(filename: "../testcases/printtest/exec.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 161, type: !10, scopeLine: 161, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "list", scope: !9, file: !1, line: 174, type: !14)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_typedef, name: "Node", file: !1, line: 159, baseType: !16)
!16 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !1, line: 154, size: 256, elements: !17)
!17 = !{!18, !20, !21, !23}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !16, file: !1, line: 155, baseType: !19, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !16, file: !1, line: 156, baseType: !19, size: 64, offset: 64)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "pData", scope: !16, file: !1, line: 157, baseType: !22, size: 64, offset: 128)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !16, file: !1, line: 158, baseType: !12, size: 32, offset: 192)
!24 = !DILocation(line: 0, scope: !9)
!25 = !{i1 false}
!26 = !DILocalVariable(name: "y", scope: !9, file: !1, line: 175, type: !14)
!27 = !DILocation(line: 176, column: 6, scope: !9)
!28 = !DILocation(line: 177, column: 5, scope: !9)
!29 = !DILocation(line: 177, column: 10, scope: !9)
!30 = !DILocation(line: 178, column: 5, scope: !9)
!31 = !DILocation(line: 178, column: 10, scope: !9)
!32 = !DILocation(line: 179, column: 17, scope: !9)
!33 = !DILocation(line: 179, column: 5, scope: !9)
!34 = !DILocation(line: 179, column: 11, scope: !9)
!35 = !DILocation(line: 181, column: 6, scope: !9)
!36 = !DILocation(line: 182, column: 5, scope: !9)
!37 = !DILocation(line: 182, column: 10, scope: !9)
!38 = !DILocation(line: 183, column: 8, scope: !9)
!39 = !DILocation(line: 183, column: 13, scope: !9)
!40 = !DILocation(line: 184, column: 13, scope: !9)
!41 = !DILocation(line: 184, column: 5, scope: !9)
!42 = !DILocation(line: 184, column: 11, scope: !9)
!43 = !DILocation(line: 186, column: 6, scope: !9)
!44 = !DILocation(line: 187, column: 5, scope: !9)
!45 = !DILocation(line: 187, column: 10, scope: !9)
!46 = !DILocation(line: 188, column: 8, scope: !9)
!47 = !DILocation(line: 188, column: 13, scope: !9)
!48 = !DILocation(line: 189, column: 13, scope: !9)
!49 = !DILocation(line: 189, column: 5, scope: !9)
!50 = !DILocation(line: 189, column: 11, scope: !9)
!51 = !DILocation(line: 191, column: 6, scope: !9)
!52 = !DILocation(line: 192, column: 5, scope: !9)
!53 = !DILocation(line: 192, column: 10, scope: !9)
!54 = !DILocation(line: 193, column: 8, scope: !9)
!55 = !DILocation(line: 193, column: 13, scope: !9)
!56 = !DILocation(line: 194, column: 13, scope: !9)
!57 = !DILocation(line: 194, column: 5, scope: !9)
!58 = !DILocation(line: 194, column: 11, scope: !9)
!59 = !DILocation(line: 196, column: 21, scope: !9)
!60 = !DILocation(line: 196, column: 2, scope: !9)
!61 = !DILocation(line: 199, column: 16, scope: !62)
!62 = distinct !DILexicalBlock(scope: !9, file: !1, line: 197, column: 2)
!63 = !DILocation(line: 200, column: 11, scope: !64)
!64 = distinct !DILexicalBlock(scope: !62, file: !1, line: 200, column: 7)
!65 = !DILocation(line: 200, column: 22, scope: !64)
!66 = !DILocation(line: 200, column: 16, scope: !64)
!67 = !DILocation(line: 200, column: 7, scope: !62)
!68 = !DILocation(line: 202, column: 12, scope: !69)
!69 = distinct !DILexicalBlock(scope: !64, file: !1, line: 201, column: 3)
!70 = !DILocation(line: 202, column: 9, scope: !69)
!71 = !DILocation(line: 202, column: 4, scope: !69)
!72 = !DILocation(line: 203, column: 3, scope: !69)
!73 = !DILocation(line: 204, column: 8, scope: !62)
!74 = !DILocation(line: 204, column: 3, scope: !62)
!75 = distinct !{!75, !60, !76}
!76 = !DILocation(line: 205, column: 2, scope: !9)
!77 = !DILocation(line: 206, column: 2, scope: !9)
