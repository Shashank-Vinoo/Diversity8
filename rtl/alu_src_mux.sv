module alu_src_mux(
    input logic [31:0] regOp2,
    input logic [31:0] ImmOp,
    input logic ALUsrc,
    output logic [31:0] ALUOp2
);


    assign ALUOp2 = (ALUsrc) ? ImmOp : regOp2;


endmodule


