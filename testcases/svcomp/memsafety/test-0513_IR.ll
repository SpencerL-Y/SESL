; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build/b-qcat_m5w.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TLItem = type { %struct.TLItem*, %struct.DItem* }
%struct.DItem = type { %struct.DItem*, i32 }

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !7 {
  call void @llvm.dbg.value(metadata %struct.TLItem* null, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %1 = call i32 @__VERIFIER_nondet_int(), !dbg !24, !verifier.code !25
  %2 = icmp ne i32 %1, 0, !dbg !26, !verifier.code !23
  br i1 %2, label %.lr.ph16, label %26, !dbg !26, !verifier.code !23

.lr.ph16:                                         ; preds = %0
  br label %3, !dbg !26, !verifier.code !23

3:                                                ; preds = %forwarder20, %.lr.ph16
  %.0114 = phi %struct.TLItem* [ null, %.lr.ph16 ], [ %.1, %forwarder20 ], !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %.0114, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %4 = call noalias i8* @malloc(i64 16) #5, !dbg !27, !verifier.code !23
  %5 = bitcast i8* %4 to %struct.DItem*, !dbg !27, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %5, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %6 = icmp ne %struct.DItem* %5, null, !dbg !30, !verifier.code !23
  br i1 %6, label %8, label %7, !dbg !32, !verifier.code !23

7:                                                ; preds = %3
  call void @abort() #6, !dbg !33, !verifier.code !23
  unreachable, !dbg !33, !verifier.code !23

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.DItem, %struct.DItem* %5, i32 0, i32 0, !dbg !34, !verifier.code !23
  store %struct.DItem* null, %struct.DItem** %9, align 8, !dbg !35, !verifier.code !23
  %10 = call i32 @__VERIFIER_nondet_int(), !dbg !36, !verifier.code !25
  %11 = getelementptr inbounds %struct.DItem, %struct.DItem* %5, i32 0, i32 1, !dbg !37, !verifier.code !23
  store i32 %10, i32* %11, align 8, !dbg !38, !verifier.code !23
  %12 = call noalias i8* @malloc(i64 16) #5, !dbg !39, !verifier.code !23
  %13 = bitcast i8* %12 to %struct.TLItem*, !dbg !39, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %13, metadata !40, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %14 = icmp ne %struct.TLItem* %.0114, null, !dbg !41, !verifier.code !23
  br i1 %14, label %15, label %20, !dbg !43, !verifier.code !23

15:                                               ; preds = %8
  %16 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.0114, i32 0, i32 0, !dbg !44, !verifier.code !23
  %17 = load %struct.TLItem*, %struct.TLItem** %16, align 8, !dbg !44, !verifier.code !23
  %18 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %13, i32 0, i32 0, !dbg !46, !verifier.code !23
  store %struct.TLItem* %17, %struct.TLItem** %18, align 8, !dbg !47, !verifier.code !23
  %19 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.0114, i32 0, i32 0, !dbg !48, !verifier.code !23
  store %struct.TLItem* %13, %struct.TLItem** %19, align 8, !dbg !49, !verifier.code !23
  br label %22, !dbg !50, !verifier.code !23

20:                                               ; preds = %8
  %21 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %13, i32 0, i32 0, !dbg !51, !verifier.code !23
  store %struct.TLItem* %13, %struct.TLItem** %21, align 8, !dbg !53, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %13, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  br label %22, !verifier.code !23

22:                                               ; preds = %20, %15
  %.1 = phi %struct.TLItem* [ %.0114, %15 ], [ %13, %20 ], !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %.1, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %23 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %13, i32 0, i32 1, !dbg !54, !verifier.code !23
  store %struct.DItem* %5, %struct.DItem** %23, align 8, !dbg !55, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* null, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* null, metadata !40, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %24 = call i32 @__VERIFIER_nondet_int(), !dbg !24, !verifier.code !25
  %25 = icmp ne i32 %24, 0, !dbg !26, !verifier.code !23
  br i1 %25, label %forwarder20, label %._crit_edge17, !dbg !26, !llvm.loop !56, !verifier.code !23

._crit_edge17:                                    ; preds = %22
  %split18 = phi %struct.TLItem* [ %.1, %22 ], !verifier.code !23
  br label %26, !dbg !26, !verifier.code !23

26:                                               ; preds = %._crit_edge17, %0
  %.01.lcssa = phi %struct.TLItem* [ %split18, %._crit_edge17 ], [ null, %0 ], !dbg !58, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %.01.lcssa, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %27 = icmp ne %struct.TLItem* %.01.lcssa, null, !dbg !59, !verifier.code !23
  br i1 %27, label %29, label %28, !dbg !61, !verifier.code !23

28:                                               ; preds = %26
  br label %92, !dbg !62, !verifier.code !23

29:                                               ; preds = %26
  call void @llvm.dbg.value(metadata %struct.TLItem* %.01.lcssa, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %30 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.01.lcssa, i32 0, i32 0, !dbg !63, !verifier.code !23
  %31 = load %struct.TLItem*, %struct.TLItem** %30, align 8, !dbg !63, !verifier.code !23
  %32 = icmp ne %struct.TLItem* %31, %.01.lcssa, !dbg !64, !verifier.code !23
  br i1 %32, label %.lr.ph12, label %81, !dbg !65, !verifier.code !23

.lr.ph12:                                         ; preds = %29
  br label %33, !dbg !65, !verifier.code !23

33:                                               ; preds = %forwarder19, %.lr.ph12
  %.210 = phi %struct.TLItem* [ %.01.lcssa, %.lr.ph12 ], [ %77, %forwarder19 ], !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %.210, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %34 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 1, !dbg !66, !verifier.code !23
  %35 = load %struct.DItem*, %struct.DItem** %34, align 8, !dbg !66, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %35, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %36 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !68, !verifier.code !23
  %37 = load %struct.TLItem*, %struct.TLItem** %36, align 8, !dbg !68, !verifier.code !23
  %38 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %37, i32 0, i32 1, !dbg !69, !verifier.code !23
  %39 = load %struct.DItem*, %struct.DItem** %38, align 8, !dbg !69, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %39, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %40 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !71, !verifier.code !23
  %41 = load %struct.TLItem*, %struct.TLItem** %40, align 8, !dbg !71, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %41, metadata !40, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %42 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %41, i32 0, i32 0, !dbg !72, !verifier.code !23
  %43 = load %struct.TLItem*, %struct.TLItem** %42, align 8, !dbg !72, !verifier.code !23
  %44 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !73, !verifier.code !23
  store %struct.TLItem* %43, %struct.TLItem** %44, align 8, !dbg !74, !verifier.code !23
  %45 = bitcast %struct.TLItem* %41 to i8*, !dbg !75, !verifier.code !23
  call void @free(i8* %45) #5, !dbg !76, !verifier.code !23
  %46 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 1, !dbg !77, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem** %46, metadata !78, metadata !DIExpression()), !dbg !80, !verifier.code !23
  br label %47, !dbg !81, !verifier.code !23

47:                                               ; preds = %65, %33
  %.07 = phi %struct.DItem** [ %46, %33 ], [ %67, %65 ], !dbg !80, !verifier.code !23
  %.05 = phi %struct.DItem* [ %39, %33 ], [ %.16, %65 ], !dbg !82, !verifier.code !23
  %.02 = phi %struct.DItem* [ %35, %33 ], [ %.13, %65 ], !dbg !80, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.02, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.05, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem** %.07, metadata !78, metadata !DIExpression()), !dbg !80, !verifier.code !23
  %48 = icmp ne %struct.DItem* %.02, null, !dbg !83, !verifier.code !23
  br i1 %48, label %49, label %51, !dbg !84, !verifier.code !23

49:                                               ; preds = %47
  %50 = icmp ne %struct.DItem* %.05, null, !dbg !84, !verifier.code !23
  br label %51, !verifier.code !23

51:                                               ; preds = %49, %47
  %52 = phi i1 [ false, %47 ], [ %50, %49 ], !dbg !80, !verifier.code !23
  br i1 %52, label %53, label %68, !dbg !81, !verifier.code !23

53:                                               ; preds = %51
  %54 = getelementptr inbounds %struct.DItem, %struct.DItem* %.02, i32 0, i32 1, !dbg !85, !verifier.code !23
  %55 = load i32, i32* %54, align 8, !dbg !85, !verifier.code !23
  %56 = getelementptr inbounds %struct.DItem, %struct.DItem* %.05, i32 0, i32 1, !dbg !88, !verifier.code !23
  %57 = load i32, i32* %56, align 8, !dbg !88, !verifier.code !23
  %58 = icmp slt i32 %55, %57, !dbg !89, !verifier.code !23
  br i1 %58, label %59, label %62, !dbg !90, !verifier.code !23

59:                                               ; preds = %53
  store %struct.DItem* %.02, %struct.DItem** %.07, align 8, !dbg !91, !verifier.code !23
  %60 = getelementptr inbounds %struct.DItem, %struct.DItem* %.02, i32 0, i32 0, !dbg !93, !verifier.code !23
  %61 = load %struct.DItem*, %struct.DItem** %60, align 8, !dbg !93, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %61, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  br label %65, !dbg !94, !verifier.code !23

62:                                               ; preds = %53
  store %struct.DItem* %.05, %struct.DItem** %.07, align 8, !dbg !95, !verifier.code !23
  %63 = getelementptr inbounds %struct.DItem, %struct.DItem* %.05, i32 0, i32 0, !dbg !97, !verifier.code !23
  %64 = load %struct.DItem*, %struct.DItem** %63, align 8, !dbg !97, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %64, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  br label %65, !verifier.code !23

65:                                               ; preds = %62, %59
  %.16 = phi %struct.DItem* [ %.05, %59 ], [ %64, %62 ], !dbg !80, !verifier.code !23
  %.13 = phi %struct.DItem* [ %61, %59 ], [ %.02, %62 ], !dbg !80, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.13, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.16, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %66 = load %struct.DItem*, %struct.DItem** %.07, align 8, !dbg !98, !verifier.code !23
  %67 = getelementptr inbounds %struct.DItem, %struct.DItem* %66, i32 0, i32 0, !dbg !99, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem** %67, metadata !78, metadata !DIExpression()), !dbg !80, !verifier.code !23
  br label %47, !dbg !81, !llvm.loop !100, !verifier.code !23

