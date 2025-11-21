module pc_reg(
    input logic clk,
    input logic rst,
    input logic [31:0] next_PC,
    output logic [31:0] PC
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst) 
            PC <= 0;
        else
            PC <= next_PC;
    end

endmodule

// on each clk posedge, increment PC <= next_PC
// if rst is high, PC <= 0
