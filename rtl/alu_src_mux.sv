module alu_src_mux(
    input  logic [31:0] reg_op2,
    input  logic [31:0] imm_ext,
    input  logic        alu_src,
    output logic [31:0] alu_op2
);


    assign alu_op2 = (alu_src) ? imm_ext : reg_op2;

endmodule


