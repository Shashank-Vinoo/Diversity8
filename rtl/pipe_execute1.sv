module pipe_execute1(
    input logic clk,
    input logic rst,
    
    input logic        reg_write_e1,
    input logic [1:0]  result_src_e1,
    input logic        mem_read_e1,
    input logic        mem_write_e1,
    input logic        jump_e1,
    input logic [1:0]  branch_e1,
    input logic [2:0]  alu_control_e1,
    input logic        alu_src_e1,
    input logic [31:0] rd1_e1,          
    input logic [31:0] rd2_e1,          
    input logic [4:0]  rs1_e1,
    input logic [4:0]  rs2_e1,
    input logic [4:0]  rd_e1,
    input logic [31:0] pc_e1,
    input logic [31:0] pc_plus4_e1,
    input logic [31:0] imm_ext_e1,
    input logic        pred_taken_e1,
    input logic [31:0] pred_pc_e1,
    
    output logic        reg_write_e2,
    output logic [1:0]  result_src_e2,
    output logic        mem_read_e2,
    output logic        mem_write_e2,
    output logic        jump_e2,
    output logic [1:0]  branch_e2,
    output logic [2:0]  alu_control_e2,
    output logic        alu_src_e2,
    output logic [31:0] rd1_e2,
    output logic [31:0] rd2_e2,
    output logic [4:0]  rs1_e2,
    output logic [4:0]  rs2_e2,
    output logic [4:0]  rd_e2,
    output logic [31:0] pc_e2,
    output logic [31:0] pc_plus4_e2,
    output logic [31:0] imm_ext_e2,
    output logic        pred_taken_e2,
    output logic [31:0] pred_pc_e2
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_write_e2   <= 1'b0;
            result_src_e2  <= 2'b0;
            mem_read_e2    <= 1'b0;
            mem_write_e2   <= 1'b0;
            jump_e2        <= 1'b0;
            branch_e2      <= 2'b0;
            alu_control_e2 <= 3'b0;
            alu_src_e2     <= 1'b0;
            rd1_e2         <= 32'b0;
            rd2_e2         <= 32'b0;
            rs1_e2         <= 5'b0;
            rs2_e2         <= 5'b0;
            rd_e2          <= 5'b0;
            pc_e2          <= 32'b0;
            pc_plus4_e2    <= 32'b0;
            imm_ext_e2     <= 32'b0;
            pred_taken_e2  <= 1'b0;
            pred_pc_e2     <= 32'b0;
        end else begin
            reg_write_e2   <= reg_write_e1;
            result_src_e2  <= result_src_e1;
            mem_read_e2    <= mem_read_e1;
            mem_write_e2   <= mem_write_e1;
            jump_e2        <= jump_e1;
            branch_e2      <= branch_e1;
            alu_control_e2 <= alu_control_e1;
            alu_src_e2     <= alu_src_e1;
            rd1_e2         <= rd1_e1;
            rd2_e2         <= rd2_e1;
            rs1_e2         <= rs1_e1;
            rs2_e2         <= rs2_e1;
            rd_e2          <= rd_e1;
            pc_e2          <= pc_e1;
            pc_plus4_e2    <= pc_plus4_e1;
            imm_ext_e2     <= imm_ext_e1;
            pred_taken_e2  <= pred_taken_e1;
            pred_pc_e2     <= pred_pc_e1;
        end
    end

endmodule