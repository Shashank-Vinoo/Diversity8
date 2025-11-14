#include "base_testbench.h"

unsigned int ticks = 0;

class PCsrc_MUX_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->PCsrc = 0;
        top->branch_PC = 0;
        top->inc_PC = 0;
    }
};


TEST_F(PCsrc_MUX_tb, PCsrc_MUX_T1)
{
    top->PCsrc = 1;
    top->branch_PC = 12;
    top->inc_PC = 0;
    top->eval();
    EXPECT_EQ(top->next_PC,12);
}



TEST_F(PCsrc_MUX_tb, PCsrc_MUX_T2)
{
    top->PCsrc = 0;
    top->branch_PC = 4;
    top->inc_PC = 8;
    top->eval();
    EXPECT_EQ(top->next_PC,8);
}


TEST_F(PCsrc_MUX_tb, PCsrc_MUX_T3)
{
    top->PCsrc = 1;
    top->branch_PC = 4;
    top->inc_PC = 0;
    top->eval();
    EXPECT_EQ(top->next_PC,4);
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
