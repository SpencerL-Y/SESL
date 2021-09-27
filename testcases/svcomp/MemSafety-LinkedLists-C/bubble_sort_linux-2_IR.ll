; ModuleID = '/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark/b-1uzbyr3j.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.list_head = type { %struct.list_head*, %struct.list_head* }
%struct.node = type { i32, %struct.list_head, %struct.list_head }

@gl_list = internal global %struct.list_head { %struct.list_head* @gl_list, %struct.list_head* @gl_list }, align 8, !dbg !0

; Function Attrs: noinline nounwind uwtable
define internal void @reach_error() #0 !dbg !29 {
  ret void, !dbg !32, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !34 {
  call void @gl_read(), !dbg !37, !verifier.code !33
  call void @inspect(%struct.list_head* @gl_list), !dbg !38, !verifier.code !33
  call void @gl_sort(), !dbg !39, !verifier.code !33
  call void @inspect(%struct.list_head* @gl_list), !dbg !40, !verifier.code !33
  call void @gl_destroy(), !dbg !41, !verifier.code !33
  ret i32 0, !dbg !42, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_read() #0 !dbg !43 {
  br label %1, !dbg !44, !verifier.code !33

1:                                                ; preds = %3, %0
  %2 = call i32 @__VERIFIER_nondet_int(), !dbg !45, !verifier.code !47
  call void @gl_insert(i32 %2), !dbg !48, !verifier.code !33
  br label %3, !dbg !49, !verifier.code !33

3:                                                ; preds = %1
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !50, !verifier.code !47
  %5 = icmp ne i32 %4, 0, !dbg !49, !verifier.code !33
  br i1 %5, label %1, label %6, !dbg !49, !llvm.loop !51, !verifier.code !33

6:                                                ; preds = %3
  ret void, !dbg !53, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @inspect(%struct.list_head* %0) #0 !dbg !54 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !33
  br label %2, !dbg !61, !verifier.code !33

2:                                                ; preds = %1
  %3 = icmp ne %struct.list_head* %0, null, !dbg !62, !verifier.code !33
  br i1 %3, label %5, label %4, !dbg !65, !verifier.code !33

4:                                                ; preds = %2
  call void @fail(), !dbg !62, !verifier.code !33
  br label %5, !dbg !62, !verifier.code !33

5:                                                ; preds = %4, %2
  br label %6, !dbg !65, !verifier.code !33

6:                                                ; preds = %5
  br label %7, !dbg !66, !verifier.code !33

7:                                                ; preds = %6
  %8 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !67, !verifier.code !33
  %9 = load %struct.list_head*, %struct.list_head** %8, align 8, !dbg !67, !verifier.code !33
  %10 = icmp ne %struct.list_head* %9, %0, !dbg !67, !verifier.code !33
  br i1 %10, label %12, label %11, !dbg !70, !verifier.code !33

11:                                               ; preds = %7
  call void @fail(), !dbg !67, !verifier.code !33
  br label %12, !dbg !67, !verifier.code !33

12:                                               ; preds = %11, %7
  br label %13, !dbg !70, !verifier.code !33

13:                                               ; preds = %12
  br label %14, !dbg !71, !verifier.code !33

14:                                               ; preds = %13
  %15 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !72, !verifier.code !33
  %16 = load %struct.list_head*, %struct.list_head** %15, align 8, !dbg !72, !verifier.code !33
  %17 = icmp ne %struct.list_head* %16, %0, !dbg !72, !verifier.code !33
  br i1 %17, label %19, label %18, !dbg !75, !verifier.code !33

18:                                               ; preds = %14
  call void @fail(), !dbg !72, !verifier.code !33
  br label %19, !dbg !72, !verifier.code !33

19:                                               ; preds = %18, %14
  br label %20, !dbg !75, !verifier.code !33

20:                                               ; preds = %19
  %21 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !76, !verifier.code !33
  %22 = load %struct.list_head*, %struct.list_head** %21, align 8, !dbg !76, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %22, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !33
  br label %23, !dbg !77, !verifier.code !33

23:                                               ; preds = %20
  %24 = icmp ne %struct.list_head* %22, null, !dbg !78, !verifier.code !33
  br i1 %24, label %26, label %25, !dbg !81, !verifier.code !33

25:                                               ; preds = %23
  call void @fail(), !dbg !78, !verifier.code !33
  br label %26, !dbg !78, !verifier.code !33

26:                                               ; preds = %25, %23
  br label %27, !dbg !81, !verifier.code !33

27:                                               ; preds = %26
  br label %28, !dbg !82, !verifier.code !33

28:                                               ; preds = %27
  %29 = getelementptr inbounds %struct.list_head, %struct.list_head* %22, i32 0, i32 0, !dbg !83, !verifier.code !33
  %30 = load %struct.list_head*, %struct.list_head** %29, align 8, !dbg !83, !verifier.code !33
  %31 = icmp ne %struct.list_head* %30, %22, !dbg !83, !verifier.code !33
  br i1 %31, label %33, label %32, !dbg !86, !verifier.code !33

32:                                               ; preds = %28
  call void @fail(), !dbg !83, !verifier.code !33
  br label %33, !dbg !83, !verifier.code !33

33:                                               ; preds = %32, %28
  br label %34, !dbg !86, !verifier.code !33

34:                                               ; preds = %33
  br label %35, !dbg !87, !verifier.code !33

35:                                               ; preds = %34
  %36 = getelementptr inbounds %struct.list_head, %struct.list_head* %22, i32 0, i32 1, !dbg !88, !verifier.code !33
  %37 = load %struct.list_head*, %struct.list_head** %36, align 8, !dbg !88, !verifier.code !33
  %38 = icmp ne %struct.list_head* %37, %22, !dbg !88, !verifier.code !33
  br i1 %38, label %40, label %39, !dbg !91, !verifier.code !33

39:                                               ; preds = %35
  call void @fail(), !dbg !88, !verifier.code !33
  br label %40, !dbg !88, !verifier.code !33

40:                                               ; preds = %39, %35
  br label %41, !dbg !91, !verifier.code !33

41:                                               ; preds = %40
  %42 = bitcast %struct.list_head* %22 to i8*, !dbg !92, !verifier.code !33
  %43 = getelementptr inbounds i8, i8* %42, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !92, !verifier.code !33
  %44 = bitcast i8* %43 to %struct.node*, !dbg !92, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.node* %44, metadata !93, metadata !DIExpression()), !dbg !60, !verifier.code !33
  br label %45, !dbg !94, !verifier.code !33

