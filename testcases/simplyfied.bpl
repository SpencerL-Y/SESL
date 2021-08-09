
// Basic types
type i1 = int;
type ref = i64;
type float;


// Basic constants
const $0: i32;
axiom ($0 == 0);
const $1: i32;
axiom ($1 == 1);
const $0.ref: ref;
axiom ($0.ref == 0);
const $1.ref: ref;
axiom ($1.ref == 1);
const $1024.ref: ref;
axiom ($1024.ref == 1024);
// Memory model constants
const $GLOBALS_BOTTOM: ref;
const $EXTERNS_BOTTOM: ref;
const $MALLOC_TOP: ref;

// Memory maps (5 regions)
var $M.0: i32;
var $M.1: [ref] i32;
var $M.2: [ref] ref;
var $M.3: [ref] i32;
var $M.4: [ref] i32;


// Memory address bounds
axiom ($GLOBALS_BOTTOM == $sub.ref(0, 21672));
axiom ($EXTERNS_BOTTOM == $add.ref($GLOBALS_BOTTOM, $sub.ref(0, 32768)));
axiom ($MALLOC_TOP == 9223372036854775807);
function {:inline} $isExternal(p: ref) returns (bool) { $slt.ref.bool(p, $EXTERNS_BOTTOM) }

// SMT bit-vector/integer conversion
function {:builtin "(_ int2bv 64)"} $int2bv.64(i: i64) returns (bv64);
function {:builtin "bv2nat"} $bv2int.64(i: bv64) returns (i64);


// Integer arithmetic operations
function {:inline} $add.i1(i1: i1, i2: i1) returns (i1) { (i1 + i2) }
function {:inline} $sub.i1(i1: i1, i2: i1) returns (i1) { (i1 - i2) }
function {:inline} $mul.i1(i1: i1, i2: i1) returns (i1) { (i1 * i2) }
function {:builtin "div"} $idiv.i1(i1: i1, i2: i1) returns (i1);
function {:inline} $sdiv.i1(i1: i1, i2: i1) returns (i1) { $idiv.i1(i1, i2) }
function {:inline} $udiv.i1(i1: i1, i2: i1) returns (i1) { $idiv.i1(i1, i2) }
function {:builtin "mod"} $smod.i1(i1: i1, i2: i1) returns (i1);
function {:builtin "mod"} $smod.i16(i1: i16, i2: i16) returns (i16);
function {:inline} $srem.i1(i1: i1, i2: i1) returns (i1) { (if ($ne.i1.bool($smod.i1(i1, i2), 0) && $slt.i1.bool(i1, 0)) then $sub.i1($smod.i1(i1, i2), $smax.i1(i2, $sub.i1(0, i2))) else $smod.i1(i1, i2)) }
function {:inline} $urem.i1(i1: i1, i2: i1) returns (i1) { $smod.i1(i1, i2) }
function $shl.i1(i1: i1, i2: i1) returns (i1);
function $lshr.i1(i1: i1, i2: i1) returns (i1);
function $ashr.i1(i1: i1, i2: i1) returns (i1);
function $and.i1(i1: i1, i2: i1) returns (i1);
function $or.i1(i1: i1, i2: i1) returns (i1);
function $xor.i1(i1: i1, i2: i1) returns (i1);
function $nand.i1(i1: i1, i2: i1) returns (i1);
function $not.i1(i: i1) returns (i1);
function {:inline} $smin.i1(i1: i1, i2: i1) returns (i1) { (if $slt.i1.bool(i1, i2) then i1 else i2) }
function {:inline} $smax.i1(i1: i1, i2: i1) returns (i1) { (if $sgt.i1.bool(i1, i2) then i1 else i2) }
function {:inline} $umin.i1(i1: i1, i2: i1) returns (i1) { (if $ult.i1.bool(i1, i2) then i1 else i2) }
function {:inline} $umax.i1(i1: i1, i2: i1) returns (i1) { (if $ugt.i1.bool(i1, i2) then i1 else i2) }

