// generated by SMACK version 2.6.3 for corral
// via /usr/local/bin/smack ../testcases/printtest/test3.c -ll ../testcases/printtest/test3_IR.ll --bpl ../testcases/printtest/test3.bpl -t

const main: ref;
axiom (main == $sub.ref(0, 1032));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $i0: i32;
  var $i1: i32;
  var $i2: i1;
  var $i3: i1;
  var $i5: i32;
  var $i6: i32;
  var $i7: i1;
  var $i8: i32;
  var $i9: i32;
  var $i4: i32;
  var $i10: i32;
$bb0:
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  $i0, $i1 := 0, 0;
  goto $bb1;
$bb1:
  $i2 := $slt.i32($i0, 6);
  assume {:branchcond $i2} true;
  goto $bb2, $bb3;
$bb2:
  assume ($i2 == 1);
  $i3 := $slt.i32($i0, 2);
  assume {:branchcond $i3} true;
  goto $bb4, $bb5;
$bb3:
  assume !(($i2 == 1));
  $r := 0;
  return;
$bb4:
  assume ($i3 == 1);
  $i4 := $i1;
  goto $bb6;
$bb5:
  assume !(($i3 == 1));
  $i5 := $add.i32($i1, 1);
  call {:cexpr "sum"} boogie_si_record_i32($i5);
  $i6 := $i0;
  goto $bb7;
$bb6:
  $i10 := $add.i32($i0, 1);
  call {:cexpr "i"} boogie_si_record_i32($i10);
  $i0, $i1 := $i10, $i4;
  goto $bb1;
$bb7:
  $i7 := $slt.i32($i6, $i5);
  assume {:branchcond $i7} true;
  goto $bb8, $bb9;
$bb8:
  assume ($i7 == 1);
  $i8 := $add.i32($i6, 1);
  call {:cexpr "j"} boogie_si_record_i32($i8);
  goto $bb10;
$bb9:
  assume !(($i7 == 1));
  $i4 := $i5;
  goto $bb6;
$bb10:
  $i9 := $add.i32($i8, 1);
  call {:cexpr "j"} boogie_si_record_i32($i9);
  $i6 := $i9;
  goto $bb7;
}
const llvm.dbg.declare: ref;
axiom (llvm.dbg.declare == $sub.ref(0, 2064));
procedure  llvm.dbg.declare($p0: ref, $p1: ref, $p2: ref);
const llvm.dbg.value: ref;
axiom (llvm.dbg.value == $sub.ref(0, 3096));
procedure  llvm.dbg.value($p0: ref, $p1: ref, $p2: ref);
const __SMACK_static_init: ref;
axiom (__SMACK_static_init == $sub.ref(0, 4128));
procedure  __SMACK_static_init()
{
$bb0:
  return;
}
procedure  boogie_si_record_i32(x: i32);
procedure  boogie_si_record_ref(x: ref);
procedure  $initialize()
{
  call __SMACK_static_init();
  return;
}