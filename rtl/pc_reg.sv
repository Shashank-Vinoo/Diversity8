module pc_reg(
    input  logic clk,
    input  logic rst,
    input  logic [31:0] next_pc,
    output logic [31:0] pc
);

    always_ff @(posedge clk) begin
        if (rst) 
            pc <= 32'b0;
        else
            pc <= next_pc;
    end

endmodule

// on each clk posedge, increment pc <= next_pc
// if rst is high, pc <= 0
// if pc_write is low, pc holds its value
