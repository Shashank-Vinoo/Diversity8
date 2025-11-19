#include "base_testbench.h"

unsigned int ticks = 0;

class RegFile_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 0;
        top->WE3 = 0;
        top->AD1 = 0;
        top->AD2 = 0;
        top->AD3 = 0;
        top->WD3 = 0;      
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
    top->WE3 = 1;
    top->AD1 = 0;
    top->AD2 = 0;
    top->AD3 = 1;
    top->WD3 = 5;     
    tick();
    top->WE3 = 0;
    top->AD1 = 1;
    top->eval();
    EXPECT_EQ(top->RD1,5);
}


TEST_F(RegFile_tb, Writing_and_readingREG0)
{
    top->WE3 = 1;
    top->AD1 = 0;
    top->AD2 = 0;
    top->AD3 = 0;
    top->WD3 = 5;     
    tick();
    top->WE3 = 0;
    top->eval();
    EXPECT_EQ(top->RD1,0);
}


TEST_F(RegFile_tb, a0_output)
{
    top->WE3 = 1;
    top->AD1 = 0;
    top->AD2 = 0;
    top->AD3 = 10;
    top->WD3 = 10;     
    tick();
    top->WE3 = 0;
    top->eval();
    EXPECT_EQ(top->a0,10);
}




int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
