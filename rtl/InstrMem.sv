module instruction_memory #(
    parameter int    DEPTH   = 1024,
    parameter string MEMFILE = "program.hex"
)(
    input logic [31:0] address, 

    output logic [31:0] dout
);

logic [31:0] instruction_memory_rom [2**(30)-1:0];

assign dout = instruction_memory_rom[address[31:2]];

initial begin
    string fn;
    if (!$value$plusargs("IMEM=%s", fn)) fn = MEMFILE;
    $display("Loading instruction memory from %s", fn);
    $readmemh(fn, instruction_memory_rom);
end 


endmodule

