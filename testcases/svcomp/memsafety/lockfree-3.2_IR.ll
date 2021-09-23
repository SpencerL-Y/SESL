; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/b-1oh1q53g.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.cell = type { i32, %struct.cell* }

@pc1 = internal global i32 1, align 4, !dbg !0
@pc4 = internal global i32 1, align 4, !dbg !8
@S = internal global %struct.cell* null, align 8, !dbg !16
@garbage = internal global %struct.cell* null, align 8, !dbg !23
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.1 = private unnamed_addr constant [32 x i8] c"svcomp/memsafety/lockfree-3.2.c\00", align 1
@__PRETTY_FUNCTION__.reach_error = private unnamed_addr constant [19 x i8] c"void reach_error()\00", align 1
@x1 = internal global %struct.cell* null, align 8, !dbg !25
@t1 = internal global %struct.cell* null, align 8, !dbg !27
@t4 = internal global %struct.cell* null, align 8, !dbg !29
@x4 = internal global %struct.cell* null, align 8, !dbg !31
@pop.res4 = internal global i32 0, align 4, !dbg !11

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !37 {
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.1, i64 0, i64 0), i32 3, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @__PRETTY_FUNCTION__.reach_error, i64 0, i64 0)) #5, !dbg !38, !verifier.code !41
  unreachable, !dbg !38, !verifier.code !41
}

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: noinline nounwind uwtable
define internal void @push() #0 !dbg !42 {
  %1 = load i32, i32* @pc1, align 4, !dbg !43, !verifier.code !41
  %2 = add nsw i32 %1, 1, !dbg !43, !verifier.code !41
  store i32 %2, i32* @pc1, align 4, !dbg !43, !verifier.code !41
  br label %NodeBlock9, !verifier.code !41

NodeBlock9:                                       ; preds = %0
  %Pivot10 = icmp slt i32 %1, 4, !verifier.code !41
  br i1 %Pivot10, label %NodeBlock1, label %NodeBlock7, !verifier.code !41

NodeBlock7:                                       ; preds = %NodeBlock9
  %Pivot8 = icmp slt i32 %1, 5, !verifier.code !41
  br i1 %Pivot8, label %15, label %NodeBlock5, !verifier.code !41

NodeBlock5:                                       ; preds = %NodeBlock7
  %Pivot6 = icmp slt i32 %1, 6, !verifier.code !41
  br i1 %Pivot6, label %19, label %LeafBlock3, !verifier.code !41

LeafBlock3:                                       ; preds = %NodeBlock5
  %SwitchLeaf4 = icmp eq i32 %1, 6, !verifier.code !41
  br i1 %SwitchLeaf4, label %27, label %NewDefault, !verifier.code !41

NodeBlock1:                                       ; preds = %NodeBlock9
  %Pivot2 = icmp slt i32 %1, 2, !verifier.code !41
  br i1 %Pivot2, label %LeafBlock, label %NodeBlock, !verifier.code !41

NodeBlock:                                        ; preds = %NodeBlock1
  %Pivot = icmp slt i32 %1, 3, !verifier.code !41
  br i1 %Pivot, label %10, label %13, !verifier.code !41

LeafBlock:                                        ; preds = %NodeBlock1
  %SwitchLeaf = icmp eq i32 %1, 1, !verifier.code !41
  br i1 %SwitchLeaf, label %3, label %NewDefault, !verifier.code !41

3:                                                ; preds = %LeafBlock
  %4 = call noalias i8* @malloc(i64 16) #6, !dbg !44, !verifier.code !41
  %5 = bitcast i8* %4 to %struct.cell*, !dbg !44, !verifier.code !41
  store %struct.cell* %5, %struct.cell** @x1, align 8, !dbg !46, !verifier.code !41
  %6 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !47, !verifier.code !41
  %7 = getelementptr inbounds %struct.cell, %struct.cell* %6, i32 0, i32 0, !dbg !48, !verifier.code !41
  store i32 0, i32* %7, align 8, !dbg !49, !verifier.code !41
  %8 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !50, !verifier.code !41
  %9 = getelementptr inbounds %struct.cell, %struct.cell* %8, i32 0, i32 1, !dbg !51, !verifier.code !41
  store %struct.cell* null, %struct.cell** %9, align 8, !dbg !52, !verifier.code !41
  br label %28, !dbg !53, !verifier.code !41

