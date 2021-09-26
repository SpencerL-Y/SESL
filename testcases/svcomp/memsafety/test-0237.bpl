// generated by SMACK version 2.6.3 for corral
// via /usr/local/bin/smack ../svcomp/memsafety//test-0237.c -ll ../svcomp/memsafety//test-0237_IR.ll --bpl ../svcomp/memsafety//test-0237.bpl -t --sh-mem-leak

const {:global_variable} {:pointer_to_size 16} .str: ref;
axiom (.str == $sub.ref(0, 1026));
const {:global_variable} {:pointer_to_size 264} {:count 33} .str.1: ref;
axiom (.str.1 == $sub.ref(0, 2083));
const {:global_variable} {:pointer_to_size 152} {:count 19} __PRETTY_FUNCTION__.reach_error: ref;
axiom (__PRETTY_FUNCTION__.reach_error == $sub.ref(0, 3126));
const {:global_variable} {:pointer_to_size 64} main.list: ref;
axiom (main.list == $sub.ref(0, 4158));
const reach_error: ref;
axiom (reach_error == $sub.ref(0, 5190));
procedure  reach_error()
{
$bb0:
  call __assert_fail(.str, .str.1, 3, __PRETTY_FUNCTION__.reach_error);
  assume false;
}
const __assert_fail: ref;
axiom (__assert_fail == $sub.ref(0, 6222));
procedure  __assert_fail($p0: ref, $p1: ref, $i2: i32, $p3: ref);
const main: ref;
axiom (main == $sub.ref(0, 7254));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $i0: i32;
  var $i1: i1;
  var $p2: ref;
$bb0:
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  goto $bb1;
$bb1:
  call l0_insert(main.list);
  goto $bb2;
$bb2:
  call $i0 := __VERIFIER_nondet_int();
  call {:cexpr "smack:ext:__VERIFIER_nondet_int"} boogie_si_record_i32($i0);
  $i1 := $ne.i32($i0, 0);
  assume {:branchcond $i1} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i1 == 1);
  goto $bb1;
$bb4:
  assume !(($i1 == 1));
  $p2 := $load.ref($M.0, main.list);
  call l0_destroy($p2);
  $r := 0;
  return;
}
const l0_insert: ref;
axiom (l0_insert == $sub.ref(0, 8286));
procedure  l0_insert($p0: ref)
{
  var $p1: ref8;
  var $p2: ref;
  var $p3: ref;
  var $i4: i32;
  var $i5: i1;
  var $p6: ref;
  var $p7: ref;
$bb0:
  call $p1 := zalloc_or_die(16);
  $p2 := $bitcast.ref.ref($p1);
  goto $bb1;
$bb1:
  $p3 := $add.ref($add.ref($p2, $mul.ref(0, 16)), $mul.ref(8, 1));
  call l1_insert($p3);
  goto $bb2;
$bb2:
  call $i4 := __VERIFIER_nondet_int();
  call {:cexpr "smack:ext:__VERIFIER_nondet_int"} boogie_si_record_i32($i4);
  $i5 := $ne.i32($i4, 0);
  assume {:branchcond $i5} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i5 == 1);
  goto $bb1;
$bb4:
  assume !(($i5 == 1));
  $p6 := $load.ref($M.0, $p0);
  $p7 := $add.ref($add.ref($p2, $mul.ref(0, 16)), $mul.ref(0, 1));
  $M.1 := $store.ref($M.1, $p7, $p6);
  $M.0 := $store.ref($M.0, $p0, $p1);
  return;
}
const __VERIFIER_nondet_int: ref;
axiom (__VERIFIER_nondet_int == $sub.ref(0, 9318));
procedure  __VERIFIER_nondet_int()
  returns ($r: i32);
const l0_destroy: ref;
axiom (l0_destroy == $sub.ref(0, 10350));
procedure  l0_destroy($p0: ref)
{
  var $p1: ref;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref;
  var $p5: ref;
  var $p6: ref8;
  var $i7: i1;
$bb0:
  $p1 := $p0;
  goto $bb1;
$bb1:
  $p2 := $add.ref($add.ref($p1, $mul.ref(0, 16)), $mul.ref(8, 1));
  $p3 := $load.ref($M.1, $p2);
  call l1_destroy($p3);
  $p4 := $add.ref($add.ref($p1, $mul.ref(0, 16)), $mul.ref(0, 1));
  $p5 := $load.ref($M.1, $p4);
  $p6 := $bitcast.ref.ref($p1);
  call free_($p6);
  goto $bb2;
$bb2:
  $i7 := $ne.ref($p5, $0.ref);
  assume {:branchcond $i7} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i7 == 1);
  $p1 := $p5;
  goto $bb1;
