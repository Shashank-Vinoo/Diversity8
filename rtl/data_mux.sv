module data_mux (
    input logic[31:0] ReadData,
    input logic[31:0] ALUResult,
    input logic ResultSrc,
    output logic [31:0] Result
);


    assign Result = (ResultSrc)? ReadData: ALUResult;

    
endmodule

