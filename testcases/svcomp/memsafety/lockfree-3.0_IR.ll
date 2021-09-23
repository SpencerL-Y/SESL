; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/b-6_ayrmul.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.cell = type { i32, %struct.cell* }

@pc1 = internal global i32 1, align 4, !dbg !0
@pc4 = internal global i32 1, align 4, !dbg !8
@S = internal global %struct.cell* null, align 8, !dbg !30
@garbage = internal global %struct.cell* null, align 8, !dbg !32
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [32 x i8] c"svcomp/memsafety/lockfree-3.0.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@push.x1 = internal global %struct.cell* null, align 8, !dbg !21
@push.t1 = internal global %struct.cell* null, align 8, !dbg !11
@pop.t4 = internal global %struct.cell* null, align 8, !dbg !23
@pop.x4 = internal global %struct.cell* null, align 8, !dbg !26
@pop.res4 = internal global i32 0, align 4, !dbg !28

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !38 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !39, !verifier.code !42
  unreachable, !dbg !39, !verifier.code !42
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @push() #0 !dbg !13 {
  %1 = load i32, i32* @pc1, align 4, !dbg !43, !verifier.code !42
  %2 = add nsw i32 %1, 1, !dbg !43, !verifier.code !42
  store i32 %2, i32* @pc1, align 4, !dbg !43, !verifier.code !42
  br label %NodeBlock9, !verifier.code !42

NodeBlock9:                                       ; preds = %0
  %Pivot10 = icmp slt i32 %1, 4, !verifier.code !42
  br i1 %Pivot10, label %NodeBlock1, label %NodeBlock7, !verifier.code !42

NodeBlock7:                                       ; preds = %NodeBlock9
  %Pivot8 = icmp slt i32 %1, 5, !verifier.code !42
  br i1 %Pivot8, label %15, label %NodeBlock5, !verifier.code !42

NodeBlock5:                                       ; preds = %NodeBlock7
  %Pivot6 = icmp slt i32 %1, 6, !verifier.code !42
  br i1 %Pivot6, label %19, label %LeafBlock3, !verifier.code !42

LeafBlock3:                                       ; preds = %NodeBlock5
  %SwitchLeaf4 = icmp eq i32 %1, 6, !verifier.code !42
  br i1 %SwitchLeaf4, label %27, label %NewDefault, !verifier.code !42

NodeBlock1:                                       ; preds = %NodeBlock9
  %Pivot2 = icmp slt i32 %1, 2, !verifier.code !42
  br i1 %Pivot2, label %LeafBlock, label %NodeBlock, !verifier.code !42

NodeBlock:                                        ; preds = %NodeBlock1
  %Pivot = icmp slt i32 %1, 3, !verifier.code !42
  br i1 %Pivot, label %10, label %13, !verifier.code !42

LeafBlock:                                        ; preds = %NodeBlock1
  %SwitchLeaf = icmp eq i32 %1, 1, !verifier.code !42
  br i1 %SwitchLeaf, label %3, label %NewDefault, !verifier.code !42

3:                                                ; preds = %LeafBlock
  %4 = call noalias i8* @malloc(i64 16) #6, !dbg !44, !verifier.code !42
  %5 = bitcast i8* %4 to %struct.cell*, !dbg !44, !verifier.code !42
  store %struct.cell* %5, %struct.cell** @push.x1, align 8, !dbg !46, !verifier.code !42
  %6 = load %struct.cell*, %struct.cell** @push.x1, align 8, !dbg !47, !verifier.code !42
  %7 = getelementptr inbounds %struct.cell, %struct.cell* %6, i32 0, i32 0, !dbg !48, !verifier.code !42
  store i32 0, i32* %7, align 8, !dbg !49, !verifier.code !42
  %8 = load %struct.cell*, %struct.cell** @push.x1, align 8, !dbg !50, !verifier.code !42
  %9 = getelementptr inbounds %struct.cell, %struct.cell* %8, i32 0, i32 1, !dbg !51, !verifier.code !42
  store %struct.cell* null, %struct.cell** %9, align 8, !dbg !52, !verifier.code !42
  br label %28, !dbg !53, !verifier.code !42

