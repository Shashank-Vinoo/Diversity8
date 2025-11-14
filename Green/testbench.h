#pragma once
#include "base_testbench.h"

class Testbench : public BaseTestbench
{
public:
    void tick()
    {
        top->clk = 0; top->eval();
        top->clk = 1; top->eval();
        ticks++;
    }
};
