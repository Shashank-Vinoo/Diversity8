module data_hazard_unit (
    input logic [4:0]   rs1_d,
    input logic [4:0]   rs2_d,
    input logic [4:0]   rs1_e,
    input logic [4:0]   rs2_e,
    input logic         mem_read_e,
    input logic [4:0]   rd_e,
    input logic         reg_write_e2,
    input logic [1:0]   result_src_e2,
    input logic [4:0]   rd_e2,
    input logic [4:0]   rd_m,
    input logic         reg_write_m,
    input logic [4:0]   rd_w,
    input logic         reg_write_w,

    output logic [1:0]  forward_a_e,
    output logic [1:0]  forward_b_e,
    output logic        stall
);

    always_comb begin 
        // no forwarding by default
        forward_a_e = 2'b00;
        forward_b_e = 2'b00;

        //stalling
        stall = 1'b0;
        
        // check ALU input A
        if(reg_write_e2 && (rd_e2 != 0) && (rd_e2 == rs1_e) && (result_src_e2 != 2'b01)) begin
            forward_a_e = 2'b11; 
        end
        else if(reg_write_m && (rd_m != 0) && (rd_m == rs1_e)) begin
            forward_a_e = 2'b10; 
        end
        else if(reg_write_w && (rd_w != 0) && (rd_w == rs1_e)) begin
            forward_a_e = 2'b01; 
        end

        // check ALU input B
        if(reg_write_e2 && (rd_e2 != 0) && (rd_e2 == rs2_e) && (result_src_e2 != 2'b01)) begin
            forward_b_e = 2'b11; 
        end
        else if(reg_write_m && (rd_m != 0) && (rd_m == rs2_e)) begin
            forward_b_e = 2'b10; 
        end
        else if(reg_write_w && (rd_w != 0) && (rd_w == rs2_e)) begin
            forward_b_e = 2'b01; 
        end

        if(mem_read_e && (rd_e == rs1_d || rd_e == rs2_d)) begin
            stall = 1'b1;
        end 

    end


endmodule

// rs1_e <= instr_d[19:15]      need to add in top.sv 
// rs2_e <= instr_d[24:20]      need to add in top.sv
//make a mux for ALU inputs in execute stage based on forward_a_e and forward_b_e signals

// stall should freeze F->D and D->E pipline registers 