68:                                               ; preds = %51
  %.07.lcssa = phi %struct.DItem** [ %.07, %51 ], !dbg !80, !verifier.code !23
  %.05.lcssa = phi %struct.DItem* [ %.05, %51 ], !dbg !82, !verifier.code !23
  %.02.lcssa = phi %struct.DItem* [ %.02, %51 ], !dbg !80, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem** %.07.lcssa, metadata !78, metadata !DIExpression()), !dbg !80, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.05.lcssa, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.02.lcssa, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %69 = icmp ne %struct.DItem* %.02.lcssa, null, !dbg !102, !verifier.code !23
  br i1 %69, label %70, label %71, !dbg !104, !verifier.code !23

70:                                               ; preds = %68
  store %struct.DItem* %.02.lcssa, %struct.DItem** %.07.lcssa, align 8, !dbg !105, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* null, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  br label %75, !dbg !107, !verifier.code !23

71:                                               ; preds = %68
  %72 = icmp ne %struct.DItem* %.05.lcssa, null, !dbg !108, !verifier.code !23
  br i1 %72, label %73, label %74, !dbg !110, !verifier.code !23

73:                                               ; preds = %71
  store %struct.DItem* %.05.lcssa, %struct.DItem** %.07.lcssa, align 8, !dbg !111, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* null, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  br label %74, !dbg !113, !verifier.code !23

