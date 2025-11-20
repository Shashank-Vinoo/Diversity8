module InstrMem#(
    parameter int    DEPTH   = 1024,
    parameter string MEMFILE = "program.hex"
)(
    input logic [31:0] Imem_Addr, 

    output logic [31:0] Read_Data
);

logic [31:0] instruction_memory_rom [0:DEPTH-1];
assign Read_Data = instruction_memory_rom[Imem_Addr[31:2]];

initial begin
    string fn;
    if (!$value$plusargs("IMEM=%s", fn)) fn = MEMFILE;
    $display("Loading instruction memory from %s", fn);
    $readmemh(fn, instruction_memory_rom);
end 


endmodule

