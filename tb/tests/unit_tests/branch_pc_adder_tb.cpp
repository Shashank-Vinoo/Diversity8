#include "../base_testbench.h"

unsigned int ticks = 0;

class Branch_PC_Adder_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->PC = 0;
        top->ImmOp = 0;
    }
};

TEST_F(Branch_PC_Adder_tb, BranchAdderT1)
{
    top->PC = 0;
    top->ImmOp = 20;
    top->eval();

    EXPECT_EQ(top->branch_PC, 20);
}

TEST_F(Branch_PC_Adder_tb, BranchAdderT2)
{
    top->PC = 34;
    top->ImmOp = -5;
    top->eval();

    EXPECT_EQ(top->branch_PC, 29);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
