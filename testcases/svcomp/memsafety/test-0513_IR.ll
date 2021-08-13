; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-0oeaifro.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TLItem = type { %struct.TLItem*, %struct.DItem* }
%struct.DItem = type { %struct.DItem*, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  call void @llvm.dbg.value(metadata %struct.TLItem* null, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !25, !verifier.code !26
  %2 = icmp ne i32 %1, 0, !dbg !27, !verifier.code !24
  br i1 %2, label %.lr.ph16, label %26, !dbg !27, !verifier.code !24

.lr.ph16:                                         ; preds = %0
  br label %3, !dbg !27, !verifier.code !24

3:                                                ; preds = %forwarder20, %.lr.ph16
  %.0114 = phi %struct.TLItem* [ null, %.lr.ph16 ], [ %.1, %forwarder20 ], !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %.0114, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %4 = call noalias i8* @malloc(i64 16) #5, !dbg !28, !verifier.code !24
  %5 = bitcast i8* %4 to %struct.DItem*, !dbg !28, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %5, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %6 = icmp ne %struct.DItem* %5, null, !dbg !31, !verifier.code !24
  br i1 %6, label %8, label %7, !dbg !33, !verifier.code !24

7:                                                ; preds = %3
  call void @abort() #6, !dbg !34, !verifier.code !24
  unreachable, !dbg !34, !verifier.code !24

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.DItem, %struct.DItem* %5, i32 0, i32 0, !dbg !35, !verifier.code !24
  store %struct.DItem* null, %struct.DItem** %9, align 8, !dbg !36, !verifier.code !24
  %10 = call i32 @__VERIFIER_nondet_int(), !dbg !37, !verifier.code !26
  %11 = getelementptr inbounds %struct.DItem, %struct.DItem* %5, i32 0, i32 1, !dbg !38, !verifier.code !24
  store i32 %10, i32* %11, align 8, !dbg !39, !verifier.code !24
  %12 = call noalias i8* @malloc(i64 16) #5, !dbg !40, !verifier.code !24
  %13 = bitcast i8* %12 to %struct.TLItem*, !dbg !40, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %13, metadata !41, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %14 = icmp ne %struct.TLItem* %.0114, null, !dbg !42, !verifier.code !24
  br i1 %14, label %15, label %20, !dbg !44, !verifier.code !24

15:                                               ; preds = %8
  %16 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.0114, i32 0, i32 0, !dbg !45, !verifier.code !24
  %17 = load %struct.TLItem*, %struct.TLItem** %16, align 8, !dbg !45, !verifier.code !24
  %18 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %13, i32 0, i32 0, !dbg !47, !verifier.code !24
  store %struct.TLItem* %17, %struct.TLItem** %18, align 8, !dbg !48, !verifier.code !24
  %19 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.0114, i32 0, i32 0, !dbg !49, !verifier.code !24
  store %struct.TLItem* %13, %struct.TLItem** %19, align 8, !dbg !50, !verifier.code !24
  br label %22, !dbg !51, !verifier.code !24

20:                                               ; preds = %8
  %21 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %13, i32 0, i32 0, !dbg !52, !verifier.code !24
  store %struct.TLItem* %13, %struct.TLItem** %21, align 8, !dbg !54, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %13, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  br label %22, !verifier.code !24

22:                                               ; preds = %20, %15
  %.1 = phi %struct.TLItem* [ %.0114, %15 ], [ %13, %20 ], !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %.1, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %23 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %13, i32 0, i32 1, !dbg !55, !verifier.code !24
  store %struct.DItem* %5, %struct.DItem** %23, align 8, !dbg !56, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* null, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* null, metadata !41, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %24 = call i32 @__VERIFIER_nondet_int(), !dbg !25, !verifier.code !26
  %25 = icmp ne i32 %24, 0, !dbg !27, !verifier.code !24
  br i1 %25, label %forwarder20, label %._crit_edge17, !dbg !27, !llvm.loop !57, !verifier.code !24

._crit_edge17:                                    ; preds = %22
  %split18 = phi %struct.TLItem* [ %.1, %22 ], !verifier.code !24
  br label %26, !dbg !27, !verifier.code !24

26:                                               ; preds = %._crit_edge17, %0
  %.01.lcssa = phi %struct.TLItem* [ %split18, %._crit_edge17 ], [ null, %0 ], !dbg !59, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %.01.lcssa, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %27 = icmp ne %struct.TLItem* %.01.lcssa, null, !dbg !60, !verifier.code !24
  br i1 %27, label %29, label %28, !dbg !62, !verifier.code !24

28:                                               ; preds = %26
  br label %92, !dbg !63, !verifier.code !24

29:                                               ; preds = %26
  call void @llvm.dbg.value(metadata %struct.TLItem* %.01.lcssa, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %30 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.01.lcssa, i32 0, i32 0, !dbg !64, !verifier.code !24
  %31 = load %struct.TLItem*, %struct.TLItem** %30, align 8, !dbg !64, !verifier.code !24
  %32 = icmp ne %struct.TLItem* %31, %.01.lcssa, !dbg !65, !verifier.code !24
  br i1 %32, label %.lr.ph12, label %81, !dbg !66, !verifier.code !24

.lr.ph12:                                         ; preds = %29
  br label %33, !dbg !66, !verifier.code !24

33:                                               ; preds = %forwarder19, %.lr.ph12
  %.210 = phi %struct.TLItem* [ %.01.lcssa, %.lr.ph12 ], [ %77, %forwarder19 ], !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %.210, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %34 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 1, !dbg !67, !verifier.code !24
  %35 = load %struct.DItem*, %struct.DItem** %34, align 8, !dbg !67, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %35, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %36 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !69, !verifier.code !24
  %37 = load %struct.TLItem*, %struct.TLItem** %36, align 8, !dbg !69, !verifier.code !24
  %38 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %37, i32 0, i32 1, !dbg !70, !verifier.code !24
  %39 = load %struct.DItem*, %struct.DItem** %38, align 8, !dbg !70, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %39, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %40 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !72, !verifier.code !24
  %41 = load %struct.TLItem*, %struct.TLItem** %40, align 8, !dbg !72, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %41, metadata !41, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %42 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %41, i32 0, i32 0, !dbg !73, !verifier.code !24
  %43 = load %struct.TLItem*, %struct.TLItem** %42, align 8, !dbg !73, !verifier.code !24
  %44 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !74, !verifier.code !24
  store %struct.TLItem* %43, %struct.TLItem** %44, align 8, !dbg !75, !verifier.code !24
  %45 = bitcast %struct.TLItem* %41 to i8*, !dbg !76, !verifier.code !24
  call void @free(i8* %45) #5, !dbg !77, !verifier.code !24
  %46 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 1, !dbg !78, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem** %46, metadata !79, metadata !DIExpression()), !dbg !81, !verifier.code !24
  br label %47, !dbg !82, !verifier.code !24

47:                                               ; preds = %65, %33
  %.07 = phi %struct.DItem** [ %46, %33 ], [ %67, %65 ], !dbg !81, !verifier.code !24
  %.05 = phi %struct.DItem* [ %39, %33 ], [ %.16, %65 ], !dbg !83, !verifier.code !24
  %.02 = phi %struct.DItem* [ %35, %33 ], [ %.13, %65 ], !dbg !81, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.02, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.05, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem** %.07, metadata !79, metadata !DIExpression()), !dbg !81, !verifier.code !24
  %48 = icmp ne %struct.DItem* %.02, null, !dbg !84, !verifier.code !24
  br i1 %48, label %49, label %51, !dbg !85, !verifier.code !24

49:                                               ; preds = %47
  %50 = icmp ne %struct.DItem* %.05, null, !dbg !85, !verifier.code !24
  br label %51, !verifier.code !24

51:                                               ; preds = %49, %47
  %52 = phi i1 [ false, %47 ], [ %50, %49 ], !dbg !81, !verifier.code !24
  br i1 %52, label %53, label %68, !dbg !82, !verifier.code !24

53:                                               ; preds = %51
  %54 = getelementptr inbounds %struct.DItem, %struct.DItem* %.02, i32 0, i32 1, !dbg !86, !verifier.code !24
  %55 = load i32, i32* %54, align 8, !dbg !86, !verifier.code !24
  %56 = getelementptr inbounds %struct.DItem, %struct.DItem* %.05, i32 0, i32 1, !dbg !89, !verifier.code !24
  %57 = load i32, i32* %56, align 8, !dbg !89, !verifier.code !24
  %58 = icmp slt i32 %55, %57, !dbg !90, !verifier.code !24
  br i1 %58, label %59, label %62, !dbg !91, !verifier.code !24

59:                                               ; preds = %53
  store %struct.DItem* %.02, %struct.DItem** %.07, align 8, !dbg !92, !verifier.code !24
  %60 = getelementptr inbounds %struct.DItem, %struct.DItem* %.02, i32 0, i32 0, !dbg !94, !verifier.code !24
  %61 = load %struct.DItem*, %struct.DItem** %60, align 8, !dbg !94, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %61, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  br label %65, !dbg !95, !verifier.code !24

62:                                               ; preds = %53
  store %struct.DItem* %.05, %struct.DItem** %.07, align 8, !dbg !96, !verifier.code !24
  %63 = getelementptr inbounds %struct.DItem, %struct.DItem* %.05, i32 0, i32 0, !dbg !98, !verifier.code !24
  %64 = load %struct.DItem*, %struct.DItem** %63, align 8, !dbg !98, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %64, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  br label %65, !verifier.code !24

65:                                               ; preds = %62, %59
  %.16 = phi %struct.DItem* [ %.05, %59 ], [ %64, %62 ], !dbg !81, !verifier.code !24
  %.13 = phi %struct.DItem* [ %61, %59 ], [ %.02, %62 ], !dbg !81, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.13, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.16, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %66 = load %struct.DItem*, %struct.DItem** %.07, align 8, !dbg !99, !verifier.code !24
  %67 = getelementptr inbounds %struct.DItem, %struct.DItem* %66, i32 0, i32 0, !dbg !100, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem** %67, metadata !79, metadata !DIExpression()), !dbg !81, !verifier.code !24
  br label %47, !dbg !82, !llvm.loop !101, !verifier.code !24

