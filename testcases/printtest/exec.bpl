// generated by SMACK version 1.0.2 for corral
// via /usr/local/bin/sesl ../testcases/printtest/exec.c -ll ../testcases/printtest/exec_IR.ll --bpl ../testcases/printtest/exec.bpl -t --sh-mem-leak --add-line-info -bw 32 --svcomp-property ../../sv-benchmarks/c/properties/valid-memsafety.prp

const main: ref;
axiom (main == $sub.ref(0, 1032));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $i0: i64;
  var $i1: i64;
  var $p2: ref8;
  var $p3: ref32;
  var $i4: i32;
  var $p5: ref32;
  var $p6: ref32;
  var $i7: i32;
  var $i8: i32;
  var $p9: ref8;
  var $i10: i32;
$bb0:
  assume {:sourceloc "../testcases/printtest/exec.c", 157, 31} true;
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  assume {:sourceloc "../testcases/printtest/exec.c", 157, 31} true;
  $i0 := $sext.i32.i64(5);
  assume {:sourceloc "../testcases/printtest/exec.c", 157, 34} true;
  $i1 := $mul.i64($i0, 4);
  assume {:sourceloc "../testcases/printtest/exec.c", 157, 24} true;
  call $p2 := malloc($i1);
  assume {:sourceloc "../testcases/printtest/exec.c", 157, 18} true;
  $p3 := $bitcast.ref.ref($p2);
  assume {:sourceloc "../testcases/printtest/exec.c", 158, 22} true;
  $i4 := $add.i32(5, $sub.i32(0, 1));
  assume {:sourceloc "../testcases/printtest/exec.c", 158, 12} true;
  $p5 := $add.ref($p3, $mul.ref(1, 4));
  assume {:sourceloc "../testcases/printtest/exec.c", 158, 16} true;
  $M.0 := $store.i32($M.0, $p5, $i4);
  assume {:sourceloc "../testcases/printtest/exec.c", 159, 23} true;
  $p6 := $add.ref($p3, $mul.ref(1, 4));
  assume {:sourceloc "../testcases/printtest/exec.c", 159, 20} true;
  $i7 := $load.i32($M.0, $p6);
  assume {:sourceloc "../testcases/printtest/exec.c", 159, 27} true;
  $i8 := $add.i32($i7, $sub.i32(0, 1));
  call {:cexpr "nnum"} boogie_si_record_i32($i8);
  assume {:sourceloc "../testcases/printtest/exec.c", 160, 14} true;
  $p9 := $bitcast.ref.ref($p3);
  assume {:sourceloc "../testcases/printtest/exec.c", 160, 9} true;
  call free_($p9);
  assume {:sourceloc "../testcases/printtest/exec.c", 161, 10} true;
  $i10 := $add.i32($u0, 1);
  call {:cexpr "i"} boogie_si_record_i32($i10);
  assume {:sourceloc "../testcases/printtest/exec.c", 163, 5} true;
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
const {:global_variable} $u0: i32;
procedure  boogie_si_record_i32(x: i32);
procedure  boogie_si_record_ref(x: ref);
procedure  $initialize()
{
  call __SMACK_static_init();
  return;
}
