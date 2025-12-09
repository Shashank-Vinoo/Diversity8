#pragma once

#include "base_testbench.h"

/**
 * Class only exists because top->clk is not always accessible in the testbench,
 * and will otherwise not compile.
 */
class Testbench : public BaseTestbench
{
public:
    // Runs the simulation for a clock cycle, evaluates the DUT, dumps waveform.
    void runSimulation(int cycles = 1)
    {
        for (int i = 0; i < cycles; i++)
        {
            // Drive a full low->high cycle and evaluate after each edge so
            // reset/pipeline flops see the intended clock transition.
            top->clk = 0;
            top->eval();
#ifndef __APPLE__
            tfp->dump(2 * ticks);
#endif

            top->clk = 1;
            top->eval();
#ifndef __APPLE__
            tfp->dump(2 * ticks + 1);
#endif

            if (Verilated::gotFinish())
            {
                exit(0);
            }
            ticks++;
        }
    }

    void compile(const std::string &program)
    {
        // Compile
        int ret = system(("./compile.sh " + program).c_str());
        if (ret != 0)
        {
            FAIL() << "Compilation failed for " << program;
        }
    }
};
