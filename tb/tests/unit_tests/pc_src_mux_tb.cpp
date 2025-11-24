#include "../base_testbench.h"

unsigned int ticks = 0;

class PCsrc_MUX_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->pc_src = 0;
        top->branch_pc = 0;
        top->pc_plus4 = 0;
    }
};

TEST_F(PCsrc_MUX_tb, PCsrc_MUX_T1)
{
    top->pc_src = 1;
    top->branch_pc = 12;
    top->pc_plus4 = 0;
    top->eval();
    EXPECT_EQ(top->next_pc, 12);
}

TEST_F(PCsrc_MUX_tb, PCsrc_MUX_T2)
{
    top->pc_src = 0;
    top->branch_pc = 4;
    top->pc_plus4 = 8;
    top->eval();
    EXPECT_EQ(top->next_pc, 8);
}

TEST_F(PCsrc_MUX_tb, PCsrc_MUX_T3)
{
    top->pc_src = 1;
    top->branch_pc = 4;
    top->pc_plus4 = 0;
    top->eval();
    EXPECT_EQ(top->next_pc, 4);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
