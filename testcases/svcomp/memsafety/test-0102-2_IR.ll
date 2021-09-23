; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-0za73i1q.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.sub_list = type { i32, %struct.list_head }
%struct.top_list = type { %struct.list_head, %struct.list_head, %struct.list_head }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0102-2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !29 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !32, !verifier.code !35
  unreachable, !dbg !32, !verifier.code !35
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @destroy_sub(%struct.list_head* %0) #0 !dbg !36 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !39, metadata !DIExpression()), !dbg !40, !verifier.code !35
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !41, !verifier.code !35
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !41, !verifier.code !35
  %4 = bitcast %struct.list_head* %3 to i8*, !dbg !41, !verifier.code !35
  %5 = getelementptr inbounds i8, i8* %4, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.sub_list, %struct.sub_list* null, i32 0, i32 1) to i64)), !dbg !41, !verifier.code !35
  %6 = bitcast i8* %5 to %struct.sub_list*, !dbg !41, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.sub_list* %6, metadata !42, metadata !DIExpression()), !dbg !40, !verifier.code !35
  %7 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %6, i32 0, i32 1, !dbg !43, !verifier.code !35
  %8 = icmp ne %struct.list_head* %7, %0, !dbg !44, !verifier.code !35
  br i1 %8, label %.lr.ph, label %19, !dbg !45, !verifier.code !35

.lr.ph:                                           ; preds = %1
  br label %9, !dbg !45, !verifier.code !35

9:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.sub_list* [ %6, %.lr.ph ], [ %15, %forwarder ], !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.sub_list* %.01, metadata !42, metadata !DIExpression()), !dbg !40, !verifier.code !35
  %10 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %.01, i32 0, i32 1, !dbg !46, !verifier.code !35
  %11 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %.01, i32 0, i32 1, i32 0
  %12 = load %struct.list_head*, %struct.list_head** %11, align 8, !dbg !46, !verifier.code !35
  %13 = bitcast %struct.list_head* %12 to i8*, !dbg !46, !verifier.code !35
  %14 = getelementptr inbounds i8, i8* %13, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.sub_list, %struct.sub_list* null, i32 0, i32 1) to i64)), !dbg !46, !verifier.code !35
  %15 = bitcast i8* %14 to %struct.sub_list*, !dbg !46, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.sub_list* %15, metadata !48, metadata !DIExpression()), !dbg !49, !verifier.code !35
  %16 = bitcast %struct.sub_list* %.01 to i8*, !dbg !50, !verifier.code !35
  call void @free(i8* %16) #6, !dbg !51, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.sub_list* %15, metadata !42, metadata !DIExpression()), !dbg !40, !verifier.code !35
  %17 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %15, i32 0, i32 1, !dbg !43, !verifier.code !35
  %18 = icmp ne %struct.list_head* %17, %0, !dbg !44, !verifier.code !35
  br i1 %18, label %forwarder, label %._crit_edge, !dbg !45, !llvm.loop !52, !verifier.code !35

._crit_edge:                                      ; preds = %9
  br label %19, !dbg !45, !verifier.code !35

19:                                               ; preds = %._crit_edge, %1
  ret void, !dbg !54, !verifier.code !35

forwarder:                                        ; preds = %9
  br label %9, !verifier.code !35
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

; Function Attrs: noinline nounwind uwtable
define internal void @destroy_top(%struct.list_head* %0) #0 !dbg !55 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !56, metadata !DIExpression()), !dbg !57, !verifier.code !35
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !58, !verifier.code !35
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !58, !verifier.code !35
  %4 = bitcast %struct.list_head* %3 to i8*, !dbg !58, !verifier.code !35
  %5 = getelementptr inbounds i8, i8* %4, i64 0, !dbg !58, !verifier.code !35
  %6 = bitcast i8* %5 to %struct.top_list*, !dbg !58, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %6, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !35
  %7 = getelementptr inbounds %struct.top_list, %struct.top_list* %6, i32 0, i32 0, !dbg !60, !verifier.code !35
  %8 = icmp ne %struct.list_head* %7, %0, !dbg !61, !verifier.code !35
  br i1 %8, label %.lr.ph, label %20, !dbg !62, !verifier.code !35

.lr.ph:                                           ; preds = %1
  br label %9, !dbg !62, !verifier.code !35

