module control_hazard_unit(
    input logic branch, 
    output logic flush
);

    always_comb begin 
        
        if (branch) begin
            flush = 1'b1;
        end
        else begin
            flush = 1'b0;
        end
        
    end



endmodule

