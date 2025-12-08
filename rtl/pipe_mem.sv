
module pipe_mem(
    //inputs from the execute stage
    input logic clk,
    input logic rst,

    input logic reg_write_e2,
    input logic [1:0] result_src_e2,
    input logic mem_write_e2,
    input logic [31:0] alu_result_e2,
    input logic [31:0] write_data_e2,
    input logic [4:0] rd_e2,
    input logic [31:0] pc_plus4_e2,
    //outputs to the memory stage
    output logic reg_write_m1,
    output logic [1:0] result_src_m1,
    output logic mem_write_m1,
    output logic [31:0] alu_result_m1,
    output logic [31:0] write_data_m1,
    output logic [4:0] rd_m1,
    output logic [31:0] pc_plus4_m1
);


always_ff @(posedge clk)            
    begin
        if(rst)
            begin
                reg_write_m1 <= 0;
                result_src_m1 <= 0;
                mem_write_m1 <= 0;
                alu_result_m1 <= 0;
                write_data_m1 <= 0;
                rd_m1 <= 0;
                pc_plus4_m1 <= 0;
            end
        else
            begin
                reg_write_m1 <= reg_write_e2;
                result_src_m1 <= result_src_e2;
                mem_write_m1 <= mem_write_e2;
                alu_result_m1 <= alu_result_e2;
                write_data_m1 <= write_data_e2;
                rd_m1 <= rd_e2;
                pc_plus4_m1 <= pc_plus4_e2;
            end
    end 
endmodule
