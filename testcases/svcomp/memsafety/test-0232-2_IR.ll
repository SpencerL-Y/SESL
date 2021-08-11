; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-ontoprrz.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.item = type { %struct.item*, %struct.item* }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca %struct.item*, align 8, !verifier.code !11
  call void @llvm.dbg.declare(metadata %struct.item** %1, metadata !12, metadata !DIExpression()), !dbg !18, !verifier.code !11
  store %struct.item* null, %struct.item** %1, align 8, !dbg !18, !verifier.code !11
  br label %2, !dbg !19, !verifier.code !11

2:                                                ; preds = %3, %0
  call void @append(%struct.item** %1), !dbg !20, !verifier.code !11
  br label %3, !dbg !20, !verifier.code !11

3:                                                ; preds = %2
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !21, !verifier.code !22
  %5 = icmp ne i32 %4, 0, !dbg !20, !verifier.code !11
  br i1 %5, label %2, label %6, !dbg !20, !llvm.loop !23, !verifier.code !11

6:                                                ; preds = %3
  %7 = load %struct.item*, %struct.item** %1, align 8, !dbg !25, !verifier.code !11
  %8 = icmp ne %struct.item* %7, null, !dbg !25, !verifier.code !11
  br i1 %8, label %9, label %19, !dbg !27, !verifier.code !11

