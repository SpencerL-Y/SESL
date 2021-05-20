#include "smack/SHSymbolicExecutor.h"
#include "smack/Debug.h"

namespace smack{
    void SHSymbolicExecutor::executeMalloc(std::string varName, const Expr* size){
        // TODOsh: need to use a map to store all pair of string, variable
        std::list<const SpatialLiteral*> mallocList;
        const Expr* varExpr = new VarExpr(varName);
        const SpatialLiteral* sizePt = SpatialLiteral::pt(varExpr, size);
        unsigned one = 1;
        const Expr* fromExpr = new BinExpr(BinExpr::Plus, varExpr, Expr::lit(one));
        const Expr* toExpr = new BinExpr(BinExpr::Plus, fromExpr, size);
        const SpatialLiteral* blkLit = SpatialLiteral::blk(fromExpr, toExpr);
        mallocList.push_back(sizePt);
        mallocList.push_back(blkLit);
        SymbolicHeapExpr* appendSH = new SymbolicHeapExpr(Expr::lit(true), mallocList);
        SymbolicHeapExpr* sh = SymbolicHeapExpr::sh_and(this->currentSH, appendSH);
        this->currentSH = sh;
        
    }

    void SHSymbolicExecutor::executeFree(std::string varName){

    }

    void SHSymbolicExecutor::executeCast(std::string leftVarName, std::string rightVarName){
        
    }

    void SHSymbolicExecutor::executeOther(){
        // do nothing
    }

    SymbolicHeapExpr *SHSymbolicExecutor::getCurrSH(){
        return this->currentSH;
    }
}