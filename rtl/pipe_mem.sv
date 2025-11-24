module pipe_mem(
    //inputs from the execute stage
    input logic clk,
    input logic reset,
    input logic reg_write_e,
    input logic [1:0] result_src_e,
    input logic mem_write_e,
    input logic [31:0] alu_result_e,
    input logic wdata_e,
    input logic [11:7] rde,
    input logic [31:0] pc_plus4_e,
    //outputs to the memory stage
    output logic  reg_write_m,
    output logic result_src_m,
    output logic mem_write_m,
    output logic alu_result_m,
    output logic wdata_m,
    output logic rdm,
    output logic pc_plus4_m
);


always_ff @(posedge clk)            
    begin
        if(reset)
            begin
                reg_write_m <= 0;
                result_src_m <= 0;
                mem_write_m <= 0;
                alu_result_m <= 0;
                wdata_m <= 0;
                rdm <= 0;
                pc_plus4_m <= 0;
            end
        else
            begin
                reg_write_m <= reg_write_e;
                result_src_m <= result_src_e;
                mem_write_m <= mem_write_e;
                alu_result_m <= alu_result_e;
                wdata_m <= wdata_e;
                rdm <= rde;
                pc_plus4_m <= pc_plus4_e;
            end
    end 
endmodule