45:                                               ; preds = %41
  %46 = icmp ne %struct.node* %44, null, !dbg !95, !verifier.code !33
  br i1 %46, label %48, label %47, !dbg !98, !verifier.code !33

47:                                               ; preds = %45
  call void @fail(), !dbg !95, !verifier.code !33
  br label %48, !dbg !95, !verifier.code !33

48:                                               ; preds = %47, %45
  br label %49, !dbg !98, !verifier.code !33

49:                                               ; preds = %48
  br label %50, !dbg !99, !verifier.code !33

50:                                               ; preds = %49
  %51 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, !dbg !100, !verifier.code !33
  %52 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, i32 0
  %53 = load %struct.list_head*, %struct.list_head** %52, align 8, !dbg !100, !verifier.code !33
  %54 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, !dbg !100, !verifier.code !33
  %55 = icmp eq %struct.list_head* %53, %54, !dbg !100, !verifier.code !33
  br i1 %55, label %57, label %56, !dbg !103, !verifier.code !33

56:                                               ; preds = %50
  call void @fail(), !dbg !100, !verifier.code !33
  br label %57, !dbg !100, !verifier.code !33

57:                                               ; preds = %56, %50
  br label %58, !dbg !103, !verifier.code !33

58:                                               ; preds = %57
  br label %59, !dbg !104, !verifier.code !33

59:                                               ; preds = %58
  %60 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, !dbg !105, !verifier.code !33
  %61 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, i32 1
  %62 = load %struct.list_head*, %struct.list_head** %61, align 8, !dbg !105, !verifier.code !33
  %63 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, !dbg !105, !verifier.code !33
  %64 = icmp eq %struct.list_head* %62, %63, !dbg !105, !verifier.code !33
  br i1 %64, label %66, label %65, !dbg !108, !verifier.code !33

65:                                               ; preds = %59
  call void @fail(), !dbg !105, !verifier.code !33
  br label %66, !dbg !105, !verifier.code !33

66:                                               ; preds = %65, %59
  br label %67, !dbg !108, !verifier.code !33

67:                                               ; preds = %66
  br label %68, !dbg !109, !verifier.code !33

68:                                               ; preds = %67
  %69 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, !dbg !110, !verifier.code !33
  %70 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, i32 0
  %71 = load %struct.list_head*, %struct.list_head** %70, align 8, !dbg !110, !verifier.code !33
  %72 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, !dbg !110, !verifier.code !33
  %73 = icmp ne %struct.list_head* %71, %72, !dbg !110, !verifier.code !33
  br i1 %73, label %75, label %74, !dbg !113, !verifier.code !33

74:                                               ; preds = %68
  call void @fail(), !dbg !110, !verifier.code !33
  br label %75, !dbg !110, !verifier.code !33

75:                                               ; preds = %74, %68
  br label %76, !dbg !113, !verifier.code !33

76:                                               ; preds = %75
  br label %77, !dbg !114, !verifier.code !33

77:                                               ; preds = %76
  %78 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, !dbg !115, !verifier.code !33
  %79 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 2, i32 1
  %80 = load %struct.list_head*, %struct.list_head** %79, align 8, !dbg !115, !verifier.code !33
  %81 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, !dbg !115, !verifier.code !33
  %82 = icmp ne %struct.list_head* %80, %81, !dbg !115, !verifier.code !33
  br i1 %82, label %84, label %83, !dbg !118, !verifier.code !33

83:                                               ; preds = %77
  call void @fail(), !dbg !115, !verifier.code !33
  br label %84, !dbg !115, !verifier.code !33

84:                                               ; preds = %83, %77
  br label %85, !dbg !118, !verifier.code !33

85:                                               ; preds = %84
  br label %86, !dbg !119, !verifier.code !33

86:                                               ; preds = %85
  %87 = bitcast %struct.list_head* %22 to %struct.node*, !dbg !120, !verifier.code !33
  %88 = icmp ne %struct.node* %44, %87, !dbg !120, !verifier.code !33
  br i1 %88, label %90, label %89, !dbg !123, !verifier.code !33

89:                                               ; preds = %86
  call void @fail(), !dbg !120, !verifier.code !33
  br label %90, !dbg !120, !verifier.code !33

90:                                               ; preds = %89, %86
  br label %91, !dbg !123, !verifier.code !33

91:                                               ; preds = %90
  br label %92, !dbg !124, !verifier.code !33

92:                                               ; preds = %91
  %93 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, !dbg !125, !verifier.code !33
  %94 = bitcast %struct.list_head* %93 to %struct.node*, !dbg !125, !verifier.code !33
  %95 = icmp ne %struct.node* %44, %94, !dbg !125, !verifier.code !33
  br i1 %95, label %97, label %96, !dbg !128, !verifier.code !33

96:                                               ; preds = %92
  call void @fail(), !dbg !125, !verifier.code !33
  br label %97, !dbg !125, !verifier.code !33

97:                                               ; preds = %96, %92
  br label %98, !dbg !128, !verifier.code !33

98:                                               ; preds = %97
  br label %99, !dbg !129, !verifier.code !33

99:                                               ; preds = %98
  %100 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 0, !dbg !130, !verifier.code !33
  %101 = bitcast i32* %100 to %struct.node*, !dbg !130, !verifier.code !33
  %102 = icmp eq %struct.node* %44, %101, !dbg !130, !verifier.code !33
  br i1 %102, label %104, label %103, !dbg !133, !verifier.code !33

103:                                              ; preds = %99
  call void @fail(), !dbg !130, !verifier.code !33
  br label %104, !dbg !130, !verifier.code !33

104:                                              ; preds = %103, %99
  br label %105, !dbg !133, !verifier.code !33

105:                                              ; preds = %104
  br label %106, !dbg !134, !verifier.code !33

106:                                              ; preds = %105
  %107 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, !dbg !135, !verifier.code !33
  %108 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, i32 0
  %109 = load %struct.list_head*, %struct.list_head** %108, align 8, !dbg !135, !verifier.code !33
  %110 = getelementptr inbounds %struct.list_head, %struct.list_head* %109, i32 0, i32 1, !dbg !135, !verifier.code !33
  %111 = load %struct.list_head*, %struct.list_head** %110, align 8, !dbg !135, !verifier.code !33
  %112 = icmp eq %struct.list_head* %22, %111, !dbg !135, !verifier.code !33
  br i1 %112, label %114, label %113, !dbg !138, !verifier.code !33

113:                                              ; preds = %106
  call void @fail(), !dbg !135, !verifier.code !33
  br label %114, !dbg !135, !verifier.code !33

