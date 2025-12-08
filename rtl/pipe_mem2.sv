module pipe_mem1(
    input logic clk,
    input logic rst,
    
    input logic        reg_write_m1,
    input logic [1:0]  result_src_m1,
    input logic        mem_write_m1,
    input logic [31:0] alu_result_m1,
    input logic [31:0] write_data_m1,
    input logic [4:0]  rd_m1,
    input logic [31:0] pc_plus4_m1,
    
    output logic        reg_write_m2,
    output logic [1:0]  result_src_m2,
    output logic        mem_write_m2,
    output logic [31:0] alu_result_m2,
    output logic [31:0] write_data_m2,
    output logic [4:0]  rd_m2,
    output logic [31:0] pc_plus4_m2
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_write_m2   <= 1'b0;
            result_src_m2  <= 2'b0;
            mem_write_m2   <= 1'b0;
            alu_result_m2  <= 32'b0;
            write_data_m2  <= 32'b0;
            rd_m2          <= 5'b0;
            pc_plus4_m2    <= 32'b0;
        end else begin
            reg_write_m2   <= reg_write_m1;
            result_src_m2  <= result_src_m1;
            mem_write_m2   <= mem_write_m1;
            alu_result_m2  <= alu_result_m1;
            write_data_m2  <= write_data_m1;
            rd_m2          <= rd_m1;
            pc_plus4_m2    <= pc_plus4_m1;
        end
    end

endmodule