9:                                                ; preds = %6
  %10 = load %struct.item*, %struct.item** %1, align 8, !dbg !28, !verifier.code !11
  %11 = getelementptr inbounds %struct.item, %struct.item* %10, i32 0, i32 0, !dbg !30, !verifier.code !11
  %12 = load %struct.item*, %struct.item** %11, align 8, !dbg !30, !verifier.code !11
  call void @llvm.dbg.value(metadata %struct.item* %12, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !11
  %13 = load %struct.item*, %struct.item** %1, align 8, !dbg !33, !verifier.code !11
  %14 = getelementptr inbounds %struct.item, %struct.item* %13, i32 0, i32 1, !dbg !34, !verifier.code !11
  %15 = load %struct.item*, %struct.item** %14, align 8, !dbg !34, !verifier.code !11
  %16 = bitcast %struct.item* %15 to i8*, !dbg !33, !verifier.code !11
  call void @free(i8* %16) #4, !dbg !35, !verifier.code !11
  %17 = load %struct.item*, %struct.item** %1, align 8, !dbg !36, !verifier.code !11
  %18 = bitcast %struct.item* %17 to i8*, !dbg !36, !verifier.code !11
  call void @free(i8* %18) #4, !dbg !37, !verifier.code !11
  store %struct.item* %12, %struct.item** %1, align 8, !dbg !38, !verifier.code !11
  br label %19, !dbg !39, !verifier.code !11

19:                                               ; preds = %9, %6
  %20 = load %struct.item*, %struct.item** %1, align 8, !dbg !40, !verifier.code !11
  %21 = icmp ne %struct.item* %20, null, !dbg !41, !verifier.code !11
  br i1 %21, label %.lr.ph, label %30, !dbg !41, !verifier.code !11

.lr.ph:                                           ; preds = %19
  br label %22, !dbg !41, !verifier.code !11

22:                                               ; preds = %.lr.ph, %22
  %23 = load %struct.item*, %struct.item** %1, align 8, !dbg !42, !verifier.code !11
  %24 = getelementptr inbounds %struct.item, %struct.item* %23, i32 0, i32 0, !dbg !44, !verifier.code !11
  %25 = load %struct.item*, %struct.item** %24, align 8, !dbg !44, !verifier.code !11
  call void @llvm.dbg.value(metadata %struct.item* %25, metadata !45, metadata !DIExpression()), !dbg !46, !verifier.code !11
  %26 = load %struct.item*, %struct.item** %1, align 8, !dbg !47, !verifier.code !11
  %27 = bitcast %struct.item* %26 to i8*, !dbg !47, !verifier.code !11
  call void @free(i8* %27) #4, !dbg !48, !verifier.code !11
  store %struct.item* %25, %struct.item** %1, align 8, !dbg !49, !verifier.code !11
  %28 = load %struct.item*, %struct.item** %1, align 8, !dbg !40, !verifier.code !11
  %29 = icmp ne %struct.item* %28, null, !dbg !41, !verifier.code !11
  br i1 %29, label %22, label %._crit_edge, !dbg !41, !llvm.loop !50, !verifier.code !11

._crit_edge:                                      ; preds = %22
  br label %30, !dbg !41, !verifier.code !11

30:                                               ; preds = %._crit_edge, %19
  ret i32 0, !dbg !52, !verifier.code !11
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define internal void @append(%struct.item** %0) #0 !dbg !53 {
  call void @llvm.dbg.value(metadata %struct.item** %0, metadata !57, metadata !DIExpression()), !dbg !58, !verifier.code !11
  %2 = call noalias i8* @malloc(i64 16) #4, !dbg !59, !verifier.code !11
  %3 = bitcast i8* %2 to %struct.item*, !dbg !59, !verifier.code !11
  call void @llvm.dbg.value(metadata %struct.item* %3, metadata !60, metadata !DIExpression()), !dbg !58, !verifier.code !11
  %4 = load %struct.item*, %struct.item** %0, align 8, !dbg !61, !verifier.code !11
  %5 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 0, !dbg !62, !verifier.code !11
  store %struct.item* %4, %struct.item** %5, align 8, !dbg !63, !verifier.code !11
  %6 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 0, !dbg !64, !verifier.code !11
  %7 = load %struct.item*, %struct.item** %6, align 8, !dbg !64, !verifier.code !11
  %8 = icmp ne %struct.item* %7, null, !dbg !65, !verifier.code !11
  br i1 %8, label %9, label %15, !dbg !65, !verifier.code !11

9:                                                ; preds = %1
  %10 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 0, !dbg !66, !verifier.code !11
  %11 = load %struct.item*, %struct.item** %10, align 8, !dbg !66, !verifier.code !11
  %12 = getelementptr inbounds %struct.item, %struct.item* %11, i32 0, i32 1, !dbg !67, !verifier.code !11
  %13 = load %struct.item*, %struct.item** %12, align 8, !dbg !67, !verifier.code !11
  %14 = bitcast %struct.item* %13 to i8*, !dbg !68, !verifier.code !11
  br label %17, !dbg !65, !verifier.code !11

15:                                               ; preds = %1
  %16 = call noalias i8* @malloc(i64 16) #4, !dbg !69, !verifier.code !11
  br label %17, !dbg !65, !verifier.code !11

17:                                               ; preds = %15, %9
  %18 = phi i8* [ %14, %9 ], [ %16, %15 ], !dbg !65, !verifier.code !11
  %19 = bitcast i8* %18 to %struct.item*, !dbg !65, !verifier.code !11
  %20 = getelementptr inbounds %struct.item, %struct.item* %3, i32 0, i32 1, !dbg !70, !verifier.code !11
  store %struct.item* %19, %struct.item** %20, align 8, !dbg !71, !verifier.code !11
  store %struct.item* %3, %struct.item** %0, align 8, !dbg !72, !verifier.code !11
  ret void, !dbg !73, !verifier.code !11
}

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0232-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 27, type: !8, scopeLine: 28, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{i1 false}
!12 = !DILocalVariable(name: "list", scope: !7, file: !1, line: 29, type: !13)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "item", file: !1, line: 9, size: 128, elements: !15)
!15 = !{!16, !17}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !1, line: 10, baseType: !13, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !14, file: !1, line: 11, baseType: !13, size: 64, offset: 64)
!18 = !DILocation(line: 29, column: 18, scope: !7)
!19 = !DILocation(line: 32, column: 5, scope: !7)
!20 = !DILocation(line: 33, column: 9, scope: !7)
!21 = !DILocation(line: 34, column: 12, scope: !7)
!22 = !{i1 true}
!23 = distinct !{!23, !19, !24}
!24 = !DILocation(line: 34, column: 35, scope: !7)
!25 = !DILocation(line: 37, column: 9, scope: !26)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 37, column: 9)
!27 = !DILocation(line: 37, column: 9, scope: !7)
!28 = !DILocation(line: 38, column: 29, scope: !29)
!29 = distinct !DILexicalBlock(scope: !26, file: !1, line: 37, column: 15)
!30 = !DILocation(line: 38, column: 35, scope: !29)
!31 = !DILocalVariable(name: "next", scope: !29, file: !1, line: 38, type: !13)
!32 = !DILocation(line: 0, scope: !29)
!33 = !DILocation(line: 41, column: 14, scope: !29)
!34 = !DILocation(line: 41, column: 20, scope: !29)
!35 = !DILocation(line: 41, column: 9, scope: !29)
!36 = !DILocation(line: 43, column: 14, scope: !29)
!37 = !DILocation(line: 43, column: 9, scope: !29)
!38 = !DILocation(line: 44, column: 14, scope: !29)
!39 = !DILocation(line: 45, column: 5, scope: !29)
!40 = !DILocation(line: 49, column: 12, scope: !7)
!41 = !DILocation(line: 49, column: 5, scope: !7)
!42 = !DILocation(line: 50, column: 29, scope: !43)
!43 = distinct !DILexicalBlock(scope: !7, file: !1, line: 49, column: 18)
!44 = !DILocation(line: 50, column: 35, scope: !43)
!45 = !DILocalVariable(name: "next", scope: !43, file: !1, line: 50, type: !13)
!46 = !DILocation(line: 0, scope: !43)
!47 = !DILocation(line: 51, column: 14, scope: !43)
!48 = !DILocation(line: 51, column: 9, scope: !43)
!49 = !DILocation(line: 52, column: 14, scope: !43)
!50 = distinct !{!50, !41, !51}
!51 = !DILocation(line: 53, column: 5, scope: !7)
!52 = !DILocation(line: 55, column: 5, scope: !7)
!53 = distinct !DISubprogram(name: "append", scope: !1, file: !1, line: 14, type: !54, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!54 = !DISubroutineType(types: !55)
!55 = !{null, !56}
!56 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!57 = !DILocalVariable(name: "plist", arg: 1, scope: !53, file: !1, line: 14, type: !56)
!58 = !DILocation(line: 0, scope: !53)
!59 = !DILocation(line: 16, column: 25, scope: !53)
!60 = !DILocalVariable(name: "item", scope: !53, file: !1, line: 16, type: !13)
!61 = !DILocation(line: 17, column: 18, scope: !53)
!62 = !DILocation(line: 17, column: 11, scope: !53)
!63 = !DILocation(line: 17, column: 16, scope: !53)
!64 = !DILocation(line: 20, column: 25, scope: !53)
!65 = !DILocation(line: 20, column: 18, scope: !53)
!66 = !DILocation(line: 21, column: 17, scope: !53)
!67 = !DILocation(line: 21, column: 23, scope: !53)
!68 = !DILocation(line: 21, column: 11, scope: !53)
!69 = !DILocation(line: 22, column: 11, scope: !53)
!70 = !DILocation(line: 20, column: 11, scope: !53)
!71 = !DILocation(line: 20, column: 16, scope: !53)
!72 = !DILocation(line: 24, column: 12, scope: !53)
!73 = !DILocation(line: 25, column: 1, scope: !53)
