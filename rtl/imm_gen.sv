/* verilator lint_off UNUSED */
// lint off to prevent errors not using all the bits in the instruction
module imm_gen(
    input  logic [1:0]  imm_src,
    input  logic [31:0] instruction,
    output logic [31:0] imm_ext  
);

always_comb begin
    case(imm_src)
        2'b00: //I type
            imm_ext = {{20{instruction[31]}},instruction[31:20]};
        2'b01: //S type
            imm_ext = {{20{instruction[31]}},instruction[31:25],instruction[11:7]};
        2'b10: //B type
            imm_ext = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0};
        default:
            imm_ext = 32'b0;
    endcase
end 


endmodule

/* verilator lint_on UNUSED */




