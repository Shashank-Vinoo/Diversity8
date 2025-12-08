module pipe_decode (
    input logic clk,
    input logic rst,
    input logic reg_write_d,
    input logic [1:0] result_src_d,
    input logic mem_read_d,
    input logic mem_write_d,
    input logic jump_d,
    input logic [1:0] branch_d,
    input logic [3:0] alu_control_d,
    input logic alu_src_d,
    input logic [31:0] rd1_d,
    input logic [31:0] rd2_d,
    input logic [4:0] rs1_d,
    input logic [4:0] rs2_d,
    input logic [31:0] pc_d,
    input logic [4:0] rd_d,
    input logic [31:0] imm_ext_d,
    input logic [31:0] pc_plus4_d,
    input logic        pred_taken_d,
    input logic [31:0] pred_pc_d,
    
    output logic reg_write_e1,
    output logic [1:0] result_src_e1,
    output logic mem_read_e1,
    output logic mem_write_e1,
    output logic jump_e1,
    output logic [1:0] branch_e1,
    output logic [3:0] alu_control_e1,
    output logic alu_src_e1,
    output logic [31:0] rd1_e1,
    output logic [31:0] rd2_e1,
    output logic [4:0] rs1_e1,
    output logic [4:0] rs2_e1,
    output logic [31:0] pc_e1,
    output logic [4:0] rd_e1,
    output logic [31:0] imm_ext_e1,
    output logic [31:0] pc_plus4_e1,
    output logic        pred_taken_e1,
    output logic [31:0] pred_pc_e1
);

always_ff @(posedge clk) begin
    if (rst) begin
        reg_write_e1 <= 1'b0;
        result_src_e1 <= 2'b0;
        mem_read_e1 <= 1'b0;
        mem_write_e1 <= 1'b0;
        jump_e1 <= 1'b0;
        branch_e1 <= 2'b0;
        alu_control_e1 <= 4'b0;
        alu_src_e1 <= 1'b0;
        rd1_e1 <= 32'b0;
        rd2_e1 <= 32'b0;
        rs1_e1 <= 5'b0;
        rs2_e1 <= 5'b0;
        pc_e1 <= 32'b0;
        rd_e1 <= 5'b0;
        imm_ext_e1 <= 32'b0;
        pc_plus4_e1 <= 32'b0;
        pred_taken_e1 <= 1'b0;
        pred_pc_e1 <= 32'b0;
    end 
    else begin
        reg_write_e1 <= reg_write_d;
        result_src_e1 <= result_src_d;
        mem_read_e1 <= mem_read_d;
        mem_write_e1 <= mem_write_d;
        jump_e1 <= jump_d;
        branch_e1 <= branch_d;
        alu_control_e1 <= alu_control_d;
        alu_src_e1 <= alu_src_d;
        rd1_e1 <= rd1_d;
        rd2_e1 <= rd2_d;
        rs1_e1 <= rs1_d;
        rs2_e1 <= rs2_d;
        pc_e1 <= pc_d;
        rd_e1 <= rd_d;
        imm_ext_e1 <= imm_ext_d;
        pc_plus4_e1 <= pc_plus4_d;
        pred_taken_e1 <= pred_taken_d;
        pred_pc_e1 <= pred_pc_d;
    end
end

endmodule
