#include "smack/SHSymbolicExecutor.h"


namespace smack{
    using llvm::errs;
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
        auto appendSH = std::make_shared<SymbolicHeapExpr>(Expr::lit(true), mallocList);
        std::shared_ptr<SymbolicHeapExpr> sh = SymbolicHeapExpr::sh_and(this->currentSH, appendSH);
        this->currentSH.reset();
        this->currentSH = sh;
    }

    void SHSymbolicExecutor::executeFree(std::string varName){
        // TODOsh: varName usually is not the initial malloc name, here we need to determine which one to free or there is no such free item.
        

    }

    void SHSymbolicExecutor::executeCast(std::list<std::string> leftVarNames, std::list<std::string> rightVarNames){
        //TODOsh: the assignment should only cast one variable to another instead of a bunch ( which is allowed in Boogie ). Check later.
        if(leftVarNames.size() == 1 && rightVarNames.size() == 1){
            // ONLY able to deal with bitcast between two reference variables
            const Expr* addedPure = Expr::eq(new VarExpr(leftVarNames.front()), new VarExpr(rightVarNames.front()));
            std::shared_ptr<SymbolicHeapExpr> sh = std::make_shared<SymbolicHeapExpr>(Expr::and_(this->currentSH->getPure(), addedPure), this->currentSH->getSpatialExpr());
            this->currentSH.reset();
            this->currentSH = sh;
        } else {
            // current not solved.
        }
        
    }

    void SHSymbolicExecutor::executeOther(){
        // do nothing
    }

    std::shared_ptr<SymbolicHeapExpr> SHSymbolicExecutor::getCurrSH(){
        return this->currentSH;
    }
}