10:                                               ; preds = %NodeBlock
  %11 = load %struct.cell*, %struct.cell** @push.x1, align 8, !dbg !54, !verifier.code !42
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 0, !dbg !55, !verifier.code !42
  store i32 4, i32* %12, align 8, !dbg !56, !verifier.code !42
  br label %28, !dbg !57, !verifier.code !42

13:                                               ; preds = %NodeBlock
  %14 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !58, !verifier.code !42
  store %struct.cell* %14, %struct.cell** @push.t1, align 8, !dbg !59, !verifier.code !42
  br label %28, !dbg !60, !verifier.code !42

15:                                               ; preds = %NodeBlock7
  %16 = load %struct.cell*, %struct.cell** @push.t1, align 8, !dbg !61, !verifier.code !42
  %17 = load %struct.cell*, %struct.cell** @push.x1, align 8, !dbg !62, !verifier.code !42
  %18 = getelementptr inbounds %struct.cell, %struct.cell* %17, i32 0, i32 1, !dbg !63, !verifier.code !42
  store %struct.cell* %16, %struct.cell** %18, align 8, !dbg !64, !verifier.code !42
  br label %28, !dbg !65, !verifier.code !42

19:                                               ; preds = %NodeBlock5
  %20 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !66, !verifier.code !42
  %21 = load %struct.cell*, %struct.cell** @push.t1, align 8, !dbg !68, !verifier.code !42
  %22 = icmp eq %struct.cell* %20, %21, !dbg !69, !verifier.code !42
  br i1 %22, label %23, label %25, !dbg !70, !verifier.code !42

23:                                               ; preds = %19
  %24 = load %struct.cell*, %struct.cell** @push.x1, align 8, !dbg !71, !verifier.code !42
  store %struct.cell* %24, %struct.cell** @S, align 8, !dbg !72, !verifier.code !42
  br label %26, !dbg !73, !verifier.code !42

25:                                               ; preds = %19
  store i32 3, i32* @pc1, align 4, !dbg !74, !verifier.code !42
  br label %26, !verifier.code !42

26:                                               ; preds = %25, %23
  br label %28, !dbg !75, !verifier.code !42

27:                                               ; preds = %LeafBlock3
  store i32 1, i32* @pc1, align 4, !dbg !76, !verifier.code !42
  br label %28, !dbg !77, !verifier.code !42

NewDefault:                                       ; preds = %LeafBlock3, %LeafBlock
  br label %28, !verifier.code !42

28:                                               ; preds = %NewDefault, %3, %10, %13, %15, %26, %27
  ret void, !dbg !78, !verifier.code !42
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal void @pop() #0 !dbg !25 {
  %1 = load i32, i32* @pc4, align 4, !dbg !79, !verifier.code !42
  %2 = add nsw i32 %1, 1, !dbg !79, !verifier.code !42
  store i32 %2, i32* @pc4, align 4, !dbg !79, !verifier.code !42
  br label %NodeBlock7, !verifier.code !42

NodeBlock7:                                       ; preds = %0
  %Pivot8 = icmp slt i32 %1, 3, !verifier.code !42
  br i1 %Pivot8, label %NodeBlock, label %NodeBlock5, !verifier.code !42

NodeBlock5:                                       ; preds = %NodeBlock7
  %Pivot6 = icmp slt i32 %1, 4, !verifier.code !42
  br i1 %Pivot6, label %10, label %NodeBlock3, !verifier.code !42

NodeBlock3:                                       ; preds = %NodeBlock5
  %Pivot4 = icmp slt i32 %1, 5, !verifier.code !42
  br i1 %Pivot4, label %14, label %LeafBlock1, !verifier.code !42

