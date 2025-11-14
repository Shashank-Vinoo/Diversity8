#include "base_testbench.h"

unsigned int ticks = 0;

class ALU_Src_Mux_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->regOp2 = 0;
        top->ImmOp = 0;
        top->ALUsrc = 0;
    }
};

TEST_F(ALU_Src_Mux_tb,T1)
{
    top->ALUsrc = 1;
    top->ImmOp = 12;
    top->regOp2 = 25;
    top->eval();
    EXPECT_EQ(top->ALUOp2,12);
}

TEST_F(ALU_Src_Mux_tb,T2)
{
    top->ALUsrc = 0;
    top->ImmOp = 12;
    top->regOp2 = 25;
    top->eval();
    EXPECT_EQ(top->ALUOp2,25);
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}




