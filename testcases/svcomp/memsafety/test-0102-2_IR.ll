; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-dyw3uwzu.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.sub_list = type { i32, %struct.list_head }
%struct.top_list = type { %struct.list_head, %struct.list_head, %struct.list_head }

; Function Attrs: noinline nounwind uwtable
define internal void @destroy_sub(%struct.list_head* %0) #0 !dbg !28 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !31, metadata !DIExpression()), !dbg !32, !verifier.code !33
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !34, !verifier.code !33
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !34, !verifier.code !33
  %4 = bitcast %struct.list_head* %3 to i8*, !dbg !34, !verifier.code !33
  %5 = getelementptr inbounds i8, i8* %4, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.sub_list, %struct.sub_list* null, i32 0, i32 1) to i64)), !dbg !34, !verifier.code !33
  %6 = bitcast i8* %5 to %struct.sub_list*, !dbg !34, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.sub_list* %6, metadata !35, metadata !DIExpression()), !dbg !32, !verifier.code !33
  %7 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %6, i32 0, i32 1, !dbg !36, !verifier.code !33
  %8 = icmp ne %struct.list_head* %7, %0, !dbg !37, !verifier.code !33
  br i1 %8, label %.lr.ph, label %19, !dbg !38, !verifier.code !33

.lr.ph:                                           ; preds = %1
  br label %9, !dbg !38, !verifier.code !33

9:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.sub_list* [ %6, %.lr.ph ], [ %15, %forwarder ], !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.sub_list* %.01, metadata !35, metadata !DIExpression()), !dbg !32, !verifier.code !33
  %10 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %.01, i32 0, i32 1, !dbg !39, !verifier.code !33
  %11 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %.01, i32 0, i32 1, i32 0
  %12 = load %struct.list_head*, %struct.list_head** %11, align 8, !dbg !39, !verifier.code !33
  %13 = bitcast %struct.list_head* %12 to i8*, !dbg !39, !verifier.code !33
  %14 = getelementptr inbounds i8, i8* %13, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.sub_list, %struct.sub_list* null, i32 0, i32 1) to i64)), !dbg !39, !verifier.code !33
  %15 = bitcast i8* %14 to %struct.sub_list*, !dbg !39, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.sub_list* %15, metadata !41, metadata !DIExpression()), !dbg !42, !verifier.code !33
  %16 = bitcast %struct.sub_list* %.01 to i8*, !dbg !43, !verifier.code !33
  call void @free(i8* %16) #5, !dbg !44, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.sub_list* %15, metadata !35, metadata !DIExpression()), !dbg !32, !verifier.code !33
  %17 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %15, i32 0, i32 1, !dbg !36, !verifier.code !33
  %18 = icmp ne %struct.list_head* %17, %0, !dbg !37, !verifier.code !33
  br i1 %18, label %forwarder, label %._crit_edge, !dbg !38, !llvm.loop !45, !verifier.code !33

._crit_edge:                                      ; preds = %9
  br label %19, !dbg !38, !verifier.code !33

19:                                               ; preds = %._crit_edge, %1
  ret void, !dbg !47, !verifier.code !33

forwarder:                                        ; preds = %9
  br label %9, !verifier.code !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal void @destroy_top(%struct.list_head* %0) #0 !dbg !48 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !49, metadata !DIExpression()), !dbg !50, !verifier.code !33
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !51, !verifier.code !33
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !51, !verifier.code !33
  %4 = bitcast %struct.list_head* %3 to i8*, !dbg !51, !verifier.code !33
  %5 = getelementptr inbounds i8, i8* %4, i64 0, !dbg !51, !verifier.code !33
  %6 = bitcast i8* %5 to %struct.top_list*, !dbg !51, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.top_list* %6, metadata !52, metadata !DIExpression()), !dbg !50, !verifier.code !33
  %7 = getelementptr inbounds %struct.top_list, %struct.top_list* %6, i32 0, i32 0, !dbg !53, !verifier.code !33
  %8 = icmp ne %struct.list_head* %7, %0, !dbg !54, !verifier.code !33
  br i1 %8, label %.lr.ph, label %20, !dbg !55, !verifier.code !33

.lr.ph:                                           ; preds = %1
  br label %9, !dbg !55, !verifier.code !33

9:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.top_list* [ %6, %.lr.ph ], [ %15, %forwarder ], !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.top_list* %.01, metadata !52, metadata !DIExpression()), !dbg !50, !verifier.code !33
  %10 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 0, !dbg !56, !verifier.code !33
  %11 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 0, i32 0
  %12 = load %struct.list_head*, %struct.list_head** %11, align 8, !dbg !56, !verifier.code !33
  %13 = bitcast %struct.list_head* %12 to i8*, !dbg !56, !verifier.code !33
  %14 = getelementptr inbounds i8, i8* %13, i64 0, !dbg !56, !verifier.code !33
  %15 = bitcast i8* %14 to %struct.top_list*, !dbg !56, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.top_list* %15, metadata !58, metadata !DIExpression()), !dbg !59, !verifier.code !33
  %16 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 1, !dbg !60, !verifier.code !33
  call void @destroy_sub(%struct.list_head* %16), !dbg !61, !verifier.code !33
  %17 = bitcast %struct.top_list* %.01 to i8*, !dbg !62, !verifier.code !33
  call void @free(i8* %17) #5, !dbg !63, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.top_list* %15, metadata !52, metadata !DIExpression()), !dbg !50, !verifier.code !33
  %18 = getelementptr inbounds %struct.top_list, %struct.top_list* %15, i32 0, i32 0, !dbg !53, !verifier.code !33
  %19 = icmp ne %struct.list_head* %18, %0, !dbg !54, !verifier.code !33
  br i1 %19, label %forwarder, label %._crit_edge, !dbg !55, !llvm.loop !64, !verifier.code !33

._crit_edge:                                      ; preds = %9
  br label %20, !dbg !55, !verifier.code !33

20:                                               ; preds = %._crit_edge, %1
  ret void, !dbg !66, !verifier.code !33

forwarder:                                        ; preds = %9
  br label %9, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @insert_sub(%struct.list_head* %0) #0 !dbg !67 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !68, metadata !DIExpression()), !dbg !69, !verifier.code !33
  %2 = call noalias i8* @malloc(i64 24) #5, !dbg !70, !verifier.code !33
  %3 = bitcast i8* %2 to %struct.sub_list*, !dbg !70, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.sub_list* %3, metadata !71, metadata !DIExpression()), !dbg !69, !verifier.code !33
  %4 = icmp ne %struct.sub_list* %3, null, !dbg !72, !verifier.code !33
  br i1 %4, label %6, label %5, !dbg !74, !verifier.code !33

5:                                                ; preds = %1
  call void @abort() #6, !dbg !75, !verifier.code !33
  unreachable, !dbg !75, !verifier.code !33

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %3, i32 0, i32 0, !dbg !76, !verifier.code !33
  store i32 0, i32* %7, align 8, !dbg !77, !verifier.code !33
  %8 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %3, i32 0, i32 1, !dbg !78, !verifier.code !33
  call void @list_add_tail(%struct.list_head* %8, %struct.list_head* %0), !dbg !79, !verifier.code !33
  ret void, !dbg !80, !verifier.code !33
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #3

; Function Attrs: noinline nounwind uwtable
define internal void @list_add_tail(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !81 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !84, metadata !DIExpression()), !dbg !85, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !86, metadata !DIExpression()), !dbg !85, !verifier.code !33
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !87, !verifier.code !33
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !87, !verifier.code !33
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %4, %struct.list_head* %1), !dbg !88, !verifier.code !33
  ret void, !dbg !89, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !90 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !95, metadata !DIExpression()), !dbg !94, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !96, metadata !DIExpression()), !dbg !94, !verifier.code !33
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !97, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !98, !verifier.code !33
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !99, !verifier.code !33
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !100, !verifier.code !33
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !101, !verifier.code !33
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !102, !verifier.code !33
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !103, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !104, !verifier.code !33
  ret void, !dbg !105, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @create_sub_list(%struct.list_head* %0) #0 !dbg !106 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !107, metadata !DIExpression()), !dbg !108, !verifier.code !33
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !109, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %2, align 8, !dbg !110, !verifier.code !33
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !111, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !112, !verifier.code !33
  br label %4, !dbg !113, !verifier.code !33

4:                                                ; preds = %5, %1
  call void @insert_sub(%struct.list_head* %0), !dbg !114, !verifier.code !33
  br label %5, !dbg !114, !verifier.code !33

5:                                                ; preds = %4
  %6 = call i32 @__VERIFIER_nondet_int(), !dbg !115, !verifier.code !116
  %7 = icmp ne i32 %6, 0, !dbg !114, !verifier.code !33
  br i1 %7, label %4, label %8, !dbg !114, !llvm.loop !117, !verifier.code !33

