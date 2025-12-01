module hazard_unit(
    //control hazard unit
    input logic branch,
    output logic flush,

    //data hazard unit
    input logic [4:0]   rs1_d,
    input logic [4:0]   rs2_d,
    input logic [4:0]   rs1_e,
    input logic [4:0]   rs2_e,
    input logic         mem_read_e,
    input logic [4:0]   rd_e,
    input logic [4:0]   rd_m,
    input logic         reg_write_m,
    input logic [4:0]   rd_w,
    input logic         reg_write_w,

    output logic [1:0]  forward_a_e,
    output logic [1:0]  forward_b_e,
    output logic        stall
);

    control_hazard_unit control_hazard_unit_i(
        .branch(branch),
        .flush(flush)
    );

    data_hazard_unit data_hazard_unit_i(
        .rs1_d(rs1_d),
        .rs2_d(rs2_d),
        .rs1_e(rs1_e),
        .rs2_e(rs2_e),
        .mem_read_e(mem_read_e),
        .rd_e(rd_e),
        .rd_m(rd_m),
        .reg_write_m(reg_write_m),
        .rd_w(rd_w),
        .reg_write_w(reg_write_w),
        .forward_a_e(forward_a_e),
        .forward_b_e(forward_b_e),
        .stall(stall)
    );

endmodule