74:                                               ; preds = %73, %71
  br label %75, !verifier.code !23

75:                                               ; preds = %74, %70
  call void @llvm.dbg.value(metadata %struct.DItem** null, metadata !78, metadata !DIExpression()), !dbg !80, !verifier.code !23
  %76 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.210, i32 0, i32 0, !dbg !114, !verifier.code !23
  %77 = load %struct.TLItem*, %struct.TLItem** %76, align 8, !dbg !114, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %77, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %78 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %77, i32 0, i32 0, !dbg !63, !verifier.code !23
  %79 = load %struct.TLItem*, %struct.TLItem** %78, align 8, !dbg !63, !verifier.code !23
  %80 = icmp ne %struct.TLItem* %79, %77, !dbg !64, !verifier.code !23
  br i1 %80, label %forwarder19, label %._crit_edge13, !dbg !65, !llvm.loop !115, !verifier.code !23

._crit_edge13:                                    ; preds = %75
  %split = phi %struct.TLItem* [ %77, %75 ], !verifier.code !23
  br label %81, !dbg !65, !verifier.code !23

81:                                               ; preds = %._crit_edge13, %29
  %.2.lcssa = phi %struct.TLItem* [ %split, %._crit_edge13 ], [ %.01.lcssa, %29 ], !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.TLItem* %.2.lcssa, metadata !11, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %82 = getelementptr inbounds %struct.TLItem, %struct.TLItem* %.2.lcssa, i32 0, i32 1, !dbg !117, !verifier.code !23
  %83 = load %struct.DItem*, %struct.DItem** %82, align 8, !dbg !117, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %83, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %84 = bitcast %struct.TLItem* %.2.lcssa to i8*, !dbg !118, !verifier.code !23
  call void @free(i8* %84) #5, !dbg !119, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %83, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %85 = icmp ne %struct.DItem* %83, null, !dbg !120, !verifier.code !23
  br i1 %85, label %.lr.ph, label %91, !dbg !120, !verifier.code !23

