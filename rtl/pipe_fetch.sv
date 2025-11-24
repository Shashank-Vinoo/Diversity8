module pipe_fetch(
    input logic clk,
    input logic rst,

    input logic [31:0] read_data,
    input logic [31:0] pcf,
    input logic [31:0] pc_plus_4F,

    output logic [31:0] instr_D,
    output logic [31:0] pcd,
    output logic [31:0] pc_plus_4D
);

always_ff @(posedge clk) begin

    if (rst) begin
        instr_D <= 32'd0;
        pcd <= 32'd0;
        pc_plus_4D <= 32'd0;

    end

    else begin
        instr_D <= read_data;
        pcd <= pcf;
        pc_plus_4D <= pc_plus_4F;

    end

end

endmodule