68:                                               ; preds = %51
  %.07.lcssa = phi %struct.DItem** [ %.07, %51 ], !dbg !81, !verifier.code !24
  %.05.lcssa = phi %struct.DItem* [ %.05, %51 ], !dbg !83, !verifier.code !24
  %.02.lcssa = phi %struct.DItem* [ %.02, %51 ], !dbg !81, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem** %.07.lcssa, metadata !79, metadata !DIExpression()), !dbg !81, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.05.lcssa, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.02.lcssa, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %69 = icmp ne %struct.DItem* %.02.lcssa, null, !dbg !103, !verifier.code !24
  br i1 %69, label %70, label %71, !dbg !105, !verifier.code !24

70:                                               ; preds = %68
  store %struct.DItem* %.02.lcssa, %struct.DItem** %.07.lcssa, align 8, !dbg !106, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* null, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  br label %75, !dbg !108, !verifier.code !24

71:                                               ; preds = %68
  %72 = icmp ne %struct.DItem* %.05.lcssa, null, !dbg !109, !verifier.code !24
  br i1 %72, label %73, label %74, !dbg !111, !verifier.code !24

73:                                               ; preds = %71
  store %struct.DItem* %.05.lcssa, %struct.DItem** %.07.lcssa, align 8, !dbg !112, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* null, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  br label %74, !dbg !114, !verifier.code !24

