#include "../base_testbench.h"

unsigned int ticks = 0;

class BranchPredictor_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 0;
        top->rst = 0;

        // fetch
        top->pc_fetch = 0;

        // execute / update
        top->upd_bt = 0;
        top->pc_e = 0;
        top->upd_taken = 0;
        top->upd_target = 0;
    }

    // reseting the DUT
    void do_reset()
    {
        // Assert reset for a couple of cycles
        top->rst = 1;

        top->clk = 0;
        top->eval();
        top->clk = 1;
        top->eval();

        // Deassert reset
        top->rst = 0;
        top->clk = 0;
        top->eval();
        top->clk = 1;
        top->eval();
    }
};



//cold start behaviour on reset, predictor should predict not taken (pc+4)

TEST_F(BranchPredictor_tb, ColdStart_NotTaken_PCPlus4)
{
    do_reset();

    uint32_t BR_PC = 0x00000040;

    // No updates so the predictor should say not taken
    top->pc_fetch = BR_PC;
    top->eval();

    EXPECT_EQ(top->pred_taken, 0);
    EXPECT_EQ(top->pred_pc, BR_PC + 4);
}



// train as taken, then predict taken

TEST_F(BranchPredictor_tb, TrainTaken_PredictsTakenToTarget)
{
    do_reset();

    uint32_t BR_PC     = 0x00000040;
    uint32_t BR_TARGET = 0x00000100;

    // branch at BR_PC taken to BR_TARGET
    top->pc_e = BR_PC;
    top->upd_taken  = 1;
    top->upd_target = BR_TARGET;
    top->upd_bt = 1;

    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();   

    top->upd_bt = 0;
    top->clk = 0; top->eval();
    top->clk = 1; top->eval();

    // Second update FSM further towards taken
    top->pc_e = BR_PC;
    top->upd_taken = 1;
    top->upd_target = BR_TARGET;
    top->upd_bt = 1;

    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    top->upd_bt = 0;
    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    // place the same PC on fetch and it should predict taken to target now
    top->pc_fetch = BR_PC;
    top->eval();

    EXPECT_EQ(top->pred_taken, 1);
    EXPECT_EQ(top->pred_pc, BR_TARGET);
}



//train not taken so predictor moves back to not taken 

TEST_F(BranchPredictor_tb, TrainNotTaken_EventuallyNotTaken)
{
    do_reset();

    uint32_t BR_PC     = 0x00000040;
    uint32_t BR_TARGET = 0x00000100;

    // push predictor towards taken first 2x taken
    top->pc_e = BR_PC;
    top->upd_taken = 1;
    top->upd_target = BR_TARGET;
    top->upd_bt = 1;

    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    top->upd_bt = 0;
    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    top->pc_e = BR_PC;
    top->upd_taken = 1;
    top->upd_target = BR_TARGET;
    top->upd_bt = 1;

    top->clk = 0; top->eval();
    top->clk = 1; top->eval();

    top->upd_bt = 0;
    top->clk = 0; top->eval();
    top->clk = 1; top->eval();

    // now train the same branch as not taken twice
    top->pc_e = BR_PC;
    top->upd_taken  = 0;
    top->upd_target = BR_TARGET; 
    top->upd_bt = 1;

    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    top->upd_bt = 0;
    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    top->pc_e = BR_PC;
    top->upd_taken  = 0;
    top->upd_target = BR_TARGET;
    top->upd_bt = 1;

    top->clk = 0; top->eval();
    top->clk = 1; top->eval();

    top->upd_bt = 0;
    top->clk = 0; top->eval();
    top->clk = 1; top->eval();

    //after enough not taken outcomes predictor should prefer not taken 
    top->pc_fetch = BR_PC;
    top->eval();

    EXPECT_EQ(top->pred_taken, 0);
    EXPECT_EQ(top->pred_pc, BR_PC + 4);
}


//training one PC branch does not affect a different PC

TEST_F(BranchPredictor_tb, DifferentPC_DoesNotAliasEntry)
{
    do_reset();

    uint32_t BR_PC  = 0x00000040;
    uint32_t BR_TARGET = 0x00000100;
    uint32_t OTHER_PC  = 0x00001040; // should map to a different index

    // make BR_PC taken once
    top->pc_e       = BR_PC;
    top->upd_taken  = 1;
    top->upd_target = BR_TARGET;
    top->upd_bt     = 1;

    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    top->upd_bt = 0;
    top->clk = 0; 
    top->eval();
    top->clk = 1; 
    top->eval();

    // OTHER_PC has never been updated should still be not taken, PC+4
    top->pc_fetch = OTHER_PC;
    top->eval();

    EXPECT_EQ(top->pred_taken, 0);
    EXPECT_EQ(top->pred_pc, OTHER_PC + 4);
}



int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
