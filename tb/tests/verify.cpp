#include "testbench.h"
#include <cstdlib>

#define CYCLES 10000

unsigned int ticks = 0;

class CpuTestbench : public Testbench
{
protected:
    void initializeInputs() override
    {
        top->clk = 1;
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


TEST_F(CpuTestbench, BaseProgramTest){
    bool success = false;
    compile("asm/program.S");
    top->rst = 1;
    runSimulation(1);
    top->rst = 0;

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
        FAIL() << "Counter did not reach 254";
    }
}


TEST_F(CpuTestbench, Countdown)
{
    compile("asm/count_down.S");
    // you need to reset the CPU as a previous test was already run
    top->rst = 1;
    runSimulation(1);
    top->rst = 0;

    bool success = false;

    // Run for enough cycles (30 is safe)
    for (int i = 0; i < 40; i++) {
        runSimulation(1);
        if (top->a0 == 0) {        
            SUCCEED();
            success = true;
            break;
        }
    }

    if (!success) {
        FAIL() << "Countdown did not reach 0";
    }
}



TEST_F(CpuTestbench, StoreLoadTest)
{
    
    compile("asm/store_load.S");

    // cpu reset
    top->rst = 1;
    runSimulation(1);
    top->rst = 0;

    bool success = false;

    // running enough cycles for lw to work
    for (int i = 0; i < 40; i++) {
        runSimulation(1);
        if (top->a0 == 10) {  
            success = true;
            SUCCEED();
            break;
        }
    }

    if (!success) {
        FAIL() << "Store/load test: a0 did not become 10";
    }
}



TEST_F(CpuTestbench, fibonacci)
{
    
    compile("asm/fib_10.S");

    // cpu reset
    top->rst = 1;
    runSimulation(1);
    top->rst = 0;

    bool success = false;

    // running enough cycles for lw to work
    for (int i = 0; i < CYCLES; i++) {
        runSimulation(1);
        if (top->a0 == 55) {  
            success = true;
            SUCCEED();
            break;
        }
    }

    if (!success) {
        FAIL() << "a0 is not 55 so not right fib10 value";
    }
}


TEST_F(CpuTestbench, Data_Hazards)
{
    
    compile("asm/DataHazards.S");

    // cpu reset
    top->rst = 1;
    runSimulation(1);
    top->rst = 0;

    bool success = false;

    // running enough cycles for lw to work
    for (int i = 0; i < CYCLES; i++) {
        runSimulation(1);
        if (top->a0 == 21) {  
            success = true;
            SUCCEED();
            break;
        }
    }

    if (!success) {
        FAIL() << "a0 is not 21 not valid";
    }
}







int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    auto res = RUN_ALL_TESTS();
    return res;
}