74:                                               ; preds = %73, %71
  br label %75, !verifier.code !24

75:                                               ; preds = %74, %70
  call void @llvm.dbg.value(metadata %struct.DItem** null, metadata !79, metadata !DIExpression()), !dbg !81, !verifier.code !24
  %76 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !115, !verifier.code !24
  %77 = load %struct.TLItem*, %struct.TLItem** %76, align 8, !dbg !115, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %77, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %78 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %77, i32 0, i32 0, !dbg !64, !verifier.code !24
  %79 = load %struct.TLItem*, %struct.TLItem** %78, align 8, !dbg !64, !verifier.code !24
  %80 = icmp ne %struct.TLItem* %79, %77, !dbg !65, !verifier.code !24
  br i1 %80, label %forwarder19, label %._crit_edge13, !dbg !66, !llvm.loop !116, !verifier.code !24

._crit_edge13:                                    ; preds = %75
  %split = phi %struct.TLItem* [ %77, %75 ], !verifier.code !24
  br label %81, !dbg !66, !verifier.code !24

81:                                               ; preds = %._crit_edge13, %29
  %.2.lcssa = phi %struct.TLItem* [ %split, %._crit_edge13 ], [ %.01.lcssa, %29 ], !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.TLItem* %.2.lcssa, metadata !12, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %82 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.2.lcssa, i32 0, i32 1, !dbg !118, !verifier.code !24
  %83 = load %struct.DItem*, %struct.DItem** %82, align 8, !dbg !118, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %83, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %84 = bitcast %struct.TLItem* %.2.lcssa to i8*, !dbg !119, !verifier.code !24
  call void @free(i8* %84) #5, !dbg !120, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %83, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %85 = icmp ne %struct.DItem* %83, null, !dbg !121, !verifier.code !24
  br i1 %85, label %.lr.ph, label %91, !dbg !121, !verifier.code !24