9:                                                ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.top_list* [ %6, %.lr.ph ], [ %15, %forwarder ], !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %.01, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !35
  %10 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 0, !dbg !63, !verifier.code !35
  %11 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 0, i32 0
  %12 = load %struct.list_head*, %struct.list_head** %11, align 8, !dbg !63, !verifier.code !35
  %13 = bitcast %struct.list_head* %12 to i8*, !dbg !63, !verifier.code !35
  %14 = getelementptr inbounds i8, i8* %13, i64 0, !dbg !63, !verifier.code !35
  %15 = bitcast i8* %14 to %struct.top_list*, !dbg !63, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %15, metadata !65, metadata !DIExpression()), !dbg !66, !verifier.code !35
  %16 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 1, !dbg !67, !verifier.code !35
  call void @destroy_sub(%struct.list_head* %16), !dbg !68, !verifier.code !35
  %17 = bitcast %struct.top_list* %.01 to i8*, !dbg !69, !verifier.code !35
  call void @free(i8* %17) #6, !dbg !70, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %15, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !35
  %18 = getelementptr inbounds %struct.top_list, %struct.top_list* %15, i32 0, i32 0, !dbg !60, !verifier.code !35
  %19 = icmp ne %struct.list_head* %18, %0, !dbg !61, !verifier.code !35
  br i1 %19, label %forwarder, label %._crit_edge, !dbg !62, !llvm.loop !71, !verifier.code !35

._crit_edge:                                      ; preds = %9
  br label %20, !dbg !62, !verifier.code !35

20:                                               ; preds = %._crit_edge, %1
  ret void, !dbg !73, !verifier.code !35

forwarder:                                        ; preds = %9
  br label %9, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @insert_sub(%struct.list_head* %0) #0 !dbg !74 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !75, metadata !DIExpression()), !dbg !76, !verifier.code !35
  %2 = call noalias i8* @malloc(i64 24) #6, !dbg !77, !verifier.code !35
  %3 = bitcast i8* %2 to %struct.sub_list*, !dbg !77, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.sub_list* %3, metadata !78, metadata !DIExpression()), !dbg !76, !verifier.code !35
  %4 = icmp ne %struct.sub_list* %3, null, !dbg !79, !verifier.code !35
  br i1 %4, label %6, label %5, !dbg !81, !verifier.code !35

5:                                                ; preds = %1
  call void @abort() #5, !dbg !82, !verifier.code !35
  unreachable, !dbg !82, !verifier.code !35

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %3, i32 0, i32 0, !dbg !83, !verifier.code !35
  store i32 0, i32* %7, align 8, !dbg !84, !verifier.code !35
  %8 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %3, i32 0, i32 1, !dbg !85, !verifier.code !35
  call void @list_add_tail(%struct.list_head* %8, %struct.list_head* %0), !dbg !86, !verifier.code !35
  ret void, !dbg !87, !verifier.code !35
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define internal void @list_add_tail(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !88 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !91, metadata !DIExpression()), !dbg !92, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !93, metadata !DIExpression()), !dbg !92, !verifier.code !35
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !94, !verifier.code !35
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !94, !verifier.code !35
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %4, %struct.list_head* %1), !dbg !95, !verifier.code !35
  ret void, !dbg !96, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !97 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !100, metadata !DIExpression()), !dbg !101, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !102, metadata !DIExpression()), !dbg !101, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !103, metadata !DIExpression()), !dbg !101, !verifier.code !35
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !104, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !105, !verifier.code !35
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !106, !verifier.code !35
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !107, !verifier.code !35
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !108, !verifier.code !35
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !109, !verifier.code !35
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !110, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !111, !verifier.code !35
  ret void, !dbg !112, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @create_sub_list(%struct.list_head* %0) #0 !dbg !113 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !114, metadata !DIExpression()), !dbg !115, !verifier.code !35
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !116, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %2, align 8, !dbg !117, !verifier.code !35
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !118, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !119, !verifier.code !35
  br label %4, !dbg !120, !verifier.code !35

4:                                                ; preds = %5, %1
  call void @insert_sub(%struct.list_head* %0), !dbg !121, !verifier.code !35
  br label %5, !dbg !121, !verifier.code !35

5:                                                ; preds = %4
  %6 = call i32 @__VERIFIER_nondet_int(), !dbg !122, !verifier.code !123
  %7 = icmp ne i32 %6, 0, !dbg !121, !verifier.code !35
  br i1 %7, label %4, label %8, !dbg !121, !llvm.loop !124, !verifier.code !35

