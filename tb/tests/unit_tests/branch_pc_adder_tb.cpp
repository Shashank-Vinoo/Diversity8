#include "../base_testbench.h"

unsigned int ticks = 0;

class Branch_PC_Adder_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->pc = 0;
        top->imm_ext = 0;
    }
};

TEST_F(Branch_PC_Adder_tb, BranchAdderT1)
{
    top->pc = 0;
    top->imm_ext = 20;
    top->eval();

    EXPECT_EQ(top->branch_pc, 20);
}

TEST_F(Branch_PC_Adder_tb, BranchAdderT2)
{
    top->pc = 34;
    top->imm_ext = -5;
    top->eval();

    EXPECT_EQ(top->branch_pc, 29);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
