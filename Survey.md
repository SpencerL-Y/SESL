## From LLVM Bitcode to Boogie IVL
```
if (!Modular) {
    auto PreserveKeyGlobals = [=](const llvm::GlobalValue &GV) {
      std::string name = GV.getName();
      return smack::SmackOptions::isEntryPoint(name) ||
             smack::Naming::isSmackName(name) ||
             name.find("__VERIFIER_assume") != std::string::npos;
    };
    //createInternalizePass - This pass loops over all of the functions in the input module, internalizing all globals (functions and variables) it can.

    ------------------------------------------------------------
    1 ----------------------------------------------------------
    //Before internalizing a symbol, the callback MustPreserveGV is invoked and gives to the client the ability to prevent internalizing specific symbols.
    pass_manager.add(llvm::createInternalizePass(PreserveKeyGlobals));
    2 ----------------------------------------------------------
    //eliminate unreachable internal globals from the program
    pass_manager.add(llvm::createGlobalDCEPass());
    // Dead Inst Elimination performs a single pass over the function removing
    // instructions that are obviously dead
    pass_manager.add(llvm::createDeadCodeEliminationPass());

    pass_manager.add(llvm::createGlobalDCEPass());
    pass_manager.add(llvm::createDeadCodeEliminationPass());
    3 ----------------------------------------------------------
    // remove the dead function definitions except those who with special prefix as __SMACK_ : dead no calls or isTriviallyDead
    pass_manager.add(new smack::RemoveDeadDefs());
    ------------------------------------------------------------
  }

  ------------------------------------------------------------
  4 ----------------------------------------------------------
  // Sea-DSA: context-, field-, and array-sensitive unification-based points-to analysis for LLVM bitcode inspired by DSA
   /*
  *
  clang-format off
 
  Rewrites
   %_311 = bitcast i8** @msg_buf to i32*
   %_312 = load i32, i32* %_311, align 4
   %_313 = bitcast %struct.iovec* %_9 to i32*
   store i32 %_312, i32* %_313, align 4
 
   into
 
   %_311.ptr = bitcast i8** @msg_buf to i8**
   %_312.ptr = load i8*, i8** @_311.ptr, align 4
   %_313.ptr = bitcast %struct.iovec* %_9 to i8**
   store i8* %_312.ptr, i8** %_313.ptr, align 4
 
   clang-format on
  */
  pass_manager.add(seadsa::createRemovePtrToIntPass());
  5 ----------------------------------------------------------

  // The LowerSwitch transformation rewrites switch instructions with a sequence of branches, which allows targets to get away with not implementing the switch instruction until it is convenient.
  pass_manager.add(llvm::createLowerSwitchPass());

  6 ----------------------------------------------------------

  //This file promotes memory references to be register references. It promotes alloca instructions which only have loads and stores as uses. An alloca is transformed by using dominator frontiers to place phi nodes, then traversing the function in depth-first order to rewrite loads and stores as appropriate.
  pass_manager.add(llvm::createPromoteMemoryToRegisterPass());
  
  7 ----------------------------------------------------------
  // Unroll the loop
  if (StaticUnroll) {
    pass_manager.add(llvm::createLoopSimplifyPass());
    pass_manager.add(llvm::createLoopRotatePass());
    // pass_manager.add(llvm::createIndVarSimplifyPass());
    pass_manager.add(llvm::createLoopUnrollPass(32767));
  }
  
  8 ----------------------------------------------------------
  // pass_manager.add(new llvm::StructRet());
  // This pass normalizes loop structures to allow easier generation of Boogie code when a loop edge comes from a branch. Specifically, a forwarding block is added between a branching block and the loop header.
  pass_manager.add(new smack::NormalizeLoops());
  9 ----------------------------------------------------------
  // EV IV on loops
  pass_manager.add(new llvm::SimplifyEV());
  pass_manager.add(new llvm::SimplifyIV());
  10----------------------------------------------------------
  pass_manager.add(new smack::ExtractContracts());
  pass_manager.add(new smack::VerifierCodeMetadata());
  pass_manager.add(llvm::createDeadCodeEliminationPass());
  pass_manager.add(smack::createCodifyStaticInitsPass());
  if (!Modular) {
    pass_manager.add(new smack::RemoveDeadDefs());
  }
  pass_manager.add(new llvm::MergeArrayGEP());
  // pass_manager.add(new smack::SimplifyLibCalls());
  pass_manager.add(new llvm::Devirtualize());
  pass_manager.add(new smack::SplitAggregateValue());

  11----------------------------------------------------------
  //Checker passes
  if (smack::SmackOptions::MemorySafety) {
    pass_manager.add(new smack::MemorySafetyChecker());
  }

  pass_manager.add(new smack::IntegerOverflowChecker());

  if (smack::SmackOptions::RewriteBitwiseOps &&
      !(smack::SmackOptions::BitPrecise ||
        smack::SmackOptions::BitPrecisePointers)) {
    pass_manager.add(new smack::RewriteBitwiseOps());
  }

  if (smack::SmackOptions::AddTiming) {
    Triple ModuleTriple(module->getTargetTriple());
    assert(
        ModuleTriple.getArch() &&
        "Module has no defined architecture: unable to add timing annotations");

    const TargetOptions Options;  /* = InitTargetOptionsFromCodeGenFlags();*/
    std::string CPUStr = "";      /*getCPUStr();*/
    std::string FeaturesStr = ""; /*getFeaturesStr();*/
    TargetMachine *Machine =
        GetTargetMachine(ModuleTriple, CPUStr, FeaturesStr, Options);

    assert(Machine &&
           "Module did not have a Target Machine: Cannot set up timing pass");
    // Add an appropriate TargetLibraryInfo pass for the module's triple.
    TargetLibraryInfoImpl TLII(ModuleTriple);
    pass_manager.add(new TargetLibraryInfoWrapperPass(TLII));

    // Add internal analysis passes from the target machine.
    pass_manager.add(
        createTargetTransformInfoWrapperPass(Machine->getTargetIRAnalysis()));
    pass_manager.add(new smack::AddTiming());
```
## Important Passes

- SmackModuleGenerator
- MemorySafetyChecker
- IntegerOverflowChecker
- BplFilePrinter


## Important Classes
- SmackRep
- BoogieAST



