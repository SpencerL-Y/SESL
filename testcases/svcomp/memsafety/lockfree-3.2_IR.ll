; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-f4d12yoo.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.cell = type { i32, %struct.cell* }

@pc1 = internal global i32 1, align 4, !dbg !0
@pc4 = internal global i32 1, align 4, !dbg !8
@S = internal global %struct.cell* null, align 8, !dbg !17
@garbage = internal global %struct.cell* null, align 8, !dbg !24
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [36 x i8] c"../svcomp/memsafety//lockfree-3.2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@x1 = internal global %struct.cell* null, align 8, !dbg !26
@t1 = internal global %struct.cell* null, align 8, !dbg !28
@t4 = internal global %struct.cell* null, align 8, !dbg !30
@x4 = internal global %struct.cell* null, align 8, !dbg !32
@pop.res4 = internal global i32 0, align 4, !dbg !12

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !38 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !39, !verifier.code !42
  unreachable, !dbg !39, !verifier.code !42
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @push() #0 !dbg !43 {
  %1 = load i32, i32* @pc1, align 4, !dbg !44, !verifier.code !42
  %2 = add nsw i32 %1, 1, !dbg !44, !verifier.code !42
  store i32 %2, i32* @pc1, align 4, !dbg !44, !verifier.code !42
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
  %4 = call noalias i8* @malloc(i64 16) #6, !dbg !45, !verifier.code !42
  %5 = bitcast i8* %4 to %struct.cell*, !dbg !45, !verifier.code !42
  store %struct.cell* %5, %struct.cell** @x1, align 8, !dbg !47, !verifier.code !42
  %6 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !48, !verifier.code !42
  %7 = getelementptr inbounds %struct.cell, %struct.cell* %6, i32 0, i32 0, !dbg !49, !verifier.code !42
  store i32 0, i32* %7, align 8, !dbg !50, !verifier.code !42
  %8 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !51, !verifier.code !42
  %9 = getelementptr inbounds %struct.cell, %struct.cell* %8, i32 0, i32 1, !dbg !52, !verifier.code !42
  store %struct.cell* null, %struct.cell** %9, align 8, !dbg !53, !verifier.code !42
  br label %28, !dbg !54, !verifier.code !42

10:                                               ; preds = %NodeBlock
  %11 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !55, !verifier.code !42
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 0, !dbg !56, !verifier.code !42
  store i32 4, i32* %12, align 8, !dbg !57, !verifier.code !42
  br label %28, !dbg !58, !verifier.code !42

13:                                               ; preds = %NodeBlock
  %14 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !59, !verifier.code !42
  store %struct.cell* %14, %struct.cell** @t1, align 8, !dbg !60, !verifier.code !42
  br label %28, !dbg !61, !verifier.code !42

15:                                               ; preds = %NodeBlock7
  %16 = load %struct.cell*, %struct.cell** @t1, align 8, !dbg !62, !verifier.code !42
  %17 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !63, !verifier.code !42
  %18 = getelementptr inbounds %struct.cell, %struct.cell* %17, i32 0, i32 1, !dbg !64, !verifier.code !42
  store %struct.cell* %16, %struct.cell** %18, align 8, !dbg !65, !verifier.code !42
  br label %28, !dbg !66, !verifier.code !42

19:                                               ; preds = %NodeBlock5
  %20 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !67, !verifier.code !42
  %21 = load %struct.cell*, %struct.cell** @t1, align 8, !dbg !69, !verifier.code !42
  %22 = icmp eq %struct.cell* %20, %21, !dbg !70, !verifier.code !42
  br i1 %22, label %23, label %25, !dbg !71, !verifier.code !42

23:                                               ; preds = %19
  %24 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !72, !verifier.code !42
  store %struct.cell* %24, %struct.cell** @S, align 8, !dbg !73, !verifier.code !42
  br label %26, !dbg !74, !verifier.code !42

