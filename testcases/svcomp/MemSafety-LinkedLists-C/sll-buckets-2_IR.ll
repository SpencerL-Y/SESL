; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-6wbsaut7.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.TBCK = type { %struct.TBCK*, %struct.TSLL*, i32 }
%struct.TSLL = type { %struct.TSLL*, i32 }

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !9 {
  ret void, !dbg !13, !verifier.code !14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !15 {
  %1 = call noalias i8* @malloc(i64 24) #5, !dbg !19, !verifier.code !14
  %2 = bitcast i8* %1 to %struct.TBCK*, !dbg !19, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %2, metadata !20, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %3 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %2, i32 0, i32 2, !dbg !37, !verifier.code !14
  store i32 0, i32* %3, align 8, !dbg !38, !verifier.code !14
  %4 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %2, i32 0, i32 1, !dbg !39, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %4, align 8, !dbg !40, !verifier.code !14
  %5 = call noalias i8* @malloc(i64 24) #5, !dbg !41, !verifier.code !14
  %6 = bitcast i8* %5 to %struct.TBCK*, !dbg !41, !verifier.code !14
  %7 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %2, i32 0, i32 0, !dbg !42, !verifier.code !14
  store %struct.TBCK* %6, %struct.TBCK** %7, align 8, !dbg !43, !verifier.code !14
  %8 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %2, i32 0, i32 0, !dbg !44, !verifier.code !14
  %9 = load %struct.TBCK*, %struct.TBCK** %8, align 8, !dbg !44, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %9, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %10 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %9, i32 0, i32 2, !dbg !46, !verifier.code !14
  store i32 1, i32* %10, align 8, !dbg !47, !verifier.code !14
  %11 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %9, i32 0, i32 1, !dbg !48, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %11, align 8, !dbg !49, !verifier.code !14
  %12 = call noalias i8* @malloc(i64 24) #5, !dbg !50, !verifier.code !14
  %13 = bitcast i8* %12 to %struct.TBCK*, !dbg !50, !verifier.code !14
  %14 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %9, i32 0, i32 0, !dbg !51, !verifier.code !14
  store %struct.TBCK* %13, %struct.TBCK** %14, align 8, !dbg !52, !verifier.code !14
  %15 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %9, i32 0, i32 0, !dbg !53, !verifier.code !14
  %16 = load %struct.TBCK*, %struct.TBCK** %15, align 8, !dbg !53, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %16, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %17 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %16, i32 0, i32 2, !dbg !54, !verifier.code !14
  store i32 2, i32* %17, align 8, !dbg !55, !verifier.code !14
  %18 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %16, i32 0, i32 1, !dbg !56, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %18, align 8, !dbg !57, !verifier.code !14
  %19 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %16, i32 0, i32 0, !dbg !58, !verifier.code !14
  store %struct.TBCK* null, %struct.TBCK** %19, align 8, !dbg !59, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* null, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* null, metadata !61, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %20 = call i32 @__VERIFIER_nondet_int(), !dbg !62, !verifier.code !63
  %21 = icmp ne i32 %20, 0, !dbg !64, !verifier.code !14
  br i1 %21, label %.lr.ph20, label %89, !dbg !64, !verifier.code !14

.lr.ph20:                                         ; preds = %0
  br label %22, !dbg !64, !verifier.code !14

22:                                               ; preds = %.lr.ph20, %86
  %23 = call noalias i8* @malloc(i64 16) #5, !dbg !65, !verifier.code !14
  %24 = bitcast i8* %23 to %struct.TSLL*, !dbg !65, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %24, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %25 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %24, i32 0, i32 0, !dbg !67, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %25, align 8, !dbg !68, !verifier.code !14
  %26 = call i32 @__VERIFIER_nondet_int(), !dbg !69, !verifier.code !63
  %27 = icmp ne i32 %26, 0, !dbg !69, !verifier.code !14
  br i1 %27, label %28, label %30, !dbg !71, !verifier.code !14

28:                                               ; preds = %22
  %29 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %24, i32 0, i32 1, !dbg !72, !verifier.code !14
  store i32 0, i32* %29, align 8, !dbg !73, !verifier.code !14
  br label %38, !dbg !74, !verifier.code !14

30:                                               ; preds = %22
  %31 = call i32 @__VERIFIER_nondet_int(), !dbg !75, !verifier.code !63
  %32 = icmp ne i32 %31, 0, !dbg !75, !verifier.code !14
  br i1 %32, label %33, label %35, !dbg !77, !verifier.code !14

33:                                               ; preds = %30
  %34 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %24, i32 0, i32 1, !dbg !78, !verifier.code !14
  store i32 1, i32* %34, align 8, !dbg !79, !verifier.code !14
  br label %37, !dbg !80, !verifier.code !14

35:                                               ; preds = %30
  %36 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %24, i32 0, i32 1, !dbg !81, !verifier.code !14
  store i32 2, i32* %36, align 8, !dbg !82, !verifier.code !14
  br label %37, !verifier.code !14

37:                                               ; preds = %35, %33
  br label %38, !verifier.code !14

38:                                               ; preds = %37, %28
  call void @llvm.dbg.value(metadata %struct.TBCK* %2, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  br label %39, !dbg !83, !verifier.code !14

39:                                               ; preds = %38
  %40 = icmp ne %struct.TBCK* %2, null, !dbg !84, !verifier.code !14
  br i1 %40, label %42, label %41, !dbg !87, !verifier.code !14

41:                                               ; preds = %39
  call void @reach_error(), !dbg !88, !verifier.code !14
  call void @abort() #6, !dbg !88, !verifier.code !14
  unreachable, !dbg !88, !verifier.code !14

42:                                               ; preds = %39
  br label %43, !dbg !87, !verifier.code !14

43:                                               ; preds = %42
  br label %44, !dbg !90, !verifier.code !14

44:                                               ; preds = %43
  %45 = icmp ne %struct.TSLL* %24, null, !dbg !91, !verifier.code !14
  br i1 %45, label %47, label %46, !dbg !94, !verifier.code !14

46:                                               ; preds = %44
  call void @reach_error(), !dbg !95, !verifier.code !14
  call void @abort() #6, !dbg !95, !verifier.code !14
  unreachable, !dbg !95, !verifier.code !14

47:                                               ; preds = %44
  br label %48, !dbg !94, !verifier.code !14

48:                                               ; preds = %47
  call void @llvm.dbg.value(metadata %struct.TBCK* %2, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %49 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %2, i32 0, i32 2, !dbg !97, !verifier.code !14
  %50 = load i32, i32* %49, align 8, !dbg !97, !verifier.code !14
  %51 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %24, i32 0, i32 1, !dbg !98, !verifier.code !14
  %52 = load i32, i32* %51, align 8, !dbg !98, !verifier.code !14
  %53 = icmp ne i32 %50, %52, !dbg !99, !verifier.code !14
  br i1 %53, label %.lr.ph11, label %61, !dbg !100, !verifier.code !14

.lr.ph11:                                         ; preds = %48
  br label %54, !dbg !100, !verifier.code !14

54:                                               ; preds = %forwarder23, %.lr.ph11
  %.019 = phi %struct.TBCK* [ %2, %.lr.ph11 ], [ %56, %forwarder23 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %.019, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %55 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.019, i32 0, i32 0, !dbg !101, !verifier.code !14
  %56 = load %struct.TBCK*, %struct.TBCK** %55, align 8, !dbg !101, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %56, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %57 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %56, i32 0, i32 2, !dbg !97, !verifier.code !14
  %58 = load i32, i32* %57, align 8, !dbg !97, !verifier.code !14
  %59 = load i32, i32* %51, align 8, !dbg !98, !verifier.code !14
  %60 = icmp ne i32 %58, %59, !dbg !99, !verifier.code !14
  br i1 %60, label %forwarder23, label %._crit_edge12, !dbg !100, !llvm.loop !102, !verifier.code !14

._crit_edge12:                                    ; preds = %54
  %split13 = phi %struct.TBCK* [ %56, %54 ], !verifier.code !14
  br label %61, !dbg !100, !verifier.code !14

61:                                               ; preds = %._crit_edge12, %48
  %.01.lcssa = phi %struct.TBCK* [ %split13, %._crit_edge12 ], [ %2, %48 ], !dbg !103, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %.01.lcssa, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  br label %62, !dbg !104, !verifier.code !14

62:                                               ; preds = %61
  %63 = icmp ne %struct.TBCK* %.01.lcssa, null, !dbg !105, !verifier.code !14
  br i1 %63, label %65, label %64, !dbg !108, !verifier.code !14

64:                                               ; preds = %62
  call void @reach_error(), !dbg !109, !verifier.code !14
  call void @abort() #6, !dbg !109, !verifier.code !14
  unreachable, !dbg !109, !verifier.code !14

65:                                               ; preds = %62
  br label %66, !dbg !108, !verifier.code !14

66:                                               ; preds = %65
  %67 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.01.lcssa, i32 0, i32 1, !dbg !111, !verifier.code !14
  %68 = load %struct.TSLL*, %struct.TSLL** %67, align 8, !dbg !111, !verifier.code !14
  %69 = icmp eq %struct.TSLL* %68, null, !dbg !113, !verifier.code !14
  br i1 %69, label %70, label %72, !dbg !114, !verifier.code !14

70:                                               ; preds = %66
  %71 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.01.lcssa, i32 0, i32 1, !dbg !115, !verifier.code !14
  store %struct.TSLL* %24, %struct.TSLL** %71, align 8, !dbg !116, !verifier.code !14
  br label %86, !dbg !117, !verifier.code !14

72:                                               ; preds = %66
  %73 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.01.lcssa, i32 0, i32 1, !dbg !118, !verifier.code !14
  %74 = load %struct.TSLL*, %struct.TSLL** %73, align 8, !dbg !118, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %74, metadata !61, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %75 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %74, i32 0, i32 0, !dbg !120, !verifier.code !14
  %76 = load %struct.TSLL*, %struct.TSLL** %75, align 8, !dbg !120, !verifier.code !14
  %77 = icmp ne %struct.TSLL* %76, null, !dbg !121, !verifier.code !14
  br i1 %77, label %.lr.ph16, label %84, !dbg !122, !verifier.code !14

.lr.ph16:                                         ; preds = %72
  br label %78, !dbg !122, !verifier.code !14

78:                                               ; preds = %forwarder24, %.lr.ph16
  %.014 = phi %struct.TSLL* [ %74, %.lr.ph16 ], [ %80, %forwarder24 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.014, metadata !61, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %79 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.014, i32 0, i32 0, !dbg !123, !verifier.code !14
  %80 = load %struct.TSLL*, %struct.TSLL** %79, align 8, !dbg !123, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %80, metadata !61, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %81 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %80, i32 0, i32 0, !dbg !120, !verifier.code !14
  %82 = load %struct.TSLL*, %struct.TSLL** %81, align 8, !dbg !120, !verifier.code !14
  %83 = icmp ne %struct.TSLL* %82, null, !dbg !121, !verifier.code !14
  br i1 %83, label %forwarder24, label %._crit_edge17, !dbg !122, !llvm.loop !124, !verifier.code !14

._crit_edge17:                                    ; preds = %78
  %split18 = phi %struct.TSLL* [ %80, %78 ], !verifier.code !14
  br label %84, !dbg !122, !verifier.code !14

84:                                               ; preds = %._crit_edge17, %72
  %.0.lcssa = phi %struct.TSLL* [ %split18, %._crit_edge17 ], [ %74, %72 ], !dbg !125, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.0.lcssa, metadata !61, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %85 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.0.lcssa, i32 0, i32 0, !dbg !126, !verifier.code !14
  store %struct.TSLL* %24, %struct.TSLL** %85, align 8, !dbg !127, !verifier.code !14
  br label %86, !verifier.code !14

86:                                               ; preds = %84, %70
  %87 = call i32 @__VERIFIER_nondet_int(), !dbg !62, !verifier.code !63
  %88 = icmp ne i32 %87, 0, !dbg !64, !verifier.code !14
  br i1 %88, label %22, label %._crit_edge21, !dbg !64, !llvm.loop !128, !verifier.code !14

._crit_edge21:                                    ; preds = %86
  br label %89, !dbg !64, !verifier.code !14

89:                                               ; preds = %._crit_edge21, %0
  call void @llvm.dbg.value(metadata %struct.TBCK* %2, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %90 = icmp ne %struct.TBCK* %2, null, !dbg !130, !verifier.code !14
  br i1 %90, label %.lr.ph7, label %120, !dbg !131, !verifier.code !14

.lr.ph7:                                          ; preds = %89
  br label %91, !dbg !131, !verifier.code !14

91:                                               ; preds = %forwarder, %.lr.ph7
  %.15 = phi %struct.TBCK* [ %2, %.lr.ph7 ], [ %117, %forwarder ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %.15, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %92 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.15, i32 0, i32 1, !dbg !132, !verifier.code !14
  %93 = load %struct.TSLL*, %struct.TSLL** %92, align 8, !dbg !132, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %93, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %94 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.15, i32 0, i32 1, !dbg !134, !verifier.code !14
  store %struct.TSLL* null, %struct.TSLL** %94, align 8, !dbg !135, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %93, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %95 = icmp ne %struct.TSLL* %93, null, !dbg !136, !verifier.code !14
  br i1 %95, label %.lr.ph, label %110, !dbg !137, !verifier.code !14

.lr.ph:                                           ; preds = %91
  br label %96, !dbg !137, !verifier.code !14

96:                                               ; preds = %forwarder22, %.lr.ph
  %.024 = phi %struct.TSLL* [ %93, %.lr.ph ], [ %98, %forwarder22 ], !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.024, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.024, metadata !61, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %97 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.024, i32 0, i32 0, !dbg !138, !verifier.code !14
  %98 = load %struct.TSLL*, %struct.TSLL** %97, align 8, !dbg !138, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %98, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  br label %99, !dbg !140, !verifier.code !14

99:                                               ; preds = %96
  %100 = getelementptr inbounds %struct.TSLL, %struct.TSLL* %.024, i32 0, i32 1, !dbg !141, !verifier.code !14
  %101 = load i32, i32* %100, align 8, !dbg !141, !verifier.code !14
  %102 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.15, i32 0, i32 2, !dbg !141, !verifier.code !14
  %103 = load i32, i32* %102, align 8, !dbg !141, !verifier.code !14
  %104 = icmp ne i32 %101, %103, !dbg !141, !verifier.code !14
  br i1 %104, label %106, label %105, !dbg !144, !verifier.code !14

105:                                              ; preds = %99
  call void @reach_error(), !dbg !145, !verifier.code !14
  call void @abort() #6, !dbg !145, !verifier.code !14
  unreachable, !dbg !145, !verifier.code !14

106:                                              ; preds = %99
  br label %107, !dbg !144, !verifier.code !14

107:                                              ; preds = %106
  %108 = bitcast %struct.TSLL* %.024 to i8*, !dbg !147, !verifier.code !14
  call void @free(i8* %108) #5, !dbg !148, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %98, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %109 = icmp ne %struct.TSLL* %98, null, !dbg !136, !verifier.code !14
  br i1 %109, label %forwarder22, label %._crit_edge, !dbg !137, !llvm.loop !149, !verifier.code !14

._crit_edge:                                      ; preds = %107
  %split = phi %struct.TSLL* [ %98, %107 ], !verifier.code !14
  br label %110, !dbg !137, !verifier.code !14

110:                                              ; preds = %._crit_edge, %91
  %.02.lcssa = phi %struct.TSLL* [ %split, %._crit_edge ], [ %93, %91 ], !dbg !151, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TSLL* %.02.lcssa, metadata !60, metadata !DIExpression()), !dbg !36, !verifier.code !14
  br label %111, !dbg !152, !verifier.code !14

111:                                              ; preds = %110
  %112 = icmp eq %struct.TSLL* %.02.lcssa, null, !dbg !153, !verifier.code !14
  br i1 %112, label %114, label %113, !dbg !156, !verifier.code !14

113:                                              ; preds = %111
  call void @reach_error(), !dbg !157, !verifier.code !14
  call void @abort() #6, !dbg !157, !verifier.code !14
  unreachable, !dbg !157, !verifier.code !14

114:                                              ; preds = %111
  br label %115, !dbg !156, !verifier.code !14

115:                                              ; preds = %114
  call void @llvm.dbg.value(metadata %struct.TBCK* %.15, metadata !20, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %116 = getelementptr inbounds %struct.TBCK, %struct.TBCK* %.15, i32 0, i32 0, !dbg !159, !verifier.code !14
  %117 = load %struct.TBCK*, %struct.TBCK** %116, align 8, !dbg !159, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* %117, metadata !45, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %118 = bitcast %struct.TBCK* %.15 to i8*, !dbg !160, !verifier.code !14
  call void @free(i8* %118) #5, !dbg !161, !verifier.code !14
  call void @llvm.dbg.value(metadata %struct.TBCK* null, metadata !20, metadata !DIExpression()), !dbg !36, !verifier.code !14
  %119 = icmp ne %struct.TBCK* %117, null, !dbg !130, !verifier.code !14
  br i1 %119, label %forwarder, label %._crit_edge8, !dbg !131, !llvm.loop !162, !verifier.code !14

._crit_edge8:                                     ; preds = %115
  br label %120, !dbg !131, !verifier.code !14

120:                                              ; preds = %._crit_edge8, %89
  ret i32 0, !dbg !164, !verifier.code !14

forwarder:                                        ; preds = %115
  br label %91, !verifier.code !14

forwarder22:                                      ; preds = %107
  br label %96, !verifier.code !14

forwarder23:                                      ; preds = %54
  br label %54, !verifier.code !14

forwarder24:                                      ; preds = %78
  br label %78, !verifier.code !14
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
!1 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/sll-buckets-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{!"clang version 10.0.0-4ubuntu1 "}
!6 = !{i32 7, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "reach_error", scope: !10, file: !10, line: 13, type: !11, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//sll-buckets-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!11 = !DISubroutineType(types: !12)
!12 = !{null}
!13 = !DILocation(line: 13, column: 20, scope: !9)
!14 = !{i1 false}
!15 = distinct !DISubprogram(name: "main", scope: !10, file: !10, line: 29, type: !16, scopeLine: 30, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocation(line: 32, column: 16, scope: !15)
!20 = !DILocalVariable(name: "bucket", scope: !15, file: !10, line: 32, type: !21)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "BCK", file: !10, line: 27, baseType: !23)
!23 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TBCK", file: !10, line: 22, size: 192, elements: !24)
!24 = !{!25, !27, !35}
!25 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !23, file: !10, line: 24, baseType: !26, size: 64)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "list", scope: !23, file: !10, line: 25, baseType: !28, size: 64, offset: 64)
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_typedef, name: "SLL", file: !10, line: 19, baseType: !30)
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "TSLL", file: !10, line: 15, size: 128, elements: !31)
!31 = !{!32, !34}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !30, file: !10, line: 17, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !30, file: !10, line: 18, baseType: !18, size: 32, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !23, file: !10, line: 26, baseType: !18, size: 32, offset: 128)
!36 = !DILocation(line: 0, scope: !15)
!37 = !DILocation(line: 33, column: 10, scope: !15)
!38 = !DILocation(line: 33, column: 15, scope: !15)
!39 = !DILocation(line: 34, column: 10, scope: !15)
!40 = !DILocation(line: 34, column: 15, scope: !15)
!41 = !DILocation(line: 36, column: 17, scope: !15)
!42 = !DILocation(line: 36, column: 10, scope: !15)
!43 = !DILocation(line: 36, column: 15, scope: !15)
!44 = !DILocation(line: 37, column: 22, scope: !15)
!45 = !DILocalVariable(name: "bcki", scope: !15, file: !10, line: 37, type: !21)
!46 = !DILocation(line: 38, column: 8, scope: !15)
!47 = !DILocation(line: 38, column: 13, scope: !15)
!48 = !DILocation(line: 39, column: 8, scope: !15)
!49 = !DILocation(line: 39, column: 13, scope: !15)
!50 = !DILocation(line: 41, column: 15, scope: !15)
!51 = !DILocation(line: 41, column: 8, scope: !15)
!52 = !DILocation(line: 41, column: 13, scope: !15)
!53 = !DILocation(line: 42, column: 15, scope: !15)
!54 = !DILocation(line: 43, column: 8, scope: !15)
!55 = !DILocation(line: 43, column: 13, scope: !15)
!56 = !DILocation(line: 44, column: 8, scope: !15)
!57 = !DILocation(line: 44, column: 13, scope: !15)
!58 = !DILocation(line: 45, column: 8, scope: !15)
!59 = !DILocation(line: 45, column: 13, scope: !15)
!60 = !DILocalVariable(name: "item", scope: !15, file: !10, line: 47, type: !33)
!61 = !DILocalVariable(name: "itr", scope: !15, file: !10, line: 48, type: !33)
!62 = !DILocation(line: 49, column: 9, scope: !15)
!63 = !{i1 true}
!64 = !DILocation(line: 49, column: 2, scope: !15)
!65 = !DILocation(line: 51, column: 10, scope: !66)
!66 = distinct !DILexicalBlock(scope: !15, file: !10, line: 50, column: 2)
!67 = !DILocation(line: 52, column: 9, scope: !66)
!68 = !DILocation(line: 52, column: 14, scope: !66)
!69 = !DILocation(line: 53, column: 7, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !10, line: 53, column: 7)
!71 = !DILocation(line: 53, column: 7, scope: !66)
!72 = !DILocation(line: 54, column: 10, scope: !70)
!73 = !DILocation(line: 54, column: 15, scope: !70)
!74 = !DILocation(line: 54, column: 4, scope: !70)
!75 = !DILocation(line: 55, column: 12, scope: !76)
!76 = distinct !DILexicalBlock(scope: !70, file: !10, line: 55, column: 12)
!77 = !DILocation(line: 55, column: 12, scope: !70)
!78 = !DILocation(line: 56, column: 10, scope: !76)
!79 = !DILocation(line: 56, column: 15, scope: !76)
!80 = !DILocation(line: 56, column: 4, scope: !76)
!81 = !DILocation(line: 58, column: 10, scope: !76)
!82 = !DILocation(line: 58, column: 15, scope: !76)
!83 = !DILocation(line: 62, column: 3, scope: !66)
!84 = !DILocation(line: 62, column: 3, scope: !85)
!85 = distinct !DILexicalBlock(scope: !86, file: !10, line: 62, column: 3)
!86 = distinct !DILexicalBlock(scope: !66, file: !10, line: 62, column: 3)
!87 = !DILocation(line: 62, column: 3, scope: !86)
!88 = !DILocation(line: 62, column: 3, scope: !89)
!89 = distinct !DILexicalBlock(scope: !85, file: !10, line: 62, column: 3)
!90 = !DILocation(line: 63, column: 3, scope: !66)
!91 = !DILocation(line: 63, column: 3, scope: !92)
!92 = distinct !DILexicalBlock(scope: !93, file: !10, line: 63, column: 3)
!93 = distinct !DILexicalBlock(scope: !66, file: !10, line: 63, column: 3)
!94 = !DILocation(line: 63, column: 3, scope: !93)
!95 = !DILocation(line: 63, column: 3, scope: !96)
!96 = distinct !DILexicalBlock(scope: !92, file: !10, line: 63, column: 3)
!97 = !DILocation(line: 64, column: 16, scope: !66)
!98 = !DILocation(line: 64, column: 30, scope: !66)
!99 = !DILocation(line: 64, column: 21, scope: !66)
!100 = !DILocation(line: 64, column: 3, scope: !66)
!101 = !DILocation(line: 65, column: 17, scope: !66)
!102 = distinct !{!102, !100, !101}
!103 = !DILocation(line: 0, scope: !66)
!104 = !DILocation(line: 66, column: 3, scope: !66)
!105 = !DILocation(line: 66, column: 3, scope: !106)
!106 = distinct !DILexicalBlock(scope: !107, file: !10, line: 66, column: 3)
!107 = distinct !DILexicalBlock(scope: !66, file: !10, line: 66, column: 3)
!108 = !DILocation(line: 66, column: 3, scope: !107)
!109 = !DILocation(line: 66, column: 3, scope: !110)
!110 = distinct !DILexicalBlock(scope: !106, file: !10, line: 66, column: 3)
!111 = !DILocation(line: 68, column: 13, scope: !112)
!112 = distinct !DILexicalBlock(scope: !66, file: !10, line: 68, column: 7)
!113 = !DILocation(line: 68, column: 18, scope: !112)
!114 = !DILocation(line: 68, column: 7, scope: !66)
!115 = !DILocation(line: 69, column: 10, scope: !112)
!116 = !DILocation(line: 69, column: 15, scope: !112)
!117 = !DILocation(line: 69, column: 4, scope: !112)
!118 = !DILocation(line: 72, column: 16, scope: !119)
!119 = distinct !DILexicalBlock(scope: !112, file: !10, line: 71, column: 3)
!120 = !DILocation(line: 73, column: 16, scope: !119)
!121 = !DILocation(line: 73, column: 21, scope: !119)
!122 = !DILocation(line: 73, column: 4, scope: !119)
!123 = !DILocation(line: 74, column: 16, scope: !119)
!124 = distinct !{!124, !122, !123}
!125 = !DILocation(line: 0, scope: !119)
!126 = !DILocation(line: 75, column: 9, scope: !119)
!127 = !DILocation(line: 75, column: 14, scope: !119)
!128 = distinct !{!128, !64, !129}
!129 = !DILocation(line: 77, column: 2, scope: !15)
!130 = !DILocation(line: 81, column: 13, scope: !15)
!131 = !DILocation(line: 81, column: 2, scope: !15)
!132 = !DILocation(line: 83, column: 16, scope: !133)
!133 = distinct !DILexicalBlock(scope: !15, file: !10, line: 82, column: 2)
!134 = !DILocation(line: 84, column: 9, scope: !133)
!135 = !DILocation(line: 84, column: 14, scope: !133)
!136 = !DILocation(line: 85, column: 14, scope: !133)
!137 = !DILocation(line: 85, column: 3, scope: !133)
!138 = !DILocation(line: 88, column: 17, scope: !139)
!139 = distinct !DILexicalBlock(scope: !133, file: !10, line: 86, column: 3)
!140 = !DILocation(line: 89, column: 4, scope: !139)
!141 = !DILocation(line: 89, column: 4, scope: !142)
!142 = distinct !DILexicalBlock(scope: !143, file: !10, line: 89, column: 4)
!143 = distinct !DILexicalBlock(scope: !139, file: !10, line: 89, column: 4)
!144 = !DILocation(line: 89, column: 4, scope: !143)
!145 = !DILocation(line: 89, column: 4, scope: !146)
!146 = distinct !DILexicalBlock(scope: !142, file: !10, line: 89, column: 4)
!147 = !DILocation(line: 90, column: 9, scope: !139)
!148 = !DILocation(line: 90, column: 4, scope: !139)
!149 = distinct !{!149, !137, !150}
!150 = !DILocation(line: 91, column: 3, scope: !133)
!151 = !DILocation(line: 0, scope: !133)
!152 = !DILocation(line: 92, column: 3, scope: !133)
!153 = !DILocation(line: 92, column: 3, scope: !154)
!154 = distinct !DILexicalBlock(scope: !155, file: !10, line: 92, column: 3)
!155 = distinct !DILexicalBlock(scope: !133, file: !10, line: 92, column: 3)
!156 = !DILocation(line: 92, column: 3, scope: !155)
!157 = !DILocation(line: 92, column: 3, scope: !158)
!158 = distinct !DILexicalBlock(scope: !154, file: !10, line: 92, column: 3)
!159 = !DILocation(line: 94, column: 16, scope: !133)
!160 = !DILocation(line: 95, column: 8, scope: !133)
!161 = !DILocation(line: 95, column: 3, scope: !133)
!162 = distinct !{!162, !131, !163}
!163 = !DILocation(line: 97, column: 2, scope: !15)
!164 = !DILocation(line: 99, column: 2, scope: !15)
