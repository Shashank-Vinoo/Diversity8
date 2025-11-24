module reg_file(
    input logic clk,
    input logic rst,
    input logic we3,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] wd3,
    output logic [31:0] rd1,
    output logic [31:0] rd2,
    output logic [31:0] a0
);
    logic [31:0] registers[31:0];

    always_comb begin
        rd1 = registers[rs1];
        rd2 = registers[rs2];
        a0 = registers[5'd10];
    end

    always_ff @(negedge clk) begin
        if(rst) begin
        for(integer register_index = 0; register_index < 32; register_index++) 
            registers[register_index] <= 32'b0;
        end
        if(we3 && rd!= 5'b0) begin
            registers[rd] <= wd3;
        end
    end


endmodule