axiom ($and.i1(0, 0) == 0);
axiom ($or.i1(0, 0) == 0);
axiom ($xor.i1(0, 0) == 0);
axiom ($and.i1(0, 1) == 0);
axiom ($or.i1(0, 1) == 1);
axiom ($xor.i1(0, 1) == 1);
axiom ($and.i1(1, 0) == 0);
axiom ($or.i1(1, 0) == 1);
axiom ($xor.i1(1, 0) == 1);
axiom ($and.i1(1, 1) == 1);
axiom ($or.i1(1, 1) == 1);
axiom ($xor.i1(1, 1) == 0);
axiom ($and.i32(32, 16) == 0);

// Integer predicates

function {:inline} $ule.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 <= i2) }
function {:inline} $ult.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 < i2) }
function {:inline} $uge.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 >= i2) }
function {:inline} $ugt.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 > i2) }
function {:inline} $sle.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 <= i2) }
function {:inline} $slt.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 < i2) }
function {:inline} $sge.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 >= i2) }
function {:inline} $sgt.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 > i2) }
function {:inline} $eq.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 == i2) }
function {:inline} $ne.i1.bool(i1: i1, i2: i1) returns (bool) { (i1 != i2) }


// Integer load/store operations
function {:inline} $load.i1(M: [ref] i1, p: ref) returns (i1) { M[p] }
function {:inline} $store.i1(M: [ref] i1, p: ref, i: i1) returns ([ref] i1) { M[p := i] }

// Conversion between integer types
function {:inline} $trunc.i5.i1(i: i5) returns (i1) { i }
function {:inline} $sext.i1.i5(i: i1) returns (i5) { i }
function $extractvalue.i1(p: ref, i: int) returns (i1);

// Pointer arithmetic operations
function {:inline} $add.ref(p1: ref, p2: ref) returns (ref) { $add.i64(p1, p2) }
function {:inline} $sub.ref(p1: ref, p2: ref) returns (ref) { $sub.i64(p1, p2) }
function {:inline} $mul.ref(p1: ref, p2: ref) returns (ref) { $mul.i64(p1, p2) }

// Pointer predicates
function {:inline} $eq.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 == p2) }
function {:inline} $eq.ref(p1: ref, p2: ref) returns (i1) { (if $eq.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $ne.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 != p2) }
function {:inline} $ne.ref(p1: ref, p2: ref) returns (i1) { (if $ne.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $ugt.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 > p2) }
function {:inline} $ugt.ref(p1: ref, p2: ref) returns (i1) { (if $ugt.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $uge.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 >= p2) }
function {:inline} $uge.ref(p1: ref, p2: ref) returns (i1) { (if $uge.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $ult.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 < p2) }
function {:inline} $ult.ref(p1: ref, p2: ref) returns (i1) { (if $ult.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $ule.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 <= p2) }
function {:inline} $ule.ref(p1: ref, p2: ref) returns (i1) { (if $ule.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $sgt.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 > p2) }
function {:inline} $sgt.ref(p1: ref, p2: ref) returns (i1) { (if $sgt.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $sge.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 >= p2) }
function {:inline} $sge.ref(p1: ref, p2: ref) returns (i1) { (if $sge.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $slt.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 < p2) }
function {:inline} $slt.ref(p1: ref, p2: ref) returns (i1) { (if $slt.ref.bool(p1, p2) then 1 else 0) }
function {:inline} $sle.ref.bool(p1: ref, p2: ref) returns (bool) { (p1 <= p2) }
function {:inline} $sle.ref(p1: ref, p2: ref) returns (i1) { (if $sle.ref.bool(p1, p2) then 1 else 0) }

// Pointer load/store operations
function {:inline} $load.ref(M: [ref] ref, p: ref) returns (ref) { M[p] }
function {:inline} $store.ref(M: [ref] ref, p: ref, i: ref) returns ([ref] ref) { M[p := i] }


