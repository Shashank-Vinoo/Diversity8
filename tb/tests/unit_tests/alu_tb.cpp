#include "../base_testbench.h"

unsigned int ticks = 0;

class ALU_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->alu_op1 = 0;
        top->alu_op2 = 0;
        top->alu_ctrl = 0;
    }
};

TEST_F(ALU_tb, ADD)
{
    top->alu_op1 = 5;
    top->alu_op2 = 10;
    top->alu_ctrl = 0;
    top->eval();
    EXPECT_EQ(top->alu_out, 15);
    EXPECT_EQ(top->eq, 0);
}

TEST_F(ALU_tb, SUB)
{
    top->alu_op1 = 10;
    top->alu_op2 = 5;
    top->alu_ctrl = 1;
    top->eval();
    EXPECT_EQ(top->alu_out, 5);
    EXPECT_EQ(top->eq, 0);
}

TEST_F(ALU_tb, EQ_Flag) // using sub to set the flag
{
    top->alu_op1 = 10;
    top->alu_op2 = 10;
    top->alu_ctrl = 1;
    top->eval();
    EXPECT_EQ(top->alu_out, 0);
    EXPECT_EQ(top->eq, 1);
}

TEST_F(ALU_tb, OR)
{
    top->alu_op1 = 2;
    top->alu_op2 = 3;
    top->alu_ctrl = 3;
    top->eval();
    EXPECT_EQ(top->alu_out, 3);
    EXPECT_EQ(top->eq, 0);
}

TEST_F(ALU_tb, AND)
{
    top->alu_op1 = 2;
    top->alu_op2 = 3;
    top->alu_ctrl = 2;
    top->eval();
    EXPECT_EQ(top->alu_out, 2);
    EXPECT_EQ(top->eq, 0);
}

TEST_F(ALU_tb, SLT)
{
    top->alu_op1 = 2;
    top->alu_op2 = 5;
    top->alu_ctrl = 5;
    top->eval();
    EXPECT_EQ(top->alu_out, 1);
    EXPECT_EQ(top->eq, 0);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
