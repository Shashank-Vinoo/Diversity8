module pipe_execute2(
    input logic clk,
    input logic rst,
    
    input logic        reg_write_e2,
    input logic [1:0]  result_src_e2,
    input logic        mem_read_e2,
    input logic        mem_write_e2,
    input logic [31:0] alu_result_e2,    
    input logic [31:0] write_data_e2,    
    input logic [4:0]  rd_e2,
    input logic [31:0] pc_e2,
    input logic [31:0] pc_plus4_e2,
    input logic        jump_e2,
    input logic [1:0]  branch_e2,
    input logic        alu_zero_e2,      
    input logic [31:0] branch_pc_e2,     
    input logic        pred_taken_e2,
    input logic [31:0] pred_pc_e2,
    
    output logic        reg_write_m1,
    output logic [1:0]  result_src_m1,
    output logic        mem_read_m1,
    output logic        mem_write_m1,
    output logic [31:0] alu_result_m1,
    output logic [31:0] write_data_m1,
    output logic [4:0]  rd_m1,
    output logic [31:0] pc_plus4_m1
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_write_m1   <= 1'b0;
            result_src_m1  <= 2'b0;
            mem_read_m1    <= 1'b0;
            mem_write_m1   <= 1'b0;
            alu_result_m1  <= 32'b0;
            write_data_m1  <= 32'b0;
            rd_m1          <= 5'b0;
            pc_plus4_m1    <= 32'b0;
        end else begin
            reg_write_m1   <= reg_write_e2;
            result_src_m1  <= result_src_e2;
            mem_read_m1    <= mem_read_e2;
            mem_write_m1   <= mem_write_e2;
            alu_result_m1  <= alu_result_e2;
            write_data_m1  <= write_data_e2;
            rd_m1          <= rd_e2;
            pc_plus4_m1    <= pc_plus4_e2;
        end
    end

endmodule