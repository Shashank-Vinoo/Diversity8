module PCsrc_MUX(
    input logic PCsrc,
    input logic [31:0] branch_PC,
    input logic [31:0] inc_PC,
    output logic [31:0] next_PC
);

    assign next_PC = (PCsrc) ? branch_PC : inc_PC;



endmodule

// if PCsrc is high, next_PC = branch_PC
// otherwise next_PC = inc_PC (+4 because it is byte addressed)
