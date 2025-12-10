module alu(
    input  logic [31:0] alu_op1,
    input  logic [31:0] alu_op2,
    // increased alu_ctrl width to 4 bits to accommodate more operations
    input  logic [3:0]  alu_ctrl,
    output logic [31:0] alu_out,
    
    output logic        eq
);

   always_comb begin
        case(alu_ctrl)
            4'b0000: alu_out = alu_op1 + alu_op2;
            4'b0001: alu_out = alu_op1 - alu_op2;
            4'b0101: alu_out = (alu_op1 < alu_op2) ? 32'b1 : 32'b0;
            4'b0011: alu_out = alu_op1 | alu_op2;
            4'b0010: alu_out = alu_op1 & alu_op2;
            // Add Multiply and divide operations according to the alu control signal
            4'b1000: alu_out = alu_op1[15:0] * alu_op2[15:0]; // lower 16 bits multiplication
            4'b1001: alu_out = alu_op1[31:16] * alu_op2[31:16]; // upper 16 bits multiplication
            4'b1010: alu_out = alu_op1[31:16] * alu_op2[31:16];
            4'b1011: alu_out = alu_op1[31:16] * alu_op2[31:16];
            4'b1100: alu_out = (alu_op2 == 0) ? -1 : alu_op1 / alu_op2;
            4'b1101: alu_out = (alu_op2 == 0) ? -1 : alu_op1 / alu_op2;
            4'b1110: alu_out = (alu_op2 == 0) ? alu_op1 : alu_op1 % alu_op2;
            4'b1111: alu_out = (alu_op2 == 0) ? alu_op1 : alu_op1 % alu_op2;
            default: alu_out = 32'b0;
        endcase
   end

    assign eq = alu_op1 == alu_op2;

endmodule
