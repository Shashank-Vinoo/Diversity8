#include "../base_testbench.h"

unsigned int ticks = 0;

class ALU_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->ALU_Op1 = 0;
        top->ALU_Op2 = 0;
        top->ALUctrl = 0;
    }
};

TEST_F(ALU_tb, ADD)
{
    top->ALU_Op1 = 5;
    top->ALU_Op2 = 10;
    top->ALUctrl = 0;
    top->eval();
    EXPECT_EQ(top->ALU_out, 15);
    EXPECT_EQ(top->EQ, 0);
}

TEST_F(ALU_tb, SUB)
{
    top->ALU_Op1 = 10;
    top->ALU_Op2 = 5;
    top->ALUctrl = 1;
    top->eval();
    EXPECT_EQ(top->ALU_out, 5);
    EXPECT_EQ(top->EQ, 0);
}

TEST_F(ALU_tb, EQ_Flag) // using sub to set the flag
{
    top->ALU_Op1 = 10;
    top->ALU_Op2 = 10;
    top->ALUctrl = 1;
    top->eval();
    EXPECT_EQ(top->ALU_out, 0);
    EXPECT_EQ(top->EQ, 1);
}

TEST_F(ALU_tb, OR)
{
    top->ALU_Op1 = 2;
    top->ALU_Op2 = 3;
    top->ALUctrl = 3;
    top->eval();
    EXPECT_EQ(top->ALU_out, 3);
    EXPECT_EQ(top->EQ, 0);
}

TEST_F(ALU_tb, AND)
{
    top->ALU_Op1 = 2;
    top->ALU_Op2 = 3;
    top->ALUctrl = 2;
    top->eval();
    EXPECT_EQ(top->ALU_out, 2);
    EXPECT_EQ(top->EQ, 0);
}

TEST_F(ALU_tb, SLT)
{
    top->ALU_Op1 = 2;
    top->ALU_Op2 = 5;
    top->ALUctrl = 5;
    top->eval();
    EXPECT_EQ(top->ALU_out, 1);
    EXPECT_EQ(top->EQ, 0);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
