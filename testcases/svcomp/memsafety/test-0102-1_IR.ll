; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-w2q1w_ve.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.sub_list = type { i32, %struct.list_head }
%struct.top_list = type { %struct.list_head, %struct.list_head, %struct.list_head }

@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"../svcomp/memsafety//test-0102-1.c\00", align 1
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
  br i1 %8, label %.lr.ph, label %21, !dbg !62, !verifier.code !35

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
  %17 = getelementptr inbounds %struct.top_list, %struct.top_list* %.01, i32 0, i32 2, !dbg !69, !verifier.code !35
  call void @destroy_sub(%struct.list_head* %17), !dbg !70, !verifier.code !35
  %18 = bitcast %struct.top_list* %.01 to i8*, !dbg !71, !verifier.code !35
  call void @free(i8* %18) #6, !dbg !72, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %15, metadata !59, metadata !DIExpression()), !dbg !57, !verifier.code !35
  %19 = getelementptr inbounds %struct.top_list, %struct.top_list* %15, i32 0, i32 0, !dbg !60, !verifier.code !35
  %20 = icmp ne %struct.list_head* %19, %0, !dbg !61, !verifier.code !35
  br i1 %20, label %forwarder, label %._crit_edge, !dbg !62, !llvm.loop !73, !verifier.code !35

._crit_edge:                                      ; preds = %9
  br label %21, !dbg !62, !verifier.code !35

21:                                               ; preds = %._crit_edge, %1
  ret void, !dbg !75, !verifier.code !35

forwarder:                                        ; preds = %9
  br label %9, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @insert_sub(%struct.list_head* %0) #0 !dbg !76 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !77, metadata !DIExpression()), !dbg !78, !verifier.code !35
  %2 = call noalias i8* @malloc(i64 24) #6, !dbg !79, !verifier.code !35
  %3 = bitcast i8* %2 to %struct.sub_list*, !dbg !79, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.sub_list* %3, metadata !80, metadata !DIExpression()), !dbg !78, !verifier.code !35
  %4 = icmp ne %struct.sub_list* %3, null, !dbg !81, !verifier.code !35
  br i1 %4, label %6, label %5, !dbg !83, !verifier.code !35

5:                                                ; preds = %1
  call void @abort() #5, !dbg !84, !verifier.code !35
  unreachable, !dbg !84, !verifier.code !35

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %3, i32 0, i32 0, !dbg !85, !verifier.code !35
  store i32 0, i32* %7, align 8, !dbg !86, !verifier.code !35
  %8 = getelementptr inbounds %struct.sub_list, %struct.sub_list* %3, i32 0, i32 1, !dbg !87, !verifier.code !35
  call void @list_add_tail(%struct.list_head* %8, %struct.list_head* %0), !dbg !88, !verifier.code !35
  ret void, !dbg !89, !verifier.code !35
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #1

; Function Attrs: noinline nounwind uwtable
define internal void @list_add_tail(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !90 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !93, metadata !DIExpression()), !dbg !94, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !95, metadata !DIExpression()), !dbg !94, !verifier.code !35
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !96, !verifier.code !35
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !96, !verifier.code !35
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %4, %struct.list_head* %1), !dbg !97, !verifier.code !35
  ret void, !dbg !98, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !99 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !102, metadata !DIExpression()), !dbg !103, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !104, metadata !DIExpression()), !dbg !103, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !105, metadata !DIExpression()), !dbg !103, !verifier.code !35
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !106, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !107, !verifier.code !35
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !108, !verifier.code !35
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !109, !verifier.code !35
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !110, !verifier.code !35
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !111, !verifier.code !35
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !112, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !113, !verifier.code !35
  ret void, !dbg !114, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @create_sub_list(%struct.list_head* %0) #0 !dbg !115 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !116, metadata !DIExpression()), !dbg !117, !verifier.code !35
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !118, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %2, align 8, !dbg !119, !verifier.code !35
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !120, !verifier.code !35
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !121, !verifier.code !35
  br label %4, !dbg !122, !verifier.code !35

4:                                                ; preds = %5, %1
  call void @insert_sub(%struct.list_head* %0), !dbg !123, !verifier.code !35
  br label %5, !dbg !123, !verifier.code !35

5:                                                ; preds = %4
  %6 = call i32 @__VERIFIER_nondet_int(), !dbg !124, !verifier.code !125
  %7 = icmp ne i32 %6, 0, !dbg !123, !verifier.code !35
  br i1 %7, label %4, label %8, !dbg !123, !llvm.loop !126, !verifier.code !35

8:                                                ; preds = %5
  ret void, !dbg !128, !verifier.code !35
}

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @insert_top(%struct.list_head* %0) #0 !dbg !129 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !130, metadata !DIExpression()), !dbg !131, !verifier.code !35
  %2 = call noalias i8* @malloc(i64 48) #6, !dbg !132, !verifier.code !35
  %3 = bitcast i8* %2 to %struct.top_list*, !dbg !132, !verifier.code !35
  call void @llvm.dbg.value(metadata %struct.top_list* %3, metadata !133, metadata !DIExpression()), !dbg !131, !verifier.code !35
  %4 = icmp ne %struct.top_list* %3, null, !dbg !134, !verifier.code !35
  br i1 %4, label %6, label %5, !dbg !136, !verifier.code !35

