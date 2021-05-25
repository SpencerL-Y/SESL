# 代码阅读

## BasicBlock相关

### BasicBlock存储问题

Block信息被保存在Program里面DeclarationList decls中，里面的Decl有一部分是ProcDecl。ProcDecl继承了CodeContainer ，CodeContainer中保存了block信息。



**相关代码：**

Smack进行处理的入口函数为SmackModuleGenerator中的：

```cpp
void SmackModuleGenerator::generateProgram(llvm::Module &M) 
```

SmackModuleGenerator初始化时会新建一个Program

* generateProgram函数中首先创建一个SmackRep

  ```cpp
  SmackRep rep(&M.getDataLayout(), &naming, program, &getAnalysis<Regions>());
  ```

* 之后对于LLVM Module中的所有function

  * 提取所有声明

  * 找到function中的caller,建立对应的ProcDecl指针list，然后插入到program的decls中

    ```cpp
    auto procs = rep.procedure(&F);
    if (naming.get(F) != Naming::DECLARATIONS_PROC)
     decls.insert(decls.end(), procs.begin(), procs.end());
    ```

    该函数中会调用，处理不同的函数
  
    ```cpp
  ProcDecl *SmackRep::procedure(Function *F, CallInst *CI)
    ```

  * 对procs中的每个proc

    * 新建一个SmackInstGenerator
  
      ```c++
      for (auto P : procs) {
        SmackInstGenerator igen(
            getAnalysis<LoopInfoWrapperPass>(F).getLoopInfo(), &rep, P,
          &naming);
      ```

      * SmackInstGenerator中有std::map<const llvm::BasicBlock *, Block *> blockMap;

    * 调用
  
      ```cpp
    void visitBasicBlock(llvm::BasicBlock &bb);
      ```

      在该函数中，调用
  
      ```cpp
      currBlock = getBlock(&bb);
      
      Block *SmackInstGenerator::getBlock(llvm::BasicBlock *bb) {
        if (blockMap.count(bb) == 0)
          blockMap[bb] = createBlock();
        return blockMap[bb];
      }
      
      Block *SmackInstGenerator::createBlock() {
        Block *b = Block::block(naming->freshBlockName());
        proc->getBlocks().push_back(b);
        return b;
    }
      ```
  
      这个函数，如果之前该LLVM block已经有对应的函数，那么使用原来的block；否则，新建一个block，存储在传入的SmackInstGenerator的proc中的CodeContainer中的BlockList中
      
      

