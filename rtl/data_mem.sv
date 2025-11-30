/* verilator lint_off UNUSED */
module data_mem (
    input  logic [31:0] addr,
    input  logic        clk,
    input  logic [31:0] write_data,
    input  logic        write_enable,
    output logic [31:0] read_data
);

    logic [31:0] mem[1023:0];

    assign read_data = (!write_enable) ? mem[addr[11:2]] : 32'b0;

    always_ff @( posedge clk ) begin 
        if(write_enable) begin
            mem[addr[11:2]] <= write_data;
        end
    end


    
endmodule
/* verilator lint_on UNUSED */