8:                                                ; preds = %5
  ret void, !dbg !126, !verifier.code !35
}

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @insert_top(%struct.list_head* %0) #0 !dbg !127 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !128, metadata !DIExpression()), !dbg !129, !verifier.code !35
  %2 = call noalias i8* @malloc(i64 48) #6, !dbg !130, !verifier.code !35
  %3 = bitcast i8* %2 to %struct.top_list*, !dbg !130, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %3, metadata !131, metadata !DIExpression()), !dbg !129, !verifier.code !35
  %4 = icmp ne %struct.top_list* %3, null, !dbg !132, !verifier.code !35
  br i1 %4, label %6, label %5, !dbg !134, !verifier.code !35

5:                                                ; preds = %1
  call void @abort() #5, !dbg !135, !verifier.code !35
  unreachable, !dbg !135, !verifier.code !35

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 1, !dbg !136, !verifier.code !35
  call void @create_sub_list(%struct.list_head* %7), !dbg !137, !verifier.code !35
  %8 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 2, !dbg !138, !verifier.code !35
  call void @create_sub_list(%struct.list_head* %8), !dbg !139, !verifier.code !35
  %9 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 0, !dbg !140, !verifier.code !35
  call void @list_add_tail(%struct.list_head* %9, %struct.list_head* %0), !dbg !141, !verifier.code !35
  ret void, !dbg !142, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @create_top(%struct.list_head* %0) #0 !dbg !143 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !35
  br label %2, !dbg !146, !verifier.code !35

2:                                                ; preds = %3, %1
  call void @insert_top(%struct.list_head* %0), !dbg !147, !verifier.code !35
  br label %3, !dbg !147, !verifier.code !35

3:                                                ; preds = %2
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !148, !verifier.code !123
  %5 = icmp ne i32 %4, 0, !dbg !147, !verifier.code !35
  br i1 %5, label %2, label %6, !dbg !147, !llvm.loop !149, !verifier.code !35

