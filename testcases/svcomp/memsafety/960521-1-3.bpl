// generated by SMACK version 2.6.3 for corral
// via /usr/local/bin/smack ../testcases/svcomp/memsafety/960521-1-3.i -ll ../testcases/svcomp/memsafety/960521-1-3_IR.ll --bpl ../testcases/svcomp/memsafety/960521-1-3.bpl -t --sh-mem-leak --add-line-info

const {:global_variable} {:pointer_to_size 32} n: ref;
axiom (n == $sub.ref(0, 1028));
const {:global_variable} {:pointer_to_size 64} a: ref;
axiom (a == $sub.ref(0, 2060));
const {:global_variable} {:pointer_to_size 64} b: ref;
axiom (b == $sub.ref(0, 3092));
const {:global_variable} {:pointer_to_size 16} .str: ref;
axiom (.str == $sub.ref(0, 4118));
const {:global_variable} {:pointer_to_size 104} {:count 13} .str.1: ref;
axiom (.str.1 == $sub.ref(0, 5155));
const {:global_variable} {:pointer_to_size 152} {:count 19} __PRETTY_FUNCTION__.reach_error: ref;
axiom (__PRETTY_FUNCTION__.reach_error == $sub.ref(0, 6198));
const reach_error: ref;
axiom (reach_error == $sub.ref(0, 7230));
procedure  reach_error()
{
$bb0:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 12, 83} true;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 12, 83} true;
  call __assert_fail(.str, .str.1, 3, __PRETTY_FUNCTION__.reach_error);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 12, 83} true;
  assume false;
}
const __assert_fail: ref;
axiom (__assert_fail == $sub.ref(0, 8262));
procedure  __assert_fail($p0: ref, $p1: ref, $i2: i32, $p3: ref);
const foo: ref;
axiom (foo == $sub.ref(0, 9294));
procedure  foo()
{
  var $i0: i32;
  var $i1: i1;
  var $i2: i32;
  var $p3: ref32;
  var $i4: i64;
  var $p5: ref32;
  var $i6: i32;
  var $i7: i32;
  var $i8: i1;
  var $i9: i32;
  var $p10: ref32;
  var $i11: i64;
  var $p12: ref32;
  var $i13: i32;
  var $i14: i1;
$bb0:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 19} true;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 19} true;
  $i0 := $M.0;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 17} true;
  $i1 := $slt.i32(0, $i0);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 3} true;
  assume {:branchcond $i1} true;
  goto $bb1, $bb2;
$bb1:
  assume ($i1 == 1);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 3} true;
  $i2 := 0;
  goto $bb4;
$bb2:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 3} true;
  assume !(($i1 == 1));
  goto $bb3;
$bb3:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 530, 3} true;
  $i9 := 0;
  goto $bb8;
$bb4:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 529, 5} true;
  $p3 := $M.1;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 529, 5} true;
  $i4 := $sext.i32.i64($i2);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 529, 5} true;
  $p5 := $add.ref($p3, $mul.ref($i4, 4));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 529, 10} true;
  $M.2 := $store.i32($M.2, $p5, $sub.i32(0, 1));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 529, 5} true;
  goto $bb5;
$bb5:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 23} true;
  $i6 := $add.i32($i2, 1);
  call {:cexpr "i"} boogie_si_record_i32($i6);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 19} true;
  $i7 := $M.0;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 17} true;
  $i8 := $slt.i32($i6, $i7);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 3} true;
  assume {:branchcond $i8} true;
  goto $bb6, $bb7;
$bb6:
  assume ($i8 == 1);
  $i2 := $i6;
  goto $bb4;
$bb7:
  assume !(($i8 == 1));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 528, 3} true;
  goto $bb3;
$bb8:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 531, 5} true;
  $p10 := $M.3;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 531, 5} true;
  $i11 := $sext.i32.i64($i9);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 531, 5} true;
  $p12 := $add.ref($p10, $mul.ref($i11, 4));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 531, 10} true;
  $M.4 := $store.i32($M.4, $p12, $sub.i32(0, 1));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 531, 5} true;
  goto $bb9;
$bb9:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 530, 29} true;
  $i13 := $add.i32($i9, 1);
  call {:cexpr "i"} boogie_si_record_i32($i13);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 530, 17} true;
  $i14 := $slt.i32($i13, 127);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 530, 3} true;
  assume {:branchcond $i14} true;
  goto $bb10, $bb11;
$bb10:
  assume ($i14 == 1);
  $i9 := $i13;
  goto $bb8;
