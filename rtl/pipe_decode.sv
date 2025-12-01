module pipe_decode (
    input logic clk,
    input logic rst,
    input logic reg_write_d,
    input logic [1:0] result_src_d,
    input logic mem_read_d,
    input logic mem_write_d,
    input logic jump_d,
    input logic [1:0] branch_d,
    input logic [2:0] alu_control_d,
    input logic alu_src_d,
    input logic [31:0] rd1_d,
    input logic [31:0] rd2_d,
    input logic [4:0] rs1_d,
    input logic [4:0] rs2_d,
    input logic [31:0] pc_d,
    input logic [4:0] rd_d,
    input logic [31:0] imm_ext_d,
    input logic [31:0] pc_plus4_d,
    
    output logic reg_write_e,
    output logic [1:0] result_src_e,
    output logic mem_read_e,
    output logic mem_write_e,
    output logic jump_e,
    output logic [1:0] branch_e,
    output logic [2:0] alu_control_e,
    output logic alu_src_e,
    output logic [31:0] rd1_e,
    output logic [31:0] rd2_e,
    output logic [4:0] rs1_e,
    output logic [4:0] rs2_e,
    output logic [31:0] pc_e,
    output logic [4:0] rd_e,
    output logic [31:0] imm_ext_e,
    output logic [31:0] pc_plus4_e
);

always_ff @(posedge clk) begin
    if (rst) begin
        reg_write_e <= 1'b0;
        result_src_e <= 2'b0;
        mem_read_e <= 1'b0;
        mem_write_e <= 1'b0;
        jump_e <= 1'b0;
        branch_e <= 2'b0;
        alu_control_e <= 3'b0;
        alu_src_e <= 1'b0;
        rd1_e <= 32'b0;
        rd2_e <= 32'b0;
        rs1_e <= 5'b0;
        rs2_e <= 5'b0;
        pc_e <= 32'b0;
        rd_e <= 5'b0;
        imm_ext_e <= 32'b0;
        pc_plus4_e <= 32'b0;
    end 
    else begin
        reg_write_e <= reg_write_d;
        result_src_e <= result_src_d;
        mem_read_e <= mem_read_d;
        mem_write_e <= mem_write_d;
        jump_e <= jump_d;
        branch_e <= branch_d;
        alu_control_e <= alu_control_d;
        alu_src_e <= alu_src_d;
        rd1_e <= rd1_d;
        rd2_e <= rd2_d;
        rs1_e <= rs1_d;
        rs2_e <= rs2_d;
        pc_e <= pc_d;
        rd_e <= rd_d;
        imm_ext_e <= imm_ext_d;
        pc_plus4_e <= pc_plus4_d;
    end
end

endmodule