6:                                                ; preds = %3
  ret void, !dbg !151, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !152 {
  %1 = alloca %struct.list_head, align 8, !verifier.code !35
  call void @llvm.dbg.declare(metadata %struct.list_head* %1, metadata !155, metadata !DIExpression()), !dbg !156, !verifier.code !35
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !156, !verifier.code !35
  store %struct.list_head* %1, %struct.list_head** %2, align 8, !dbg !156, !verifier.code !35
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !156, !verifier.code !35
  store %struct.list_head* %1, %struct.list_head** %3, align 8, !dbg !156, !verifier.code !35
  call void @create_top(%struct.list_head* %1), !dbg !157, !verifier.code !35
  call void @destroy_top(%struct.list_head* %1), !dbg !158, !verifier.code !35
  ret i32 0, !dbg !159, !verifier.code !35
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
!llvm.ident = !{!25}
!llvm.module.flags = !{!26, !27, !28}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/memsafety/test-0102-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !16, !18, !19}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sub_list", file: !6, line: 47, size: 192, elements: !7)
!6 = !DIFile(filename: "../svcomp/memsafety//test-0102-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!7 = !{!8, !10}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "number", scope: !5, file: !6, line: 48, baseType: !9, size: 32)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "link", scope: !5, file: !6, line: 49, baseType: !11, size: 128, offset: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list_head", file: !6, line: 14, size: 128, elements: !12)
!12 = !{!13, !15}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !11, file: !6, line: 15, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !11, file: !6, line: 15, baseType: !14, size: 64, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!18 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "top_list", file: !6, line: 41, size: 384, elements: !21)
!21 = !{!22, !23, !24}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "link", scope: !20, file: !6, line: 42, baseType: !11, size: 128)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "sub1", scope: !20, file: !6, line: 43, baseType: !11, size: 128, offset: 128)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "sub2", scope: !20, file: !6, line: 44, baseType: !11, size: 128, offset: 256)
!25 = !{!"clang version 10.0.0-4ubuntu1 "}
!26 = !{i32 7, !"Dwarf Version", i32 4}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = distinct !DISubprogram(name: "reach_error", scope: !6, file: !6, line: 3, type: !30, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{null}
!32 = !DILocation(line: 3, column: 22, scope: !33)
!33 = distinct !DILexicalBlock(scope: !34, file: !6, line: 3, column: 22)
!34 = distinct !DILexicalBlock(scope: !29, file: !6, line: 3, column: 22)
!35 = !{i1 false}
!36 = distinct !DISubprogram(name: "destroy_sub", scope: !6, file: !6, line: 52, type: !37, scopeLine: 53, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{null, !14}
!39 = !DILocalVariable(name: "head", arg: 1, scope: !36, file: !6, line: 52, type: !14)
!40 = !DILocation(line: 0, scope: !36)
!41 = !DILocation(line: 54, column: 28, scope: !36)
!42 = !DILocalVariable(name: "now", scope: !36, file: !6, line: 54, type: !4)
!43 = !DILocation(line: 56, column: 18, scope: !36)
!44 = !DILocation(line: 56, column: 23, scope: !36)
!45 = !DILocation(line: 56, column: 5, scope: !36)
!46 = !DILocation(line: 57, column: 33, scope: !47)
!47 = distinct !DILexicalBlock(scope: !36, file: !6, line: 56, column: 34)
!48 = !DILocalVariable(name: "next", scope: !47, file: !6, line: 57, type: !4)
!49 = !DILocation(line: 0, scope: !47)
!50 = !DILocation(line: 59, column: 14, scope: !47)
!51 = !DILocation(line: 59, column: 9, scope: !47)
!52 = distinct !{!52, !45, !53}
!53 = !DILocation(line: 61, column: 5, scope: !36)
!54 = !DILocation(line: 62, column: 1, scope: !36)
!55 = distinct !DISubprogram(name: "destroy_top", scope: !6, file: !6, line: 64, type: !37, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!56 = !DILocalVariable(name: "head", arg: 1, scope: !55, file: !6, line: 64, type: !14)
!57 = !DILocation(line: 0, scope: !55)
!58 = !DILocation(line: 66, column: 28, scope: !55)
!59 = !DILocalVariable(name: "now", scope: !55, file: !6, line: 66, type: !19)
!60 = !DILocation(line: 68, column: 18, scope: !55)
!61 = !DILocation(line: 68, column: 23, scope: !55)
!62 = !DILocation(line: 68, column: 5, scope: !55)
!63 = !DILocation(line: 69, column: 33, scope: !64)
!64 = distinct !DILexicalBlock(scope: !55, file: !6, line: 68, column: 34)
!65 = !DILocalVariable(name: "next", scope: !64, file: !6, line: 69, type: !19)
!66 = !DILocation(line: 0, scope: !64)
!67 = !DILocation(line: 71, column: 27, scope: !64)
!68 = !DILocation(line: 71, column: 9, scope: !64)
!69 = !DILocation(line: 77, column: 14, scope: !64)
!70 = !DILocation(line: 77, column: 9, scope: !64)
!71 = distinct !{!71, !62, !72}
!72 = !DILocation(line: 79, column: 5, scope: !55)
!73 = !DILocation(line: 80, column: 1, scope: !55)
!74 = distinct !DISubprogram(name: "insert_sub", scope: !6, file: !6, line: 82, type: !37, scopeLine: 83, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!75 = !DILocalVariable(name: "head", arg: 1, scope: !74, file: !6, line: 82, type: !14)
!76 = !DILocation(line: 0, scope: !74)
!77 = !DILocation(line: 84, column: 28, scope: !74)
!78 = !DILocalVariable(name: "sub", scope: !74, file: !6, line: 84, type: !4)
!79 = !DILocation(line: 85, column: 10, scope: !80)
!80 = distinct !DILexicalBlock(scope: !74, file: !6, line: 85, column: 9)
!81 = !DILocation(line: 85, column: 9, scope: !74)
!82 = !DILocation(line: 86, column: 9, scope: !80)
!83 = !DILocation(line: 88, column: 10, scope: !74)
!84 = !DILocation(line: 88, column: 17, scope: !74)
!85 = !DILocation(line: 90, column: 25, scope: !74)
!86 = !DILocation(line: 90, column: 5, scope: !74)
!87 = !DILocation(line: 91, column: 1, scope: !74)
!88 = distinct !DISubprogram(name: "list_add_tail", scope: !6, file: !6, line: 36, type: !89, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!89 = !DISubroutineType(types: !90)
!90 = !{null, !14, !14}
!91 = !DILocalVariable(name: "new", arg: 1, scope: !88, file: !6, line: 36, type: !14)
!92 = !DILocation(line: 0, scope: !88)
!93 = !DILocalVariable(name: "head", arg: 2, scope: !88, file: !6, line: 36, type: !14)
!94 = !DILocation(line: 38, column: 27, scope: !88)
!95 = !DILocation(line: 38, column: 5, scope: !88)
!96 = !DILocation(line: 39, column: 1, scope: !88)
!97 = distinct !DISubprogram(name: "__list_add", scope: !6, file: !6, line: 26, type: !98, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!98 = !DISubroutineType(types: !99)
!99 = !{null, !14, !14, !14}
!100 = !DILocalVariable(name: "new", arg: 1, scope: !97, file: !6, line: 26, type: !14)
!101 = !DILocation(line: 0, scope: !97)
!102 = !DILocalVariable(name: "prev", arg: 2, scope: !97, file: !6, line: 27, type: !14)
!103 = !DILocalVariable(name: "next", arg: 3, scope: !97, file: !6, line: 28, type: !14)
!104 = !DILocation(line: 30, column: 11, scope: !97)
!105 = !DILocation(line: 30, column: 16, scope: !97)
!106 = !DILocation(line: 31, column: 10, scope: !97)
!107 = !DILocation(line: 31, column: 15, scope: !97)
!108 = !DILocation(line: 32, column: 10, scope: !97)
!109 = !DILocation(line: 32, column: 15, scope: !97)
!110 = !DILocation(line: 33, column: 11, scope: !97)
!111 = !DILocation(line: 33, column: 16, scope: !97)
!112 = !DILocation(line: 34, column: 1, scope: !97)
!113 = distinct !DISubprogram(name: "create_sub_list", scope: !6, file: !6, line: 93, type: !37, scopeLine: 94, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!114 = !DILocalVariable(name: "sub", arg: 1, scope: !113, file: !6, line: 93, type: !14)
!115 = !DILocation(line: 0, scope: !113)
!116 = !DILocation(line: 95, column: 10, scope: !113)
!117 = !DILocation(line: 95, column: 15, scope: !113)
!118 = !DILocation(line: 96, column: 10, scope: !113)
!119 = !DILocation(line: 96, column: 15, scope: !113)
!120 = !DILocation(line: 98, column: 5, scope: !113)
!121 = !DILocation(line: 99, column: 9, scope: !113)
!122 = !DILocation(line: 100, column: 12, scope: !113)
!123 = !{i1 true}
!124 = distinct !{!124, !120, !125}
!125 = !DILocation(line: 100, column: 35, scope: !113)
!126 = !DILocation(line: 101, column: 1, scope: !113)
!127 = distinct !DISubprogram(name: "insert_top", scope: !6, file: !6, line: 103, type: !37, scopeLine: 104, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!128 = !DILocalVariable(name: "head", arg: 1, scope: !127, file: !6, line: 103, type: !14)
!129 = !DILocation(line: 0, scope: !127)
!130 = !DILocation(line: 105, column: 28, scope: !127)
!131 = !DILocalVariable(name: "top", scope: !127, file: !6, line: 105, type: !19)
!132 = !DILocation(line: 106, column: 10, scope: !133)
!133 = distinct !DILexicalBlock(scope: !127, file: !6, line: 106, column: 9)
!134 = !DILocation(line: 106, column: 9, scope: !127)
!135 = !DILocation(line: 107, column: 9, scope: !133)
!136 = !DILocation(line: 109, column: 27, scope: !127)
!137 = !DILocation(line: 109, column: 5, scope: !127)
!138 = !DILocation(line: 110, column: 27, scope: !127)
!139 = !DILocation(line: 110, column: 5, scope: !127)
!140 = !DILocation(line: 112, column: 25, scope: !127)
!141 = !DILocation(line: 112, column: 5, scope: !127)
!142 = !DILocation(line: 113, column: 1, scope: !127)
!143 = distinct !DISubprogram(name: "create_top", scope: !6, file: !6, line: 115, type: !37, scopeLine: 116, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!144 = !DILocalVariable(name: "top", arg: 1, scope: !143, file: !6, line: 115, type: !14)
!145 = !DILocation(line: 0, scope: !143)
!146 = !DILocation(line: 117, column: 5, scope: !143)
!147 = !DILocation(line: 118, column: 9, scope: !143)
!148 = !DILocation(line: 119, column: 12, scope: !143)
!149 = distinct !{!149, !146, !150}
!150 = !DILocation(line: 119, column: 35, scope: !143)
!151 = !DILocation(line: 120, column: 1, scope: !143)
!152 = distinct !DISubprogram(name: "main", scope: !6, file: !6, line: 122, type: !153, scopeLine: 123, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!153 = !DISubroutineType(types: !154)
!154 = !{!9}
!155 = !DILocalVariable(name: "top", scope: !152, file: !6, line: 124, type: !11)
!156 = !DILocation(line: 124, column: 5, scope: !152)
!157 = !DILocation(line: 126, column: 5, scope: !152)
!158 = !DILocation(line: 128, column: 5, scope: !152)
!159 = !DILocation(line: 130, column: 5, scope: !152)
