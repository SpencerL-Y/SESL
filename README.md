# SmackBasedPrj
## 6.11 TODO
* 指针算数
 * 所有有初值的指针算数：DONE 目前已有该功能
  * 该功能后续需要：
    - 找更多的例子进行实验
    - 在指针算术分裂时，需要知道分裂的块分配时的基本内存大小，比如是(int*)malloc还是(char*)malloc
* 数组支持
  - 6.15 本周加这个支持
* 类型信息——细化
* bitCast


## 6.15 TODO
* 指针算术的迭代:对已有代码debug，扩展到更类似于SV-COMP的例子上
* 添加数组的支持
*  之后还需要考虑：
 - 结构体以及结构体嵌套的处理
 - 指针的指针
 - 循环的处理
 - 值到指针，指针到值的cast

## 6.16 
考虑到的问题：
目前有对于malloc的基本指针算术单位，要翻译到验证，需要对数据结构的基本内存单位进行转换：
- 已有的变量数据结构如何转换？TODO: 有VarFactory，需要对纯公式中的变量进行替换。---> 直接根据变量名字进行替换
- 其他问题：目前这套框架不能定位出程序出错的位置。

## 6.23 
TODOs:
- 修复/8的bug DONE
- 修复blk语义导致的entailment不成功问题 DONE
- 修复blk分裂时，如果一开始malloc的大小是0的问题 DONE
- 加入对数组和结构体的支持 DONE
  - 对alloca函数进行相关的符号执行处理 DONE
  - 将所有变量在调用求解器之前转为字节为基本单位：需要在符号执行时所有变量的类型，等式翻译时的cast问题的处理，新旧变量之间的关系和新变量的取值约束 DONE

## 7.13
TODOs:
- Fix the bug for free (DONE)
- interprocedural analysis: call graph, order of function calls, recursive calls, context of stack elements, inlining
- library functions: alloca for basic variables, intepretation of byte variables.