114:                                              ; preds = %113, %106
  br label %115, !dbg !138, !verifier.code !33

115:                                              ; preds = %114
  br label %116, !dbg !139, !verifier.code !33

116:                                              ; preds = %115
  %117 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, !dbg !140, !verifier.code !33
  %118 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, i32 1
  %119 = load %struct.list_head*, %struct.list_head** %118, align 8, !dbg !140, !verifier.code !33
  %120 = getelementptr inbounds %struct.list_head, %struct.list_head* %119, i32 0, i32 0, !dbg !140, !verifier.code !33
  %121 = load %struct.list_head*, %struct.list_head** %120, align 8, !dbg !140, !verifier.code !33
  %122 = icmp eq %struct.list_head* %22, %121, !dbg !140, !verifier.code !33
  br i1 %122, label %124, label %123, !dbg !143, !verifier.code !33

123:                                              ; preds = %116
  call void @fail(), !dbg !140, !verifier.code !33
  br label %124, !dbg !140, !verifier.code !33

124:                                              ; preds = %123, %116
  br label %125, !dbg !143, !verifier.code !33

125:                                              ; preds = %124
  %126 = getelementptr inbounds %struct.list_head, %struct.list_head* %22, i32 0, i32 0, !dbg !144, !verifier.code !33
  %127 = load %struct.list_head*, %struct.list_head** %126, align 8, !dbg !144, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %127, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !33
  %128 = getelementptr inbounds %struct.node, %struct.node* %44, i32 0, i32 1, !dbg !146, !verifier.code !33
  %129 = icmp ne %struct.list_head* %128, %127, !dbg !148, !verifier.code !33
  br i1 %129, label %.lr.ph, label %135, !dbg !149, !verifier.code !33

.lr.ph:                                           ; preds = %125
  br label %130, !dbg !149, !verifier.code !33

130:                                              ; preds = %forwarder, %.lr.ph
  %.01 = phi %struct.list_head* [ %127, %.lr.ph ], [ %133, %forwarder ], !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %.01, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !33
  br label %131, !dbg !149, !verifier.code !33

131:                                              ; preds = %130
  %132 = getelementptr inbounds %struct.list_head, %struct.list_head* %.01, i32 0, i32 0, !dbg !150, !verifier.code !33
  %133 = load %struct.list_head*, %struct.list_head** %132, align 8, !dbg !150, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %133, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !33
  %134 = icmp ne %struct.list_head* %128, %133, !dbg !148, !verifier.code !33
  br i1 %134, label %forwarder, label %._crit_edge, !dbg !149, !llvm.loop !151, !verifier.code !33

._crit_edge:                                      ; preds = %131
  %split = phi %struct.list_head* [ %133, %131 ], !verifier.code !33
  br label %135, !dbg !149, !verifier.code !33

135:                                              ; preds = %._crit_edge, %125
  %.0.lcssa = phi %struct.list_head* [ %split, %._crit_edge ], [ %127, %125 ], !dbg !153, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %.0.lcssa, metadata !59, metadata !DIExpression()), !dbg !60, !verifier.code !33
  br label %136, !dbg !154, !verifier.code !33

136:                                              ; preds = %135
  %137 = bitcast %struct.list_head* %.0.lcssa to i8*, !dbg !155, !verifier.code !33
  %138 = getelementptr inbounds i8, i8* %137, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !155, !verifier.code !33
  %139 = bitcast i8* %138 to %struct.node*, !dbg !155, !verifier.code !33
  %140 = icmp eq %struct.node* %139, %44, !dbg !155, !verifier.code !33
  br i1 %140, label %142, label %141, !dbg !158, !verifier.code !33

141:                                              ; preds = %136
  call void @fail(), !dbg !155, !verifier.code !33
  br label %142, !dbg !155, !verifier.code !33

142:                                              ; preds = %141, %136
  br label %143, !dbg !158, !verifier.code !33

143:                                              ; preds = %142
  ret void, !dbg !159, !verifier.code !33

forwarder:                                        ; preds = %131
  br label %130, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_sort() #0 !dbg !160 {
  br label %1, !dbg !161, !verifier.code !33

1:                                                ; preds = %1, %0
  %2 = call zeroext i1 @gl_sort_pass(), !dbg !162, !verifier.code !33
  br i1 %2, label %1, label %3, !dbg !161, !llvm.loop !163, !verifier.code !33

3:                                                ; preds = %1
  ret void, !dbg !165, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @gl_destroy() #0 !dbg !166 {
  %1 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !167, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !168, metadata !DIExpression()), !dbg !169, !verifier.code !33
  %2 = icmp ne %struct.list_head* @gl_list, %1, !dbg !170, !verifier.code !33
  br i1 %2, label %.lr.ph, label %13, !dbg !171, !verifier.code !33

.lr.ph:                                           ; preds = %0
  br label %3, !dbg !171, !verifier.code !33

3:                                                ; preds = %forwarder, %.lr.ph
  %4 = phi %struct.list_head* [ %1, %.lr.ph ], [ %11, %forwarder ], !verifier.code !33
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %4, i32 0, i32 0, !dbg !172, !verifier.code !33
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !172, !verifier.code !33
  store %struct.list_head* %6, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !174, !verifier.code !33
  %7 = bitcast %struct.list_head* %4 to i8*, !dbg !175, !verifier.code !33
  %8 = getelementptr inbounds i8, i8* %7, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !175, !verifier.code !33
  %9 = bitcast i8* %8 to %struct.node*, !dbg !175, !verifier.code !33
  %10 = bitcast %struct.node* %9 to i8*, !dbg !175, !verifier.code !33
  call void @free(i8* %10) #5, !dbg !176, !verifier.code !33
  %11 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !167, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %11, metadata !168, metadata !DIExpression()), !dbg !169, !verifier.code !33
  %12 = icmp ne %struct.list_head* @gl_list, %11, !dbg !170, !verifier.code !33
  br i1 %12, label %forwarder, label %._crit_edge, !dbg !171, !llvm.loop !177, !verifier.code !33

._crit_edge:                                      ; preds = %3
  br label %13, !dbg !171, !verifier.code !33

13:                                               ; preds = %._crit_edge, %0
  ret void, !dbg !179, !verifier.code !33

forwarder:                                        ; preds = %3
  br label %3, !verifier.code !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: noinline nounwind uwtable
