module pipe_fetch(
    input logic clk,
    input logic rst,
    input logic stall,

    input logic [31:0] instr_f,
    input logic [31:0] pc_f,
    input logic [31:0] pc_plus4_f,

    output logic [31:0] instr_d,
    output logic [31:0] pc_d,
    output logic [31:0] pc_plus4_d
);

always_ff @(posedge clk) begin

    if (rst) begin
        instr_d <= 32'd0;
        pc_d <= 32'd0;
        pc_plus4_d <= 32'd0;

    end

    else if (!stall)begin
        instr_d <= instr_f;
        pc_d <= pc_f;
        pc_plus4_d <= pc_plus4_f;

    end

end

endmodule