$bb4:
  assume !(($i7 == 1));
  return;
}
const llvm.dbg.declare: ref;
axiom (llvm.dbg.declare == $sub.ref(0, 11382));
procedure  llvm.dbg.declare($p0: ref, $p1: ref, $p2: ref);
const l1_destroy: ref;
axiom (l1_destroy == $sub.ref(0, 12414));
procedure  l1_destroy($p0: ref)
{
  var $p1: ref;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref;
  var $p5: ref;
  var $p6: ref8;
  var $i7: i1;
$bb0:
  $p1 := $p0;
  goto $bb1;
$bb1:
  $p2 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(0, 1));
  $p3 := $load.ref($M.1, $p2);
  call l2_destroy($p3);
  $p4 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(8, 1));
  $p5 := $load.ref($M.1, $p4);
  $p6 := $bitcast.ref.ref($p1);
  call free_($p6);
  goto $bb2;
$bb2:
  $i7 := $ne.ref($p5, $0.ref);
  assume {:branchcond $i7} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i7 == 1);
  $p1 := $p5;
  goto $bb1;
$bb4:
  assume !(($i7 == 1));
  return;
}
const free_: ref;
axiom (free_ == $sub.ref(0, 13446));
procedure  free_($p0: ref)
{
  call $free($p0);
}
const l2_destroy: ref;
axiom (l2_destroy == $sub.ref(0, 14478));
procedure  l2_destroy($p0: ref)
{
  var $p1: ref;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref;
  var $p5: ref;
  var $p6: ref8;
  var $i7: i1;
$bb0:
  $p1 := $p0;
  goto $bb1;
$bb1:
  $p2 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(16, 1));
  $p3 := $load.ref($M.1, $p2);
  call l3_destroy($p3);
  $p4 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(8, 1));
  $p5 := $load.ref($M.1, $p4);
  $p6 := $bitcast.ref.ref($p1);
  call free_($p6);
  goto $bb2;
$bb2:
  $i7 := $ne.ref($p5, $0.ref);
  assume {:branchcond $i7} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i7 == 1);
  $p1 := $p5;
  goto $bb1;
$bb4:
  assume !(($i7 == 1));
  return;
}
const l3_destroy: ref;
axiom (l3_destroy == $sub.ref(0, 15510));
procedure  l3_destroy($p0: ref)
{
  var $p1: ref;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref;
  var $p5: ref;
  var $p6: ref8;
  var $i7: i1;
$bb0:
  $p1 := $p0;
  goto $bb1;
$bb1:
  $p2 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(0, 1));
  $p3 := $load.ref($M.1, $p2);
  call l4_destroy($p3);
  $p4 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(8, 1));
  $p5 := $load.ref($M.1, $p4);
  $p6 := $bitcast.ref.ref($p1);
  call free_($p6);
  goto $bb2;
$bb2:
  $i7 := $ne.ref($p5, $0.ref);
  assume {:branchcond $i7} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i7 == 1);
  $p1 := $p5;
  goto $bb1;
$bb4:
  assume !(($i7 == 1));
  return;
}
const l4_destroy: ref;
axiom (l4_destroy == $sub.ref(0, 16542));
procedure  l4_destroy($p0: ref)
{
  var $p1: ref;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref8;
  var $p5: ref;
  var $p6: ref;
  var $p7: ref8;
  var $i8: i1;
$bb0:
  $p1 := $p0;
  goto $bb1;
$bb1:
  $p2 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(16, 1));
  $p3 := $load.ref($M.1, $p2);
  $p4 := $bitcast.ref.ref($p3);
  call free_($p4);
  $p5 := $add.ref($add.ref($p1, $mul.ref(0, 24)), $mul.ref(8, 1));
  $p6 := $load.ref($M.1, $p5);
  $p7 := $bitcast.ref.ref($p1);
  call free_($p7);
  goto $bb2;
$bb2:
  $i8 := $ne.ref($p6, $0.ref);
  assume {:branchcond $i8} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i8 == 1);
  $p1 := $p6;
  goto $bb1;
