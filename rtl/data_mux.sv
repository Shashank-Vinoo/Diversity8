module data_mux (
    input  logic [31:0] read_data_w,
    input  logic [31:0] alu_result_w,
    input  logic [31:0] pc_plus4_w,
    input  logic [1:0]  result_src_w,
    output logic [31:0] result_w
);


    always_comb begin
        // Default to ALU result and override when memory/PC results selected
        result_w = alu_result_w;
        unique case(result_src_w)
            2'b00: result_w = alu_result_w;
            2'b01: result_w = read_data_w;
            2'b10: result_w = pc_plus4_w;
            2'b11: result_w = alu_result_w; // explicit cover to avoid CASEINCOMPLETE
            default: result_w = alu_result_w;
        endcase
    end
    
endmodule