const main: ref;
axiom (main == $sub.ref(0, 2064));
procedure {:entrypoint} main()
  returns ($r: i32)
{
  var $i0: i32;
  var $p1: ref;
  var $p2: ref;
  var $p3: ref;
  var $p4: ref;
  var $p5: ref;
  var $p6: ref;
  var $p7: ref;
  var $p8: ref;
  var $p9: ref;
  var $p10: ref;
  var $p11: ref;
  var $i12: i32;
  var $i13: i1;
  var $p14: ref;
  var $p15: ref;
  var $p16: ref;
  var $p17: ref;
  var $p18: ref;
$bb0:
  call $initialize();
  assume {:sourceloc "../testcases/test1.c", 21, 5} true;
  assume {:verifier.code 0} true;
  call {:cexpr "smack:entry:main"} boogie_si_record_ref(main);
  assume {:sourceloc "../testcases/test1.c", 21, 5} true;
  assume {:verifier.code 0} true;
  call $i0 := func();
  assume {:sourceloc "../testcases/test1.c", 22, 14} true;
  assume {:verifier.code 0} true;
  call $p1 := malloc(4);
  assume {:sourceloc "../testcases/test1.c", 22, 14} true;
  assume {:verifier.code 0} true;
  $p2 := $bitcast.ref.ref($p1);
  assume {:sourceloc "../testcases/test1.c", 23, 8} true;
  assume {:verifier.code 0} true;
  $M.1 := $store.i32($M.1, $p2, 10);
  assume {:sourceloc "../testcases/test1.c", 25, 29} true;
  assume {:verifier.code 0} true;
  call $p3 := malloc(16);
  assume {:sourceloc "../testcases/test1.c", 25, 20} true;
  assume {:verifier.code 0} true;
  $p4 := $bitcast.ref.ref($p3);
  assume {:sourceloc "../testcases/test1.c", 26, 27} true;
  assume {:verifier.code 0} true;
  call $p5 := malloc(16);
  assume {:sourceloc "../testcases/test1.c", 26, 18} true;
  assume {:verifier.code 0} true;
  $p6 := $bitcast.ref.ref($p5);
  assume {:sourceloc "../testcases/test1.c", 26, 11} true;
  assume {:verifier.code 0} true;
  $p7 := $add.ref($add.ref($p4, $mul.ref(0, 16)), $mul.ref(8, 1));
  assume {:sourceloc "../testcases/test1.c", 26, 16} true;
  assume {:verifier.code 0} true;
  $M.2 := $store.ref($M.2, $p7, $p5);
  assume {:sourceloc "../testcases/test1.c", 27, 11} true;
  assume {:verifier.code 0} true;
  $p8 := $add.ref($add.ref($p4, $mul.ref(0, 16)), $mul.ref(0, 1));
  assume {:sourceloc "../testcases/test1.c", 27, 15} true;
  assume {:verifier.code 0} true;
  $M.3 := $store.i32($M.3, $p8, 123);
  assume {:sourceloc "../testcases/test1.c", 28, 11} true;
  assume {:verifier.code 0} true;
  $p9 := $add.ref($add.ref($p4, $mul.ref(0, 16)), $mul.ref(8, 1));
  assume {:sourceloc "../testcases/test1.c", 28, 11} true;
  assume {:verifier.code 0} true;
  $p10 := $load.ref($M.2, $p9);
  assume {:sourceloc "../testcases/test1.c", 28, 17} true;
  assume {:verifier.code 0} true;
  $p11 := $add.ref($add.ref($p10, $mul.ref(0, 16)), $mul.ref(0, 1));
  assume {:sourceloc "../testcases/test1.c", 28, 21} true;
  assume {:verifier.code 0} true;
  $M.4 := $store.i32($M.4, $p11, 456);
  assume {:sourceloc "../testcases/test1.c", 30, 8} true;
  assume {:verifier.code 0} true;
  $M.1 := $store.i32($M.1, $p2, 1);
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  goto $bb1;
$bb1:
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  $i12 := $load.i32($M.1, $p2);
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  $i13 := $eq.i32($i12, 1);
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  assume {:branchcond $i13} true;
  goto $bb2, $bb4;
$bb2:
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  assume ($i13 == 1);
  goto $bb3;
$bb3:
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  goto $bb5;
$bb4:
  assume !(($i13 == 1));
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 1} true;
  call __VERIFIER_assert(0);
  assume {:sourceloc "../testcases/test1.c", 31, 5} true;
  assume {:verifier.code 0} true;
  goto $bb3;