.lr.ph:                                           ; preds = %81
  br label %86, !dbg !121, !verifier.code !24

86:                                               ; preds = %forwarder, %.lr.ph
  %.249 = phi %struct.DItem* [ %83, %.lr.ph ], [ %88, %forwarder ], !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.249, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %.249, metadata !71, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %87 = getelementptr inbounds %struct.DItem, %struct.DItem* %.249, i32 0, i32 0, !dbg !122, !verifier.code !24
  %88 = load %struct.DItem*, %struct.DItem** %87, align 8, !dbg !122, !verifier.code !24
  call void @llvm.dbg.value(metadata %struct.DItem* %88, metadata !30, metadata !DIExpression()), !dbg !23, !verifier.code !24
  %89 = bitcast %struct.DItem* %.249 to i8*, !dbg !124, !verifier.code !24
  call void @free(i8* %89) #5, !dbg !125, !verifier.code !24
  %90 = icmp ne %struct.DItem* %88, null, !dbg !121, !verifier.code !24
  br i1 %90, label %forwarder, label %._crit_edge, !dbg !121, !llvm.loop !126, !verifier.code !24

._crit_edge:                                      ; preds = %86
  br label %91, !dbg !121, !verifier.code !24

91:                                               ; preds = %._crit_edge, %81
  br label %92, !dbg !128, !verifier.code !24

92:                                               ; preds = %91, %28
  ret i32 0, !dbg !129, !verifier.code !24

forwarder:                                        ; preds = %86
  br label %86, !verifier.code !24

forwarder19:                                      ; preds = %75
  br label %33, !verifier.code !24

forwarder20:                                      ; preds = %22
  br label %3, !verifier.code !24
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @__VERIFIER_nondet_int() #2

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #3

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #4