10:                                               ; preds = %NodeBlock
  %11 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !54, !verifier.code !41
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 0, !dbg !55, !verifier.code !41
  store i32 4, i32* %12, align 8, !dbg !56, !verifier.code !41
  br label %28, !dbg !57, !verifier.code !41

13:                                               ; preds = %NodeBlock
  %14 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !58, !verifier.code !41
  store %struct.cell* %14, %struct.cell** @t1, align 8, !dbg !59, !verifier.code !41
  br label %28, !dbg !60, !verifier.code !41

15:                                               ; preds = %NodeBlock7
  %16 = load %struct.cell*, %struct.cell** @t1, align 8, !dbg !61, !verifier.code !41
  %17 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !62, !verifier.code !41
  %18 = getelementptr inbounds %struct.cell, %struct.cell* %17, i32 0, i32 1, !dbg !63, !verifier.code !41
  store %struct.cell* %16, %struct.cell** %18, align 8, !dbg !64, !verifier.code !41
  br label %28, !dbg !65, !verifier.code !41

19:                                               ; preds = %NodeBlock5
  %20 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !66, !verifier.code !41
  %21 = load %struct.cell*, %struct.cell** @t1, align 8, !dbg !68, !verifier.code !41
  %22 = icmp eq %struct.cell* %20, %21, !dbg !69, !verifier.code !41
  br i1 %22, label %23, label %25, !dbg !70, !verifier.code !41

23:                                               ; preds = %19
  %24 = load %struct.cell*, %struct.cell** @x1, align 8, !dbg !71, !verifier.code !41
  store %struct.cell* %24, %struct.cell** @S, align 8, !dbg !72, !verifier.code !41
  br label %26, !dbg !73, !verifier.code !41

25:                                               ; preds = %19
  store i32 3, i32* @pc1, align 4, !dbg !74, !verifier.code !41
  br label %26, !verifier.code !41

26:                                               ; preds = %25, %23
  br label %28, !dbg !75, !verifier.code !41

27:                                               ; preds = %LeafBlock3
  store i32 1, i32* @pc1, align 4, !dbg !76, !verifier.code !41
  br label %28, !dbg !77, !verifier.code !41

NewDefault:                                       ; preds = %LeafBlock3, %LeafBlock
  br label %28, !verifier.code !41

28:                                               ; preds = %NewDefault, %3, %10, %13, %15, %26, %27
  ret void, !dbg !78, !verifier.code !41
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: noinline nounwind uwtable
define internal void @pop() #0 !dbg !13 {
  %1 = load i32, i32* @pc4, align 4, !dbg !79, !verifier.code !41
  %2 = add nsw i32 %1, 1, !dbg !79, !verifier.code !41
  store i32 %2, i32* @pc4, align 4, !dbg !79, !verifier.code !41
  br label %NodeBlock7, !verifier.code !41

NodeBlock7:                                       ; preds = %0
  %Pivot8 = icmp slt i32 %1, 3, !verifier.code !41
  br i1 %Pivot8, label %NodeBlock, label %NodeBlock5, !verifier.code !41

NodeBlock5:                                       ; preds = %NodeBlock7
  %Pivot6 = icmp slt i32 %1, 4, !verifier.code !41
  br i1 %Pivot6, label %10, label %NodeBlock3, !verifier.code !41

NodeBlock3:                                       ; preds = %NodeBlock5
  %Pivot4 = icmp slt i32 %1, 5, !verifier.code !41
  br i1 %Pivot4, label %14, label %LeafBlock1, !verifier.code !41

LeafBlock1:                                       ; preds = %NodeBlock3
  %SwitchLeaf2 = icmp eq i32 %1, 5, !verifier.code !41
  br i1 %SwitchLeaf2, label %22, label %NewDefault, !verifier.code !41

NodeBlock:                                        ; preds = %NodeBlock7
  %Pivot = icmp slt i32 %1, 2, !verifier.code !41
  br i1 %Pivot, label %LeafBlock, label %5, !verifier.code !41