5:                                                ; preds = %1
  call void @abort() #5, !dbg !137, !verifier.code !35
  unreachable, !dbg !137, !verifier.code !35

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 1, !dbg !138, !verifier.code !35
  call void @create_sub_list(%struct.list_head* %7), !dbg !139, !verifier.code !35
  %8 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 2, !dbg !140, !verifier.code !35
  call void @create_sub_list(%struct.list_head* %8), !dbg !141, !verifier.code !35
  %9 = getelementptr inbounds %struct.top_list, %struct.top_list* %3, i32 0, i32 0, !dbg !142, !verifier.code !35
  call void @list_add_tail(%struct.list_head* %9, %struct.list_head* %0), !dbg !143, !verifier.code !35
  ret void, !dbg !144, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define internal void @create_top(%struct.list_head* %0) #0 !dbg !145 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !146, metadata !DIExpression()), !dbg !147, !verifier.code !35
  br label %2, !dbg !148, !verifier.code !35

2:                                                ; preds = %3, %1
  call void @insert_top(%struct.list_head* %0), !dbg !149, !verifier.code !35
  br label %3, !dbg !149, !verifier.code !35

3:                                                ; preds = %2
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !150, !verifier.code !125
  %5 = icmp ne i32 %4, 0, !dbg !149, !verifier.code !35
  br i1 %5, label %2, label %6, !dbg !149, !llvm.loop !151, !verifier.code !35