$bb5:
  assume {:sourceloc "../testcases/test1.c", 32, 10} true;
  assume {:verifier.code 0} true;
  $p14 := $bitcast.ref.ref($p2);
  assume {:sourceloc "../testcases/test1.c", 32, 5} true;
  assume {:verifier.code 0} true;
  call free_($p14);
  assume {:sourceloc "../testcases/test1.c", 33, 16} true;
  assume {:verifier.code 0} true;
  $p15 := $add.ref($add.ref($p4, $mul.ref(0, 16)), $mul.ref(8, 1));
  assume {:sourceloc "../testcases/test1.c", 33, 16} true;
  assume {:verifier.code 0} true;
  $p16 := $load.ref($M.2, $p15);
  assume {:sourceloc "../testcases/test1.c", 33, 10} true;
  assume {:verifier.code 0} true;
  $p17 := $bitcast.ref.ref($p16);
  assume {:sourceloc "../testcases/test1.c", 33, 5} true;
  assume {:verifier.code 0} true;
  call free_($p17);
  assume {:sourceloc "../testcases/test1.c", 34, 10} true;
  assume {:verifier.code 0} true;
  $p18 := $bitcast.ref.ref($p4);
  assume {:sourceloc "../testcases/test1.c", 34, 5} true;
  assume {:verifier.code 0} true;
  call free_($p18);
  assume {:sourceloc "../testcases/test1.c", 35, 8} true;
  assume {:verifier.code 0} true;
  $M.1 := $store.i32($M.1, $p2, 10);
  assume {:sourceloc "../testcases/test1.c", 36, 1} true;
  assume {:verifier.code 0} true;
  $r := 0;
  $exn := false;
  return;
}

// initialization of Memory model
const __SMACK_static_init: ref;
axiom (__SMACK_static_init == $sub.ref(0, 21672));
procedure {:inline 1} $initialize()
{
  call __SMACK_static_init();
  call __SMACK_init_func_memory_model();
  return;
}

procedure {:inline 1} __SMACK_static_init()
{
$bb0:
  $exn := false;
  return;
}

const malloc: ref;
axiom (malloc == $sub.ref(0, 2064));
procedure {:inline 1} malloc($i0: i64)
  returns ($r: ref)
{
  call $r := $malloc($i0);
}


const free_: ref;
axiom (free_ == $sub.ref(0, 3096));
procedure {:inline 1} free_($p0: ref)
{
  call $free($p0);
}


const __SMACK_check_overflow: ref;
axiom (__SMACK_check_overflow == $sub.ref(0, 16512));
procedure {:inline 1} __SMACK_check_overflow($i0: i32)
{
$bb0:
  assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 1604, 29} true;
  assume {:verifier.code 1} true;
  call {:cexpr "__SMACK_check_overflow:arg:flag"} boogie_si_record_i32($i0);
  assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 1604, 29} true;
  assume {:verifier.code 1} true;
  assume true;
  assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 1409, 3} true;
  assume {:verifier.code 1} true;
  assert {:overflow} $i0 == $0;
  assume {:sourceloc "/usr/local/share/smack/lib/smack.c", 1410, 1} true;
  assume {:verifier.code 0} true;
  $exn := false;
  return;
}