LeafBlock:                                        ; preds = %NodeBlock
  %SwitchLeaf = icmp eq i32 %1, 1, !verifier.code !41
  br i1 %SwitchLeaf, label %3, label %NewDefault, !verifier.code !41

3:                                                ; preds = %LeafBlock
  %4 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !80, !verifier.code !41
  store %struct.cell* %4, %struct.cell** @t4, align 8, !dbg !82, !verifier.code !41
  br label %30, !dbg !83, !verifier.code !41

5:                                                ; preds = %NodeBlock
  %6 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !84, !verifier.code !41
  %7 = icmp eq %struct.cell* %6, null, !dbg !86, !verifier.code !41
  br i1 %7, label %8, label %9, !dbg !87, !verifier.code !41

8:                                                ; preds = %5
  store i32 1, i32* @pc4, align 4, !dbg !88, !verifier.code !41
  br label %9, !dbg !89, !verifier.code !41

9:                                                ; preds = %8, %5
  br label %30, !dbg !90, !verifier.code !41

10:                                               ; preds = %NodeBlock5
  %11 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !91, !verifier.code !41
  %12 = getelementptr inbounds %struct.cell, %struct.cell* %11, i32 0, i32 1, !dbg !92, !verifier.code !41
  %13 = load %struct.cell*, %struct.cell** %12, align 8, !dbg !92, !verifier.code !41
  store %struct.cell* %13, %struct.cell** @x4, align 8, !dbg !93, !verifier.code !41
  br label %30, !dbg !94, !verifier.code !41

14:                                               ; preds = %NodeBlock3
  %15 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !95, !verifier.code !41
  %16 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !97, !verifier.code !41
  %17 = icmp eq %struct.cell* %15, %16, !dbg !98, !verifier.code !41
  br i1 %17, label %18, label %20, !dbg !99, !verifier.code !41

18:                                               ; preds = %14
  %19 = load %struct.cell*, %struct.cell** @x4, align 8, !dbg !100, !verifier.code !41
  store %struct.cell* %19, %struct.cell** @S, align 8, !dbg !101, !verifier.code !41
  br label %21, !dbg !102, !verifier.code !41

20:                                               ; preds = %14
  store i32 1, i32* @pc4, align 4, !dbg !103, !verifier.code !41
  br label %21, !verifier.code !41

21:                                               ; preds = %20, %18
  br label %30, !dbg !104, !verifier.code !41

22:                                               ; preds = %LeafBlock1
  %23 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !105, !verifier.code !41
  %24 = getelementptr inbounds %struct.cell, %struct.cell* %23, i32 0, i32 0, !dbg !106, !verifier.code !41
  %25 = load i32, i32* %24, align 8, !dbg !106, !verifier.code !41
  store i32 %25, i32* @pop.res4, align 4, !dbg !107, !verifier.code !41
  %26 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !108, !verifier.code !41
  %27 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !109, !verifier.code !41
  %28 = getelementptr inbounds %struct.cell, %struct.cell* %27, i32 0, i32 1, !dbg !110, !verifier.code !41
  store %struct.cell* %26, %struct.cell** %28, align 8, !dbg !111, !verifier.code !41
  %29 = load %struct.cell*, %struct.cell** @t4, align 8, !dbg !112, !verifier.code !41
  store %struct.cell* %29, %struct.cell** @garbage, align 8, !dbg !113, !verifier.code !41
  store i32 1, i32* @pc4, align 4, !dbg !114, !verifier.code !41
  br label %30, !dbg !115, !verifier.code !41

NewDefault:                                       ; preds = %LeafBlock1, %LeafBlock
  br label %30, !verifier.code !41

