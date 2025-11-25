module hazard_unit(
    input logic branch,
    output logic flush
);

    control_hazard_unit control_hazard_unit_i(
        .branch(branch),
        .flush(flush),
    );

endmodule