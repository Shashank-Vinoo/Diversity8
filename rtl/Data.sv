module Data (
    input logic [31:0] A,
    input logic clk,
    input logic [31:0] WD,
    input logic WE,
    output logic[31:0] RD
);

    logic [31:0] mem[1023:0];

    assign RD = (!WE)?mem[A[11:2]]: 32'b0;

    always_ff @( posedge clk ) begin 
        if(WE) begin
            mem[A[11:2]] <= WD;
        end
    end


    
endmodule

