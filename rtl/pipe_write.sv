module pipe_write (
    input logic clk,
    input logic rst,
    input logic [31:0] read_data,
    input logic [31:0] alu_result_m,
    input logic [1:0] result_src_m,
    input logic reg_write_m,
    input logic [11:7] rdm,
    input logic [31:0] pc_plus_4m,
    output logic [31:0] read_data_w,
    output logic [31:0] alu_result_w,
    output logic [1:0] result_src_w,
    output logic reg_write_w,
    output logic [11:7] rdw,
    output logic [31:0] pc_plus_4w    
);

  // Initialize pipeline registers

    always_ff @( posedge clk ) begin
        if (rst) begin
            read_data_w <= 31'b0;
            alu_result_w <= 31'b0;
            result_src_w <= 2'b0;
            reg_write_w <= 1'b0;
            rdw <= 4'b0;
            pc_plus_4w <= 31'b0;
        end
        else begin
            read_data_w <= read_data;
            alu_result_w <= alu_result_m;
            result_src_w <= result_src_m;
            reg_write_w <= reg_write_m;
            rdw <= rdm;
            pc_plus_4w <= pc_plus_4w;
        end
    end


    
endmodule

