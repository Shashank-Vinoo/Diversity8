#include "../base_testbench.h"

unsigned int ticks = 0;

class RegFile_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 0;
        top->we3 = 0;
        top->rs1 = 0;
        top->rs2 = 0;
        top->rd = 0;
        top->wd3 = 0;
    }
    void tick()
    {
        // Falling edge
        top->clk = 0;
        top->eval();

        // Rising edge (this triggers the always_ff block)
        top->clk = 1;
        top->eval();
    }
};

TEST_F(RegFile_tb, Writing_and_reading)
{
    top->we3 = 1;
    top->rs1 = 0;
    top->rs2 = 0;
    top->rd = 1;
    top->wd3 = 5;
    tick();
    top->we3 = 0;
    top->rs1 = 1;
    top->eval();
    EXPECT_EQ(top->rd1, 5);
}

TEST_F(RegFile_tb, Writing_and_readingREG0)
{
    top->we3 = 1;
    top->rs1 = 0;
    top->rs2 = 0;
    top->rd = 0;
    top->wd3 = 5;
    tick();
    top->we3 = 0;
    top->eval();
    EXPECT_EQ(top->rd1, 0);
}

TEST_F(RegFile_tb, a0_output)
{
    top->we3 = 1;
    top->rs1 = 0;
    top->rs2 = 0;
    top->rd = 10;
    top->wd3 = 10;
    tick();
    top->we3 = 0;
    top->eval();
    EXPECT_EQ(top->a0, 10);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