$bb11:
  assume !(($i14 == 1));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 532, 1} true;
  return;
}
const llvm.dbg.declare: ref;
axiom (llvm.dbg.declare == $sub.ref(0, 10326));
procedure  llvm.dbg.declare($p0: ref, $p1: ref, $p2: ref);
const main: ref;
axiom (main == $sub.ref(0, 11358));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $i0: i32;
  var $i1: i64;
  var $i2: i64;
  var $i3: i32;
  var $p4: ref8;
  var $p5: ref32;
  var $i6: i32;
  var $i7: i64;
  var $i8: i64;
  var $i9: i32;
  var $p10: ref8;
  var $p11: ref32;
  var $p12: ref32;
  var $p13: ref32;
  var $p14: ref32;
  var $p15: ref32;
  var $i16: i32;
  var $i17: i1;
  var $p18: ref32;
  var $p19: ref8;
  var $p20: ref32;
  var $p21: ref32;
  var $p22: ref8;
  var $p23: ref32;
  var $p24: ref8;
  var $p25: ref32;
  var $p26: ref32;
  var $p27: ref8;
$bb0:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 535, 5} true;
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 535, 5} true;
  $M.0 := 128;
  call {:cexpr "n"} boogie_si_record_i32(128);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 15} true;
  $i0 := $M.0;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 15} true;
  $i1 := $sext.i32.i64($i0);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 17} true;
  $i2 := $mul.i64($i1, 4);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 15} true;
  $i3 := $trunc.i64.i32($i2);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 7} true;
  call $p4 := malloc($i3);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 7} true;
  $p5 := $bitcast.ref.ref($p4);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 536, 5} true;
  $M.1 := $p4;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 15} true;
  $i6 := $M.0;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 15} true;
  $i7 := $sext.i32.i64($i6);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 17} true;
  $i8 := $mul.i64($i7, 4);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 15} true;
  $i9 := $trunc.i64.i32($i8);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 7} true;
  call $p10 := malloc($i9);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 7} true;
  $p11 := $bitcast.ref.ref($p10);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 537, 5} true;
  $M.3 := $p10;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 538, 5} true;
  $p12 := $M.3;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 538, 5} true;
  $p13 := $add.ref($p12, $mul.ref(1, 4));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 538, 5} true;
  $M.3 := $p13;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 538, 8} true;
  $M.4 := $store.i32($M.4, $p12, 0);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 539, 3} true;
  call foo();
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 540, 7} true;
  $p14 := $M.3;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 540, 7} true;
  $p15 := $add.ref($p14, $mul.ref($sub.ref(0, 2), 4));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 540, 7} true;
  $i16 := $load.i32($M.4, $p15);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 540, 7} true;
  $i17 := $ne.i32($i16, 0);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 540, 7} true;
  assume {:branchcond $i17} true;
  goto $bb1, $bb2;
$bb1:
  assume ($i17 == 1);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 10} true;
  $p18 := $M.1;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 10} true;
  $p19 := $bitcast.ref.ref($p18);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 5} true;
  call free_($p19);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 19} true;
  $p20 := $M.3;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 20} true;
  $p21 := $add.ref($p20, $mul.ref($sub.ref(0, 1), 4));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 19} true;
  $p22 := $bitcast.ref.ref($p21);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 14} true;
  call free_($p22);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 541, 25} true;
  goto $bb3;
$bb2:
  assume !(($i17 == 1));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 10} true;
  $p23 := $M.1;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 10} true;
  $p24 := $bitcast.ref.ref($p23);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 5} true;
  call free_($p24);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 19} true;
  $p25 := $M.3;
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 20} true;
  $p26 := $add.ref($p25, $mul.ref($sub.ref(0, 1), 4));
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 19} true;
  $p27 := $bitcast.ref.ref($p26);
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 543, 14} true;
  call free_($p27);
  goto $bb3;
$bb3:
  assume {:sourceloc "../testcases/svcomp/memsafety/960521-1-3.i", 544, 3} true;
  $r := 0;
  return;
}
const malloc: ref;
axiom (malloc == $sub.ref(0, 12390));
procedure  malloc($i0: i32)
  returns ($r: ref)
{
  call $r := $malloc($zext.i32.i64($i0));
}
const free_: ref;
axiom (free_ == $sub.ref(0, 13422));
procedure  free_($p0: ref)
{
  call $free($p0);
}
const llvm.dbg.value: ref;
axiom (llvm.dbg.value == $sub.ref(0, 14454));
procedure  llvm.dbg.value($p0: ref, $p1: ref, $p2: ref);
const __SMACK_static_init: ref;
axiom (__SMACK_static_init == $sub.ref(0, 15486));
procedure  __SMACK_static_init()
{
$bb0:
  $M.0 := 0;
  call {:cexpr "n"} boogie_si_record_i32(0);
  $M.1 := $0.ref;
  $M.3 := $0.ref;
  return;
}
procedure  boogie_si_record_i32(x: i32);
procedure  boogie_si_record_ref(x: ref);
procedure  $initialize()
{
  call __SMACK_static_init();
  return;
}