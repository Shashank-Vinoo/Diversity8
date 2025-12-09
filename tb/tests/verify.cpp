#include "testbench.h"
#include <cstdlib>

#define CYCLES 10000

unsigned int ticks = 0;

class CpuTestbench : public Testbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 0;
        top->rst = 1;
    }

    void resetCpu(int cycles = 2)
    {
        top->rst = 1;
        runSimulation(cycles);
        top->rst = 0;
    }
};

// Note this is how we are going to test your CPU. Do not worry about this for
// now, as it requires a lot more instructions to function
// TEST_F(CpuTestbench, Return5Test)
// {
//     system("./compile.sh c/return_5.c");
//     runSimulation(100);
//     EXPECT_EQ(top->a0, 5);
// }

TEST_F(CpuTestbench, BaseProgram)
{
    bool success = false;
    compile("asm/program.S");
    resetCpu();

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
        if (top->a0 == 254)
        {
            SUCCEED();
            success = true;
            break;
        }
    }
    if (!success)
    {
        FAIL() << "Counter did not reach 254, current a0 value: " << top->a0;
    }
}

TEST_F(CpuTestbench, Countdown)
{
    compile("asm/count_down.S");
    resetCpu();

    bool success = false;

    // Run for enough cycles (30 is safe)
    for (int i = 0; i < 40; i++)
    {
        runSimulation(1);
        if (top->a0 == 0)
        {
            success = true;
            SUCCEED();
            break;
        }
    }

    if (!success)
    {
        FAIL() << "Countdown did not reach 0, current a0 value: " << top->a0;
    }
}

TEST_F(CpuTestbench, StoreLoad)
{

    compile("asm/store_load.S");

    resetCpu();

    bool success = false;

    // running enough cycles for lw to work
    for (int i = 0; i < 40; i++)
        runSimulation(1);

    if (top->a0 == 10)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "a0 did not become 10, current a0 value: " << top->a0;
    }
}

TEST_F(CpuTestbench, Fibonacci10)
{

    compile("asm/fib_10.S");

    resetCpu();

    bool success = false;

    // running enough cycles for lw to work
    for (int i = 0; i < CYCLES; i++)
        runSimulation(1);

    if (top->a0 == 55)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "a0 is not 55 so not right fib10 value, current a0 value: " << top->a0;
    }
}

TEST_F(CpuTestbench, DataHazards)
{

    compile("asm/data_hazards.S");

    resetCpu();

    bool success = false;

    // running enough cycles for lw to work
    for (int i = 0; i < CYCLES; i++)
        runSimulation(1);

    if (top->a0 == 21)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "a0 is not 21 not valid, current a0 value: " << top->a0;
    }
}

TEST_F(CpuTestbench, LoadUseHazard)
{
    compile("asm/lw_hazard.S");
    resetCpu();

    bool success = false;

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
    }

    if (top->a0 == 20)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "Load-use hazard failed, a0 != 20. Current a0: " << top->a0;
    }
}

TEST_F(CpuTestbench, GeneralHazards)
{
    compile("asm/general_hazards.S");
    resetCpu();

    bool success = false;

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation(1);
    }
    if (top->a0 == 28)
    {
        success = true;
        SUCCEED();
    }
    if (!success)
    {
        FAIL() << "GeneralHazards failed, a0 != 28. Current a0: " << top->a0;
    }
}

TEST_F(CpuTestbench, Multiply_Divide)
{
    compile("asm/multiply_divide.S");
    resetCpu();

    bool success = false;

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation();
    }

    if (top->a0 == 511, 192, 483)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "Multiply_Divide test failed, a0 != -178. Current a0 : " << top->a0;
    }
}

TEST_F(CpuTestbench, DivisionByZero)
{
    compile("asm/division_by_zero.S");
    resetCpu();

    bool success = false;

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation();
    }

    if (top->a0 == 244)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "Division by zero test failed, a0 != 244. Current a0 : " << top->a0;
    }
}



TEST_F(CpuTestbench, Cache)
{
    compile("asm/cache.S");
    resetCpu();

    bool success = false;

    for (int i = 0; i < CYCLES; i++)
    {
        runSimulation();
    }

    if (top->a0 == 42)
    {
        success = true;
        SUCCEED();
    }

    if (!success)
    {
        FAIL() << "Division by zero test failed, a0 != 42. Current a0 : " << top->a0;
    }
}


int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();
    return res;
}
