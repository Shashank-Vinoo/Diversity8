module ALU(
    input logic [31:0] ALU_Op1,
    input logic [31:0] ALU_Op2,
    input logic [2:0] ALUctrl,
    output logic [31:0] ALU_out,
    output logic EQ
);

   always_comb begin
        case(ALUctrl)
            3'b000: ALU_out = ALU_Op1 +ALU_Op2;
            3'b001: ALU_out = ALU_Op1 - ALU_Op2;
            3'b101: ALU_out = (ALU_Op1< ALU_Op2)? 32'b1:32'b0;
            3'b011: ALU_out = ALU_Op1 | ALU_Op2;
            3'b010: ALU_out = ALU_Op1 & ALU_Op2;
            default: ALU_out = 32'b0;
        endcase
   end

    assign EQ = ALU_Op1 == ALU_Op2;


endmodule


