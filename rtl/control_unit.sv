/* verilator lint_off UNUSED */

module control_unit(
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic [1:0] branch,
    output logic       jump,
    output logic       result_src,
    output logic       mem_write,
    output logic [2:0] alu_control,
    output logic       alu_src,
    output logic [1:0] imm_src,
    output logic       reg_write
);
    logic [1:0] alu_op;

    always_comb begin
        alu_op     = 2'b00;
        reg_write  = 1'b0;
        imm_src    = 2'b00;
        branch  = 2'b0;
        alu_src    = 1'b0;
        mem_write  = 1'b0;
        result_src = 1'b0;

        case (opcode)
            7'b0010011: begin // I type 
                alu_op     = 2'b10;
                reg_write  = 1'b1;
                imm_src    = 2'b00; 
                alu_src    = 1'b1;
            end
            7'b1100011: begin // B type 
                alu_op     = 2'b10;
                reg_write  = 1'b0;
                imm_src    = 2'b10; 
                branch[0]  = (funct3 == 3'b000);
                branch[1] = (funct3 == 3'b001);
                alu_src    = 1'b0;
            end
            7'b0100011: begin // S type 
                alu_op     = 2'b00;
                reg_write  = 1'b0;
                imm_src    = 2'b01; 
                alu_src    = 1'b1;
                mem_write  = 1'b1;
            end
            7'b0000011: begin // I type - lw  
                alu_op     = 2'b00;
                reg_write  = 1'b1;
                imm_src    = 2'b00; 
                alu_src    = 1'b1;
                result_src = 1'b1;
            end
            7'b0110011: begin // R type
                alu_op     = 2'b10;
                reg_write  = 1'b1;
                imm_src    = 2'b00; 
                alu_src    = 1'b0;
            end
            default: ; 
        endcase
    end


    always_comb begin
        unique case (alu_op)
            2'b00: alu_control = 3'b000; // ADD
            2'b01: alu_control = 3'b001; // SUB
            2'b10: begin
                unique case (funct3)
                    3'b000: begin
                        if ({opcode[5], funct7[5]} == 2'b11)
                            alu_control = 3'b001; // SUB
                        else
                            alu_control = 3'b000; // ADD 
                    end
                    3'b110: alu_control = 3'b011; // AND
                    3'b111: alu_control = 3'b010; // OR
                    default: alu_control = 3'b000;
                endcase
            end
            default: alu_control = 3'b000;
        endcase
    end

endmodule

/* verilator lint_on UNUSED */
