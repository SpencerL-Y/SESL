#include "smack/sesl/bmc/BMCVCGen.h"

namespace smack
{
    std::vector<z3::expr> BlockNormalForm::getBNFVars(){
        std::list<std::string> varNames;
        for(int i = 0; i < this->length; i++){
            varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i)+ "_(" + std::to_string(this->primeNum) + ")");
            varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
            varNames.push_back("pta_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
            varNames.push_back("ptd_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        }
        varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length)+ "_(" + std::to_string(this->primeNum) + ")");
        varNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        std::vector<z3::expr> bnfVars;
        for(std::string s : varNames){
            z3::expr tempVar = this->z3Ctx->int_const(s.c_str());
            bnfVars.push_back(tempVar);
        }
        return bnfVars;
    }

    std::vector<z3::expr> BlockNormalForm::getBNFAddrVars(){
        std::list<std::string> addrVarNames;
        for(int i = 0; i < this->length; i++){
            addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i) + "_(" + std::to_string(this->primeNum) + ")");
            addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
            addrVarNames.push_back("pta_" + std::to_string(this->blockId) + "_" + std::to_string(2*i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        }
        addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length)+ "_(" + std::to_string(this->primeNum) + ")");
        addrVarNames.push_back("blka_" + std::to_string(this->blockId) + "_" + std::to_string(2*this->length + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        std::vector<z3::expr> bnfAddrVars;
        for(std::string s : addrVarNames){
            z3::expr tempVar = this->z3Ctx->int_const(s.c_str());
            bnfAddrVars.push_back(tempVar);
        }

        assert(bnfAddrVars.size() == this->length * 2 + 1);
        return bnfAddrVars;
    }

    std::vector<z3::expr> BlockNormalForm::getBNFDataVars(){
        std::list<std::string> dataVarNames;
        for(int i = 0; i < this->length; i ++){
            dataVarNames.push_back("ptd_" + std::to_string(this->blockId) + "_" + std::to_string(2 * i + 1)+ "_(" + std::to_string(this->primeNum) + ")");
        }
        std::vector<z3::expr> bnfDataVars;
        for(std::string s : dataVarNames){
            z3::expr tempVar = this->z3Ctx->int_const(s.c_str());
            bnfDataVars.push_back(tempVar);
        }
        return bnfDataVars;
    }

    z3::expr BlockNormalForm::generateInitialCondition(){
        z3::expr initCond = this->z3Ctx->bool_val(true);
        std::vector<z3::expr> addrVars = this->getBNFAddrVars();
        std::vector<z3::expr> dataVars = this->getBNFDataVars();
        for(z3::expr addr : addrVars){
            initCond = (initCond && (addr == BOT));
        }
        for(z3::expr data : dataVars){
            initCond = (initCond && (data == 0));
        }
        return initCond; 
    }

    z3::expr BlockNormalForm::generateImplicitConstraint(){
        z3::expr addrOrder = this->z3Ctx->bool_val(true);
        std::vector<z3::expr> addrList = this->getBNFAddrVars();
        for(int i = 0; i < addrList.size() - 1; i++){
            z3::expr left = addrList[i];
            z3::expr right = addrList[i + 1];
            addrOrder = (addrOrder && (left <= right));
        }

        z3::expr bottomSplit = this->z3Ctx->bool_val(true);
        for(int i = 0; i < addrList.size(); i ++){
            z3::expr premise = (addrList[i] == BOT);
            z3::expr implicant = this->z3Ctx->bool_val(true);
            for(int j = i + 1; j <addrList.size(); j ++){
                implicant = (implicant && (addrList[j] == BOT));
            }
            bottomSplit = bottomSplit && z3::implies(premise, implicant);
        }

        z3::expr headTailLinked = this->z3Ctx->bool_val(true);
        for(int i = 1; i < this->length; i++){
            // TODObmc: the number of byte number is currently defined as 1
            z3::expr tempEqual = (addrList[2 * i - 1] + 1 == addrList[2 * i]);
            headTailLinked = (headTailLinked && tempEqual);
        }

        z3::expr finalResult = (addrOrder && bottomSplit && headTailLinked);
        return finalResult;
    }

    RegionNormalForm::RegionNormalForm(z3::context& ctx, int regionNum, int length, int primeNum){
        this->maxRegionNum = regionNum;
        this->primeNum = primeNum;
        this->z3Ctx = &ctx;
        this->length = length;
        for(int i = 0; i < this->maxRegionNum; i++){
            this->bnfList[i] = std::make_shared<BlockNormalForm>(ctx, i, length, primeNum);
        }
    }

    z3::expr RegionNormalForm::genreateInitialCondition(){
        z3::expr rnfInitCond = this->z3Ctx->bool_val(true);
        for(BNFPtr bnf : this->bnfList){
            rnfInitCond = (rnfInitCond && bnf->generateInitialCondition());
        }
        return rnfInitCond;
    }
    
    z3::expr RegionNormalForm::generateImplicitConstraint(){
        z3::expr blkImplicitCons = this->z3Ctx->bool_val(true);
        for(BNFPtr bnf : this->bnfList){
            blkImplicitCons = (blkImplicitCons && bnf->generateImplicitConstraint());
        }

        z3::expr rnfImplicitCons = this->z3Ctx->bool_val(true);
        for(int i = 0; i < this->maxRegionNum; i++){
            for(int j = 0; j < this->maxRegionNum; i++){
                if(j == i) {
                    continue;
                } else {
                    BNFPtr iBnf = this->bnfList[i];
                    BNFPtr jBnf = this->bnfList[j];
                    std::vector<z3::expr> iVector = iBnf->getBNFAddrVars();
                    std::vector<z3::expr> jVector = jBnf->getBNFAddrVars();
                    rnfImplicitCons = (
                        rnfImplicitCons && 
                        !(iVector[0] >= jVector[0] && iVector[0] < jVector[2 * this->length + 1] || iVector[2 * this->length + 1] - 1 >= jVector[0] && iVector[0] < jVector[2*this->length + 1])
                    );
                }
            }
        }

        z3::expr finalResult = (blkImplicitCons && rnfImplicitCons);
        return finalResult;
    }

    std::vector<z3::expr> RegionNormalForm::getRNFVars(){
        std::vector<z3::expr> rnfVars;
        for(BNFPtr bnf : this->bnfList){
            std::vector<z3::expr> bnfVars = bnf->getBNFVars();
            for(z3::expr var : bnfVars){
                rnfVars.push_back(var);
            }
        }
        return rnfVars;
    }

} // namespace smack
