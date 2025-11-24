module pipe_mem(
    //inputs from the execute stage
    input clk,
    input reset,
    input reg_write_e,
    input [1:0] result_src_e,
    input mem_write_e,
    input [31:0] alu_result_e,
    input wdata_e,
    input [11:7] rde,
    input [31:0] pc_plus4_e,
    //outputs to the memory stage
    output reg [] reg_write_m,
    output reg [] result_src_m,
    output reg [] mem_write_m,
    output reg [] alu_result_m,
    output reg [] wdata_m,
    output reg [] rdm,
    output reg [] pc_plus4_m
);

//intialize pipeline registers
initial begin
    reg_write_m = 0;
    result_src_m = 0;
    mem_write_m = 0;
    alu_result_m = 0;
    wdata_m = 0;
    rdm = 0;
    pc_plus4_m = 0;
end

//pipeline register between execute and memory stage
always@(posedge clk)            
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


