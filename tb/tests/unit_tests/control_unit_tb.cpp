#include "../base_testbench.h"

unsigned int ticks = 0;

class ControlUnit_tb : public BaseTestbench
{
protected:
    void initializeInputs() override
    {
        top->opcode = 0;
        top->funct3 = 0;
        top->funct7 = 0;
        top->eq = 0;
    }
};

// R-type instruction opcode = 0110011
TEST_F(ControlUnit_tb, R_Type_MainDecoder)
{
    top->opcode = 0b0110011;
    top->eval();

    EXPECT_EQ(top->reg_write, 1);
    EXPECT_EQ(top->imm_src, 0);
    EXPECT_EQ(top->alu_src, 0);
    EXPECT_EQ(top->mem_write, 0);
    EXPECT_EQ(top->result_src, 0);
    EXPECT_EQ(top->pc_src, 0);
    EXPECT_EQ(top->alu_control, 0b000);
}

// LW instruction opcode = 0000011
TEST_F(ControlUnit_tb, LW_Decoding)
{
    top->opcode = 0b0000011;
    top->eval();

    EXPECT_EQ(top->reg_write, 1);
    EXPECT_EQ(top->imm_src, 0);
    EXPECT_EQ(top->alu_src, 1);
    EXPECT_EQ(top->mem_write, 0);
    EXPECT_EQ(top->result_src, 1);
    EXPECT_EQ(top->pc_src, 0);
    EXPECT_EQ(top->alu_control, 0b000); // add for address
}

// SW instruction opcode = 0100011
TEST_F(ControlUnit_tb, SW_Decoding)
{
    top->opcode = 0b0100011;
    top->eval();

    EXPECT_EQ(top->reg_write, 0);
    EXPECT_EQ(top->imm_src, 1);
    EXPECT_EQ(top->alu_src, 1);
    EXPECT_EQ(top->mem_write, 1);
    EXPECT_EQ(top->result_src, 0);
    EXPECT_EQ(top->pc_src, 0);
    EXPECT_EQ(top->alu_control, 0b000); // add for store address
}

// BEQ instruction: opcode = 1100011
TEST_F(ControlUnit_tb, BEQ_PCsrc)
{
    top->opcode = 0b1100011;
    top->funct3 = 0b000;
    top->eq = 1;
    top->eval();

    // Check decoder
    EXPECT_EQ(top->reg_write, 0);
    EXPECT_EQ(top->imm_src, 2);
    EXPECT_EQ(top->pc_src, 1);
}

// ADDI instruction opcode = 0010011
TEST_F(ControlUnit_tb, ADDI_Decoding)
{
    top->opcode = 0b0010011;
    top->funct3 = 0b000;
    top->funct7 = 0;
    top->eval();

    EXPECT_EQ(top->reg_write, 1);
    EXPECT_EQ(top->alu_src, 1);
    EXPECT_EQ(top->imm_src, 0);
    EXPECT_EQ(top->pc_src, 0);
    EXPECT_EQ(top->alu_control, 0b000);
}

// ALUControl testing for R-type instructions

TEST_F(ControlUnit_tb, ALUControl_ADD)
{
    top->opcode = 0b0110011;
    top->funct3 = 0b000;
    top->funct7 = 0b0000000;
    top->eval();
    EXPECT_EQ(top->alu_control, 0b000);
}

TEST_F(ControlUnit_tb, ALUControl_SUB)
{
    top->opcode = 0b0110011;
    top->funct3 = 0b000;
    top->funct7 = 0b0100000;
    top->eval();
    EXPECT_EQ(top->alu_control, 0b001);
}

TEST_F(ControlUnit_tb, ALUControl_OR)
{
    top->opcode = 0b0110011;
    top->funct3 = 0b110;
    top->eval();
    EXPECT_EQ(top->alu_control, 0b011);
}

TEST_F(ControlUnit_tb, ALUControl_AND)
{
    top->opcode = 0b0110011;
    top->funct3 = 0b111;
    top->eval();
    EXPECT_EQ(top->alu_control, 0b010);
}

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
