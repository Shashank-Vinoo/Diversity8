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

logic [31:0] instr_D;
logic [31:0] pcd;
logic [31:0] pc_plus_4D;

// Decode->Execute 
logic        reg_write_e;
logic [1:0]  result_src_e;
logic        mem_write_e;
logic        jump_e;
logic        branch_e;
logic [2:0]  alu_control_e;
logic        alu_src_e;
logic        imm_src_e;
logic [31:0] rd1_e;
logic [31:0] rd2_e;
logic [31:0] pc_e;
logic [4:0]  rd_e;
logic [31:0] imm_ext_e;
logic [31:0] pc_plus4_e;

// Execute->Mem 
logic        reg_write_m;
logic [1:0]  result_src_m;
logic        mem_write_m;
logic [31:0] alu_result_m;
logic [31:0] wdata_m;
logic [4:0]  rd_m;
logic [31:0] pc_plus4_m;

// Mem->Write
logic [31:0] read_data_w;
logic [31:0] alu_result_w;
logic [1:0]  result_src_w;
logic        reg_write_w;
logic [4:0]  rd_w;
logic [31:0] pc_plus4_w;

logic [1:0] result_src_d;
assign result_src_d = {1'b0, ResultSrc}; // MSB reserved for PC+4 selection later



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

// instruction decode
assign inc_PC = PC + 32'd4;
assign opcode = instr_D[6:0];
assign funct3 = instr_D[14:12];
assign funct7 = instr_D[31:25];
assign AD1 = instr_D[19:15];
assign AD2 = instr_D[24:20];
assign AD3 = instr_D[11:7];

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
    .instruction(instr_D),
    .Imm(ImmOp)
);

instr_mem instr_mem_i(
    .Imem_Addr(PC),
    .Read_Data(instruction)
);

logic [31:0] ALU_Op2_e;
alu_src_mux alu_src_mux_i(
    .regOp2(rd2_e),
    .ImmOp(imm_ext_e),
    .ALUsrc(alu_src_e),
    .ALUOp2(ALU_Op2_e)
);

alu alu_i(
    .ALU_Op1(rd1_e),
    .ALU_Op2(ALU_Op2_e),
    .ALUctrl(alu_control_e),
    .ALU_out(ALU_out),
    .EQ(EQ)
);

data_mem data_mem_i(
    .A(alu_result_m),
    .clk(clk),
    .WD(wdata_m),
    .WE(mem_write_m),
    .RD(data_rd)
);

data_mux data_mux_i(
    .read_data_w(read_data_w),
    .alu_result_w(alu_result_w),
    .pc_plus_4w(pc_plus4_w),
    .result_src_w(result_src_w),
    .result_w(WD3)
);

reg_file reg_file_i(
    .clk (clk),
    .rst (rst),
    .WE3 (reg_write_w),
    .AD1 (AD1),
    .AD2 (AD2),
    .AD3 (rd_w),
    .WD3 (WD3),
    .RD1 (RD1),
    .RD2 (RD2),
    .a0(a0)
);

pipe_fetch pipe_fetch_i(
    .clk(clk),
    .rst(rst),
    .read_data(instruction),
    .pcf(PC),
    .pc_plus_4F(inc_PC),
    .instr_D(instr_D),
    .pcd(pcd),
    .pc_plus_4D(pc_plus_4D)
);


pipe_decode pipe_decode_i(
    .clk(clk),
    .rst(rst),
    .reg_write_d(RegWrite),
    .result_src_d(result_src_d),
    .mem_write_d(MemWrite),
    .jump_d(PCSrc),
    .branch_d(PCSrc),
    .alu_control_d(ALUControl),
    .alu_src_d(ALUSrc),
    .imm_src_d(ImmSrc),
    .rd1_d(RD1),
    .rd2_d(RD2),
    .pc_d(pcd),          
    .rd_d(AD3),
    .imm_ext_d(ImmOp),
    .pc_plus4_d(pc_plus_4D),

    .reg_write_e(reg_write_e),
    .result_src_e(result_src_e),
    .mem_write_e(mem_write_e),
    .jump_e(jump_e),
    .branch_e(branch_e),
    .alu_control_e(alu_control_e),
    .alu_src_e(alu_src_e),
    .imm_src_e(imm_src_e),
    .rd1_e(rd1_e),
    .rd2_e(rd2_e),
    .pc_e(pc_e),
    .rd_e(rd_e),
    .imm_ext_e(imm_ext_e),
    .pc_plus4_e(pc_plus4_e)
);


pipe_mem pipe_mem_i(
    .clk(clk),
    .reset(rst),            
    .reg_write_e(reg_write_e),
    .result_src_e(result_src_e),
    .mem_write_e(mem_write_e),
    .alu_result_e(ALU_out), 
    .wdata_e(rd2_e),         
    .rde(rd_e),
    .pc_plus4_e(pc_plus4_e),

    .reg_write_m(reg_write_m),
    .result_src_m(result_src_m),
    .mem_write_m(mem_write_m),
    .alu_result_m(alu_result_m),
    .wdata_m(wdata_m),
    .rdm(rd_m),
    .pc_plus4_m(pc_plus4_m)
);

pipe_write pipe_write_i(
    .clk(clk),
    .rst(rst),
    .read_data(data_rd),
    .alu_result_m(alu_result_m),
    .result_src_m(result_src_m),
    .reg_write_m(reg_write_m),
    .rdm(rd_m),                
    .pc_plus_4m(pc_plus4_m),

    .read_data_w(read_data_w),
    .alu_result_w(alu_result_w),
    .result_src_w(result_src_w),
    .reg_write_w(reg_write_w),
    .rdw(rd_w),
    .pc_plus_4w(pc_plus4_w)
);

endmodule