LeafBlock1:                                       ; preds = %NodeBlock3
  %SwitchLeaf2 = icmp eq i32 %1, 5, !verifier.code !42
  br i1 %SwitchLeaf2, label %22, label %NewDefault, !verifier.code !42

NodeBlock:                                        ; preds = %NodeBlock7
  %Pivot = icmp slt i32 %1, 2, !verifier.code !42
  br i1 %Pivot, label %LeafBlock, label %5, !verifier.code !42

LeafBlock:                                        ; preds = %NodeBlock
  %SwitchLeaf = icmp eq i32 %1, 1, !verifier.code !42
  br i1 %SwitchLeaf, label %3, label %NewDefault, !verifier.code !42

3:                                                ; preds = %LeafBlock
  %4 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !80, !verifier.code !42
  store %struct.cell* %4, %struct.cell** @pop.t4, align 8, !dbg !82, !verifier.code !42
  br label %30, !dbg !83, !verifier.code !42

5:                                                ; preds = %NodeBlock
  %6 = load %struct.cell*, %struct.cell** @pop.t4, align 8, !dbg !84, !verifier.code !42
  %7 = icmp eq %struct.cell* %6, null, !dbg !86, !verifier.code !42
  br i1 %7, label %8, label %9, !dbg !87, !verifier.code !42

8:                                                ; preds = %5
  store i32 1, i32* @pc4, align 4, !dbg !88, !verifier.code !42
  br label %9, !dbg !89, !verifier.code !42

9:                                                ; preds = %8, %5
  br label %30, !dbg !90, !verifier.code !42

10:                                               ; preds = %NodeBlock5
  %11 = load %struct.cell*, %struct.cell** @pop.t4, align 8, !dbg !91, !verifier.code !42
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 1, !dbg !92, !verifier.code !42
  %13 = load %struct.cell*, %struct.cell** %12, align 8, !dbg !92, !verifier.code !42
  store %struct.cell* %13, %struct.cell** @pop.x4, align 8, !dbg !93, !verifier.code !42
  br label %30, !dbg !94, !verifier.code !42

14:                                               ; preds = %NodeBlock3
  %15 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !95, !verifier.code !42
  %16 = load %struct.cell*, %struct.cell** @pop.t4, align 8, !dbg !97, !verifier.code !42
  %17 = icmp eq %struct.cell* %15, %16, !dbg !98, !verifier.code !42
  br i1 %17, label %18, label %20, !dbg !99, !verifier.code !42

18:                                               ; preds = %14
  %19 = load %struct.cell*, %struct.cell** @pop.x4, align 8, !dbg !100, !verifier.code !42
  store %struct.cell* %19, %struct.cell** @S, align 8, !dbg !101, !verifier.code !42
  br label %21, !dbg !102, !verifier.code !42

20:                                               ; preds = %14
  store i32 1, i32* @pc4, align 4, !dbg !103, !verifier.code !42
  br label %21, !verifier.code !42

21:                                               ; preds = %20, %18
  br label %30, !dbg !104, !verifier.code !42

22:                                               ; preds = %LeafBlock1
  %23 = load %struct.cell*, %struct.cell** @pop.t4, align 8, !dbg !105, !verifier.code !42
  %24 = getelementptr inbounds %struct.cell, %struct.cell* %23, i32 0, i32 0, !dbg !106, !verifier.code !42
  %25 = load i32, i32* %24, align 8, !dbg !106, !verifier.code !42
  store i32 %25, i32* @pop.res4, align 4, !dbg !107, !verifier.code !42
  %26 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !108, !verifier.code !42
  %27 = load %struct.cell*, %struct.cell** @pop.t4, align 8, !dbg !109, !verifier.code !42
  %28 = getelementptr inbounds %struct.cell, %struct.cell* %27, i32 0, i32 1, !dbg !110, !verifier.code !42
  store %struct.cell* %26, %struct.cell** %28, align 8, !dbg !111, !verifier.code !42
  %29 = load %struct.cell*, %struct.cell** @pop.t4, align 8, !dbg !112, !verifier.code !42
  store %struct.cell* %29, %struct.cell** @garbage, align 8, !dbg !113, !verifier.code !42
  store i32 1, i32* @pc4, align 4, !dbg !114, !verifier.code !42
  br label %30, !dbg !115, !verifier.code !42

