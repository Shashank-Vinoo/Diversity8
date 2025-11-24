module top(
    input  logic clk,
    input  logic rst,
    output logic [31:0] a0
);

//PC
logic [31:0] PC;
logic [31:0] next_PC;
logic [31:0] inc_PC;
logic [31:0] branch_PC;

//Control unit
logic [31:0] instruction;
logic [31:0] ImmOp;

logic [6:0] opcode;
logic [2:0] funct3;
logic [6:0] funct7;

logic PCSrc;
logic ResultSrc;
logic MemWrite;
logic [2:0] ALUControl;
logic ALUSrc;
logic [1:0] ImmSrc;
logic RegWrite;

//Regfile 
logic [31:0] RD1;
logic [31:0] RD2;
logic [31:0] regOp2;
logic [4:0] AD1, AD2, AD3;
logic [31:0] WD3;

//ALU
logic [31:0] ALU_Op1;
logic [31:0] ALU_Op2;
logic [31:0] ALU_out;
logic EQ;
logic [31:0] data_rd;

<<<<<<< Updated upstream



=======
>>>>>>> Stashed changes
branch_pc_adder branch_pc_adder_i(
    .PC(PC),
    .ImmOp(ImmOp),
    .branch_PC(branch_PC)
);

pc_reg pc_reg_i(
    .clk(clk),
    .rst(rst),
    .next_PC(next_PC),
    .PC(PC)
);

pc_src_mux pc_src_mux_i(
    .PCsrc(PCSrc),
    .branch_PC(branch_PC),
    .inc_PC(inc_PC),
    .next_PC(next_PC)
);

// output for pipe_fetch_i
logic [31:0] pcd;
logic [31:0] pc_plus_4D;

<<<<<<< Updated upstream
=======
pipe_fetch pipe_fetch_i(
    .clk(clk), 
    .rst(rst),
    .read_data(instruction),
    .pcf(PC),
    .pc_plus_4F(inc_PC),
    //outputs
    .instr_D(instr_D),
    .pcd(pcd),
    .pc_plus_4D(pc_plus_4D)
);

// instruction decode
assign inc_PC = PC + 32'd4;
assign opcode = instr_D[6:0];
assign funct3 = instr_D[14:12];
assign funct7 = instr_D[31:25];
assign AD1 = instr_D[19:15];
assign AD2 = instr_D[24:20];
assign AD3 = instr_D[11:7];

>>>>>>> Stashed changes
control_unit control_unit_i(
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .EQ(EQ),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUControl(ALUControl),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite)
);

imm_gen imm_gen_i(
    .ImmSrc(ImmSrc),
    .instruction(instruction),
    .Imm(ImmOp)
);

instr_mem instr_mem_i(
    .Imem_Addr(PC),
    .Read_Data(instruction)
);


alu_src_mux alu_src_mux_i(
    .regOp2(RD2),
    .ImmOp(ImmOp),
    .ALUsrc(ALUSrc),
    .ALUOp2(ALU_Op2)
);

alu alu_i(
    .ALU_Op1(RD1),
    .ALU_Op2(ALU_Op2),
    .ALUctrl(ALUControl),
    .ALU_out(ALU_out),
    .EQ(EQ)
);

data_mem data_mem_i(
    .A(ALU_out),
    .clk(clk),
    .WD(RD2),
    .WE(MemWrite),
    .RD(data_rd)
);

data_mux data_mux_i(
    .ReadData(data_rd),
    .ALUResult(ALU_out),
    .ResultSrc(ResultSrc),
    .Result(WD3)
);

reg_file reg_file_i(
    .clk (clk),
    .rst (rst),
    .WE3 (RegWrite),
    .AD1 (AD1),
    .AD2 (AD2),
    .AD3 (AD3),
    .WD3 (WD3),
    .RD1 (RD1),
    .RD2 (RD2),
    .a0(a0)
);


// Pipeline Memory Stage output reg declerations
logic        reg_write_m;
logic [1:0]  result_src_m;   
logic        mem_write_m;
logic [31:0] alu_result_m;
logic [31:0] wdata_m;
logic [4:0]  rdm;            
logic [31:0] pc_plus4_m;

pipe_mem pipe_mem_i(
    //inputs
    .clk(clk),
    .reset(rst),
    .reg_write_e(),
    .result_src_e(),
    .mem_write_e(),
    .alu_result_e(ALU_out),
    .wdata_e(),
    .rde(),
    .pc_plus4_e(pc_plus4_e),
    //outputs to the memory stage
    .reg_write_m(reg_write_m),
    .result_src_m(result_src_m),
    .mem_write_m(mem_write_m),
    .alu_result_m(alu_result_m),
    .wdata_m(wdata_m),
    .rdm(rdm),
    .pc_plus4_m(pc_plus4_m)
);


endmodule
