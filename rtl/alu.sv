module alu(
    input  logic [31:0] alu_op1,
    input  logic [31:0] alu_op2,
    input  logic [2:0]  alu_ctrl,
    output logic [31:0] alu_out,
    output logic        eq
);

   always_comb begin
        case(alu_ctrl)
            3'b000: alu_out = alu_op1 + alu_op2;
            3'b001: alu_out = alu_op1 - alu_op2;
            3'b101: alu_out = (alu_op1 < alu_op2) ? 32'b1 : 32'b0;
            3'b011: alu_out = alu_op1 | alu_op2;
            3'b010: alu_out = alu_op1 & alu_op2;
            default: alu_out = 32'b0;
        endcase
   end

    assign eq = alu_op1 == alu_op2;

endmodule
