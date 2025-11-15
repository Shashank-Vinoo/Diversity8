module Data_mux (
    input logic[31:0] ReadData,
    input logic[31:0] ALUResult,
    input logic ResultSrc,
    output logic Result
);


    assign Result = (ResultSrc)? ReadData: ALUResult;
    
    
endmodule