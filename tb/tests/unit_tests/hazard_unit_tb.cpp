#include "../base_testbench.h"

unsigned int ticks = 0;

class HazardUnit_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->branch = 0;
        top->rs1_d = 0;
        top->rs2_d = 0;
        top->rs1_e = 0;
        top->rs2_e = 0;
        top->mem_read_e = 0;
        top->rd_e = 0;
        top->rd_m = 0;
        top->reg_write_m = 0;
        top->rd_w = 0;
        top->reg_write_w = 0;
    }
};

TEST_F(HazardUnit_tb, NoHazardsNoForwarding)
{
    top->branch = 0;
    top->rs1_d = 4;
    top->rs2_d = 5;
    top->rs1_e = 1;
    top->rs2_e = 2;
    top->mem_read_e = 0;
    top->rd_e = 0;
    top->rd_m = 0;
    top->reg_write_m = 0;
    top->rd_w = 0;
    top->reg_write_w = 0;
    top->eval();

    EXPECT_EQ(top->flush, 0);
    EXPECT_EQ(top->stall, 0);
    EXPECT_EQ(top->forward_a_e, 0b00);
    EXPECT_EQ(top->forward_b_e, 0b00);
}

TEST_F(HazardUnit_tb, BranchFlushesPipeline)
{
    top->branch = 1;
    top->mem_read_e = 0;
    top->rd_e = 0;
    top->rs1_d = 0;
    top->rs2_d = 0;
    top->eval();

    EXPECT_EQ(top->flush, 1);
    EXPECT_EQ(top->stall, 0);
}

TEST_F(HazardUnit_tb, DataForwarding)
{
    top->branch = 0;
    top->rs1_d = 0;
    top->rs2_d = 0;
    top->mem_read_e = 0;
    top->rd_e = 0;
    top->reg_write_m = 1;
    top->rd_m = 3;
    top->reg_write_w = 0;
    top->rd_w = 0;
    top->rs1_e = 3;
    top->rs2_e = 3;
    top->eval();

    EXPECT_EQ(top->flush, 0);
    EXPECT_EQ(top->stall, 0);
    EXPECT_EQ(top->forward_a_e, 0b10);
    EXPECT_EQ(top->forward_b_e, 0b10);
}

TEST_F(HazardUnit_tb, WritebackForwarding)
{
    top->branch = 0;
    top->rs1_d = 0;
    top->rs2_d = 0;
    top->mem_read_e = 0;
    top->rd_e = 0;
    top->reg_write_m = 0;
    top->rd_m = 0;
    top->reg_write_w = 1;
    top->rd_w = 7;
    top->rs1_e = 7;
    top->rs2_e = 1;
    top->eval();

    EXPECT_EQ(top->stall, 0);
    EXPECT_EQ(top->forward_a_e, 0b01);
    EXPECT_EQ(top->forward_b_e, 0b00);
}

TEST_F(HazardUnit_tb, LoadStalls)
{
    top->branch = 0;
    top->rs1_d = 2;
    top->rs2_d = 8;
    top->rs1_e = 0;
    top->rs2_e = 0;
    top->mem_read_e = 1;
    top->rd_e = 8;
    top->rd_m = 0;
    top->reg_write_m = 0;
    top->rd_w = 0;
    top->reg_write_w = 0;
    top->eval();

    EXPECT_EQ(top->flush, 0);
    EXPECT_EQ(top->stall, 1);
    EXPECT_EQ(top->forward_a_e, 0b00);
    EXPECT_EQ(top->forward_b_e, 0b00);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
