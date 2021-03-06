//
// This file is distributed under the MIT License. See LICENSE for details.
//
#include "smack/MemSafeMarker.h"
#include "smack/Debug.h"
#include "smack/Naming.h"
#include "smack/SmackOptions.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/ValueSymbolTable.h"

namespace smack {

using namespace llvm;

Function *MemSafeMarker::getLeakCheckFunction(Module &M) {
  auto F = M.getFunction(Naming::MEMORY_LEAK_FUNCTION);
  assert(F && "Memory leak check function must be present.");
  return F;
}

Function *MemSafeMarker::getSafetyCheckFunction(Module &M) {
  auto F = M.getFunction(Naming::MEMORY_SAFETY_FUNCTION);
  assert(F && "Memory safety check function must be present.");
  F->setDoesNotAccessMemory();
  F->setDoesNotThrow();
  return F;
}

Function *MemSafeMarker::getMyCheckFunction(Module &M) {
  auto F = M.getFunction(Naming::MEMORY_MY_FUNCTION);
  assert(F && "My memory check function must be present.");
  return F;
}

Function *MemSafeMarker::getWhatIsThisCheckFunction(Module &M){
  auto F = M.getFunction(Naming::WHATISTHIS_FUNCTION);
  assert(F && "what is This check must be present");
  return F;
}

void MemSafeMarker::copyDbgMetadata(Instruction *src, Instruction *dst) {
  dst->setMetadata("dbg", src->getMetadata("dbg"));
}

void MemSafeMarker::insertMemoryLeakCheck(Instruction *I) {
  auto &M = *I->getParent()->getParent()->getParent();
  auto ci = CallInst::Create(getLeakCheckFunction(M), "", I);
  copyDbgMetadata(I, ci);
}

void MemSafeMarker::insertMemoryAccessCheck(Value *addr, Value *size,
                                                  Instruction *I) {
  auto &M = *I->getParent()->getParent()->getParent();
  auto &C = M.getContext();
  auto T = PointerType::getUnqual(Type::getInt8Ty(C));
  auto ptrArg = CastInst::Create(Instruction::BitCast, addr, T, "", I);
  auto sizeArg = CastInst::CreateBitOrPointerCast(size, T, "", I);
  auto ci =
      CallInst::Create(getSafetyCheckFunction(M), {ptrArg, sizeArg}, "", I);
  copyDbgMetadata(I, ptrArg);
  copyDbgMetadata(I, sizeArg);
  copyDbgMetadata(I, ci);
}

void MemSafeMarker::insertMyMemoryCheck(Instruction *I){
  auto &M = *I->getParent()->getParent()->getParent();
  auto ci = CallInst::Create(getMyCheckFunction(M), "", I);
  copyDbgMetadata(I, ci);
}

void MemSafeMarker::insertWhatIsThisCheck(Instruction *I){
  auto &M = *I->getParent()->getParent()->getParent();
  auto ci = CallInst::Create(getWhatIsThisCheckFunction(M), "", I);
  copyDbgMetadata(I, ci);
}

bool MemSafeMarker::runOnFunction(Function &F) {
  if (Naming::isSmackName(F.getName()))
    return false;

  this->visit(F);
  return true;
}

void MemSafeMarker::visitReturnInst(llvm::ReturnInst &I) {
  auto &F = *I.getParent()->getParent();
  if (SmackOptions::isEntryPoint(F.getName())){
    insertMemoryLeakCheck(&I);
    insertMyMemoryCheck(&I);
    //insertWhatIsThisCheck(&I);
  }
    
}

namespace {
Value *accessSizeAsPointer(Module &M, Value *V) {
  auto T = dyn_cast<PointerType>(V->getType());
  assert(T && "expected pointer type");

  return ConstantExpr::getIntToPtr(
      ConstantInt::get(
          Type::getInt64Ty(M.getContext()),
          M.getDataLayout().getTypeStoreSize(T->getPointerElementType())),
      PointerType::getUnqual(Type::getInt8Ty(M.getContext())));
}

Value *accessSizeAsPointer(LoadInst &I) {
  auto &M = *I.getParent()->getParent()->getParent();
  return accessSizeAsPointer(M, I.getPointerOperand());
}

Value *accessSizeAsPointer(StoreInst &I) {
  auto &M = *I.getParent()->getParent()->getParent();
  return accessSizeAsPointer(M, I.getPointerOperand());
}
} // namespace

void MemSafeMarker::visitLoadInst(LoadInst &I) {
  insertMemoryAccessCheck(I.getPointerOperand(), accessSizeAsPointer(I), &I);
}

void MemSafeMarker::visitStoreInst(StoreInst &I) {
  insertMemoryAccessCheck(I.getPointerOperand(), accessSizeAsPointer(I), &I);
}

void MemSafeMarker::visitMemSetInst(MemSetInst &I) {
  insertMemoryAccessCheck(I.getDest(), I.getLength(), &I);
}

void MemSafeMarker::visitMemTransferInst(MemTransferInst &I) {
  insertMemoryAccessCheck(I.getDest(), I.getLength(), &I);
  insertMemoryAccessCheck(I.getSource(), I.getLength(), &I);
}

// Pass ID variable
char MemSafeMarker::ID = 0;
} // namespace smack