$bb4:
  assume !(($i8 == 1));
  return;
}
const zalloc_or_die: ref;
axiom (zalloc_or_die == $sub.ref(0, 17574));
procedure  zalloc_or_die($i0: i32)
  returns ($r: ref)
{
  var $i1: i64;
  var $p2: ref8;
  var $i3: i1;
$bb0:
  call {:cexpr "zalloc_or_die:arg:size"} boogie_si_record_i32($i0);
  $i1 := $zext.i32.i64($i0);
  call $p2 := calloc_model(1, $i1);
  $i3 := $ne.ref($p2, $0.ref);
  assume {:branchcond $i3} true;
  goto $bb1, $bb2;
$bb1:
  assume ($i3 == 1);
  $r := $p2;
  return;
$bb2:
  assume !(($i3 == 1));
  call abort();
  assume false;
}
const l1_insert: ref;
axiom (l1_insert == $sub.ref(0, 18606));
procedure  l1_insert($p0: ref)
{
  var $p1: ref8;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref8;
  var $i5: i32;
  var $i6: i1;
  var $p7: ref;
  var $p8: ref;
  var $p9: ref;
$bb0:
  call $p1 := zalloc_or_die(24);
  $p2 := $bitcast.ref.ref($p1);
  goto $bb1;
$bb1:
  $p3 := $add.ref($add.ref($p2, $mul.ref(0, 24)), $mul.ref(0, 1));
  $p4 := $bitcast.ref.ref($p0);
  call l2_insert($p3, $p4);
  goto $bb2;
$bb2:
  call $i5 := __VERIFIER_nondet_int();
  call {:cexpr "smack:ext:__VERIFIER_nondet_int"} boogie_si_record_i32($i5);
  $i6 := $ne.i32($i5, 0);
  assume {:branchcond $i6} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i6 == 1);
  goto $bb1;
$bb4:
  assume !(($i6 == 1));
  $p7 := $add.ref($add.ref($p2, $mul.ref(0, 24)), $mul.ref(16, 1));
  $M.1 := $store.ref($M.1, $p7, $p0);
  $p8 := $load.ref($M.1, $p0);
  $p9 := $add.ref($add.ref($p2, $mul.ref(0, 24)), $mul.ref(8, 1));
  $M.1 := $store.ref($M.1, $p9, $p8);
  $M.1 := $store.ref($M.1, $p0, $p1);
  return;
}
const l2_insert: ref;
axiom (l2_insert == $sub.ref(0, 19638));
procedure  l2_insert($p0: ref, $p1: ref)
{
  var $p2: ref8;
  var $p3: ref;
  var $p4: ref;
  var $i5: i32;
  var $i6: i1;
  var $p7: ref;
  var $p8: ref;
  var $p9: ref;
  var $p10: ref;
$bb0:
  call $p2 := zalloc_or_die(24);
  $p3 := $bitcast.ref.ref($p2);
  goto $bb1;
$bb1:
  $p4 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(16, 1));
  call l3_insert($p4);
  goto $bb2;
$bb2:
  call $i5 := __VERIFIER_nondet_int();
  call {:cexpr "smack:ext:__VERIFIER_nondet_int"} boogie_si_record_i32($i5);
  $i6 := $ne.i32($i5, 0);
  assume {:branchcond $i6} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i6 == 1);
  goto $bb1;