8:                                                ; preds = %5
  ret void, !dbg !119, !verifier.code !33
}

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @insert_top(%struct.list_head* %0) #0 !dbg !120 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !121, metadata !DIExpression()), !dbg !122, !verifier.code !33
  %2 = call noalias i8* @malloc(i64 48) #5, !dbg !123, !verifier.code !33
  %3 = bitcast i8* %2 to %struct.top_list*, !dbg !123, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.top_list* %3, metadata !124, metadata !DIExpression()), !dbg !122, !verifier.code !33
  %4 = icmp ne %struct.top_list* %3, null, !dbg !125, !verifier.code !33
  br i1 %4, label %6, label %5, !dbg !127, !verifier.code !33

5:                                                ; preds = %1
  call void @abort() #6, !dbg !128, !verifier.code !33
  unreachable, !dbg !128, !verifier.code !33

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 1, !dbg !129, !verifier.code !33
  call void @create_sub_list(%struct.list_head* %7), !dbg !130, !verifier.code !33
  %8 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 2, !dbg !131, !verifier.code !33
  call void @create_sub_list(%struct.list_head* %8), !dbg !132, !verifier.code !33
  %9 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 0, !dbg !133, !verifier.code !33
  call void @list_add_tail(%struct.list_head* %9, %struct.list_head* %0), !dbg !134, !verifier.code !33
  ret void, !dbg !135, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @create_top(%struct.list_head* %0) #0 !dbg !136 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !137, metadata !DIExpression()), !dbg !138, !verifier.code !33
  br label %2, !dbg !139, !verifier.code !33

2:                                                ; preds = %3, %1
  call void @insert_top(%struct.list_head* %0), !dbg !140, !verifier.code !33
  br label %3, !dbg !140, !verifier.code !33

3:                                                ; preds = %2
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !141, !verifier.code !116
  %5 = icmp ne i32 %4, 0, !dbg !140, !verifier.code !33
  br i1 %5, label %2, label %6, !dbg !140, !llvm.loop !142, !verifier.code !33

6:                                                ; preds = %3
  ret void, !dbg !144, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !145 {
  %1 = alloca %struct.list_head, align 8, !verifier.code !33
  call void @llvm.dbg.declare(metadata %struct.list_head* %1, metadata !148, metadata !DIExpression()), !dbg !149, !verifier.code !33
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !149, !verifier.code !33
  store %struct.list_head* %1, %struct.list_head** %2, align 8, !dbg !149, !verifier.code !33
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !149, !verifier.code !33
  store %struct.list_head* %1, %struct.list_head** %3, align 8, !dbg !149, !verifier.code !33
  call void @create_top(%struct.list_head* %1), !dbg !150, !verifier.code !33
  call void @destroy_top(%struct.list_head* %1), !dbg !151, !verifier.code !33
  ret i32 0, !dbg !152, !verifier.code !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!24}
