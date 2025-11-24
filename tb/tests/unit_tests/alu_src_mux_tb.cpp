#include "../base_testbench.h"

unsigned int ticks = 0;

class ALU_Src_Mux_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->reg_op2 = 0;
        top->imm_ext = 0;
        top->alu_src = 0;
    }
};

TEST_F(ALU_Src_Mux_tb, T1)
{
    top->alu_src = 1;
    top->imm_ext = 12;
    top->reg_op2 = 25;
    top->eval();
    EXPECT_EQ(top->alu_op2, 12);
}

TEST_F(ALU_Src_Mux_tb, T2)
{
    top->alu_src = 0;
    top->imm_ext = 12;
    top->reg_op2 = 25;
    top->eval();
    EXPECT_EQ(top->alu_op2, 25);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
