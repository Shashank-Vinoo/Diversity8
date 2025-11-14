#include "base_testbench.h"

unsigned int ticks = 0;

class PC_REG_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 0;
        top->rst = 0;
        top->next_PC = 0;
    }
    void tick(){
    // Falling edge
    top->clk = 0;
    top->eval();

    // Rising edge (this triggers the always_ff block)
    top->clk = 1;
    top->eval();
    }
};



TEST_F(PC_REG_tb, PC_REG_tb_T1)
{
    top->rst=1;
    tick();
    EXPECT_EQ(top->PC,0);
}



TEST_F(PC_REG_tb, PC_REG_tb_T2)
{
    top->rst = 0;
    top->next_PC = 4;
    tick();
    EXPECT_EQ(top->PC, 4);
}


TEST_F(PC_REG_tb, PC_REG_tb_sequence_T3)
{
    top->rst = 0;
    top->next_PC = 4;
    tick();
    EXPECT_EQ(top->PC, 4);
    top->next_PC = 8;
    tick();
    EXPECT_EQ(top->PC, 8);
    top->rst = 1;
    tick();
    EXPECT_EQ(top->PC, 0);
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
