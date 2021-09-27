; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-0mvk8pzx.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TSLL = type { %struct.TSLL*, %struct.TSLL*, i32 }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  ret void, !dbg !13, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !15 {
  %1 = call noalias i8* @malloc(i64 24) #5, !dbg !19, !verifier.code !14
  %2 = bitcast i8* %1 to %struct.TSLL*, !dbg !19, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %2, metadata !20, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %3 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %2, i32 0, i32 0, !dbg !30, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %3, align 8, !dbg !31, !verifier.code !14
  %4 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %2, i32 0, i32 1, !dbg !32, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %4, align 8, !dbg !33, !verifier.code !14
  %5 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %2, i32 0, i32 2, !dbg !34, !verifier.code !14
  store i32 0, i32* %5, align 8, !dbg !35, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %2, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %6 = call i32 @__VERIFIER_nondet_int(), !dbg !37, !verifier.code !38
  %7 = icmp ne i32 %6, 0, !dbg !39, !verifier.code !14
  br i1 %7, label %.lr.ph19, label %21, !dbg !39, !verifier.code !14

.lr.ph19:                                         ; preds = %0
  br label %8, !dbg !39, !verifier.code !14

8:                                                ; preds = %forwarder24, %.lr.ph19
  %.017 = phi %struct.TSLL* [ %2, %.lr.ph19 ], [ %16, %forwarder24 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.017, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %9 = call noalias i8* @malloc(i64 24) #5, !dbg !40, !verifier.code !14
  %10 = bitcast i8* %9 to %struct.TSLL*, !dbg !40, !verifier.code !14
  %11 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.017, i32 0, i32 0, !dbg !42, !verifier.code !14
  store %struct.TSLL* %10, %struct.TSLL** %11, align 8, !dbg !43, !verifier.code !14
  %12 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.017, i32 0, i32 0, !dbg !44, !verifier.code !14
  %13 = load %struct.TSLL*, %struct.TSLL** %12, align 8, !dbg !44, !verifier.code !14
  %14 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %13, i32 0, i32 1, !dbg !45, !verifier.code !14
  store %struct.TSLL* %.017, %struct.TSLL** %14, align 8, !dbg !46, !verifier.code !14
  %15 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.017, i32 0, i32 0, !dbg !47, !verifier.code !14
  %16 = load %struct.TSLL*, %struct.TSLL** %15, align 8, !dbg !47, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %16, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %17 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %16, i32 0, i32 2, !dbg !48, !verifier.code !14
  store i32 0, i32* %17, align 8, !dbg !49, !verifier.code !14
  %18 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %16, i32 0, i32 0, !dbg !50, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %18, align 8, !dbg !51, !verifier.code !14
  %19 = call i32 @__VERIFIER_nondet_int(), !dbg !37, !verifier.code !38
  %20 = icmp ne i32 %19, 0, !dbg !39, !verifier.code !14
  br i1 %20, label %forwarder24, label %._crit_edge20, !dbg !39, !llvm.loop !52, !verifier.code !14

._crit_edge20:                                    ; preds = %8
  br label %21, !dbg !39, !verifier.code !14

21:                                               ; preds = %._crit_edge20, %0
  %22 = call i32 @__VERIFIER_nondet_int(), !dbg !54, !verifier.code !38
  %23 = icmp ne i32 %22, 0, !dbg !54, !verifier.code !14
  br i1 %23, label %24, label %30, !dbg !56, !verifier.code !14

24:                                               ; preds = %21
  %25 = call noalias i8* @malloc(i64 24) #5, !dbg !57, !verifier.code !14
  %26 = bitcast i8* %25 to %struct.TSLL*, !dbg !57, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %26, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %27 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %26, i32 0, i32 2, !dbg !59, !verifier.code !14
  store i32 1, i32* %27, align 8, !dbg !60, !verifier.code !14
  %28 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %26, i32 0, i32 0, !dbg !61, !verifier.code !14
  store %struct.TSLL* %2, %struct.TSLL** %28, align 8, !dbg !62, !verifier.code !14
  %29 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %26, i32 0, i32 1, !dbg !63, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %29, align 8, !dbg !64, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %26, metadata !20, metadata !DIExpression()), !dbg !29, !verifier.code !14
  br label %61, !dbg !65, !verifier.code !14

30:                                               ; preds = %21
  call void @llvm.dbg.value(metadata %struct.TSLL* %2, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %31 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %2, i32 0, i32 0, !dbg !66, !verifier.code !14
  %32 = load %struct.TSLL*, %struct.TSLL** %31, align 8, !dbg !66, !verifier.code !14
  %33 = icmp ne %struct.TSLL* %32, null, !dbg !68, !verifier.code !14
  br i1 %33, label %.lr.ph15, label %.loopexit, !dbg !69, !verifier.code !14

.lr.ph15:                                         ; preds = %30
  br label %34, !dbg !69, !verifier.code !14

34:                                               ; preds = %forwarder23, %.lr.ph15
  %.113 = phi %struct.TSLL* [ %2, %.lr.ph15 ], [ %40, %forwarder23 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.113, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %35 = call i32 @__VERIFIER_nondet_int(), !dbg !70, !verifier.code !38
  %36 = icmp ne i32 %35, 0, !dbg !70, !verifier.code !14
  br i1 %36, label %37, label %38, !dbg !73, !verifier.code !14

37:                                               ; preds = %34
  %.1.lcssa2 = phi %struct.TSLL* [ %.113, %34 ], !dbg !74, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.1.lcssa2, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  br label %44, !dbg !75, !verifier.code !14

38:                                               ; preds = %34
  %39 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.113, i32 0, i32 0, !dbg !76, !verifier.code !14
  %40 = load %struct.TSLL*, %struct.TSLL** %39, align 8, !dbg !76, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %40, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %41 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %40, i32 0, i32 0, !dbg !66, !verifier.code !14
  %42 = load %struct.TSLL*, %struct.TSLL** %41, align 8, !dbg !66, !verifier.code !14
  %43 = icmp ne %struct.TSLL* %42, null, !dbg !68, !verifier.code !14
  br i1 %43, label %forwarder23, label %..loopexit_crit_edge, !dbg !69, !llvm.loop !77, !verifier.code !14

..loopexit_crit_edge:                             ; preds = %38
  %split16 = phi %struct.TSLL* [ %40, %38 ], !verifier.code !14
  br label %.loopexit, !dbg !69, !verifier.code !14

.loopexit:                                        ; preds = %..loopexit_crit_edge, %30
  %.1.lcssa = phi %struct.TSLL* [ %split16, %..loopexit_crit_edge ], [ %2, %30 ], !dbg !74, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.1.lcssa, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  br label %44, !dbg !79, !verifier.code !14

44:                                               ; preds = %.loopexit, %37
  %.13 = phi %struct.TSLL* [ %.1.lcssa, %.loopexit ], [ %.1.lcssa2, %37 ], !verifier.code !14
  %45 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.13, i32 0, i32 0, !dbg !79, !verifier.code !14
  %46 = load %struct.TSLL*, %struct.TSLL** %45, align 8, !dbg !79, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %46, metadata !80, metadata !DIExpression()), !dbg !74, !verifier.code !14
  %47 = call noalias i8* @malloc(i64 24) #5, !dbg !81, !verifier.code !14
  %48 = bitcast i8* %47 to %struct.TSLL*, !dbg !81, !verifier.code !14
  %49 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.13, i32 0, i32 0, !dbg !82, !verifier.code !14
  store %struct.TSLL* %48, %struct.TSLL** %49, align 8, !dbg !83, !verifier.code !14
  %50 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.13, i32 0, i32 0, !dbg !84, !verifier.code !14
  %51 = load %struct.TSLL*, %struct.TSLL** %50, align 8, !dbg !84, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %51, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %52 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %51, i32 0, i32 2, !dbg !85, !verifier.code !14
  store i32 1, i32* %52, align 8, !dbg !86, !verifier.code !14
  %53 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %51, i32 0, i32 0, !dbg !87, !verifier.code !14
  store %struct.TSLL* %46, %struct.TSLL** %53, align 8, !dbg !88, !verifier.code !14
  %54 = icmp ne %struct.TSLL* %46, null, !dbg !89, !verifier.code !14
  br i1 %54, label %55, label %60, !dbg !91, !verifier.code !14

55:                                               ; preds = %44
  %56 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %46, i32 0, i32 1, !dbg !92, !verifier.code !14
  %57 = load %struct.TSLL*, %struct.TSLL** %56, align 8, !dbg !92, !verifier.code !14
  %58 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %51, i32 0, i32 1, !dbg !94, !verifier.code !14
  store %struct.TSLL* %57, %struct.TSLL** %58, align 8, !dbg !95, !verifier.code !14
  %59 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %46, i32 0, i32 1, !dbg !96, !verifier.code !14
  store %struct.TSLL* %51, %struct.TSLL** %59, align 8, !dbg !97, !verifier.code !14
  br label %60, !dbg !98, !verifier.code !14

60:                                               ; preds = %55, %44
  br label %61, !verifier.code !14

61:                                               ; preds = %60, %24
  %.01 = phi %struct.TSLL* [ %26, %24 ], [ %2, %60 ], !dbg !29, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.01, metadata !20, metadata !DIExpression()), !dbg !29, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.01, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %62 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.01, i32 0, i32 2, !dbg !99, !verifier.code !14
  %63 = load i32, i32* %62, align 8, !dbg !99, !verifier.code !14
  %64 = icmp ne i32 %63, 1, !dbg !100, !verifier.code !14
  br i1 %64, label %.lr.ph11, label %71, !dbg !101, !verifier.code !14

.lr.ph11:                                         ; preds = %61
  br label %65, !dbg !101, !verifier.code !14

65:                                               ; preds = %forwarder22, %.lr.ph11
  %.29 = phi %struct.TSLL* [ %.01, %.lr.ph11 ], [ %67, %forwarder22 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.29, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %66 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.29, i32 0, i32 0, !dbg !102, !verifier.code !14
  %67 = load %struct.TSLL*, %struct.TSLL** %66, align 8, !dbg !102, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %67, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %68 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %67, i32 0, i32 2, !dbg !99, !verifier.code !14
  %69 = load i32, i32* %68, align 8, !dbg !99, !verifier.code !14
  %70 = icmp ne i32 %69, 1, !dbg !100, !verifier.code !14
  br i1 %70, label %forwarder22, label %._crit_edge12, !dbg !101, !llvm.loop !104, !verifier.code !14

._crit_edge12:                                    ; preds = %65
  %split = phi %struct.TSLL* [ %67, %65 ], !verifier.code !14
  br label %71, !dbg !101, !verifier.code !14

71:                                               ; preds = %._crit_edge12, %61
  %.2.lcssa = phi %struct.TSLL* [ %split, %._crit_edge12 ], [ %.01, %61 ], !dbg !29, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.2.lcssa, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %72 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.2.lcssa, i32 0, i32 0, !dbg !106, !verifier.code !14
  %73 = load %struct.TSLL*, %struct.TSLL** %72, align 8, !dbg !106, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %73, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %74 = icmp ne %struct.TSLL* %73, null, !dbg !107, !verifier.code !14
  br i1 %74, label %.lr.ph7, label %86, !dbg !107, !verifier.code !14

.lr.ph7:                                          ; preds = %71
  br label %75, !dbg !107, !verifier.code !14

75:                                               ; preds = %forwarder21, %.lr.ph7
  %.35 = phi %struct.TSLL* [ %73, %.lr.ph7 ], [ %84, %forwarder21 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.35, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %76 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.35, i32 0, i32 2, !dbg !108, !verifier.code !14
  %77 = load i32, i32* %76, align 8, !dbg !108, !verifier.code !14
  %78 = icmp ne i32 %77, 1, !dbg !111, !verifier.code !14
  br i1 %78, label %79, label %82, !dbg !112, !verifier.code !14

79:                                               ; preds = %75
  br label %80, !dbg !113, !verifier.code !14

80:                                               ; preds = %79
  call void @reach_error(), !dbg !114, !verifier.code !14
  call void @abort() #6, !dbg !114, !verifier.code !14
  unreachable, !dbg !114, !verifier.code !14

81:                                               ; No predecessors!
  unreachable, !dbg !118, !verifier.code !14

82:                                               ; preds = %75
  %83 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.35, i32 0, i32 0, !dbg !119, !verifier.code !14
  %84 = load %struct.TSLL*, %struct.TSLL** %83, align 8, !dbg !119, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %84, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %85 = icmp ne %struct.TSLL* %84, null, !dbg !107, !verifier.code !14
  br i1 %85, label %forwarder21, label %._crit_edge8, !dbg !107, !llvm.loop !120, !verifier.code !14

._crit_edge8:                                     ; preds = %82
  br label %86, !dbg !107, !verifier.code !14

86:                                               ; preds = %._crit_edge8, %71
  call void @llvm.dbg.value(metadata %struct.TSLL* %.01, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %87 = icmp ne %struct.TSLL* %.01, null, !dbg !122, !verifier.code !14
  br i1 %87, label %.lr.ph, label %93, !dbg !123, !verifier.code !14

.lr.ph:                                           ; preds = %86
  br label %88, !dbg !123, !verifier.code !14

88:                                               ; preds = %forwarder, %.lr.ph
  %.44 = phi %struct.TSLL* [ %.01, %.lr.ph ], [ %90, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.44, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.44, metadata !20, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %89 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.44, i32 0, i32 0, !dbg !124, !verifier.code !14
  %90 = load %struct.TSLL*, %struct.TSLL** %89, align 8, !dbg !124, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %90, metadata !36, metadata !DIExpression()), !dbg !29, !verifier.code !14
  %91 = bitcast %struct.TSLL* %.44 to i8*, !dbg !126, !verifier.code !14
  call void @free(i8* %91) #5, !dbg !127, !verifier.code !14
  %92 = icmp ne %struct.TSLL* %90, null, !dbg !122, !verifier.code !14
  br i1 %92, label %forwarder, label %._crit_edge, !dbg !123, !llvm.loop !128, !verifier.code !14

._crit_edge:                                      ; preds = %88
  br label %93, !dbg !123, !verifier.code !14

93:                                               ; preds = %._crit_edge, %86
  ret i32 0, !dbg !130, !verifier.code !14

forwarder:                                        ; preds = %88
  br label %88, !verifier.code !14

forwarder21:                                      ; preds = %82
  br label %75, !verifier.code !14

forwarder22:                                      ; preds = %65
  br label %65, !verifier.code !14

forwarder23:                                      ; preds = %38
  br label %34, !verifier.code !14

forwarder24:                                      ; preds = %8
  br label %8, !verifier.code !14
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

declare dso_local i32 @__VERIFIER_nondet_int() #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #4

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
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/dll-simple-white-blue-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !10, file: !10, line: 15, type: !11, scopeLine: 15, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//dll-simple-white-blue-1.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 15, column: 20, scope: !9)
!14 = !{i1 false}
!15 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 27, type: !16, scopeLine: 28, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocation(line: 30, column: 14, scope: !15)
!20 = !DILocalVariable(name: "head", scope: !15, file: !10, line: 30, type: !21)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "SLL", file: !10, line: 25, baseType: !23)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TSLL", file: !10, line: 20, size: 192, elements: !24)
!24 = !{!25, !27, !28}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !23, file: !10, line: 22, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !23, file: !10, line: 23, baseType: !26, size: 64, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !23, file: !10, line: 24, baseType: !18, size: 32, offset: 128)
!29 = !DILocation(line: 0, scope: !15)
!30 = !DILocation(line: 31, column: 8, scope: !15)
!31 = !DILocation(line: 31, column: 13, scope: !15)
!32 = !DILocation(line: 32, column: 8, scope: !15)
!33 = !DILocation(line: 32, column: 13, scope: !15)
!34 = !DILocation(line: 33, column: 8, scope: !15)
!35 = !DILocation(line: 33, column: 13, scope: !15)
!36 = !DILocalVariable(name: "x", scope: !15, file: !10, line: 35, type: !21)
!37 = !DILocation(line: 38, column: 9, scope: !15)
!38 = !{i1 true}
!39 = !DILocation(line: 38, column: 2, scope: !15)
!40 = !DILocation(line: 41, column: 13, scope: !41)
!41 = distinct !DILexicalBlock(scope: !15, file: !10, line: 39, column: 2)
!42 = !DILocation(line: 41, column: 6, scope: !41)
!43 = !DILocation(line: 41, column: 11, scope: !41)
!44 = !DILocation(line: 42, column: 6, scope: !41)
!45 = !DILocation(line: 42, column: 12, scope: !41)
!46 = !DILocation(line: 42, column: 17, scope: !41)
!47 = !DILocation(line: 43, column: 10, scope: !41)
!48 = !DILocation(line: 44, column: 6, scope: !41)
!49 = !DILocation(line: 44, column: 11, scope: !41)
!50 = !DILocation(line: 45, column: 6, scope: !41)
!51 = !DILocation(line: 45, column: 11, scope: !41)
!52 = distinct !{!52, !39, !53}
!53 = !DILocation(line: 46, column: 2, scope: !15)
!54 = !DILocation(line: 49, column: 6, scope: !55)
!55 = distinct !DILexicalBlock(scope: !15, file: !10, line: 49, column: 6)
!56 = !DILocation(line: 49, column: 6, scope: !15)
!57 = !DILocation(line: 50, column: 7, scope: !58)
!58 = distinct !DILexicalBlock(scope: !55, file: !10, line: 49, column: 31)
!59 = !DILocation(line: 51, column: 6, scope: !58)
!60 = !DILocation(line: 51, column: 11, scope: !58)
!61 = !DILocation(line: 52, column: 6, scope: !58)
!62 = !DILocation(line: 52, column: 11, scope: !58)
!63 = !DILocation(line: 53, column: 6, scope: !58)
!64 = !DILocation(line: 53, column: 11, scope: !58)
!65 = !DILocation(line: 55, column: 2, scope: !58)
!66 = !DILocation(line: 60, column: 13, scope: !67)
!67 = distinct !DILexicalBlock(scope: !55, file: !10, line: 57, column: 2)
!68 = !DILocation(line: 60, column: 18, scope: !67)
!69 = !DILocation(line: 60, column: 3, scope: !67)
!70 = !DILocation(line: 62, column: 8, scope: !71)
!71 = distinct !DILexicalBlock(scope: !72, file: !10, line: 62, column: 8)
!72 = distinct !DILexicalBlock(scope: !67, file: !10, line: 61, column: 3)
!73 = !DILocation(line: 62, column: 8, scope: !72)
!74 = !DILocation(line: 0, scope: !67)
!75 = !DILocation(line: 62, column: 33, scope: !71)
!76 = !DILocation(line: 63, column: 11, scope: !72)
!77 = distinct !{!77, !69, !78}
!78 = !DILocation(line: 64, column: 3, scope: !67)
!79 = !DILocation(line: 67, column: 15, scope: !67)
!80 = !DILocalVariable(name: "y", scope: !67, file: !10, line: 67, type: !21)
!81 = !DILocation(line: 68, column: 13, scope: !67)
!82 = !DILocation(line: 68, column: 6, scope: !67)
!83 = !DILocation(line: 68, column: 11, scope: !67)
!84 = !DILocation(line: 69, column: 10, scope: !67)
!85 = !DILocation(line: 70, column: 6, scope: !67)
!86 = !DILocation(line: 70, column: 11, scope: !67)
!87 = !DILocation(line: 71, column: 6, scope: !67)
!88 = !DILocation(line: 71, column: 11, scope: !67)
!89 = !DILocation(line: 72, column: 9, scope: !90)
!90 = distinct !DILexicalBlock(scope: !67, file: !10, line: 72, column: 7)
!91 = !DILocation(line: 72, column: 7, scope: !67)
!92 = !DILocation(line: 74, column: 17, scope: !93)
!93 = distinct !DILexicalBlock(scope: !90, file: !10, line: 73, column: 3)
!94 = !DILocation(line: 74, column: 7, scope: !93)
!95 = !DILocation(line: 74, column: 12, scope: !93)
!96 = !DILocation(line: 75, column: 7, scope: !93)
!97 = !DILocation(line: 75, column: 12, scope: !93)
!98 = !DILocation(line: 76, column: 3, scope: !93)
!99 = !DILocation(line: 83, column: 15, scope: !15)
!100 = !DILocation(line: 83, column: 20, scope: !15)
!101 = !DILocation(line: 83, column: 5, scope: !15)
!102 = !DILocation(line: 85, column: 10, scope: !103)
!103 = distinct !DILexicalBlock(scope: !15, file: !10, line: 84, column: 2)
!104 = distinct !{!104, !101, !105}
!105 = !DILocation(line: 86, column: 5, scope: !15)
!106 = !DILocation(line: 89, column: 12, scope: !15)
!107 = !DILocation(line: 90, column: 5, scope: !15)
!108 = !DILocation(line: 92, column: 10, scope: !109)
!109 = distinct !DILexicalBlock(scope: !110, file: !10, line: 92, column: 7)
!110 = distinct !DILexicalBlock(scope: !15, file: !10, line: 91, column: 2)
!111 = !DILocation(line: 92, column: 15, scope: !109)
!112 = !DILocation(line: 92, column: 7, scope: !110)
!113 = !DILocation(line: 93, column: 4, scope: !109)
!114 = !DILocation(line: 93, column: 4, scope: !115)
!115 = distinct !DILexicalBlock(scope: !116, file: !10, line: 93, column: 4)
!116 = distinct !DILexicalBlock(scope: !117, file: !10, line: 93, column: 4)
!117 = distinct !DILexicalBlock(scope: !109, file: !10, line: 93, column: 4)
!118 = !DILocation(line: 93, column: 4, scope: !117)
!119 = !DILocation(line: 94, column: 16, scope: !110)
!120 = distinct !{!120, !107, !121}
!121 = !DILocation(line: 95, column: 5, scope: !15)
!122 = !DILocation(line: 99, column: 11, scope: !15)
!123 = !DILocation(line: 99, column: 2, scope: !15)
!124 = !DILocation(line: 102, column: 10, scope: !125)
!125 = distinct !DILexicalBlock(scope: !15, file: !10, line: 100, column: 2)
!126 = !DILocation(line: 103, column: 8, scope: !125)
!127 = !DILocation(line: 103, column: 3, scope: !125)
!128 = distinct !{!128, !123, !129}
!129 = !DILocation(line: 104, column: 2, scope: !15)
!130 = !DILocation(line: 106, column: 2, scope: !15)