; Function Attrs: nounwind
declare dso_local void @free(i8*) #3

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
attributes #4 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.ident = !{!3}
!llvm.module.flags = !{!4, !5, !6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "../svcomp/memsafety/test-0513.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 19, type: !9, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DIFile(filename: "../svcomp/memsafety//test-0513.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !DISubroutineType(types: !10)
!10 = !{!11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "data", scope: !7, file: !8, line: 21, type: !13)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TLItem", file: !8, line: 14, size: 128, elements: !15)
!15 = !{!16, !17}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !14, file: !8, line: 15, baseType: !13, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !14, file: !8, line: 16, baseType: !18, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DItem", file: !8, line: 9, size: 128, elements: !20)
!20 = !{!21, !22}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !19, file: !8, line: 10, baseType: !18, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !19, file: !8, line: 11, baseType: !11, size: 32, offset: 64)
!23 = !DILocation(line: 0, scope: !7)
!24 = !{i1 false}
!25 = !DILocation(line: 26, column: 12, scope: !7)
!26 = !{i1 true}
!27 = !DILocation(line: 26, column: 5, scope: !7)
!28 = !DILocation(line: 28, column: 16, scope: !29)
!29 = distinct !DILexicalBlock(scope: !7, file: !8, line: 26, column: 37)
!30 = !DILocalVariable(name: "item", scope: !7, file: !8, line: 22, type: !18)
!31 = !DILocation(line: 29, column: 14, scope: !32)
!32 = distinct !DILexicalBlock(scope: !29, file: !8, line: 29, column: 13)
!33 = !DILocation(line: 29, column: 13, scope: !29)
!34 = !DILocation(line: 30, column: 13, scope: !32)
!35 = !DILocation(line: 32, column: 15, scope: !29)
!36 = !DILocation(line: 32, column: 20, scope: !29)
!37 = !DILocation(line: 33, column: 23, scope: !29)
!38 = !DILocation(line: 33, column: 15, scope: !29)
!39 = !DILocation(line: 33, column: 21, scope: !29)
!40 = !DILocation(line: 35, column: 17, scope: !29)
!41 = !DILocalVariable(name: "lItem", scope: !7, file: !8, line: 23, type: !13)
!42 = !DILocation(line: 36, column: 13, scope: !43)
!43 = distinct !DILexicalBlock(scope: !29, file: !8, line: 36, column: 13)
!44 = !DILocation(line: 36, column: 13, scope: !29)
!45 = !DILocation(line: 37, column: 33, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !8, line: 36, column: 19)
!47 = !DILocation(line: 37, column: 20, scope: !46)
!48 = !DILocation(line: 37, column: 25, scope: !46)
!49 = !DILocation(line: 38, column: 19, scope: !46)
!50 = !DILocation(line: 38, column: 24, scope: !46)
!51 = !DILocation(line: 39, column: 9, scope: !46)
!52 = !DILocation(line: 40, column: 20, scope: !53)
!53 = distinct !DILexicalBlock(scope: !43, file: !8, line: 39, column: 16)
!54 = !DILocation(line: 40, column: 25, scope: !53)
!55 = !DILocation(line: 43, column: 16, scope: !29)
!56 = !DILocation(line: 43, column: 21, scope: !29)
!57 = distinct !{!57, !27, !58}
!58 = !DILocation(line: 47, column: 5, scope: !7)
!59 = !DILocation(line: 21, column: 20, scope: !7)
!60 = !DILocation(line: 49, column: 10, scope: !61)
!61 = distinct !DILexicalBlock(scope: !7, file: !8, line: 49, column: 9)
!62 = !DILocation(line: 49, column: 9, scope: !7)
!63 = !DILocation(line: 50, column: 9, scope: !61)
!64 = !DILocation(line: 53, column: 18, scope: !7)
!65 = !DILocation(line: 53, column: 23, scope: !7)
!66 = !DILocation(line: 53, column: 5, scope: !7)
!67 = !DILocation(line: 55, column: 22, scope: !68)
!68 = distinct !DILexicalBlock(scope: !7, file: !8, line: 53, column: 32)
!69 = !DILocation(line: 56, column: 23, scope: !68)
!70 = !DILocation(line: 56, column: 29, scope: !68)
!71 = !DILocalVariable(name: "item2", scope: !7, file: !8, line: 22, type: !18)
!72 = !DILocation(line: 58, column: 23, scope: !68)
!73 = !DILocation(line: 59, column: 29, scope: !68)
!74 = !DILocation(line: 59, column: 15, scope: !68)
!75 = !DILocation(line: 59, column: 20, scope: !68)
!76 = !DILocation(line: 60, column: 14, scope: !68)
!77 = !DILocation(line: 60, column: 9, scope: !68)
!78 = !DILocation(line: 62, column: 37, scope: !68)
!79 = !DILocalVariable(name: "dst", scope: !68, file: !8, line: 62, type: !80)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!81 = !DILocation(line: 0, scope: !68)
!82 = !DILocation(line: 64, column: 9, scope: !68)
!83 = !DILocation(line: 56, column: 15, scope: !68)
!84 = !DILocation(line: 64, column: 16, scope: !68)
!85 = !DILocation(line: 64, column: 21, scope: !68)
!86 = !DILocation(line: 66, column: 23, scope: !87)
!87 = distinct !DILexicalBlock(scope: !88, file: !8, line: 66, column: 17)
!88 = distinct !DILexicalBlock(scope: !68, file: !8, line: 64, column: 31)
!89 = !DILocation(line: 66, column: 38, scope: !87)
!90 = !DILocation(line: 66, column: 29, scope: !87)
!91 = !DILocation(line: 66, column: 17, scope: !88)
!92 = !DILocation(line: 67, column: 22, scope: !93)
!93 = distinct !DILexicalBlock(scope: !87, file: !8, line: 66, column: 45)
!94 = !DILocation(line: 68, column: 30, scope: !93)
!95 = !DILocation(line: 69, column: 13, scope: !93)
!96 = !DILocation(line: 70, column: 22, scope: !97)
!97 = distinct !DILexicalBlock(scope: !87, file: !8, line: 69, column: 20)
!98 = !DILocation(line: 71, column: 32, scope: !97)
!99 = !DILocation(line: 74, column: 21, scope: !88)
!100 = !DILocation(line: 74, column: 28, scope: !88)
!101 = distinct !{!101, !82, !102}
!102 = !DILocation(line: 75, column: 9, scope: !68)
!103 = !DILocation(line: 77, column: 13, scope: !104)
!104 = distinct !DILexicalBlock(scope: !68, file: !8, line: 77, column: 13)
!105 = !DILocation(line: 77, column: 13, scope: !68)
!106 = !DILocation(line: 78, column: 18, scope: !107)
!107 = distinct !DILexicalBlock(scope: !104, file: !8, line: 77, column: 19)
!108 = !DILocation(line: 80, column: 9, scope: !107)
!109 = !DILocation(line: 80, column: 20, scope: !110)
!110 = distinct !DILexicalBlock(scope: !104, file: !8, line: 80, column: 20)
!111 = !DILocation(line: 80, column: 20, scope: !104)
!112 = !DILocation(line: 81, column: 18, scope: !113)
!113 = distinct !DILexicalBlock(scope: !110, file: !8, line: 80, column: 27)
!114 = !DILocation(line: 83, column: 9, scope: !113)
!115 = !DILocation(line: 86, column: 22, scope: !68)
!116 = distinct !{!116, !66, !117}
!117 = !DILocation(line: 87, column: 5, scope: !7)
!118 = !DILocation(line: 90, column: 18, scope: !7)
!119 = !DILocation(line: 91, column: 10, scope: !7)
!120 = !DILocation(line: 91, column: 5, scope: !7)
!121 = !DILocation(line: 93, column: 5, scope: !7)
!122 = !DILocation(line: 95, column: 22, scope: !123)
!123 = distinct !DILexicalBlock(scope: !7, file: !8, line: 93, column: 18)
!124 = !DILocation(line: 96, column: 14, scope: !123)
!125 = !DILocation(line: 96, column: 9, scope: !123)
!126 = distinct !{!126, !121, !127}
!127 = !DILocation(line: 97, column: 5, scope: !7)
!128 = !DILocation(line: 99, column: 5, scope: !7)
!129 = !DILocation(line: 100, column: 1, scope: !7)