.lr.ph:                                           ; preds = %81
  br label %86, !dbg !120, !verifier.code !23

86:                                               ; preds = %forwarder, %.lr.ph
  %.249 = phi %struct.DItem* [ %83, %.lr.ph ], [ %88, %forwarder ], !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.249, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %.249, metadata !70, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %87 = getelementptr inbounds %struct.DItem, %struct.DItem* %.249, i32 0, i32 0, !dbg !121, !verifier.code !23
  %88 = load %struct.DItem*, %struct.DItem** %87, align 8, !dbg !121, !verifier.code !23
  call void @llvm.dbg.value(metadata %struct.DItem* %88, metadata !29, metadata !DIExpression()), !dbg !22, !verifier.code !23
  %89 = bitcast %struct.DItem* %.249 to i8*, !dbg !123, !verifier.code !23
  call void @free(i8* %89) #5, !dbg !124, !verifier.code !23
  %90 = icmp ne %struct.DItem* %88, null, !dbg !120, !verifier.code !23
  br i1 %90, label %forwarder, label %._crit_edge, !dbg !120, !llvm.loop !125, !verifier.code !23

._crit_edge:                                      ; preds = %86
  br label %91, !dbg !120, !verifier.code !23

91:                                               ; preds = %._crit_edge, %81
  br label %92, !dbg !127, !verifier.code !23

92:                                               ; preds = %91, %28
  ret i32 0, !dbg !128, !verifier.code !23

forwarder:                                        ; preds = %86
  br label %86, !verifier.code !23

forwarder19:                                      ; preds = %75
  br label %33, !verifier.code !23