define internal zeroext i1 @gl_sort_pass() #0 !dbg !180 {
  call void @llvm.dbg.value(metadata i8 0, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %1 = load %struct.list_head*, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0), align 8, !dbg !186, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !187, metadata !DIExpression()), !dbg !185, !verifier.code !33
  call void @llvm.dbg.value(metadata i8 0, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %2 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !188, !verifier.code !33
  %3 = load %struct.list_head*, %struct.list_head** %2, align 8, !dbg !188, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %3, metadata !189, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %4 = icmp ne %struct.list_head* @gl_list, %3, !dbg !190, !verifier.code !33
  br i1 %4, label %.lr.ph.lr.ph, label %.outer._crit_edge, !dbg !191, !verifier.code !33

.lr.ph.lr.ph:                                     ; preds = %0
  br label %.lr.ph, !dbg !191, !verifier.code !33

.lr.ph:                                           ; preds = %forwarder, %.lr.ph.lr.ph
  %5 = phi %struct.list_head* [ %3, %.lr.ph.lr.ph ], [ %13, %forwarder ], !verifier.code !33
  %6 = phi %struct.list_head** [ %2, %.lr.ph.lr.ph ], [ %12, %forwarder ], !verifier.code !33
  %.0.ph7 = phi i8 [ 0, %.lr.ph.lr.ph ], [ %.0.lcssa3, %forwarder ], !verifier.code !33
  %.01.ph6 = phi %struct.list_head* [ %1, %.lr.ph.lr.ph ], [ %.lcssa2, %forwarder ], !verifier.code !33
  call void @llvm.dbg.value(metadata i8 %.0.ph7, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %.01.ph6, metadata !187, metadata !DIExpression()), !dbg !185, !verifier.code !33
  br label %7, !dbg !191, !verifier.code !33

7:                                                ; preds = %forwarder9, %.lr.ph
  %8 = phi %struct.list_head* [ %5, %.lr.ph ], [ %16, %forwarder9 ], !verifier.code !33
  %.04 = phi i8 [ %.0.ph7, %.lr.ph ], [ 1, %forwarder9 ], !verifier.code !33
  call void @llvm.dbg.value(metadata i8 %.04, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %9 = call i32 @val_from_node(%struct.list_head* %.01.ph6), !dbg !192, !verifier.code !33
  call void @llvm.dbg.value(metadata i32 %9, metadata !194, metadata !DIExpression()), !dbg !196, !verifier.code !33
  %10 = call i32 @val_from_node(%struct.list_head* %8), !dbg !197, !verifier.code !33
  call void @llvm.dbg.value(metadata i32 %10, metadata !198, metadata !DIExpression()), !dbg !196, !verifier.code !33
  %11 = icmp sle i32 %9, %10, !dbg !199, !verifier.code !33
  br i1 %11, label %.outer, label %15, !dbg !201, !verifier.code !33

.outer:                                           ; preds = %7
  %.0.lcssa3 = phi i8 [ %.04, %7 ], !dbg !185, !verifier.code !33
  %.lcssa2 = phi %struct.list_head* [ %8, %7 ], !dbg !188, !verifier.code !33
  call void @llvm.dbg.value(metadata i8 %.0.lcssa3, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %.lcssa2, metadata !187, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %12 = getelementptr inbounds %struct.list_head, %struct.list_head* %.lcssa2, i32 0, i32 0, !dbg !188, !verifier.code !33
  %13 = load %struct.list_head*, %struct.list_head** %12, align 8, !dbg !188, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %13, metadata !189, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %14 = icmp ne %struct.list_head* @gl_list, %13, !dbg !190, !verifier.code !33
  br i1 %14, label %forwarder, label %.outer..outer._crit_edge_crit_edge, !dbg !191, !llvm.loop !202, !verifier.code !33

15:                                               ; preds = %7
  call void @llvm.dbg.value(metadata i8 1, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  call void @list_move(%struct.list_head* %.01.ph6, %struct.list_head* %8), !dbg !204, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %.01.ph6, metadata !187, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %16 = load %struct.list_head*, %struct.list_head** %6, align 8, !dbg !188, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %16, metadata !189, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %17 = icmp ne %struct.list_head* @gl_list, %16, !dbg !190, !verifier.code !33
  br i1 %17, label %forwarder9, label %._crit_edge, !dbg !191, !llvm.loop !202, !verifier.code !33

.outer..outer._crit_edge_crit_edge:               ; preds = %.outer
  %split8 = phi i8 [ %.0.lcssa3, %.outer ], !verifier.code !33
  br label %.outer._crit_edge, !dbg !191, !verifier.code !33

.outer._crit_edge:                                ; preds = %.outer..outer._crit_edge_crit_edge, %0
  %split = phi i8 [ %split8, %.outer..outer._crit_edge_crit_edge ], [ 0, %0 ], !verifier.code !33
  br label %18, !dbg !191, !verifier.code !33

._crit_edge:                                      ; preds = %15
  %split5 = phi i8 [ 1, %15 ], !verifier.code !33
  br label %18, !dbg !191, !verifier.code !33

18:                                               ; preds = %._crit_edge, %.outer._crit_edge
  %.0.lcssa = phi i8 [ %split5, %._crit_edge ], [ %split, %.outer._crit_edge ], !dbg !185, !verifier.code !33
  call void @llvm.dbg.value(metadata i8 %.0.lcssa, metadata !184, metadata !DIExpression()), !dbg !185, !verifier.code !33
  %19 = trunc i8 %.0.lcssa to i1, !dbg !205, !verifier.code !33
  ret i1 %19, !dbg !206, !verifier.code !33

forwarder:                                        ; preds = %.outer
  br label %.lr.ph, !verifier.code !33

forwarder9:                                       ; preds = %15
  br label %7, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @val_from_node(%struct.list_head* %0) #0 !dbg !207 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !210, metadata !DIExpression()), !dbg !211, !verifier.code !33
  %2 = bitcast %struct.list_head* %0 to i8*, !dbg !212, !verifier.code !33
  %3 = getelementptr inbounds i8, i8* %2, i64 sub (i64 0, i64 ptrtoint (%struct.list_head* getelementptr inbounds (%struct.node, %struct.node* null, i32 0, i32 1) to i64)), !dbg !212, !verifier.code !33
  %4 = bitcast i8* %3 to %struct.node*, !dbg !212, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.node* %4, metadata !213, metadata !DIExpression()), !dbg !211, !verifier.code !33
  %5 = getelementptr inbounds %struct.node, %struct.node* %4, i32 0, i32 0, !dbg !214, !verifier.code !33
  %6 = load i32, i32* %5, align 8, !dbg !214, !verifier.code !33
  ret i32 %6, !dbg !215, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_move(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !216 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !219, metadata !DIExpression()), !dbg !220, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !221, metadata !DIExpression()), !dbg !220, !verifier.code !33
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !222, !verifier.code !33
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !222, !verifier.code !33
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !223, !verifier.code !33
  %6 = load %struct.list_head*, %struct.list_head** %5, align 8, !dbg !223, !verifier.code !33
  call void @__list_del(%struct.list_head* %4, %struct.list_head* %6), !dbg !224, !verifier.code !33
  call void @list_add(%struct.list_head* %0, %struct.list_head* %1), !dbg !225, !verifier.code !33
  ret void, !dbg !226, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_del(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !227 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !228, metadata !DIExpression()), !dbg !229, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !230, metadata !DIExpression()), !dbg !229, !verifier.code !33
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 1, !dbg !231, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %3, align 8, !dbg !232, !verifier.code !33
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !233, !verifier.code !33
  store %struct.list_head* %1, %struct.list_head** %4, align 8, !dbg !234, !verifier.code !33
  ret void, !dbg !235, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @list_add(%struct.list_head* %0, %struct.list_head* %1) #0 !dbg !236 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !237, metadata !DIExpression()), !dbg !238, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !239, metadata !DIExpression()), !dbg !238, !verifier.code !33
  %3 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !240, !verifier.code !33
  %4 = load %struct.list_head*, %struct.list_head** %3, align 8, !dbg !240, !verifier.code !33
  call void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %4), !dbg !241, !verifier.code !33
  ret void, !dbg !242, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @__list_add(%struct.list_head* %0, %struct.list_head* %1, %struct.list_head* %2) #0 !dbg !243 {
  call void @llvm.dbg.value(metadata %struct.list_head* %0, metadata !246, metadata !DIExpression()), !dbg !247, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %1, metadata !248, metadata !DIExpression()), !dbg !247, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.list_head* %2, metadata !249, metadata !DIExpression()), !dbg !247, !verifier.code !33
  %4 = getelementptr inbounds %struct.list_head, %struct.list_head* %2, i32 0, i32 1, !dbg !250, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %4, align 8, !dbg !251, !verifier.code !33
  %5 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 0, !dbg !252, !verifier.code !33
  store %struct.list_head* %2, %struct.list_head** %5, align 8, !dbg !253, !verifier.code !33
  %6 = getelementptr inbounds %struct.list_head, %struct.list_head* %0, i32 0, i32 1, !dbg !254, !verifier.code !33
  store %struct.list_head* %1, %struct.list_head** %6, align 8, !dbg !255, !verifier.code !33
  %7 = getelementptr inbounds %struct.list_head, %struct.list_head* %1, i32 0, i32 0, !dbg !256, !verifier.code !33
  store %struct.list_head* %0, %struct.list_head** %7, align 8, !dbg !257, !verifier.code !33
  ret void, !dbg !258, !verifier.code !33
}

