module instr_mem#(
    parameter DEPTH = 1024
)(
    input  logic [31:0] imem_addr, 

    output logic [31:0] read_data
);

logic [31:0] instruction_memory_rom [0:DEPTH-1];
assign read_data = instruction_memory_rom[imem_addr[31:2]];

initial begin
    $display("Loading instruction memory from ");
    $readmemh("program.hex", instruction_memory_rom);
end 

endmodule