6:                                                ; preds = %3
  ret void, !dbg !153, !verifier.code !35
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !154 {
  %1 = alloca %struct.list_head, align 8, !verifier.code !35
  call void @llvm.dbg.declare(metadata %struct.list_head* %1, metadata !157, metadata !DIExpression()), !dbg !158, !verifier.code !35
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !158, !verifier.code !35
  store %struct.list_head* %1, %struct.list_head** %2, align 8, !dbg !158, !verifier.code !35
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !158, !verifier.code !35
  store %struct.list_head* %1, %struct.list_head** %3, align 8, !dbg !158, !verifier.code !35
  call void @create_top(%struct.list_head* %1), !dbg !159, !verifier.code !35
  call void @destroy_top(%struct.list_head* %1), !dbg !160, !verifier.code !35
  ret i32 0, !dbg !161, !verifier.code !35
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
!1 = !DIFile(filename: "../svcomp/memsafety/test-0102-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4, !16, !18, !19}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sub_list", file: !6, line: 47, size: 192, elements: !7)
!6 = !DIFile(filename: "../svcomp/memsafety//test-0102-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
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
!69 = !DILocation(line: 72, column: 27, scope: !64)
!70 = !DILocation(line: 72, column: 9, scope: !64)
!71 = !DILocation(line: 74, column: 14, scope: !64)
!72 = !DILocation(line: 74, column: 9, scope: !64)
!73 = distinct !{!73, !62, !74}
!74 = !DILocation(line: 76, column: 5, scope: !55)
!75 = !DILocation(line: 77, column: 1, scope: !55)
!76 = distinct !DISubprogram(name: "insert_sub", scope: !6, file: !6, line: 79, type: !37, scopeLine: 80, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!77 = !DILocalVariable(name: "head", arg: 1, scope: !76, file: !6, line: 79, type: !14)
!78 = !DILocation(line: 0, scope: !76)
!79 = !DILocation(line: 81, column: 28, scope: !76)
!80 = !DILocalVariable(name: "sub", scope: !76, file: !6, line: 81, type: !4)
!81 = !DILocation(line: 82, column: 10, scope: !82)
!82 = distinct !DILexicalBlock(scope: !76, file: !6, line: 82, column: 9)
!83 = !DILocation(line: 82, column: 9, scope: !76)
!84 = !DILocation(line: 83, column: 9, scope: !82)
!85 = !DILocation(line: 85, column: 10, scope: !76)
!86 = !DILocation(line: 85, column: 17, scope: !76)
!87 = !DILocation(line: 87, column: 25, scope: !76)
!88 = !DILocation(line: 87, column: 5, scope: !76)
!89 = !DILocation(line: 88, column: 1, scope: !76)
!90 = distinct !DISubprogram(name: "list_add_tail", scope: !6, file: !6, line: 36, type: !91, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!91 = !DISubroutineType(types: !92)
!92 = !{null, !14, !14}
!93 = !DILocalVariable(name: "new", arg: 1, scope: !90, file: !6, line: 36, type: !14)
!94 = !DILocation(line: 0, scope: !90)
!95 = !DILocalVariable(name: "head", arg: 2, scope: !90, file: !6, line: 36, type: !14)
!96 = !DILocation(line: 38, column: 27, scope: !90)
!97 = !DILocation(line: 38, column: 5, scope: !90)
!98 = !DILocation(line: 39, column: 1, scope: !90)
!99 = distinct !DISubprogram(name: "__list_add", scope: !6, file: !6, line: 26, type: !100, scopeLine: 29, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !0, retainedNodes: !2)
!100 = !DISubroutineType(types: !101)
!101 = !{null, !14, !14, !14}
!102 = !DILocalVariable(name: "new", arg: 1, scope: !99, file: !6, line: 26, type: !14)
!103 = !DILocation(line: 0, scope: !99)
!104 = !DILocalVariable(name: "prev", arg: 2, scope: !99, file: !6, line: 27, type: !14)
!105 = !DILocalVariable(name: "next", arg: 3, scope: !99, file: !6, line: 28, type: !14)
!106 = !DILocation(line: 30, column: 11, scope: !99)
!107 = !DILocation(line: 30, column: 16, scope: !99)
!108 = !DILocation(line: 31, column: 10, scope: !99)
!109 = !DILocation(line: 31, column: 15, scope: !99)
!110 = !DILocation(line: 32, column: 10, scope: !99)
!111 = !DILocation(line: 32, column: 15, scope: !99)
!112 = !DILocation(line: 33, column: 11, scope: !99)
!113 = !DILocation(line: 33, column: 16, scope: !99)
!114 = !DILocation(line: 34, column: 1, scope: !99)
!115 = distinct !DISubprogram(name: "create_sub_list", scope: !6, file: !6, line: 90, type: !37, scopeLine: 91, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!116 = !DILocalVariable(name: "sub", arg: 1, scope: !115, file: !6, line: 90, type: !14)
!117 = !DILocation(line: 0, scope: !115)
!118 = !DILocation(line: 92, column: 10, scope: !115)
!119 = !DILocation(line: 92, column: 15, scope: !115)
!120 = !DILocation(line: 93, column: 10, scope: !115)
!121 = !DILocation(line: 93, column: 15, scope: !115)
!122 = !DILocation(line: 95, column: 5, scope: !115)
!123 = !DILocation(line: 96, column: 9, scope: !115)
!124 = !DILocation(line: 97, column: 12, scope: !115)
!125 = !{i1 true}
!126 = distinct !{!126, !122, !127}
!127 = !DILocation(line: 97, column: 35, scope: !115)
!128 = !DILocation(line: 98, column: 1, scope: !115)
!129 = distinct !DISubprogram(name: "insert_top", scope: !6, file: !6, line: 100, type: !37, scopeLine: 101, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!130 = !DILocalVariable(name: "head", arg: 1, scope: !129, file: !6, line: 100, type: !14)
!131 = !DILocation(line: 0, scope: !129)
!132 = !DILocation(line: 102, column: 28, scope: !129)
!133 = !DILocalVariable(name: "top", scope: !129, file: !6, line: 102, type: !19)
!134 = !DILocation(line: 103, column: 10, scope: !135)
!135 = distinct !DILexicalBlock(scope: !129, file: !6, line: 103, column: 9)
!136 = !DILocation(line: 103, column: 9, scope: !129)
!137 = !DILocation(line: 104, column: 9, scope: !135)
!138 = !DILocation(line: 106, column: 27, scope: !129)
!139 = !DILocation(line: 106, column: 5, scope: !129)
!140 = !DILocation(line: 107, column: 27, scope: !129)
!141 = !DILocation(line: 107, column: 5, scope: !129)
!142 = !DILocation(line: 109, column: 25, scope: !129)
!143 = !DILocation(line: 109, column: 5, scope: !129)
!144 = !DILocation(line: 110, column: 1, scope: !129)
!145 = distinct !DISubprogram(name: "create_top", scope: !6, file: !6, line: 112, type: !37, scopeLine: 113, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!146 = !DILocalVariable(name: "top", arg: 1, scope: !145, file: !6, line: 112, type: !14)
!147 = !DILocation(line: 0, scope: !145)
!148 = !DILocation(line: 114, column: 5, scope: !145)
!149 = !DILocation(line: 115, column: 9, scope: !145)
!150 = !DILocation(line: 116, column: 12, scope: !145)
!151 = distinct !{!151, !148, !152}
!152 = !DILocation(line: 116, column: 35, scope: !145)
!153 = !DILocation(line: 117, column: 1, scope: !145)
!154 = distinct !DISubprogram(name: "main", scope: !6, file: !6, line: 119, type: !155, scopeLine: 120, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!155 = !DISubroutineType(types: !156)
!156 = !{!9}
!157 = !DILocalVariable(name: "top", scope: !154, file: !6, line: 121, type: !11)
!158 = !DILocation(line: 121, column: 5, scope: !154)
!159 = !DILocation(line: 123, column: 5, scope: !154)
!160 = !DILocation(line: 125, column: 5, scope: !154)
!161 = !DILocation(line: 127, column: 5, scope: !154)
