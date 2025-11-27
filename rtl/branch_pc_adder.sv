module branch_pc_adder(
    input  logic [31:0] pc,
    input  logic [31:0] imm_ext,
    output logic [31:0] branch_pc
);

    assign branch_pc = pc + imm_ext;

endmodule

