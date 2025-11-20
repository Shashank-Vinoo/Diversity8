/* verilator lint_off UNUSEDSIGNAL */

module ControlUnit(
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    input  logic       EQ,

    output logic       PCSrc,
    output logic       ResultSrc,
    output logic       MemWrite,
    output logic [2:0] ALUControl,
    output logic       ALUSrc,
    output logic [1:0] ImmSrc,
    output logic       RegWrite
);
    logic branch_e;
    logic branch_ne;
    logic [1:0] ALUOp;

    assign PCSrc = (branch_ne & ~EQ) | (branch_e & EQ);

    always_comb begin
        ALUOp     = 2'b00;
        RegWrite  = 1'b0;
        ImmSrc    = 2'b00;
        branch_e  = 1'b0;
        branch_ne = 1'b0;
        ALUSrc    = 1'b0;
        MemWrite  = 1'b0;
        ResultSrc = 1'b0;

        case (opcode)
            7'b0010011: begin // I type 
                ALUOp     = 2'b10;
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00; 
                ALUSrc    = 1'b1;
            end
            7'b1100011: begin // B type 
                ALUOp     = 2'b10;
                RegWrite  = 1'b0;
                ImmSrc    = 2'b10; 
                branch_e  = (funct3 == 3'b000);
                branch_ne = (funct3 == 3'b001);
                ALUSrc    = 1'b0;
            end
            7'b0100011: begin // S type 
                ALUOp     = 2'b00;
                RegWrite  = 1'b0;
                ImmSrc    = 2'b01; 
                ALUSrc    = 1'b1;
                MemWrite  = 1'b1;
            end
            7'b0000011: begin // I type - lw  
                ALUOp     = 2'b00;
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00; 
                ALUSrc    = 1'b1;
                ResultSrc = 1'b1;
            end
            7'b0110011: begin // R type
                ALUOp     = 2'b10;
                RegWrite  = 1'b1;
                ImmSrc    = 2'b00; 
                ALUSrc    = 1'b0;
            end
            default: ; 
        endcase
    end


    always_comb begin
        unique case (ALUOp)
            2'b00: ALUControl = 3'b000; // ADD
            2'b01: ALUControl = 3'b001; // SUB
            2'b10: begin
                unique case (funct3)
                    3'b000: begin
                        if ({opcode[5], funct7[5]} == 2'b11)
                            ALUControl = 3'b001; // SUB
                        else
                            ALUControl = 3'b000; // ADD 
                    end
                    3'b110: ALUControl = 3'b011; // AND
                    3'b111: ALUControl = 3'b010; // OR
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end

endmodule

/* verilator lint_on UNUSEDSIGNAL */
