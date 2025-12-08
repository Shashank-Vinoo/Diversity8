module pipe_write (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] read_data_m2,
    input  logic [31:0] alu_result_m2,
    input  logic [1:0]  result_src_m2,
    input  logic        reg_write_m2,
    input  logic [4:0]  rd_m2,
    input  logic [31:0] pc_plus4_m2,
    output logic [31:0] read_data_w,
    output logic [31:0] alu_result_w,
    output logic [1:0]  result_src_w,
    output logic        reg_write_w,
    output logic [4:0]  rd_w,
    output logic [31:0] pc_plus4_w    
);

    always_ff @(posedge clk) begin
        if (rst) begin
            read_data_w  <= 32'b0;
            alu_result_w <= 32'b0;
            result_src_w <= 2'b0;
            reg_write_w  <= 1'b0;
            rd_w         <= 5'b0;
            pc_plus4_w   <= 32'b0;
        end
        else begin
            read_data_w  <= read_data_m2;
            alu_result_w <= alu_result_m2;
            result_src_w <= result_src_m2;
            reg_write_w  <= reg_write_m2;
            rd_w         <= rd_m2;
            pc_plus4_w   <= pc_plus4_m2;
        end
    end

endmodule
