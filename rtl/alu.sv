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
            default: alu_out = 32'b0;
        endcase
   end

    assign eq = alu_op1 == alu_op2;

endmodule
