module pc_src_mux(
    input  logic       pc_src,
    input  logic [31:0] branch_pc,
    input  logic [31:0] pc_plus4,
    output logic [31:0] next_pc
);

    assign next_pc = (pc_src) ? branch_pc : pc_plus4;

endmodule

// if pc_src is high, next_pc = branch_pc
// otherwise next_pc = pc_plus4 (+4 because it is byte addressed)