NewDefault:                                       ; preds = %LeafBlock1, %LeafBlock
  br label %30, !verifier.code !42

30:                                               ; preds = %NewDefault, %3, %9, %10, %21, %22
  ret void, !dbg !116, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !117 {
  br label %1, !dbg !120, !verifier.code !42

1:                                                ; preds = %20, %0
  %2 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !121, !verifier.code !42
  %3 = icmp ne %struct.cell* %2, null, !dbg !121, !verifier.code !42
  br i1 %3, label %13, label %4, !dbg !122, !verifier.code !42

4:                                                ; preds = %1
  %5 = load i32, i32* @pc1, align 4, !dbg !123, !verifier.code !42
  %6 = icmp ne i32 1, %5, !dbg !124, !verifier.code !42
  br i1 %6, label %13, label %7, !dbg !125, !verifier.code !42

7:                                                ; preds = %4
  %8 = load i32, i32* @pc4, align 4, !dbg !126, !verifier.code !42
  %9 = icmp ne i32 1, %8, !dbg !127, !verifier.code !42
  br i1 %9, label %13, label %10, !dbg !128, !verifier.code !42

10:                                               ; preds = %7
  %11 = call i32 @__VERIFIER_nondet_int(), !dbg !129, !verifier.code !130
  %12 = icmp ne i32 %11, 0, !dbg !128, !verifier.code !42
  br label %13, !dbg !128, !verifier.code !42

13:                                               ; preds = %10, %7, %4, %1
  %14 = phi i1 [ true, %7 ], [ true, %4 ], [ true, %1 ], [ %12, %10 ], !verifier.code !42
  br i1 %14, label %15, label %21, !dbg !120, !verifier.code !42

15:                                               ; preds = %13
  %16 = call i32 @__VERIFIER_nondet_int(), !dbg !131, !verifier.code !130
  %17 = icmp ne i32 %16, 0, !dbg !131, !verifier.code !42
  br i1 %17, label %18, label %19, !dbg !134, !verifier.code !42

18:                                               ; preds = %15
  call void @push(), !dbg !135, !verifier.code !42
  br label %20, !dbg !135, !verifier.code !42

19:                                               ; preds = %15
  call void @pop(), !dbg !136, !verifier.code !42
  br label %20, !verifier.code !42

20:                                               ; preds = %19, %18
  br label %1, !dbg !120, !llvm.loop !137, !verifier.code !42

21:                                               ; preds = %13
  %22 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !139, !verifier.code !42
  %23 = icmp ne %struct.cell* %22, null, !dbg !140, !verifier.code !42
  br i1 %23, label %.lr.ph, label %32, !dbg !140, !verifier.code !42

.lr.ph:                                           ; preds = %21
  br label %24, !dbg !140, !verifier.code !42

24:                                               ; preds = %.lr.ph, %24
  %25 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !141, !verifier.code !42
  %26 = getelementptr inbounds %struct.cell, %struct.cell* %25, i32 0, i32 1, !dbg !143, !verifier.code !42
  %27 = load %struct.cell*, %struct.cell** %26, align 8, !dbg !143, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.cell* %27, metadata !144, metadata !DIExpression()), !dbg !145, !verifier.code !42
  %28 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !146, !verifier.code !42
  %29 = bitcast %struct.cell* %28 to i8*, !dbg !146, !verifier.code !42
  call void @free(i8* %29) #6, !dbg !147, !verifier.code !42
  store %struct.cell* %27, %struct.cell** @garbage, align 8, !dbg !148, !verifier.code !42
  %30 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !139, !verifier.code !42
  %31 = icmp ne %struct.cell* %30, null, !dbg !140, !verifier.code !42
  br i1 %31, label %24, label %._crit_edge, !dbg !140, !llvm.loop !149, !verifier.code !42

