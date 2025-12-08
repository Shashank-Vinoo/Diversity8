module alu_hazard_mux (
    input logic [31:0]  rd1_e,
    input logic [31:0]  rd2_e,
    input logic [31:0]  alu_result_e,
    input logic [31:0]  alu_result_m,
    input logic [31:0]  result_w,
    input logic [1:0]   forward_a_e,
    input logic [1:0]   forward_b_e,

    output logic [31:0] alu_input_a_e,
    output logic [31:0] alu_input_b_e
);

    always_comb begin
        // ALU input a
        case (forward_a_e)
            2'b00 : alu_input_a_e = rd1_e;
            2'b01 : alu_input_a_e = result_w;
            2'b10 : alu_input_a_e = alu_result_m;
            2'b11 : alu_input_a_e = alu_result_e;
            default : alu_input_a_e = rd1_e;
        endcase

        // ALU input b
        case (forward_b_e) 
            2'b00 : alu_input_b_e = rd2_e;
            2'b01 : alu_input_b_e = result_w;
            2'b10 : alu_input_b_e = alu_result_m;
            2'b11 : alu_input_b_e = alu_result_e;
            default : alu_input_b_e = rd2_e;
        endcase
    end

endmodule