!llvm.module.flags = !{!25, !26, !27}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0102-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!4, !15, !17, !18}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sub_list", file: !1, line: 47, size: 192, elements: !6)
!6 = !{!7, !9}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "number", scope: !5, file: !1, line: 48, baseType: !8, size: 32)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_member, name: "link", scope: !5, file: !1, line: 49, baseType: !10, size: 128, offset: 64)
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list_head", file: !1, line: 14, size: 128, elements: !11)
!11 = !{!12, !14}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !10, file: !1, line: 15, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !10, file: !1, line: 15, baseType: !13, size: 64, offset: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "top_list", file: !1, line: 41, size: 384, elements: !20)
!20 = !{!21, !22, !23}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "link", scope: !19, file: !1, line: 42, baseType: !10, size: 128)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "sub1", scope: !19, file: !1, line: 43, baseType: !10, size: 128, offset: 128)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "sub2", scope: !19, file: !1, line: 44, baseType: !10, size: 128, offset: 256)
!24 = !{!"clang version 10.0.0-4ubuntu1 "}
!25 = !{i32 7, !"Dwarf Version", i32 4}
!26 = !{i32 2, !"Debug Info Version", i32 3}
!27 = !{i32 1, !"wchar_size", i32 4}
!28 = distinct !DISubprogram(name: "destroy_sub", scope: !1, file: !1, line: 52, type: !29, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{null, !13}
!31 = !DILocalVariable(name: "head", arg: 1, scope: !28, file: !1, line: 52, type: !13)
!32 = !DILocation(line: 0, scope: !28)
!33 = !{i1 false}
!34 = !DILocation(line: 54, column: 28, scope: !28)
!35 = !DILocalVariable(name: "now", scope: !28, file: !1, line: 54, type: !4)
!36 = !DILocation(line: 56, column: 18, scope: !28)
!37 = !DILocation(line: 56, column: 23, scope: !28)
!38 = !DILocation(line: 56, column: 5, scope: !28)
!39 = !DILocation(line: 57, column: 33, scope: !40)
!40 = distinct !DILexicalBlock(scope: !28, file: !1, line: 56, column: 34)
!41 = !DILocalVariable(name: "next", scope: !40, file: !1, line: 57, type: !4)
!42 = !DILocation(line: 0, scope: !40)
!43 = !DILocation(line: 59, column: 14, scope: !40)
!44 = !DILocation(line: 59, column: 9, scope: !40)
!45 = distinct !{!45, !38, !46}
!46 = !DILocation(line: 61, column: 5, scope: !28)
!47 = !DILocation(line: 62, column: 1, scope: !28)
!48 = distinct !DISubprogram(name: "destroy_top", scope: !1, file: !1, line: 64, type: !29, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!49 = !DILocalVariable(name: "head", arg: 1, scope: !48, file: !1, line: 64, type: !13)
!50 = !DILocation(line: 0, scope: !48)
!51 = !DILocation(line: 66, column: 28, scope: !48)
!52 = !DILocalVariable(name: "now", scope: !48, file: !1, line: 66, type: !18)
!53 = !DILocation(line: 68, column: 18, scope: !48)
!54 = !DILocation(line: 68, column: 23, scope: !48)
!55 = !DILocation(line: 68, column: 5, scope: !48)
!56 = !DILocation(line: 69, column: 33, scope: !57)
!57 = distinct !DILexicalBlock(scope: !48, file: !1, line: 68, column: 34)
!58 = !DILocalVariable(name: "next", scope: !57, file: !1, line: 69, type: !18)
!59 = !DILocation(line: 0, scope: !57)
!60 = !DILocation(line: 71, column: 27, scope: !57)
!61 = !DILocation(line: 71, column: 9, scope: !57)
!62 = !DILocation(line: 77, column: 14, scope: !57)
!63 = !DILocation(line: 77, column: 9, scope: !57)
!64 = distinct !{!64, !55, !65}
!65 = !DILocation(line: 79, column: 5, scope: !48)
!66 = !DILocation(line: 80, column: 1, scope: !48)
!67 = distinct !DISubprogram(name: "insert_sub", scope: !1, file: !1, line: 82, type: !29, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!68 = !DILocalVariable(name: "head", arg: 1, scope: !67, file: !1, line: 82, type: !13)
!69 = !DILocation(line: 0, scope: !67)
!70 = !DILocation(line: 84, column: 28, scope: !67)
!71 = !DILocalVariable(name: "sub", scope: !67, file: !1, line: 84, type: !4)
!72 = !DILocation(line: 85, column: 10, scope: !73)
!73 = distinct !DILexicalBlock(scope: !67, file: !1, line: 85, column: 9)
!74 = !DILocation(line: 85, column: 9, scope: !67)
!75 = !DILocation(line: 86, column: 9, scope: !73)
!76 = !DILocation(line: 88, column: 10, scope: !67)
!77 = !DILocation(line: 88, column: 17, scope: !67)
!78 = !DILocation(line: 90, column: 25, scope: !67)
!79 = !DILocation(line: 90, column: 5, scope: !67)
!80 = !DILocation(line: 91, column: 1, scope: !67)
!81 = distinct !DISubprogram(name: "list_add_tail", scope: !1, file: !1, line: 36, type: !82, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!82 = !DISubroutineType(types: !83)
!83 = !{null, !13, !13}
!84 = !DILocalVariable(name: "new", arg: 1, scope: !81, file: !1, line: 36, type: !13)
!85 = !DILocation(line: 0, scope: !81)
!86 = !DILocalVariable(name: "head", arg: 2, scope: !81, file: !1, line: 36, type: !13)
!87 = !DILocation(line: 38, column: 27, scope: !81)
!88 = !DILocation(line: 38, column: 5, scope: !81)
!89 = !DILocation(line: 39, column: 1, scope: !81)
!90 = distinct !DISubprogram(name: "__list_add", scope: !1, file: !1, line: 26, type: !91, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!91 = !DISubroutineType(types: !92)
!92 = !{null, !13, !13, !13}
!93 = !DILocalVariable(name: "new", arg: 1, scope: !90, file: !1, line: 26, type: !13)
!94 = !DILocation(line: 0, scope: !90)
!95 = !DILocalVariable(name: "prev", arg: 2, scope: !90, file: !1, line: 27, type: !13)
!96 = !DILocalVariable(name: "next", arg: 3, scope: !90, file: !1, line: 28, type: !13)
!97 = !DILocation(line: 30, column: 11, scope: !90)
!98 = !DILocation(line: 30, column: 16, scope: !90)
!99 = !DILocation(line: 31, column: 10, scope: !90)
!100 = !DILocation(line: 31, column: 15, scope: !90)
!101 = !DILocation(line: 32, column: 10, scope: !90)
!102 = !DILocation(line: 32, column: 15, scope: !90)
!103 = !DILocation(line: 33, column: 11, scope: !90)
!104 = !DILocation(line: 33, column: 16, scope: !90)
!105 = !DILocation(line: 34, column: 1, scope: !90)
!106 = distinct !DISubprogram(name: "create_sub_list", scope: !1, file: !1, line: 93, type: !29, scopeLine: 94, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!107 = !DILocalVariable(name: "sub", arg: 1, scope: !106, file: !1, line: 93, type: !13)
!108 = !DILocation(line: 0, scope: !106)
!109 = !DILocation(line: 95, column: 10, scope: !106)
!110 = !DILocation(line: 95, column: 15, scope: !106)
!111 = !DILocation(line: 96, column: 10, scope: !106)
!112 = !DILocation(line: 96, column: 15, scope: !106)
!113 = !DILocation(line: 98, column: 5, scope: !106)
!114 = !DILocation(line: 99, column: 9, scope: !106)
!115 = !DILocation(line: 100, column: 12, scope: !106)
!116 = !{i1 true}
!117 = distinct !{!117, !113, !118}
!118 = !DILocation(line: 100, column: 35, scope: !106)
!119 = !DILocation(line: 101, column: 1, scope: !106)
!120 = distinct !DISubprogram(name: "insert_top", scope: !1, file: !1, line: 103, type: !29, scopeLine: 104, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!121 = !DILocalVariable(name: "head", arg: 1, scope: !120, file: !1, line: 103, type: !13)
!122 = !DILocation(line: 0, scope: !120)
!123 = !DILocation(line: 105, column: 28, scope: !120)
!124 = !DILocalVariable(name: "top", scope: !120, file: !1, line: 105, type: !18)
!125 = !DILocation(line: 106, column: 10, scope: !126)
!126 = distinct !DILexicalBlock(scope: !120, file: !1, line: 106, column: 9)
!127 = !DILocation(line: 106, column: 9, scope: !120)
!128 = !DILocation(line: 107, column: 9, scope: !126)
!129 = !DILocation(line: 109, column: 27, scope: !120)
!130 = !DILocation(line: 109, column: 5, scope: !120)
!131 = !DILocation(line: 110, column: 27, scope: !120)
!132 = !DILocation(line: 110, column: 5, scope: !120)
!133 = !DILocation(line: 112, column: 25, scope: !120)
!134 = !DILocation(line: 112, column: 5, scope: !120)
!135 = !DILocation(line: 113, column: 1, scope: !120)
!136 = distinct !DISubprogram(name: "create_top", scope: !1, file: !1, line: 115, type: !29, scopeLine: 116, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!137 = !DILocalVariable(name: "top", arg: 1, scope: !136, file: !1, line: 115, type: !13)
!138 = !DILocation(line: 0, scope: !136)
!139 = !DILocation(line: 117, column: 5, scope: !136)
!140 = !DILocation(line: 118, column: 9, scope: !136)
!141 = !DILocation(line: 119, column: 12, scope: !136)
!142 = distinct !{!142, !139, !143}
!143 = !DILocation(line: 119, column: 35, scope: !136)
!144 = !DILocation(line: 120, column: 1, scope: !136)
!145 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 122, type: !146, scopeLine: 123, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!146 = !DISubroutineType(types: !147)
!147 = !{!8}
!148 = !DILocalVariable(name: "top", scope: !145, file: !1, line: 124, type: !10)
!149 = !DILocation(line: 124, column: 5, scope: !145)
!150 = !DILocation(line: 126, column: 5, scope: !145)
!151 = !DILocation(line: 128, column: 5, scope: !145)
!152 = !DILocation(line: 130, column: 5, scope: !145)