._crit_edge:                                      ; preds = %24
  br label %32, !dbg !140, !verifier.code !42

32:                                               ; preds = %._crit_edge, %21
  %33 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !151, !verifier.code !42
  %34 = icmp ne %struct.cell* %33, null, !dbg !152, !verifier.code !42
  %35 = xor i1 %34, true, !dbg !152, !verifier.code !42
  %36 = xor i1 %35, true, !dbg !153, !verifier.code !42
  %37 = zext i1 %36 to i32, !dbg !153, !verifier.code !42
  ret i32 %37, !dbg !154, !verifier.code !42
}

declare dso_local i32 @__VERIFIER_nondet_int() #3

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #4

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

define void @__SMACK_static_init() {
entry:
  store i32 1, i32* @pc1
  store i32 1, i32* @pc4
  store %struct.cell* null, %struct.cell** @S
  store %struct.cell* null, %struct.cell** @garbage
  store %struct.cell* null, %struct.cell** @push.x1
  store %struct.cell* null, %struct.cell** @push.t1
  store %struct.cell* null, %struct.cell** @pop.t4
  store %struct.cell* null, %struct.cell** @pop.x4
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone speculatable willreturn }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!34}
!llvm.module.flags = !{!35, !36, !37}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "pc1", scope: !2, file: !3, line: 16, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "svcomp/memsafety/lockfree-3.0.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!0, !8, !11, !21, !23, !26, !28, !30, !32}
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "pc4", scope: !2, file: !3, line: 17, type: !10, isLocal: false, isDefinition: true)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(name: "t1", scope: !13, file: !3, line: 21, type: !16, isLocal: true, isDefinition: true)
!13 = distinct !DISubprogram(name: "push", scope: !3, file: !3, line: 19, type: !14, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!14 = !DISubroutineType(types: !15)
!15 = !{null}
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cell", file: !3, line: 9, size: 128, elements: !18)
!18 = !{!19, !20}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !17, file: !3, line: 10, baseType: !10, size: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !17, file: !3, line: 11, baseType: !16, size: 64, offset: 64)
!21 = !DIGlobalVariableExpression(var: !22, expr: !DIExpression())
!22 = distinct !DIGlobalVariable(name: "x1", scope: !13, file: !3, line: 22, type: !16, isLocal: true, isDefinition: true)
!23 = !DIGlobalVariableExpression(var: !24, expr: !DIExpression())
!24 = distinct !DIGlobalVariable(name: "t4", scope: !25, file: !3, line: 60, type: !16, isLocal: true, isDefinition: true)
!25 = distinct !DISubprogram(name: "pop", scope: !3, file: !3, line: 58, type: !14, scopeLine: 59, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(name: "x4", scope: !25, file: !3, line: 61, type: !16, isLocal: true, isDefinition: true)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(name: "res4", scope: !25, file: !3, line: 62, type: !10, isLocal: true, isDefinition: true)
!30 = !DIGlobalVariableExpression(var: !31, expr: !DIExpression())
!31 = distinct !DIGlobalVariable(name: "S", scope: !2, file: !3, line: 14, type: !16, isLocal: false, isDefinition: true)
!32 = !DIGlobalVariableExpression(var: !33, expr: !DIExpression())
!33 = distinct !DIGlobalVariable(name: "garbage", scope: !2, file: !3, line: 56, type: !16, isLocal: false, isDefinition: true)
!34 = !{!"clang version 10.0.0-4ubuntu1 "}
!35 = !{i32 7, !"Dwarf Version", i32 4}
!36 = !{i32 2, !"Debug Info Version", i32 3}
!37 = !{i32 1, !"wchar_size", i32 4}
!38 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !14, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!39 = !DILocation(line: 3, column: 22, scope: !40)
!40 = distinct !DILexicalBlock(scope: !41, file: !3, line: 3, column: 22)
!41 = distinct !DILexicalBlock(scope: !38, file: !3, line: 3, column: 22)
!42 = !{i1 false}
!43 = !DILocation(line: 24, column: 16, scope: !13)
!44 = !DILocation(line: 26, column: 18, scope: !45)
!45 = distinct !DILexicalBlock(scope: !13, file: !3, line: 24, column: 20)
!46 = !DILocation(line: 26, column: 16, scope: !45)
!47 = !DILocation(line: 27, column: 13, scope: !45)
!48 = !DILocation(line: 27, column: 17, scope: !45)
!49 = !DILocation(line: 27, column: 22, scope: !45)
!50 = !DILocation(line: 28, column: 13, scope: !45)
!51 = !DILocation(line: 28, column: 17, scope: !45)
!52 = !DILocation(line: 28, column: 22, scope: !45)
!53 = !DILocation(line: 29, column: 13, scope: !45)
!54 = !DILocation(line: 32, column: 13, scope: !45)
!55 = !DILocation(line: 32, column: 17, scope: !45)
!56 = !DILocation(line: 32, column: 22, scope: !45)
!57 = !DILocation(line: 33, column: 13, scope: !45)
!58 = !DILocation(line: 36, column: 18, scope: !45)
!59 = !DILocation(line: 36, column: 16, scope: !45)
!60 = !DILocation(line: 37, column: 13, scope: !45)
!61 = !DILocation(line: 40, column: 24, scope: !45)
!62 = !DILocation(line: 40, column: 13, scope: !45)
!63 = !DILocation(line: 40, column: 17, scope: !45)
!64 = !DILocation(line: 40, column: 22, scope: !45)
!65 = !DILocation(line: 41, column: 13, scope: !45)
!66 = !DILocation(line: 44, column: 17, scope: !67)
!67 = distinct !DILexicalBlock(scope: !45, file: !3, line: 44, column: 17)
!68 = !DILocation(line: 44, column: 22, scope: !67)
!69 = !DILocation(line: 44, column: 19, scope: !67)
!70 = !DILocation(line: 44, column: 17, scope: !45)
!71 = !DILocation(line: 45, column: 21, scope: !67)
!72 = !DILocation(line: 45, column: 19, scope: !67)
!73 = !DILocation(line: 45, column: 17, scope: !67)
!74 = !DILocation(line: 47, column: 21, scope: !67)
!75 = !DILocation(line: 48, column: 13, scope: !45)
!76 = !DILocation(line: 51, column: 17, scope: !45)
!77 = !DILocation(line: 52, column: 13, scope: !45)
!78 = !DILocation(line: 54, column: 1, scope: !13)
!79 = !DILocation(line: 64, column: 16, scope: !25)
!80 = !DILocation(line: 66, column: 18, scope: !81)
!81 = distinct !DILexicalBlock(scope: !25, file: !3, line: 64, column: 20)
!82 = !DILocation(line: 66, column: 16, scope: !81)
!83 = !DILocation(line: 67, column: 13, scope: !81)
!84 = !DILocation(line: 70, column: 16, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !3, line: 70, column: 16)
!86 = !DILocation(line: 70, column: 19, scope: !85)
!87 = !DILocation(line: 70, column: 16, scope: !81)
!88 = !DILocation(line: 71, column: 21, scope: !85)
!89 = !DILocation(line: 71, column: 17, scope: !85)
!90 = !DILocation(line: 72, column: 13, scope: !81)
!91 = !DILocation(line: 75, column: 18, scope: !81)
!92 = !DILocation(line: 75, column: 22, scope: !81)
!93 = !DILocation(line: 75, column: 16, scope: !81)
!94 = !DILocation(line: 76, column: 13, scope: !81)
!95 = !DILocation(line: 79, column: 17, scope: !96)
!96 = distinct !DILexicalBlock(scope: !81, file: !3, line: 79, column: 17)
!97 = !DILocation(line: 79, column: 22, scope: !96)
!98 = !DILocation(line: 79, column: 19, scope: !96)
!99 = !DILocation(line: 79, column: 17, scope: !81)
!100 = !DILocation(line: 80, column: 21, scope: !96)
!101 = !DILocation(line: 80, column: 19, scope: !96)
!102 = !DILocation(line: 80, column: 17, scope: !96)
!103 = !DILocation(line: 82, column: 21, scope: !96)
!104 = !DILocation(line: 83, column: 13, scope: !81)
!105 = !DILocation(line: 86, column: 20, scope: !81)
!106 = !DILocation(line: 86, column: 24, scope: !81)
!107 = !DILocation(line: 86, column: 18, scope: !81)
!108 = !DILocation(line: 87, column: 24, scope: !81)
!109 = !DILocation(line: 87, column: 13, scope: !81)
!110 = !DILocation(line: 87, column: 17, scope: !81)
!111 = !DILocation(line: 87, column: 22, scope: !81)
!112 = !DILocation(line: 88, column: 23, scope: !81)
!113 = !DILocation(line: 88, column: 21, scope: !81)
!114 = !DILocation(line: 89, column: 17, scope: !81)
!115 = !DILocation(line: 90, column: 13, scope: !81)
!116 = !DILocation(line: 92, column: 1, scope: !25)
!117 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 94, type: !118, scopeLine: 95, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!118 = !DISubroutineType(types: !119)
!119 = !{!10}
!120 = !DILocation(line: 96, column: 5, scope: !117)
!121 = !DILocation(line: 96, column: 12, scope: !117)
!122 = !DILocation(line: 96, column: 14, scope: !117)
!123 = !DILocation(line: 96, column: 22, scope: !117)
!124 = !DILocation(line: 96, column: 19, scope: !117)
!125 = !DILocation(line: 96, column: 26, scope: !117)
!126 = !DILocation(line: 96, column: 34, scope: !117)
!127 = !DILocation(line: 96, column: 31, scope: !117)
!128 = !DILocation(line: 96, column: 38, scope: !117)
!129 = !DILocation(line: 96, column: 41, scope: !117)
!130 = !{i1 true}
!131 = !DILocation(line: 97, column: 13, scope: !132)
!132 = distinct !DILexicalBlock(scope: !133, file: !3, line: 97, column: 13)
!133 = distinct !DILexicalBlock(scope: !117, file: !3, line: 96, column: 66)
!134 = !DILocation(line: 97, column: 13, scope: !133)
!135 = !DILocation(line: 98, column: 13, scope: !132)
!136 = !DILocation(line: 100, column: 13, scope: !132)
!137 = distinct !{!137, !120, !138}
!138 = !DILocation(line: 101, column: 5, scope: !117)
!139 = !DILocation(line: 103, column: 12, scope: !117)
!140 = !DILocation(line: 103, column: 5, scope: !117)
!141 = !DILocation(line: 104, column: 29, scope: !142)
!142 = distinct !DILexicalBlock(scope: !117, file: !3, line: 103, column: 21)
!143 = !DILocation(line: 104, column: 38, scope: !142)
!144 = !DILocalVariable(name: "next", scope: !142, file: !3, line: 104, type: !16)
!145 = !DILocation(line: 0, scope: !142)
!146 = !DILocation(line: 105, column: 14, scope: !142)
!147 = !DILocation(line: 105, column: 9, scope: !142)
!148 = !DILocation(line: 106, column: 17, scope: !142)
!149 = distinct !{!149, !140, !150}
!150 = !DILocation(line: 107, column: 5, scope: !117)
!151 = !DILocation(line: 109, column: 14, scope: !117)
!152 = !DILocation(line: 109, column: 13, scope: !117)
!153 = !DILocation(line: 109, column: 12, scope: !117)
!154 = !DILocation(line: 109, column: 5, scope: !117)
