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

    该函数中会下面的函数来处理不同的函数

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

      ### 寻找跳转代码

      #### goto语句生成

      核心函数

      ```cpp
      void SmackInstGenerator::generateGotoStmts(
          llvm::Instruction &inst,
          std::vector<std::pair<const Expr *, llvm::BasicBlock *>> targets) 
      ```

      targets是一个ector，用来保存，从Expr与BasicBlock组成的元组。该元组表示某个Expr将要跳转到哪一个LLVM的BasicBlock。

      Expr用来表示到达这块block所需要的条件，llvm BB就是相对应的块。

      inst应该是上一个块的跳转语句

      如果，target数量大于1，那么对于其中每一条语句
      
      * ```cpp
        if (target->getUniquePredecessor() == inst.getParent())
        ```
      
        * getUniquePredecessor 如果基本块有unique predecessor，返回这个predecessor，否则返回空指针；
        * inst.getParent()返回当前语句所在的LLVM BB
        * Q：这个判断实际上是说当前块只能从inst所在的块到达？
        
        如果LLVM BB的UniquePredecessor和指令的Parent一样
        
        找到目标块对应的Smack Block，在dispatch中将b的名字加入。
        
        否则，自己新建一个Smack block,做一些处理，相当于搞了一个中间节点。
        
        ```cpp
        annotate(inst, b);
        ```
        
        然后将SB加入到dispatch中，最后进行emit。
      
      如果数量=1：直接添加到disptch。
      
      最后Stmt::goto_(dispatch)，来生成对应的语句
      
      
      
      #### annotate
      
      * 首先，如果调用的函数名字里有llvm.dbg那么直接返回，不做处理
      * 如果指令中含有dbg信息，没有作处理
      * 注释？
      * Q：之后好像也没做什么处理，这里需要再看看
      
      Q：
      
      * Expr是啥，为啥会有多个LLVM BB？
      * dipatch是作什么的
      * 何时用到这个函数？
      * if中的条件是什么意思
      * instruaction有什么用
      * annotate函数作用
      * 如果获得当前stmt的类型，如何获得procedure的类型——在kind里面
      
      
      
      