$bb4:
  assume !(($i6 == 1));
  $p7 := $bitcast.ref.ref($p1);
  $p8 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(0, 1));
  $M.1 := $store.ref($M.1, $p8, $p1);
  $p9 := $load.ref($M.1, $p0);
  $p10 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(8, 1));
  $M.1 := $store.ref($M.1, $p10, $p9);
  $M.1 := $store.ref($M.1, $p0, $p2);
  return;
}
const l3_insert: ref;
axiom (l3_insert == $sub.ref(0, 20670));
procedure  l3_insert($p0: ref)
{
  var $p1: ref8;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref8;
  var $i5: i32;
  var $i6: i1;
  var $p7: ref;
  var $p8: ref;
  var $p9: ref;
$bb0:
  call $p1 := zalloc_or_die(24);
  $p2 := $bitcast.ref.ref($p1);
  goto $bb1;
$bb1:
  $p3 := $add.ref($add.ref($p2, $mul.ref(0, 24)), $mul.ref(0, 1));
  $p4 := $bitcast.ref.ref($p0);
  call l4_insert($p3, $p4);
  goto $bb2;
$bb2:
  call $i5 := __VERIFIER_nondet_int();
  call {:cexpr "smack:ext:__VERIFIER_nondet_int"} boogie_si_record_i32($i5);
  $i6 := $ne.i32($i5, 0);
  assume {:branchcond $i6} true;
  goto $bb3, $bb4;
$bb3:
  assume ($i6 == 1);
  goto $bb1;
$bb4:
  assume !(($i6 == 1));
  $p7 := $add.ref($add.ref($p2, $mul.ref(0, 24)), $mul.ref(16, 1));
  $M.1 := $store.ref($M.1, $p7, $p0);
  $p8 := $load.ref($M.1, $p0);
  $p9 := $add.ref($add.ref($p2, $mul.ref(0, 24)), $mul.ref(8, 1));
  $M.1 := $store.ref($M.1, $p9, $p8);
  $M.1 := $store.ref($M.1, $p0, $p1);
  return;
}
const l4_insert: ref;
axiom (l4_insert == $sub.ref(0, 21702));
procedure  l4_insert($p0: ref, $p1: ref)
{
  var $p2: ref8;
  var $p3: ref;
  var $p4: ref8;
  var $p5: ref;
  var $p6: ref;
  var $p7: ref8;
  var $p8: ref;
  var $p9: ref;
  var $p10: ref;
  var $p11: ref;
  var $p12: ref;
  var $p13: ref;
  var $p14: ref;
$bb0:
  call $p2 := zalloc_or_die(24);
  $p3 := $bitcast.ref.ref($p2);
  call $p4 := zalloc_or_die(119);
  $p5 := $bitcast.ref.ref($p4);
  $p6 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(16, 1));
  $M.1 := $store.ref($M.1, $p6, $p4);
  $p7 := $bitcast.ref.ref($p3);
  $p8 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(16, 1));
  $p9 := $load.ref($M.1, $p8);
  $p10 := $bitcast.ref.ref($p9);
  $M.1 := $store.ref($M.1, $p10, $p2);
  $p11 := $bitcast.ref.ref($p1);
  $p12 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(0, 1));
  $M.1 := $store.ref($M.1, $p12, $p1);
  $p13 := $load.ref($M.1, $p0);
  $p14 := $add.ref($add.ref($p3, $mul.ref(0, 24)), $mul.ref(8, 1));
  $M.1 := $store.ref($M.1, $p14, $p13);
  $M.1 := $store.ref($M.1, $p0, $p2);
  return;
}
const calloc_model: ref;
axiom (calloc_model == $sub.ref(0, 22734));
procedure  calloc_model($i0: i64, $i1: i64)
  returns ($r: ref)
{
  var $i2: i64;
  var $p3: ref8;
  var $i4: i64;
$bb0:
  call {:cexpr "calloc_model:arg:nmemb"} boogie_si_record_i64($i0);
  call {:cexpr "calloc_model:arg:size"} boogie_si_record_i64($i1);
  $i2 := $mul.i64($i0, $i1);
  call $p3 := malloc($i2);
  $i4 := $mul.i64($i0, $i1);
  call $M.1 := $memset.i8($M.1, $p3, 0, $i4, false);
  $r := $p3;
  return;
}
const abort: ref;
axiom (abort == $sub.ref(0, 23766));
procedure  abort();
const malloc: ref;
axiom (malloc == $sub.ref(0, 24798));
procedure  malloc($i0: i64)
  returns ($r: ref)
{
  call $r := $malloc($i0);
}
const llvm.memset.p0i8.i64: ref;
axiom (llvm.memset.p0i8.i64 == $sub.ref(0, 25830));
procedure  llvm.memset.p0i8.i64($p0: ref, $i1: i8, $i2: i64, $i3: i1);
const llvm.dbg.value: ref;
axiom (llvm.dbg.value == $sub.ref(0, 26862));
procedure  llvm.dbg.value($p0: ref, $p1: ref, $p2: ref);
const __SMACK_static_init: ref;
axiom (__SMACK_static_init == $sub.ref(0, 27894));
procedure  __SMACK_static_init()
{
$bb0:
  $M.0 := $store.ref($M.0, main.list, $0.ref);
  return;
}
procedure  $memset.i8(M: [ref] i8, dst: ref, val: i8, len: ref, isvolatile: bool) returns (M.ret: [ref] i8)
{
  assume (forall x: ref :: $sle.ref.bool(dst,x) && $slt.ref.bool(x,$add.ref(dst,len)) ==> M.ret[x] == val);
  assume (forall x: ref :: $slt.ref.bool(x,dst) ==> M.ret[x] == M[x]);
  assume (forall x: ref :: $sle.ref.bool($add.ref(dst,len),x) ==> M.ret[x] == M[x]);
}

procedure  boogie_si_record_i32(x: i32);
procedure  boogie_si_record_i64(x: i64);
procedure  boogie_si_record_ref(x: ref);
procedure  $initialize()
{
  call __SMACK_static_init();
  return;
}