; Function Attrs: noinline nounwind uwtable
define internal void @fail() #0 !dbg !259 {
  br label %1, !dbg !260, !verifier.code !33

1:                                                ; preds = %0
  call void @llvm.dbg.label(metadata !261), !dbg !262, !verifier.code !33
  call void @reach_error(), !dbg !263, !verifier.code !33
  call void @abort() #6, !dbg !265, !verifier.code !33
  unreachable, !dbg !265, !verifier.code !33
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #1

; Function Attrs: noreturn nounwind
declare dso_local void @abort() #3

declare dso_local i32 @__VERIFIER_nondet_int() #4

; Function Attrs: noinline nounwind uwtable
define internal void @gl_insert(i32 %0) #0 !dbg !266 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !269, metadata !DIExpression()), !dbg !270, !verifier.code !33
  %2 = call noalias i8* @malloc(i64 40) #5, !dbg !271, !verifier.code !33
  %3 = bitcast i8* %2 to %struct.node*, !dbg !271, !verifier.code !33
  call void @llvm.dbg.value(metadata %struct.node* %3, metadata !272, metadata !DIExpression()), !dbg !270, !verifier.code !33
  %4 = icmp ne %struct.node* %3, null, !dbg !273, !verifier.code !33
  br i1 %4, label %6, label %5, !dbg !275, !verifier.code !33

5:                                                ; preds = %1
  call void @abort() #6, !dbg !276, !verifier.code !33
  unreachable, !dbg !276, !verifier.code !33

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 0, !dbg !277, !verifier.code !33
  store i32 %0, i32* %7, align 8, !dbg !278, !verifier.code !33
  %8 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 1, !dbg !279, !verifier.code !33
  call void @list_add(%struct.list_head* %8, %struct.list_head* @gl_list), !dbg !280, !verifier.code !33
  br label %9, !dbg !281, !verifier.code !33

9:                                                ; preds = %6
  %10 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, !dbg !282, !verifier.code !33
  %11 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, !dbg !282, !verifier.code !33
  %12 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, i32 0
  store %struct.list_head* %10, %struct.list_head** %12, align 8, !dbg !282, !verifier.code !33
  %13 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, !dbg !282, !verifier.code !33
  %14 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, !dbg !282, !verifier.code !33
  %15 = getelementptr inbounds %struct.node, %struct.node* %3, i32 0, i32 2, i32 0
  store %struct.list_head* %13, %struct.list_head** %15, align 8, !dbg !282, !verifier.code !33
  br label %16, !dbg !282, !verifier.code !33

16:                                               ; preds = %9
  ret void, !dbg !284, !verifier.code !33
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

