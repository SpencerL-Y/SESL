// generated by SMACK version 2.6.3 for corral
// via /usr/local/bin/smack ../testcases/svcomp/memsafety/test-memleak_nexttime.i -ll ../testcases/svcomp/memsafety/test-memleak_nexttime_IR.ll --bpl ../testcases/svcomp/memsafety/test-memleak_nexttime.bpl -t --sh-mem-leak --add-line-info

const {:global_variable} {:pointer_to_size 64} {:count 8} a: ref;
axiom (a == $sub.ref(0, 1032));
const {:global_variable} {:pointer_to_size 16} .str: ref;
axiom (.str == $sub.ref(0, 2058));
const {:global_variable} {:pointer_to_size 192} {:count 24} .str.1: ref;
axiom (.str.1 == $sub.ref(0, 3106));
const {:global_variable} {:pointer_to_size 152} {:count 19} __PRETTY_FUNCTION__.reach_error: ref;
axiom (__PRETTY_FUNCTION__.reach_error == $sub.ref(0, 4149));
const reach_error: ref;
axiom (reach_error == $sub.ref(0, 5181));
procedure  reach_error()
{
$bb0:
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 12, 83} true;
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 12, 83} true;
  call __assert_fail(.str, .str.1, 3, __PRETTY_FUNCTION__.reach_error);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 12, 83} true;
  assume false;
}
const __assert_fail: ref;
axiom (__assert_fail == $sub.ref(0, 6213));
procedure  __assert_fail($p0: ref, $p1: ref, $i2: i32, $p3: ref);
const foo: ref;
axiom (foo == $sub.ref(0, 7245));
procedure  foo()
{
  var $p0: ref;
  var $p1: ref8;
  var $p2: ref32;
  var $p3: ref8;
  var $p4: ref8;
$bb0:
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 643, 20} true;
  call $p0 := $alloc($mul.ref(8, $zext.i32.i64(1)));
  assume true;
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 643, 20} true;
  call $p1 := malloc(10);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 643, 13} true;
  $p2 := $bitcast.ref.ref($p1);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 643, 9} true;
  $M.0 := $store.ref($M.0, $p0, $p1);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 644, 14} true;
  $p3 := $bitcast.ref.ref($p0);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 644, 4} true;
  call $p4 := memcpy(a, $p3, 8);
  assume $isExternal($p4);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 645, 1} true;
  return;
}
const llvm.dbg.declare: ref;
axiom (llvm.dbg.declare == $sub.ref(0, 8277));
procedure  llvm.dbg.declare($p0: ref, $p1: ref, $p2: ref);
const malloc: ref;
axiom (malloc == $sub.ref(0, 9309));
procedure  malloc($i0: i32)
  returns ($r: ref)
{
  call $r := $malloc($zext.i32.i64($i0));
}
const memcpy: ref;
axiom (memcpy == $sub.ref(0, 10341));
procedure  memcpy($p0: ref, $p1: ref, $i2: i32)
  returns ($r: ref);
const main: ref;
axiom (main == $sub.ref(0, 11373));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $p0: ref;
  var $p1: ref8;
  var $p2: ref8;
  var $p3: ref8;
$bb0:
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 648, 4} true;
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  call $p0 := $alloc($mul.ref(8, $zext.i32.i64(1)));
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 648, 4} true;
  call foo();
  assume true;
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 650, 11} true;
  $p1 := $bitcast.ref.ref($p0);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 650, 4} true;
  call $p2 := memcpy($p1, a, 8);
  assume $isExternal($p2);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 651, 9} true;
  $p3 := $load.ref($M.2, $p0);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 651, 4} true;
  call free_($p3);
  assume {:sourceloc "../testcases/svcomp/memsafety/test-memleak_nexttime.i", 652, 1} true;
  $r := 0;
  return;
}
const free_: ref;
axiom (free_ == $sub.ref(0, 12405));
procedure  free_($p0: ref)
{
  call $free($p0);
}
const __SMACK_static_init: ref;
axiom (__SMACK_static_init == $sub.ref(0, 13437));
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