30:                                               ; preds = %NewDefault, %3, %9, %10, %21, %22
  ret void, !dbg !116, !verifier.code !41
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !117 {
  br label %1, !dbg !120, !verifier.code !41

1:                                                ; preds = %17, %0
  %2 = load %struct.cell*, %struct.cell** @S, align 8, !dbg !121, !verifier.code !41
  %3 = icmp ne %struct.cell* %2, null, !dbg !121, !verifier.code !41
  br i1 %3, label %10, label %4, !dbg !122, !verifier.code !41

4:                                                ; preds = %1
  %5 = load i32, i32* @pc4, align 4, !dbg !123, !verifier.code !41
  %6 = icmp ne i32 1, %5, !dbg !124, !verifier.code !41
  br i1 %6, label %10, label %7, !dbg !125, !verifier.code !41

7:                                                ; preds = %4
  %8 = call i32 @__VERIFIER_nondet_int(), !dbg !126, !verifier.code !127
  %9 = icmp ne i32 %8, 0, !dbg !125, !verifier.code !41
  br label %10, !dbg !125, !verifier.code !41

10:                                               ; preds = %7, %4, %1
  %11 = phi i1 [ true, %4 ], [ true, %1 ], [ %9, %7 ], !verifier.code !41
  br i1 %11, label %12, label %18, !dbg !120, !verifier.code !41

12:                                               ; preds = %10
  %13 = call i32 @__VERIFIER_nondet_int(), !dbg !128, !verifier.code !127
  %14 = icmp ne i32 %13, 0, !dbg !128, !verifier.code !41
  br i1 %14, label %15, label %16, !dbg !131, !verifier.code !41

15:                                               ; preds = %12
  call void @push(), !dbg !132, !verifier.code !41
  br label %17, !dbg !132, !verifier.code !41

16:                                               ; preds = %12
  call void @pop(), !dbg !133, !verifier.code !41
  br label %17, !verifier.code !41

17:                                               ; preds = %16, %15
  br label %1, !dbg !120, !llvm.loop !134, !verifier.code !41

18:                                               ; preds = %10
  %19 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !136, !verifier.code !41
  %20 = icmp ne %struct.cell* %19, null, !dbg !137, !verifier.code !41
  br i1 %20, label %.lr.ph, label %29, !dbg !137, !verifier.code !41

.lr.ph:                                           ; preds = %18
  br label %21, !dbg !137, !verifier.code !41

21:                                               ; preds = %.lr.ph, %21
  %22 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !138, !verifier.code !41
  %23 = getelementptr inbounds %struct.cell, %struct.cell* %22, i32 0, i32 1, !dbg !140, !verifier.code !41
  %24 = load %struct.cell*, %struct.cell** %23, align 8, !dbg !140, !verifier.code !41
  call void @llvm.dbg.value(metadata %struct.cell* %24, metadata !141, metadata !DIExpression()), !dbg !142, !verifier.code !41
  %25 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !143, !verifier.code !41
  %26 = bitcast %struct.cell* %25 to i8*, !dbg !143, !verifier.code !41
  call void @free(i8* %26) #6, !dbg !144, !verifier.code !41
  store %struct.cell* %24, %struct.cell** @garbage, align 8, !dbg !145, !verifier.code !41
  %27 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !136, !verifier.code !41
  %28 = icmp ne %struct.cell* %27, null, !dbg !137, !verifier.code !41
  br i1 %28, label %21, label %._crit_edge, !dbg !137, !llvm.loop !146, !verifier.code !41

._crit_edge:                                      ; preds = %21
  br label %29, !dbg !137, !verifier.code !41

29:                                               ; preds = %._crit_edge, %18
  store %struct.cell* null, %struct.cell** @S, align 8, !dbg !148, !verifier.code !41
  store %struct.cell* null, %struct.cell** @t1, align 8, !dbg !149, !verifier.code !41
  store %struct.cell* null, %struct.cell** @x1, align 8, !dbg !150, !verifier.code !41
  store %struct.cell* null, %struct.cell** @t4, align 8, !dbg !151, !verifier.code !41
  store %struct.cell* null, %struct.cell** @x4, align 8, !dbg !152, !verifier.code !41
  %30 = load %struct.cell*, %struct.cell** @garbage, align 8, !dbg !153, !verifier.code !41
  %31 = icmp ne %struct.cell* %30, null, !dbg !154, !verifier.code !41
  %32 = xor i1 %31, true, !dbg !154, !verifier.code !41
  %33 = xor i1 %32, true, !dbg !155, !verifier.code !41
  %34 = zext i1 %33 to i32, !dbg !155, !verifier.code !41
  ret i32 %34, !dbg !156, !verifier.code !41
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
!llvm.ident = !{!33}
!llvm.module.flags = !{!34, !35, !36}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "pc1", scope: !2, file: !3, line: 16, type: !10, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !7, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "svcomp/memsafety/lockfree-3.2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!7 = !{!0, !8, !11, !16, !23, !25, !27, !29, !31}
!8 = !DIGlobalVariableExpression(var: !9, expr: !DIExpression())
!9 = distinct !DIGlobalVariable(name: "pc4", scope: !2, file: !3, line: 17, type: !10, isLocal: false, isDefinition: true)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(name: "res4", scope: !13, file: !3, line: 63, type: !10, isLocal: true, isDefinition: true)
!13 = distinct !DISubprogram(name: "pop", scope: !3, file: !3, line: 61, type: !14, scopeLine: 62, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!14 = !DISubroutineType(types: !15)
!15 = !{null}
!16 = !DIGlobalVariableExpression(var: !17, expr: !DIExpression())
!17 = distinct !DIGlobalVariable(name: "S", scope: !2, file: !3, line: 14, type: !18, isLocal: false, isDefinition: true)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cell", file: !3, line: 9, size: 128, elements: !20)
!20 = !{!21, !22}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !19, file: !3, line: 10, baseType: !10, size: 32)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !19, file: !3, line: 11, baseType: !18, size: 64, offset: 64)
!23 = !DIGlobalVariableExpression(var: !24, expr: !DIExpression())
!24 = distinct !DIGlobalVariable(name: "garbage", scope: !2, file: !3, line: 56, type: !18, isLocal: false, isDefinition: true)
!25 = !DIGlobalVariableExpression(var: !26, expr: !DIExpression())
!26 = distinct !DIGlobalVariable(name: "x1", scope: !2, file: !3, line: 20, type: !18, isLocal: true, isDefinition: true)
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(name: "t1", scope: !2, file: !3, line: 19, type: !18, isLocal: true, isDefinition: true)
!29 = !DIGlobalVariableExpression(var: !30, expr: !DIExpression())
!30 = distinct !DIGlobalVariable(name: "t4", scope: !2, file: !3, line: 58, type: !18, isLocal: true, isDefinition: true)
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(name: "x4", scope: !2, file: !3, line: 59, type: !18, isLocal: true, isDefinition: true)
!33 = !{!"clang version 10.0.0-4ubuntu1 "}
!34 = !{i32 7, !"Dwarf Version", i32 4}
!35 = !{i32 2, !"Debug Info Version", i32 3}
!36 = !{i32 1, !"wchar_size", i32 4}
!37 = distinct !DISubprogram(name: "reach_error", scope: !3, file: !3, line: 3, type: !14, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!38 = !DILocation(line: 3, column: 22, scope: !39)
!39 = distinct !DILexicalBlock(scope: !40, file: !3, line: 3, column: 22)
!40 = distinct !DILexicalBlock(scope: !37, file: !3, line: 3, column: 22)
!41 = !{i1 false}
!42 = distinct !DISubprogram(name: "push", scope: !3, file: !3, line: 22, type: !14, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!43 = !DILocation(line: 24, column: 16, scope: !42)
!44 = !DILocation(line: 26, column: 18, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !3, line: 24, column: 20)
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
!78 = !DILocation(line: 54, column: 1, scope: !42)
!79 = !DILocation(line: 65, column: 16, scope: !13)
!80 = !DILocation(line: 67, column: 18, scope: !81)
!81 = distinct !DILexicalBlock(scope: !13, file: !3, line: 65, column: 20)
!82 = !DILocation(line: 67, column: 16, scope: !81)
!83 = !DILocation(line: 68, column: 13, scope: !81)
!84 = !DILocation(line: 71, column: 16, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !3, line: 71, column: 16)
!86 = !DILocation(line: 71, column: 19, scope: !85)
!87 = !DILocation(line: 71, column: 16, scope: !81)
!88 = !DILocation(line: 72, column: 21, scope: !85)
!89 = !DILocation(line: 72, column: 17, scope: !85)
!90 = !DILocation(line: 73, column: 13, scope: !81)
!91 = !DILocation(line: 76, column: 18, scope: !81)
!92 = !DILocation(line: 76, column: 22, scope: !81)
!93 = !DILocation(line: 76, column: 16, scope: !81)
!94 = !DILocation(line: 77, column: 13, scope: !81)
!95 = !DILocation(line: 80, column: 17, scope: !96)
!96 = distinct !DILexicalBlock(scope: !81, file: !3, line: 80, column: 17)
!97 = !DILocation(line: 80, column: 22, scope: !96)
!98 = !DILocation(line: 80, column: 19, scope: !96)
!99 = !DILocation(line: 80, column: 17, scope: !81)
!100 = !DILocation(line: 81, column: 21, scope: !96)
!101 = !DILocation(line: 81, column: 19, scope: !96)
!102 = !DILocation(line: 81, column: 17, scope: !96)
!103 = !DILocation(line: 83, column: 21, scope: !96)
!104 = !DILocation(line: 84, column: 13, scope: !81)
!105 = !DILocation(line: 87, column: 20, scope: !81)
!106 = !DILocation(line: 87, column: 24, scope: !81)
!107 = !DILocation(line: 87, column: 18, scope: !81)
!108 = !DILocation(line: 88, column: 24, scope: !81)
!109 = !DILocation(line: 88, column: 13, scope: !81)
!110 = !DILocation(line: 88, column: 17, scope: !81)
!111 = !DILocation(line: 88, column: 22, scope: !81)
!112 = !DILocation(line: 89, column: 23, scope: !81)
!113 = !DILocation(line: 89, column: 21, scope: !81)
!114 = !DILocation(line: 90, column: 17, scope: !81)
!115 = !DILocation(line: 91, column: 13, scope: !81)
!116 = !DILocation(line: 93, column: 1, scope: !13)
!117 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 95, type: !118, scopeLine: 96, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!118 = !DISubroutineType(types: !119)
!119 = !{!10}
!120 = !DILocation(line: 97, column: 5, scope: !117)
!121 = !DILocation(line: 97, column: 12, scope: !117)
!122 = !DILocation(line: 97, column: 14, scope: !117)
!123 = !DILocation(line: 97, column: 22, scope: !117)
!124 = !DILocation(line: 97, column: 19, scope: !117)
!125 = !DILocation(line: 97, column: 26, scope: !117)
!126 = !DILocation(line: 97, column: 29, scope: !117)
!127 = !{i1 true}
!128 = !DILocation(line: 98, column: 13, scope: !129)
!129 = distinct !DILexicalBlock(scope: !130, file: !3, line: 98, column: 13)
!130 = distinct !DILexicalBlock(scope: !117, file: !3, line: 97, column: 54)
!131 = !DILocation(line: 98, column: 13, scope: !130)
!132 = !DILocation(line: 99, column: 13, scope: !129)
!133 = !DILocation(line: 101, column: 13, scope: !129)
!134 = distinct !{!134, !120, !135}
!135 = !DILocation(line: 102, column: 5, scope: !117)
!136 = !DILocation(line: 104, column: 12, scope: !117)
!137 = !DILocation(line: 104, column: 5, scope: !117)
!138 = !DILocation(line: 105, column: 29, scope: !139)
!139 = distinct !DILexicalBlock(scope: !117, file: !3, line: 104, column: 21)
!140 = !DILocation(line: 105, column: 38, scope: !139)
!141 = !DILocalVariable(name: "next", scope: !139, file: !3, line: 105, type: !18)
!142 = !DILocation(line: 0, scope: !139)
!143 = !DILocation(line: 106, column: 14, scope: !139)
!144 = !DILocation(line: 106, column: 9, scope: !139)
!145 = !DILocation(line: 107, column: 17, scope: !139)
!146 = distinct !{!146, !137, !147}
!147 = !DILocation(line: 108, column: 5, scope: !117)
!148 = !DILocation(line: 110, column: 7, scope: !117)
!149 = !DILocation(line: 111, column: 8, scope: !117)
!150 = !DILocation(line: 112, column: 8, scope: !117)
!151 = !DILocation(line: 113, column: 8, scope: !117)
!152 = !DILocation(line: 114, column: 8, scope: !117)
!153 = !DILocation(line: 116, column: 14, scope: !117)
!154 = !DILocation(line: 116, column: 13, scope: !117)
!155 = !DILocation(line: 116, column: 12, scope: !117)
!156 = !DILocation(line: 116, column: 5, scope: !117)
