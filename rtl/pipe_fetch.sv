module pipe_fetch(
    input logic clk,
    input logic rst,
    input logic stall,

    input logic [31:0] instr_f,
    input logic [31:0] pc_f,
    input logic [31:0] pc_plus4_f,
    input logic        pred_taken_f,
    input logic [31:0] pred_pc_f,

    output logic [31:0] instr_d,
    output logic [31:0] pc_d,
    output logic [31:0] pc_plus4_d,
    output logic        pred_taken_d,
    output logic [31:0] pred_pc_d
);

always_ff @(posedge clk) begin

    if (rst) begin
        instr_d <= 32'd0;
        pc_d <= 32'd0;
        pc_plus4_d <= 32'd0;
        pred_taken_d <= 1'b0;
        pred_pc_d <= 32'd0;

    end

    else if (!stall)begin
        instr_d <= instr_f;
        pc_d <= pc_f;
        pc_plus4_d <= pc_plus4_f;
        pred_taken_d <= pred_taken_f;
        pred_pc_d <= pred_pc_f;

    end

end

endmodule
