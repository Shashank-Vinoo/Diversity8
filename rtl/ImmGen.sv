/* verilator lint_off UNUSEDSIGNAL */
// lint off to prevent errors not using all the bits in the instruction
module ImmGen(
    input logic [1:0] ImmSrc,
    input logic [31:0] instruction,
    output logic [31:0] Imm  
);

always_comb begin
    case(ImmSrc)
        2'b00: //I type
            Imm = {{20{instruction[31]}},instruction[31:20]};
        2'b01: //S type
            Imm = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
        2'b10: //B type
            Imm = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
        default:
            Imm = 32'b0;
    endcase
end 


endmodule

/* verilator lint_on UNUSEDSIGNAL */
  


