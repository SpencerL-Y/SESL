// generated by SMACK version 2.6.3 for corral
// via /usr/local/bin/smack ../testcases/printtest/exec.c -ll ../testcases/printtest/exec_IR.ll --bpl ../testcases/printtest/exec.bpl -t --sh-mem-leak

const main: ref;
axiom (main == $sub.ref(0, 1032));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $p0: ref;
  var $p1: ref8;
  var $p2: ref;
  var $p3: ref8;
  var $p4: ref;
  var $p5: ref;
  var $p6: ref8;
  var $p7: ref;
  var $p8: ref8;
  var $i9: i1;
  var $p10: ref;
  var $p11: ref;
$bb0:
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  call $p0 := $alloc($mul.ref(16, $zext.i32.i64(1)));
  assume true;
  call $p1 := malloc(16);
  $p2 := $add.ref($add.ref($p0, $mul.ref(0, 16)), $mul.ref(0, 1));
  $M.0 := $store.ref($M.0, $p2, $p1);
  call $p3 := malloc(24);
  $p4 := $add.ref($add.ref($p0, $mul.ref(0, 16)), $mul.ref(8, 1));
  $M.1 := $store.ref($M.1, $p4, $p3);
  $p5 := $add.ref($add.ref($p0, $mul.ref(0, 16)), $mul.ref(0, 1));
  $p6 := $load.ref($M.0, $p5);
  $p7 := $add.ref($add.ref($p0, $mul.ref(0, 16)), $mul.ref(8, 1));
  $p8 := $load.ref($M.1, $p7);
  $i9 := $eq.ref($p6, $p8);
  assume {:branchcond $i9} true;
  goto $bb1, $bb2;
$bb1:
  assume ($i9 == 1);
  call free_($p6);
  call free_($p8);
  goto $bb3;
$bb2:
  assume !(($i9 == 1));
  goto $bb3;
$bb3:
  $p10 := $add.ref($add.ref($p0, $mul.ref(0, 16)), $mul.ref(0, 1));
  $M.0 := $store.ref($M.0, $p10, $0.ref);
  $p11 := $add.ref($add.ref($p0, $mul.ref(0, 16)), $mul.ref(8, 1));
  $M.1 := $store.ref($M.1, $p11, $0.ref);
  $r := 0;
  return;
}
const llvm.dbg.declare: ref;
axiom (llvm.dbg.declare == $sub.ref(0, 2064));
procedure  llvm.dbg.declare($p0: ref, $p1: ref, $p2: ref);
const malloc: ref;
axiom (malloc == $sub.ref(0, 3096));
procedure  malloc($i0: i64)
  returns ($r: ref)
{
  call $r := $malloc($i0);
}
const free_: ref;
axiom (free_ == $sub.ref(0, 4128));
procedure  free_($p0: ref)
{
  call $free($p0);
}
const llvm.dbg.value: ref;
axiom (llvm.dbg.value == $sub.ref(0, 5160));
procedure  llvm.dbg.value($p0: ref, $p1: ref, $p2: ref);
const __SMACK_static_init: ref;
axiom (__SMACK_static_init == $sub.ref(0, 6192));
procedure  __SMACK_static_init()
{
$bb0:
  return;
}
procedure  boogie_si_record_ref(x: ref);
procedure  $initialize()
{
  call __SMACK_static_init();
  return;
}