define void @__SMACK_static_init() {
entry:
  store %struct.list_head* @gl_list, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 0)
  store %struct.list_head* @gl_list, %struct.list_head** getelementptr inbounds (%struct.list_head, %struct.list_head* @gl_list, i32 0, i32 1)
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.ident = !{!25}
!llvm.module.flags = !{!26, !27, !28}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "gl_list", scope: !2, file: !8, line: 46, type: !13, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !24, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C/bubble_sort_linux-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!4 = !{}
!5 = !{!6, !19, !21, !22}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "node", file: !8, line: 40, size: 320, elements: !9)
!8 = !DIFile(filename: "../svcomp/MemSafety-LinkedLists-C//bubble_sort_linux-2.c", directory: "/home/clexma/Desktop/Disk_D/Tools/SMACK/SmackBasedPrj/testcases/benchmark")
!9 = !{!10, !12, !18}
!10 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !7, file: !8, line: 41, baseType: !11, size: 32)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_member, name: "linkage", scope: !7, file: !8, line: 42, baseType: !13, size: 128, offset: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list_head", file: !8, line: 24, size: 128, elements: !14)
!14 = !{!15, !17}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !13, file: !8, line: 25, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "prev", scope: !13, file: !8, line: 25, baseType: !16, size: 64, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "nested", scope: !7, file: !8, line: 43, baseType: !13, size: 128, offset: 192)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!21 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !7)
!24 = !{!0}
!25 = !{!"clang version 10.0.0-4ubuntu1 "}
!26 = !{i32 7, !"Dwarf Version", i32 4}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = distinct !DISubprogram(name: "reach_error", scope: !8, file: !8, line: 2, type: !30, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null}
!32 = !DILocation(line: 2, column: 20, scope: !29)
!33 = !{i1 false}
!34 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 169, type: !35, scopeLine: 170, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!35 = !DISubroutineType(types: !36)
!36 = !{!11}
!37 = !DILocation(line: 171, column: 5, scope: !34)
!38 = !DILocation(line: 172, column: 5, scope: !34)
!39 = !DILocation(line: 174, column: 5, scope: !34)
!40 = !DILocation(line: 175, column: 5, scope: !34)
!41 = !DILocation(line: 177, column: 5, scope: !34)
!42 = !DILocation(line: 179, column: 5, scope: !34)
!43 = distinct !DISubprogram(name: "gl_read", scope: !8, file: !8, line: 119, type: !30, scopeLine: 120, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!44 = !DILocation(line: 121, column: 5, scope: !43)
!45 = !DILocation(line: 122, column: 19, scope: !46)
!46 = distinct !DILexicalBlock(scope: !43, file: !8, line: 121, column: 8)
!47 = !{i1 true}
!48 = !DILocation(line: 122, column: 9, scope: !46)
!49 = !DILocation(line: 123, column: 5, scope: !46)
!50 = !DILocation(line: 124, column: 12, scope: !43)
!51 = distinct !{!51, !44, !52}
!52 = !DILocation(line: 124, column: 35, scope: !43)
!53 = !DILocation(line: 125, column: 1, scope: !43)
!54 = distinct !DISubprogram(name: "inspect", scope: !8, file: !8, line: 48, type: !55, scopeLine: 49, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!55 = !DISubroutineType(types: !56)
!56 = !{null, !57}
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !13)
!59 = !DILocalVariable(name: "head", arg: 1, scope: !54, file: !8, line: 48, type: !57)
!60 = !DILocation(line: 0, scope: !54)
!61 = !DILocation(line: 51, column: 5, scope: !54)
!62 = !DILocation(line: 51, column: 5, scope: !63)
!63 = distinct !DILexicalBlock(scope: !64, file: !8, line: 51, column: 5)
!64 = distinct !DILexicalBlock(scope: !54, file: !8, line: 51, column: 5)
!65 = !DILocation(line: 51, column: 5, scope: !64)
!66 = !DILocation(line: 52, column: 5, scope: !54)
!67 = !DILocation(line: 52, column: 5, scope: !68)
!68 = distinct !DILexicalBlock(scope: !69, file: !8, line: 52, column: 5)
!69 = distinct !DILexicalBlock(scope: !54, file: !8, line: 52, column: 5)
!70 = !DILocation(line: 52, column: 5, scope: !69)
!71 = !DILocation(line: 53, column: 5, scope: !54)
!72 = !DILocation(line: 53, column: 5, scope: !73)
!73 = distinct !DILexicalBlock(scope: !74, file: !8, line: 53, column: 5)
!74 = distinct !DILexicalBlock(scope: !54, file: !8, line: 53, column: 5)
!75 = !DILocation(line: 53, column: 5, scope: !74)
!76 = !DILocation(line: 56, column: 18, scope: !54)
!77 = !DILocation(line: 57, column: 5, scope: !54)
!78 = !DILocation(line: 57, column: 5, scope: !79)
!79 = distinct !DILexicalBlock(scope: !80, file: !8, line: 57, column: 5)
!80 = distinct !DILexicalBlock(scope: !54, file: !8, line: 57, column: 5)
!81 = !DILocation(line: 57, column: 5, scope: !80)
!82 = !DILocation(line: 58, column: 5, scope: !54)
!83 = !DILocation(line: 58, column: 5, scope: !84)
!84 = distinct !DILexicalBlock(scope: !85, file: !8, line: 58, column: 5)
!85 = distinct !DILexicalBlock(scope: !54, file: !8, line: 58, column: 5)
!86 = !DILocation(line: 58, column: 5, scope: !85)
!87 = !DILocation(line: 59, column: 5, scope: !54)
!88 = !DILocation(line: 59, column: 5, scope: !89)
!89 = distinct !DILexicalBlock(scope: !90, file: !8, line: 59, column: 5)
!90 = distinct !DILexicalBlock(scope: !54, file: !8, line: 59, column: 5)
!91 = !DILocation(line: 59, column: 5, scope: !90)
!92 = !DILocation(line: 62, column: 31, scope: !54)
!93 = !DILocalVariable(name: "node", scope: !54, file: !8, line: 62, type: !22)
!94 = !DILocation(line: 63, column: 5, scope: !54)
!95 = !DILocation(line: 63, column: 5, scope: !96)
!96 = distinct !DILexicalBlock(scope: !97, file: !8, line: 63, column: 5)
!97 = distinct !DILexicalBlock(scope: !54, file: !8, line: 63, column: 5)
!98 = !DILocation(line: 63, column: 5, scope: !97)
!99 = !DILocation(line: 64, column: 5, scope: !54)
!100 = !DILocation(line: 64, column: 5, scope: !101)
!101 = distinct !DILexicalBlock(scope: !102, file: !8, line: 64, column: 5)
!102 = distinct !DILexicalBlock(scope: !54, file: !8, line: 64, column: 5)
!103 = !DILocation(line: 64, column: 5, scope: !102)
!104 = !DILocation(line: 65, column: 5, scope: !54)
!105 = !DILocation(line: 65, column: 5, scope: !106)
!106 = distinct !DILexicalBlock(scope: !107, file: !8, line: 65, column: 5)
!107 = distinct !DILexicalBlock(scope: !54, file: !8, line: 65, column: 5)
!108 = !DILocation(line: 65, column: 5, scope: !107)
!109 = !DILocation(line: 66, column: 5, scope: !54)
!110 = !DILocation(line: 66, column: 5, scope: !111)
!111 = distinct !DILexicalBlock(scope: !112, file: !8, line: 66, column: 5)
!112 = distinct !DILexicalBlock(scope: !54, file: !8, line: 66, column: 5)
!113 = !DILocation(line: 66, column: 5, scope: !112)
!114 = !DILocation(line: 67, column: 5, scope: !54)
!115 = !DILocation(line: 67, column: 5, scope: !116)
!116 = distinct !DILexicalBlock(scope: !117, file: !8, line: 67, column: 5)
!117 = distinct !DILexicalBlock(scope: !54, file: !8, line: 67, column: 5)
!118 = !DILocation(line: 67, column: 5, scope: !117)
!119 = !DILocation(line: 70, column: 5, scope: !54)
!120 = !DILocation(line: 70, column: 5, scope: !121)
!121 = distinct !DILexicalBlock(scope: !122, file: !8, line: 70, column: 5)
!122 = distinct !DILexicalBlock(scope: !54, file: !8, line: 70, column: 5)
!123 = !DILocation(line: 70, column: 5, scope: !122)
!124 = !DILocation(line: 71, column: 5, scope: !54)
!125 = !DILocation(line: 71, column: 5, scope: !126)
!126 = distinct !DILexicalBlock(scope: !127, file: !8, line: 71, column: 5)
!127 = distinct !DILexicalBlock(scope: !54, file: !8, line: 71, column: 5)
!128 = !DILocation(line: 71, column: 5, scope: !127)
!129 = !DILocation(line: 72, column: 5, scope: !54)
!130 = !DILocation(line: 72, column: 5, scope: !131)
!131 = distinct !DILexicalBlock(scope: !132, file: !8, line: 72, column: 5)
!132 = distinct !DILexicalBlock(scope: !54, file: !8, line: 72, column: 5)
!133 = !DILocation(line: 72, column: 5, scope: !132)
!134 = !DILocation(line: 73, column: 5, scope: !54)
!135 = !DILocation(line: 73, column: 5, scope: !136)
!136 = distinct !DILexicalBlock(scope: !137, file: !8, line: 73, column: 5)
!137 = distinct !DILexicalBlock(scope: !54, file: !8, line: 73, column: 5)
!138 = !DILocation(line: 73, column: 5, scope: !137)
!139 = !DILocation(line: 74, column: 5, scope: !54)
!140 = !DILocation(line: 74, column: 5, scope: !141)
!141 = distinct !DILexicalBlock(scope: !142, file: !8, line: 74, column: 5)
!142 = distinct !DILexicalBlock(scope: !54, file: !8, line: 74, column: 5)
!143 = !DILocation(line: 74, column: 5, scope: !142)
!144 = !DILocation(line: 77, column: 23, scope: !145)
!145 = distinct !DILexicalBlock(scope: !54, file: !8, line: 77, column: 5)
!146 = !DILocation(line: 77, column: 36, scope: !147)
!147 = distinct !DILexicalBlock(scope: !145, file: !8, line: 77, column: 5)
!148 = !DILocation(line: 77, column: 44, scope: !147)
!149 = !DILocation(line: 77, column: 5, scope: !145)
!150 = !DILocation(line: 77, column: 66, scope: !147)
!151 = distinct !{!151, !149, !152}
!152 = !DILocation(line: 77, column: 71, scope: !145)
!153 = !DILocation(line: 0, scope: !145)
!154 = !DILocation(line: 78, column: 5, scope: !54)
!155 = !DILocation(line: 78, column: 5, scope: !156)
!156 = distinct !DILexicalBlock(scope: !157, file: !8, line: 78, column: 5)
!157 = distinct !DILexicalBlock(scope: !54, file: !8, line: 78, column: 5)
!158 = !DILocation(line: 78, column: 5, scope: !157)
!159 = !DILocation(line: 79, column: 1, scope: !54)
!160 = distinct !DISubprogram(name: "gl_sort", scope: !8, file: !8, line: 163, type: !30, scopeLine: 164, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!161 = !DILocation(line: 165, column: 5, scope: !160)
!162 = !DILocation(line: 165, column: 12, scope: !160)
!163 = distinct !{!163, !161, !164}
!164 = !DILocation(line: 166, column: 9, scope: !160)
!165 = !DILocation(line: 167, column: 1, scope: !160)
!166 = distinct !DISubprogram(name: "gl_destroy", scope: !8, file: !8, line: 127, type: !30, scopeLine: 128, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!167 = !DILocation(line: 130, column: 40, scope: !166)
!168 = !DILocalVariable(name: "next", scope: !166, file: !8, line: 129, type: !16)
!169 = !DILocation(line: 0, scope: !166)
!170 = !DILocation(line: 130, column: 21, scope: !166)
!171 = !DILocation(line: 130, column: 5, scope: !166)
!172 = !DILocation(line: 131, column: 30, scope: !173)
!173 = distinct !DILexicalBlock(scope: !166, file: !8, line: 130, column: 47)
!174 = !DILocation(line: 131, column: 22, scope: !173)
!175 = !DILocation(line: 132, column: 14, scope: !173)
!176 = !DILocation(line: 132, column: 9, scope: !173)
!177 = distinct !{!177, !171, !178}
!178 = !DILocation(line: 133, column: 2, scope: !166)
!179 = !DILocation(line: 134, column: 1, scope: !166)
!180 = distinct !DISubprogram(name: "gl_sort_pass", scope: !8, file: !8, line: 141, type: !181, scopeLine: 142, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!181 = !DISubroutineType(types: !182)
!182 = !{!183}
!183 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!184 = !DILocalVariable(name: "any_change", scope: !180, file: !8, line: 143, type: !183)
!185 = !DILocation(line: 0, scope: !180)
!186 = !DILocation(line: 145, column: 38, scope: !180)
!187 = !DILocalVariable(name: "pos0", scope: !180, file: !8, line: 145, type: !16)
!188 = !DILocation(line: 147, column: 38, scope: !180)
!189 = !DILocalVariable(name: "pos1", scope: !180, file: !8, line: 146, type: !16)
!190 = !DILocation(line: 147, column: 21, scope: !180)
!191 = !DILocation(line: 147, column: 5, scope: !180)
!192 = !DILocation(line: 148, column: 26, scope: !193)
!193 = distinct !DILexicalBlock(scope: !180, file: !8, line: 147, column: 45)
!194 = !DILocalVariable(name: "val0", scope: !193, file: !8, line: 148, type: !195)
!195 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!196 = !DILocation(line: 0, scope: !193)
!197 = !DILocation(line: 149, column: 26, scope: !193)
!198 = !DILocalVariable(name: "val1", scope: !193, file: !8, line: 149, type: !195)
!199 = !DILocation(line: 150, column: 18, scope: !200)
!200 = distinct !DILexicalBlock(scope: !193, file: !8, line: 150, column: 13)
!201 = !DILocation(line: 150, column: 13, scope: !193)
!202 = distinct !{!202, !191, !203}
!203 = !DILocation(line: 158, column: 5, scope: !180)
!204 = !DILocation(line: 157, column: 9, scope: !193)
!205 = !DILocation(line: 160, column: 12, scope: !180)
!206 = !DILocation(line: 160, column: 5, scope: !180)
!207 = distinct !DISubprogram(name: "val_from_node", scope: !8, file: !8, line: 136, type: !208, scopeLine: 136, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!208 = !DISubroutineType(types: !209)
!209 = !{!11, !16}
!210 = !DILocalVariable(name: "head", arg: 1, scope: !207, file: !8, line: 136, type: !16)
!211 = !DILocation(line: 0, scope: !207)
!212 = !DILocation(line: 137, column: 26, scope: !207)
!213 = !DILocalVariable(name: "entry", scope: !207, file: !8, line: 137, type: !6)
!214 = !DILocation(line: 138, column: 19, scope: !207)
!215 = !DILocation(line: 138, column: 5, scope: !207)
!216 = distinct !DISubprogram(name: "list_move", scope: !8, file: !8, line: 102, type: !217, scopeLine: 103, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!217 = !DISubroutineType(types: !218)
!218 = !{null, !16, !16}
!219 = !DILocalVariable(name: "list", arg: 1, scope: !216, file: !8, line: 102, type: !16)
!220 = !DILocation(line: 0, scope: !216)
!221 = !DILocalVariable(name: "head", arg: 2, scope: !216, file: !8, line: 102, type: !16)
!222 = !DILocation(line: 104, column: 26, scope: !216)
!223 = !DILocation(line: 104, column: 38, scope: !216)
!224 = !DILocation(line: 104, column: 9, scope: !216)
!225 = !DILocation(line: 105, column: 9, scope: !216)
!226 = !DILocation(line: 106, column: 1, scope: !216)
!227 = distinct !DISubprogram(name: "__list_del", scope: !8, file: !8, line: 91, type: !217, scopeLine: 92, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!228 = !DILocalVariable(name: "prev", arg: 1, scope: !227, file: !8, line: 91, type: !16)
!229 = !DILocation(line: 0, scope: !227)
!230 = !DILocalVariable(name: "next", arg: 2, scope: !227, file: !8, line: 91, type: !16)
!231 = !DILocation(line: 93, column: 8, scope: !227)
!232 = !DILocation(line: 93, column: 13, scope: !227)
!233 = !DILocation(line: 94, column: 8, scope: !227)
!234 = !DILocation(line: 94, column: 13, scope: !227)
!235 = !DILocation(line: 95, column: 1, scope: !227)
!236 = distinct !DISubprogram(name: "list_add", scope: !8, file: !8, line: 97, type: !217, scopeLine: 98, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!237 = !DILocalVariable(name: "new", arg: 1, scope: !236, file: !8, line: 97, type: !16)
!238 = !DILocation(line: 0, scope: !236)
!239 = !DILocalVariable(name: "head", arg: 2, scope: !236, file: !8, line: 97, type: !16)
!240 = !DILocation(line: 99, column: 30, scope: !236)
!241 = !DILocation(line: 99, column: 2, scope: !236)
!242 = !DILocation(line: 100, column: 1, scope: !236)
!243 = distinct !DISubprogram(name: "__list_add", scope: !8, file: !8, line: 81, type: !244, scopeLine: 84, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!244 = !DISubroutineType(types: !245)
!245 = !{null, !16, !16, !16}
!246 = !DILocalVariable(name: "new", arg: 1, scope: !243, file: !8, line: 81, type: !16)
!247 = !DILocation(line: 0, scope: !243)
!248 = !DILocalVariable(name: "prev", arg: 2, scope: !243, file: !8, line: 82, type: !16)
!249 = !DILocalVariable(name: "next", arg: 3, scope: !243, file: !8, line: 83, type: !16)
!250 = !DILocation(line: 85, column: 8, scope: !243)
!251 = !DILocation(line: 85, column: 13, scope: !243)
!252 = !DILocation(line: 86, column: 7, scope: !243)
!253 = !DILocation(line: 86, column: 12, scope: !243)
!254 = !DILocation(line: 87, column: 7, scope: !243)
!255 = !DILocation(line: 87, column: 12, scope: !243)
!256 = !DILocation(line: 88, column: 8, scope: !243)
!257 = !DILocation(line: 88, column: 13, scope: !243)
!258 = !DILocation(line: 89, column: 1, scope: !243)
!259 = distinct !DISubprogram(name: "fail", scope: !8, file: !8, line: 15, type: !30, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!260 = !DILocation(line: 15, column: 24, scope: !259)
!261 = !DILabel(scope: !259, name: "ERROR", file: !8, line: 16)
!262 = !DILocation(line: 16, column: 1, scope: !259)
!263 = !DILocation(line: 16, column: 9, scope: !264)
!264 = distinct !DILexicalBlock(scope: !259, file: !8, line: 16, column: 8)
!265 = !DILocation(line: 16, column: 23, scope: !264)
!266 = distinct !DISubprogram(name: "gl_insert", scope: !8, file: !8, line: 108, type: !267, scopeLine: 109, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !2, retainedNodes: !4)
!267 = !DISubroutineType(types: !268)
!268 = !{null, !11}
!269 = !DILocalVariable(name: "value", arg: 1, scope: !266, file: !8, line: 108, type: !11)
!270 = !DILocation(line: 0, scope: !266)
!271 = !DILocation(line: 110, column: 25, scope: !266)
!272 = !DILocalVariable(name: "node", scope: !266, file: !8, line: 110, type: !6)
!273 = !DILocation(line: 111, column: 10, scope: !274)
!274 = distinct !DILexicalBlock(scope: !266, file: !8, line: 111, column: 9)
!275 = !DILocation(line: 111, column: 9, scope: !266)
!276 = !DILocation(line: 112, column: 9, scope: !274)
!277 = !DILocation(line: 114, column: 11, scope: !266)
!278 = !DILocation(line: 114, column: 17, scope: !266)
!279 = !DILocation(line: 115, column: 21, scope: !266)
!280 = !DILocation(line: 115, column: 5, scope: !266)
!281 = !DILocation(line: 116, column: 5, scope: !266)
!282 = !DILocation(line: 116, column: 5, scope: !283)
!283 = distinct !DILexicalBlock(scope: !266, file: !8, line: 116, column: 5)
!284 = !DILocation(line: 117, column: 1, scope: !266)