25:                                               ; preds = %19
  store i32 3, i32* @pc1, align 4, !dbg !75, !verifier.code !42
  br label %26, !verifier.code !42

26:                                               ; preds = %25, %23
  br label %28, !dbg !76, !verifier.code !42

27:                                               ; preds = %LeafBlock3
  store i32 1, i32* @pc1, align 4, !dbg !77, !verifier.code !42
  br label %28, !dbg !78, !verifier.code !42

NewDefault:                                       ; preds = %LeafBlock3, %LeafBlock
  br label %28, !verifier.code !42

28:                                               ; preds = %NewDefault, %3, %10, %13, %15, %26, %27
  ret void, !dbg !79, !verifier.code !42
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal void @pop() #0 !dbg !14 {
  %1 = load i32, i32* @pc4, align 4, !dbg !80, !verifier.code !42
  %2 = add nsw i32 %1, 1, !dbg !80, !verifier.code !42
  store i32 %2, i32* @pc4, align 4, !dbg !80, !verifier.code !42
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
  %4 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !81, !verifier.code !42
  store %struct.cell* %4, %struct.cell** @t4, align 8, !dbg !83, !verifier.code !42
  br label %30, !dbg !84, !verifier.code !42

5:                                                ; preds = %NodeBlock
  %6 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !85, !verifier.code !42
  %7 = icmp eq %struct.cell* %6, null, !dbg !87, !verifier.code !42
  br i1 %7, label %8, label %9, !dbg !88, !verifier.code !42

8:                                                ; preds = %5
  store i32 1, i32* @pc4, align 4, !dbg !89, !verifier.code !42
  br label %9, !dbg !90, !verifier.code !42

9:                                                ; preds = %8, %5
  br label %30, !dbg !91, !verifier.code !42

10:                                               ; preds = %NodeBlock5
  %11 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !92, !verifier.code !42
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 1, !dbg !93, !verifier.code !42
  %13 = load %struct.cell*, %struct.cell** %12, align 8, !dbg !93, !verifier.code !42
  store %struct.cell* %13, %struct.cell** @x4, align 8, !dbg !94, !verifier.code !42
  br label %30, !dbg !95, !verifier.code !42

14:                                               ; preds = %NodeBlock3
  %15 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !96, !verifier.code !42
  %16 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !98, !verifier.code !42
  %17 = icmp eq %struct.cell* %15, %16, !dbg !99, !verifier.code !42
  br i1 %17, label %18, label %20, !dbg !100, !verifier.code !42

18:                                               ; preds = %14
  %19 = load %struct.cell*, %struct.cell** @x4, align 8, !dbg !101, !verifier.code !42
  store %struct.cell* %19, %struct.cell** @S, align 8, !dbg !102, !verifier.code !42
  br label %21, !dbg !103, !verifier.code !42

20:                                               ; preds = %14
  store i32 1, i32* @pc4, align 4, !dbg !104, !verifier.code !42
  br label %21, !verifier.code !42

21:                                               ; preds = %20, %18
  br label %30, !dbg !105, !verifier.code !42

22:                                               ; preds = %LeafBlock1
  %23 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !106, !verifier.code !42
  %24 = getelementptr inbounds %struct.cell, %struct.cell* %23, i32 0, i32 0, !dbg !107, !verifier.code !42
  %25 = load i32, i32* %24, align 8, !dbg !107, !verifier.code !42
  store i32 %25, i32* @pop.res4, align 4, !dbg !108, !verifier.code !42
  %26 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !109, !verifier.code !42
  %27 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !110, !verifier.code !42
  %28 = getelementptr inbounds %struct.cell, %struct.cell* %27, i32 0, i32 1, !dbg !111, !verifier.code !42
  store %struct.cell* %26, %struct.cell** %28, align 8, !dbg !112, !verifier.code !42
  %29 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !113, !verifier.code !42
  store %struct.cell* %29, %struct.cell** @garbage, align 8, !dbg !114, !verifier.code !42
  store i32 1, i32* @pc4, align 4, !dbg !115, !verifier.code !42
  br label %30, !dbg !116, !verifier.code !42