forwarder20:                                      ; preds = %22
  br label %3, !verifier.code !23
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
!1 = !DIFile(filename: "../testcases/svcomp/memsafety/test-0513.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/build")
!2 = !{}
!3 = !{!"clang version 10.0.0-4ubuntu1 "}
!4 = !{i32 7, !"Dwarf Version", i32 4}
!5 = !{i32 2, !"Debug Info Version", i32 3}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 19, type: !8, scopeLine: 19, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "data", scope: !7, file: !1, line: 21, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TLItem", file: !1, line: 14, size: 128, elements: !14)
!14 = !{!15, !16}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !13, file: !1, line: 15, baseType: !12, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !13, file: !1, line: 16, baseType: !17, size: 64, offset: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "DItem", file: !1, line: 9, size: 128, elements: !19)
!19 = !{!20, !21}
!20 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !18, file: !1, line: 10, baseType: !17, size: 64)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !18, file: !1, line: 11, baseType: !10, size: 32, offset: 64)
!22 = !DILocation(line: 0, scope: !7)
!23 = !{i1 false}
!24 = !DILocation(line: 26, column: 12, scope: !7)
!25 = !{i1 true}
!26 = !DILocation(line: 26, column: 5, scope: !7)
!27 = !DILocation(line: 28, column: 16, scope: !28)
!28 = distinct !DILexicalBlock(scope: !7, file: !1, line: 26, column: 37)
!29 = !DILocalVariable(name: "item", scope: !7, file: !1, line: 22, type: !17)
!30 = !DILocation(line: 29, column: 14, scope: !31)
!31 = distinct !DILexicalBlock(scope: !28, file: !1, line: 29, column: 13)
!32 = !DILocation(line: 29, column: 13, scope: !28)
!33 = !DILocation(line: 30, column: 13, scope: !31)
!34 = !DILocation(line: 32, column: 15, scope: !28)
!35 = !DILocation(line: 32, column: 20, scope: !28)
!36 = !DILocation(line: 33, column: 23, scope: !28)
!37 = !DILocation(line: 33, column: 15, scope: !28)
!38 = !DILocation(line: 33, column: 21, scope: !28)
!39 = !DILocation(line: 35, column: 17, scope: !28)
!40 = !DILocalVariable(name: "lItem", scope: !7, file: !1, line: 23, type: !12)
!41 = !DILocation(line: 36, column: 13, scope: !42)
!42 = distinct !DILexicalBlock(scope: !28, file: !1, line: 36, column: 13)
!43 = !DILocation(line: 36, column: 13, scope: !28)
!44 = !DILocation(line: 37, column: 33, scope: !45)
!45 = distinct !DILexicalBlock(scope: !42, file: !1, line: 36, column: 19)
!46 = !DILocation(line: 37, column: 20, scope: !45)
!47 = !DILocation(line: 37, column: 25, scope: !45)
!48 = !DILocation(line: 38, column: 19, scope: !45)
!49 = !DILocation(line: 38, column: 24, scope: !45)
!50 = !DILocation(line: 39, column: 9, scope: !45)
!51 = !DILocation(line: 40, column: 20, scope: !52)
!52 = distinct !DILexicalBlock(scope: !42, file: !1, line: 39, column: 16)
!53 = !DILocation(line: 40, column: 25, scope: !52)
!54 = !DILocation(line: 43, column: 16, scope: !28)
!55 = !DILocation(line: 43, column: 21, scope: !28)
!56 = distinct !{!56, !26, !57}
!57 = !DILocation(line: 47, column: 5, scope: !7)
!58 = !DILocation(line: 21, column: 20, scope: !7)
!59 = !DILocation(line: 49, column: 10, scope: !60)
!60 = distinct !DILexicalBlock(scope: !7, file: !1, line: 49, column: 9)
!61 = !DILocation(line: 49, column: 9, scope: !7)
!62 = !DILocation(line: 50, column: 9, scope: !60)
!63 = !DILocation(line: 53, column: 18, scope: !7)
!64 = !DILocation(line: 53, column: 23, scope: !7)
!65 = !DILocation(line: 53, column: 5, scope: !7)
!66 = !DILocation(line: 55, column: 22, scope: !67)
!67 = distinct !DILexicalBlock(scope: !7, file: !1, line: 53, column: 32)
!68 = !DILocation(line: 56, column: 23, scope: !67)
!69 = !DILocation(line: 56, column: 29, scope: !67)
!70 = !DILocalVariable(name: "item2", scope: !7, file: !1, line: 22, type: !17)
!71 = !DILocation(line: 58, column: 23, scope: !67)
!72 = !DILocation(line: 59, column: 29, scope: !67)
!73 = !DILocation(line: 59, column: 15, scope: !67)
!74 = !DILocation(line: 59, column: 20, scope: !67)
!75 = !DILocation(line: 60, column: 14, scope: !67)
!76 = !DILocation(line: 60, column: 9, scope: !67)
!77 = !DILocation(line: 62, column: 37, scope: !67)
!78 = !DILocalVariable(name: "dst", scope: !67, file: !1, line: 62, type: !79)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!80 = !DILocation(line: 0, scope: !67)
!81 = !DILocation(line: 64, column: 9, scope: !67)
!82 = !DILocation(line: 56, column: 15, scope: !67)
!83 = !DILocation(line: 64, column: 16, scope: !67)
!84 = !DILocation(line: 64, column: 21, scope: !67)
!85 = !DILocation(line: 66, column: 23, scope: !86)
!86 = distinct !DILexicalBlock(scope: !87, file: !1, line: 66, column: 17)
!87 = distinct !DILexicalBlock(scope: !67, file: !1, line: 64, column: 31)
!88 = !DILocation(line: 66, column: 38, scope: !86)
!89 = !DILocation(line: 66, column: 29, scope: !86)
!90 = !DILocation(line: 66, column: 17, scope: !87)
!91 = !DILocation(line: 67, column: 22, scope: !92)
!92 = distinct !DILexicalBlock(scope: !86, file: !1, line: 66, column: 45)
!93 = !DILocation(line: 68, column: 30, scope: !92)
!94 = !DILocation(line: 69, column: 13, scope: !92)
!95 = !DILocation(line: 70, column: 22, scope: !96)
!96 = distinct !DILexicalBlock(scope: !86, file: !1, line: 69, column: 20)
!97 = !DILocation(line: 71, column: 32, scope: !96)
!98 = !DILocation(line: 74, column: 21, scope: !87)
!99 = !DILocation(line: 74, column: 28, scope: !87)
!100 = distinct !{!100, !81, !101}
!101 = !DILocation(line: 75, column: 9, scope: !67)
!102 = !DILocation(line: 77, column: 13, scope: !103)
!103 = distinct !DILexicalBlock(scope: !67, file: !1, line: 77, column: 13)
!104 = !DILocation(line: 77, column: 13, scope: !67)
!105 = !DILocation(line: 78, column: 18, scope: !106)
!106 = distinct !DILexicalBlock(scope: !103, file: !1, line: 77, column: 19)
!107 = !DILocation(line: 80, column: 9, scope: !106)
!108 = !DILocation(line: 80, column: 20, scope: !109)
!109 = distinct !DILexicalBlock(scope: !103, file: !1, line: 80, column: 20)
!110 = !DILocation(line: 80, column: 20, scope: !103)
!111 = !DILocation(line: 81, column: 18, scope: !112)
!112 = distinct !DILexicalBlock(scope: !109, file: !1, line: 80, column: 27)
!113 = !DILocation(line: 83, column: 9, scope: !112)
!114 = !DILocation(line: 86, column: 22, scope: !67)
!115 = distinct !{!115, !65, !116}
!116 = !DILocation(line: 87, column: 5, scope: !7)
!117 = !DILocation(line: 90, column: 18, scope: !7)
!118 = !DILocation(line: 91, column: 10, scope: !7)
!119 = !DILocation(line: 91, column: 5, scope: !7)
!120 = !DILocation(line: 93, column: 5, scope: !7)
!121 = !DILocation(line: 95, column: 22, scope: !122)
!122 = distinct !DILexicalBlock(scope: !7, file: !1, line: 93, column: 18)
!123 = !DILocation(line: 96, column: 14, scope: !122)
!124 = !DILocation(line: 96, column: 9, scope: !122)
!125 = distinct !{!125, !120, !126}
!126 = !DILocation(line: 97, column: 5, scope: !7)
!127 = !DILocation(line: 99, column: 5, scope: !7)
!128 = !DILocation(line: 100, column: 1, scope: !7)
