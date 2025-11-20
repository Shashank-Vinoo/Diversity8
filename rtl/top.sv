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

Branch_PC_Adder Branch_PC_Adder(
    .PC(PC),
    .ImmOp(ImmOp),
    .branch_PC(branch_PC)
);

PC_REG PC_REG(
    .clk(clk),
    .rst(rst),
    .next_PC(next_PC),
    .PC(PC)
);

PCsrc_MUX PCsrc_MUX(
    .PCsrc(PCSrc),
    .branch_PC(branch_PC),
    .inc_PC(inc_PC),
    .next_PC(next_PC)
);

assign inc_PC = PC + 32'd4;

ControlUnit ControlUnit(
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

ImmGen ImmGen(
    .ImmSrc(ImmSrc),
    .instruction(instruction),
    .Imm(ImmOp)
);

InstrMem InstrMem(
    .Imem_Addr(PC),
    .Read_Data(instruction)
);

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];
assign AD1 = instruction[19:15];
assign AD2 = instruction[24:20];
assign AD3 = instruction[11:7];

ALU_Src_Mux ALU_Src_Mux(
    .regOp2(RD2),
    .ImmOp(ImmOp),
    .ALUsrc(ALUSrc),
    .ALUOp2(ALU_Op2)
);

ALU ALU(
    .ALU_Op1(RD1),
    .ALU_Op2(ALU_Op2),
    .ALUctrl(ALUControl),
    .ALU_out(ALU_out),
    .EQ(EQ)
);

Data Data_Mem(
    .A(ALU_out),
    .clk(clk),
    .WD(RD2),
    .WE(MemWrite),
    .RD(data_rd)
);

Data_mux Data_Mux(
    .ReadData(data_rd),
    .ALUResult(ALU_out),
    .ResultSrc(ResultSrc),
    .Result(WD3)
);

RegFile RegFile(
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

endmodule