NewDefault:                                       ; preds = %LeafBlock1, %LeafBlock
  br label %30, !verifier.code !42

30:                                               ; preds = %NewDefault, %3, %9, %10, %21, %22
  ret void, !dbg !117, !verifier.code !42
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !118 {
  br label %1, !dbg !121, !verifier.code !42

1:                                                ; preds = %17, %0
  %2 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !122, !verifier.code !42
  %3 = icmp ne %struct.cell* %2, null, !dbg !122, !verifier.code !42
  br i1 %3, label %10, label %4, !dbg !123, !verifier.code !42

4:                                                ; preds = %1
  %5 = load i32, i32* @pc4, align 4, !dbg !124, !verifier.code !42
  %6 = icmp ne i32 1, %5, !dbg !125, !verifier.code !42
  br i1 %6, label %10, label %7, !dbg !126, !verifier.code !42

7:                                                ; preds = %4
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !127, !verifier.code !128
  %9 = icmp ne i32 %8, 0, !dbg !126, !verifier.code !42
  br label %10, !dbg !126, !verifier.code !42

10:                                               ; preds = %7, %4, %1
  %11 = phi i1 [ true, %4 ], [ true, %1 ], [ %9, %7 ], !verifier.code !42
  br i1 %11, label %12, label %18, !dbg !121, !verifier.code !42

12:                                               ; preds = %10
  %13 = call i32 @__VERIFIER_nondet_int(), !dbg !129, !verifier.code !128
  %14 = icmp ne i32 %13, 0, !dbg !129, !verifier.code !42
  br i1 %14, label %15, label %16, !dbg !132, !verifier.code !42

15:                                               ; preds = %12
  call void @push(), !dbg !133, !verifier.code !42
  br label %17, !dbg !133, !verifier.code !42

16:                                               ; preds = %12
  call void @pop(), !dbg !134, !verifier.code !42
  br label %17, !verifier.code !42

17:                                               ; preds = %16, %15
  br label %1, !dbg !121, !llvm.loop !135, !verifier.code !42

18:                                               ; preds = %10
  %19 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !137, !verifier.code !42
  %20 = icmp ne %struct.cell* %19, null, !dbg !138, !verifier.code !42
  br i1 %20, label %.lr.ph, label %29, !dbg !138, !verifier.code !42

.lr.ph:                                           ; preds = %18
  br label %21, !dbg !138, !verifier.code !42

21:                                               ; preds = %.lr.ph, %21
  %22 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !139, !verifier.code !42
  %23 = getelementptr inbounds %struct.cell, %struct.cell* %22, i32 0, i32 1, !dbg !141, !verifier.code !42
  %24 = load %struct.cell*, %struct.cell** %23, align 8, !dbg !141, !verifier.code !42
  call void @llvm.dbg.value(metadata %struct.cell* %24, metadata !142, metadata !DIExpression()), !dbg !143, !verifier.code !42
  %25 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !144, !verifier.code !42
  %26 = bitcast %struct.cell* %25 to i8*, !dbg !144, !verifier.code !42
  call void @free(i8* %26) #6, !dbg !145, !verifier.code !42
  store %struct.cell* %24, %struct.cell** @garbage, align 8, !dbg !146, !verifier.code !42
  %27 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !137, !verifier.code !42
  %28 = icmp ne %struct.cell* %27, null, !dbg !138, !verifier.code !42
  br i1 %28, label %21, label %._crit_edge, !dbg !138, !llvm.loop !147, !verifier.code !42

._crit_edge:                                      ; preds = %21
  br label %29, !dbg !138, !verifier.code !42

29:                                               ; preds = %._crit_edge, %18
  store %struct.cell* null, %struct.cell** @S, align 8, !dbg !149, !verifier.code !42
  store %struct.cell* null, %struct.cell** @t1, align 8, !dbg !150, !verifier.code !42
  store %struct.cell* null, %struct.cell** @x1, align 8, !dbg !151, !verifier.code !42
  store %struct.cell* null, %struct.cell** @t4, align 8, !dbg !152, !verifier.code !42
  store %struct.cell* null, %struct.cell** @x4, align 8, !dbg !153, !verifier.code !42
  %30 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !154, !verifier.code !42
  %31 = icmp ne %struct.cell* %30, null, !dbg !155, !verifier.code !42
  %32 = xor i1 %31, true, !dbg !155, !verifier.code !42
  %33 = xor i1 %32, true, !dbg !156, !verifier.code !42
  %34 = zext i1 %33 to i32, !dbg !156, !verifier.code !42
  ret i32 %34, !dbg !157, !verifier.code !42
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
  store %struct.cell* null, %struct.cell** @x1
  store %struct.cell* null, %struct.cell** @t1
  store %struct.cell* null, %struct.cell** @t4
  store %struct.cell* null, %struct.cell** @x4
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
!1 = distinct !DIGlobalVariable(name: "pc1", scope: !2, file: !10, line: 16, type: !11, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../svcomp/memsafety/lockfree-3.2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!0, !8, !12, !17, !24, !26, !28, !30, !32}
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "pc4", scope: !2, file: !10, line: 17, type: !11, isLocal: false, isDefinition: true)
!10 = !DIFile(filename: "../svcomp/memsafety//lockfree-3.2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "res4", scope: !14, file: !10, line: 63, type: !11, isLocal: true, isDefinition: true)
!14 = distinct !DISubprogram(name: "pop", scope: !10, file: !10, line: 61, type: !15, scopeLine: 62, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!15 = !DISubroutineType(types: !16)
!16 = !{null}
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "S", scope: !2, file: !10, line: 14, type: !19, isLocal: false, isDefinition: true)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cell", file: !10, line: 9, size: 128, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !20, file: !10, line: 10, baseType: !11, size: 32)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !20, file: !10, line: 11, baseType: !19, size: 64, offset: 64)
!24 = !DIGlobalVariableExpression(var: !25, expr: !DIExpression())
!25 = distinct !DIGlobalVariable(name: "garbage", scope: !2, file: !10, line: 56, type: !19, isLocal: false, isDefinition: true)
!26 = !DIGlobalVariableExpression(var: !27, expr: !DIExpression())
!27 = distinct !DIGlobalVariable(name: "x1", scope: !2, file: !10, line: 20, type: !19, isLocal: true, isDefinition: true)
!28 = !DIGlobalVariableExpression(var: !29, expr: !DIExpression())
!29 = distinct !DIGlobalVariable(name: "t1", scope: !2, file: !10, line: 19, type: !19, isLocal: true, isDefinition: true)
!30 = !DIGlobalVariableExpression(var: !31, expr: !DIExpression())
!31 = distinct !DIGlobalVariable(name: "t4", scope: !2, file: !10, line: 58, type: !19, isLocal: true, isDefinition: true)
!32 = !DIGlobalVariableExpression(var: !33, expr: !DIExpression())
!33 = distinct !DIGlobalVariable(name: "x4", scope: !2, file: !10, line: 59, type: !19, isLocal: true, isDefinition: true)
!34 = !{!"clang version 10.0.0-4ubuntu1 "}
!35 = !{i32 7, !"Dwarf Version", i32 4}
!36 = !{i32 2, !"Debug Info Version", i32 3}
!37 = !{i32 1, !"wchar_size", i32 4}
!38 = distinct !DISubprogram(name: "reach_error", scope: !10, file: !10, line: 3, type: !15, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!39 = !DILocation(line: 3, column: 22, scope: !40)
!40 = distinct !DILexicalBlock(scope: !41, file: !10, line: 3, column: 22)
!41 = distinct !DILexicalBlock(scope: !38, file: !10, line: 3, column: 22)
!42 = !{i1 false}
!43 = distinct !DISubprogram(name: "push", scope: !10, file: !10, line: 22, type: !15, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!44 = !DILocation(line: 24, column: 16, scope: !43)
!45 = !DILocation(line: 26, column: 18, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !10, line: 24, column: 20)
!47 = !DILocation(line: 26, column: 16, scope: !46)
!48 = !DILocation(line: 27, column: 13, scope: !46)
!49 = !DILocation(line: 27, column: 17, scope: !46)
!50 = !DILocation(line: 27, column: 22, scope: !46)
!51 = !DILocation(line: 28, column: 13, scope: !46)
!52 = !DILocation(line: 28, column: 17, scope: !46)
!53 = !DILocation(line: 28, column: 22, scope: !46)
!54 = !DILocation(line: 29, column: 13, scope: !46)
!55 = !DILocation(line: 32, column: 13, scope: !46)
!56 = !DILocation(line: 32, column: 17, scope: !46)
!57 = !DILocation(line: 32, column: 22, scope: !46)
!58 = !DILocation(line: 33, column: 13, scope: !46)
!59 = !DILocation(line: 36, column: 18, scope: !46)
!60 = !DILocation(line: 36, column: 16, scope: !46)
!61 = !DILocation(line: 37, column: 13, scope: !46)
!62 = !DILocation(line: 40, column: 24, scope: !46)
!63 = !DILocation(line: 40, column: 13, scope: !46)
!64 = !DILocation(line: 40, column: 17, scope: !46)
!65 = !DILocation(line: 40, column: 22, scope: !46)
!66 = !DILocation(line: 41, column: 13, scope: !46)
!67 = !DILocation(line: 44, column: 17, scope: !68)
!68 = distinct !DILexicalBlock(scope: !46, file: !10, line: 44, column: 17)
!69 = !DILocation(line: 44, column: 22, scope: !68)
!70 = !DILocation(line: 44, column: 19, scope: !68)
!71 = !DILocation(line: 44, column: 17, scope: !46)
!72 = !DILocation(line: 45, column: 21, scope: !68)
!73 = !DILocation(line: 45, column: 19, scope: !68)
!74 = !DILocation(line: 45, column: 17, scope: !68)
!75 = !DILocation(line: 47, column: 21, scope: !68)
!76 = !DILocation(line: 48, column: 13, scope: !46)
!77 = !DILocation(line: 51, column: 17, scope: !46)
!78 = !DILocation(line: 52, column: 13, scope: !46)
!79 = !DILocation(line: 54, column: 1, scope: !43)
!80 = !DILocation(line: 65, column: 16, scope: !14)
!81 = !DILocation(line: 67, column: 18, scope: !82)
!82 = distinct !DILexicalBlock(scope: !14, file: !10, line: 65, column: 20)
!83 = !DILocation(line: 67, column: 16, scope: !82)
!84 = !DILocation(line: 68, column: 13, scope: !82)
!85 = !DILocation(line: 71, column: 16, scope: !86)
!86 = distinct !DILexicalBlock(scope: !82, file: !10, line: 71, column: 16)
!87 = !DILocation(line: 71, column: 19, scope: !86)
!88 = !DILocation(line: 71, column: 16, scope: !82)
!89 = !DILocation(line: 72, column: 21, scope: !86)
!90 = !DILocation(line: 72, column: 17, scope: !86)
!91 = !DILocation(line: 73, column: 13, scope: !82)
!92 = !DILocation(line: 76, column: 18, scope: !82)
!93 = !DILocation(line: 76, column: 22, scope: !82)
!94 = !DILocation(line: 76, column: 16, scope: !82)
!95 = !DILocation(line: 77, column: 13, scope: !82)
!96 = !DILocation(line: 80, column: 17, scope: !97)
!97 = distinct !DILexicalBlock(scope: !82, file: !10, line: 80, column: 17)
!98 = !DILocation(line: 80, column: 22, scope: !97)
!99 = !DILocation(line: 80, column: 19, scope: !97)
!100 = !DILocation(line: 80, column: 17, scope: !82)
!101 = !DILocation(line: 81, column: 21, scope: !97)
!102 = !DILocation(line: 81, column: 19, scope: !97)
!103 = !DILocation(line: 81, column: 17, scope: !97)
!104 = !DILocation(line: 83, column: 21, scope: !97)
!105 = !DILocation(line: 84, column: 13, scope: !82)
!106 = !DILocation(line: 87, column: 20, scope: !82)
!107 = !DILocation(line: 87, column: 24, scope: !82)
!108 = !DILocation(line: 87, column: 18, scope: !82)
!109 = !DILocation(line: 88, column: 24, scope: !82)
!110 = !DILocation(line: 88, column: 13, scope: !82)
!111 = !DILocation(line: 88, column: 17, scope: !82)
!112 = !DILocation(line: 88, column: 22, scope: !82)
!113 = !DILocation(line: 89, column: 23, scope: !82)
!114 = !DILocation(line: 89, column: 21, scope: !82)
!115 = !DILocation(line: 90, column: 17, scope: !82)
!116 = !DILocation(line: 91, column: 13, scope: !82)
!117 = !DILocation(line: 93, column: 1, scope: !14)
!118 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 95, type: !119, scopeLine: 96, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!119 = !DISubroutineType(types: !120)
!120 = !{!11}
!121 = !DILocation(line: 97, column: 5, scope: !118)
!122 = !DILocation(line: 97, column: 12, scope: !118)
!123 = !DILocation(line: 97, column: 14, scope: !118)
!124 = !DILocation(line: 97, column: 22, scope: !118)
!125 = !DILocation(line: 97, column: 19, scope: !118)
!126 = !DILocation(line: 97, column: 26, scope: !118)
!127 = !DILocation(line: 97, column: 29, scope: !118)
!128 = !{i1 true}
!129 = !DILocation(line: 98, column: 13, scope: !130)
!130 = distinct !DILexicalBlock(scope: !131, file: !10, line: 98, column: 13)
!131 = distinct !DILexicalBlock(scope: !118, file: !10, line: 97, column: 54)
!132 = !DILocation(line: 98, column: 13, scope: !131)
!133 = !DILocation(line: 99, column: 13, scope: !130)
!134 = !DILocation(line: 101, column: 13, scope: !130)
!135 = distinct !{!135, !121, !136}
!136 = !DILocation(line: 102, column: 5, scope: !118)
!137 = !DILocation(line: 104, column: 12, scope: !118)
!138 = !DILocation(line: 104, column: 5, scope: !118)
!139 = !DILocation(line: 105, column: 29, scope: !140)
!140 = distinct !DILexicalBlock(scope: !118, file: !10, line: 104, column: 21)
!141 = !DILocation(line: 105, column: 38, scope: !140)
!142 = !DILocalVariable(name: "next", scope: !140, file: !10, line: 105, type: !19)
!143 = !DILocation(line: 0, scope: !140)
!144 = !DILocation(line: 106, column: 14, scope: !140)
!145 = !DILocation(line: 106, column: 9, scope: !140)
!146 = !DILocation(line: 107, column: 17, scope: !140)
!147 = distinct !{!147, !138, !148}
!148 = !DILocation(line: 108, column: 5, scope: !118)
!149 = !DILocation(line: 110, column: 7, scope: !118)
!150 = !DILocation(line: 111, column: 8, scope: !118)
!151 = !DILocation(line: 112, column: 8, scope: !118)
!152 = !DILocation(line: 113, column: 8, scope: !118)
!153 = !DILocation(line: 114, column: 8, scope: !118)
!154 = !DILocation(line: 116, column: 14, scope: !118)
!155 = !DILocation(line: 116, column: 13, scope: !118)
!156 = !DILocation(line: 116, column: 12, scope: !118)
!157 = !DILocation(line: 116, column: 5, scope: !118)
