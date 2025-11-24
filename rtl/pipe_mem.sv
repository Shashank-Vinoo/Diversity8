
module pipe_mem(
    //inputs from the execute stage
    input logic clk,
    input logic rst,
    input logic reg_write_e,
    input logic [1:0] result_src_e,
    input logic mem_write_e,
    input logic [31:0] alu_result_e,
    input logic [31:0] write_data_e,
    input logic [4:0] rd_e,
    input logic [31:0] pc_plus4_e,
    //outputs to the memory stage
    output logic reg_write_m,
    output logic [1:0] result_src_m,
    output logic mem_write_m,
    output logic [31:0] alu_result_m,
    output logic [31:0] write_data_m,
    output logic [4:0] rd_m,
    output logic [31:0] pc_plus4_m
);


always_ff @(posedge clk)            
    begin
        if(rst)
            begin
                reg_write_m <= 0;
                result_src_m <= 0;
                mem_write_m <= 0;
                alu_result_m <= 0;
                write_data_m <= 0;
                rd_m <= 0;
                pc_plus4_m <= 0;
            end
        else
            begin
                reg_write_m <= reg_write_e;
                result_src_m <= result_src_e;
                mem_write_m <= mem_write_e;
                alu_result_m <= alu_result_e;
                write_data_m <= write_data_e;
                rd_m <= rd_e;
                pc_plus4_m <= pc_plus4_e;
            end
    end 
endmodule
