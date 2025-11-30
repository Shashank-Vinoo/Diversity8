/* verilator lint_off UNUSED */

module instr_mem#(
    parameter DEPTH = 1024
)(
    input  logic [31:0] imem_addr, 

    output logic [31:0] read_data
);

logic [31:0] instruction_memory_rom [0:DEPTH-1];
assign read_data = instruction_memory_rom[imem_addr[11:2]];

initial begin
    $display("Loading instruction memory from ");
    $readmemh("../rtl/program.hex", instruction_memory_rom);
end 

endmodule

/* verilator lint_on UNUSED */











