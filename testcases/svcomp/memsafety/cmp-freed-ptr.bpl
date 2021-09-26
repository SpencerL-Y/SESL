// generated by SMACK version 2.6.3 for corral
// via /usr/local/bin/smack ../svcomp/memsafety//cmp-freed-ptr.c -ll ../svcomp/memsafety//cmp-freed-ptr_IR.ll --bpl ../svcomp/memsafety//cmp-freed-ptr.bpl -t --sh-mem-leak

const main: ref;
axiom (main == $sub.ref(0, 1032));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $p0: ref8;
  var $p1: ref;
  var $i2: i64;
  var $p3: ref8;
  var $p4: ref8;
  var $p5: ref;
  var $i6: i64;
  var $i7: i1;
  var $p8: ref8;
  var $p9: ref8;
$bb0:
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  call $p0 := malloc(8);
  $p1 := $bitcast.ref.ref($p0);
  $i2 := $p2i.ref.i64($p1);
  call {:cexpr "adressY"} boogie_si_record_i64($i2);
  $p3 := $bitcast.ref.ref($p1);
  call free_($p3);
  call $p4 := malloc(8);
  $p5 := $bitcast.ref.ref($p4);
  $i6 := $p2i.ref.i64($p5);
  call {:cexpr "adressX"} boogie_si_record_i64($i6);
  $i7 := $eq.i64($i6, $i2);
  assume {:branchcond $i7} true;
  goto $bb1, $bb2;
$bb1:
  assume ($i7 == 1);
  $p8 := $bitcast.ref.ref($p5);
  call free_($p8);
  goto $bb3;
$bb2:
  assume !(($i7 == 1));
  goto $bb3;
$bb3:
  $p9 := $bitcast.ref.ref($p5);
  call free_($p9);
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
procedure  boogie_si_record_i64(x: i64);
procedure  boogie_si_record_ref(x: ref);
procedure  $initialize()
{
  call __SMACK_static_init();
  return;
}