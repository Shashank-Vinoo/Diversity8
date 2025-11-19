module Branch_PC_Adder(
    input logic [31:0] PC,
    input logic [31:0] ImmOp,
    output logic [31:0] branch_PC
);

    assign branch_PC = PC + ImmOp;

endmodule

// branch_PC = PC + ImmOp
