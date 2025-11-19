#include "base_testbench.h"

unsigned int ticks = 0;

class ImmGen_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->ImmSrc = 0;
        top->instruction = 0;

    }
};

//fromt he

TEST_F(ImmGen_tb, ImmSrc_I_Type)
{
    // lw x6, -4(x9)
    top->ImmSrc = 0;
    top->instruction = 0xFFC4A303;
    top->eval();
    EXPECT_EQ((int32_t)top->Imm, -4);
}

TEST_F(ImmGen_tb, ImmSrc_S_Type)
{
    // sw x6, 8(x9)
    top->ImmSrc = 1;
    top->instruction = 0x0064A423;
    top->eval();
    EXPECT_EQ((int32_t)top->Imm, 8);
}

TEST_F(ImmGen_tb, ImmSrc_B_Type)
{
    // beq x4, x4, L7 (backwards branch)
    // Slide imm = -12 (branch 3 instructions back)
    top->ImmSrc = 2;
    top->instruction = 0xFE420AE3;
    top->eval();
    EXPECT_EQ((int32_t)top->Imm, -12);
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

