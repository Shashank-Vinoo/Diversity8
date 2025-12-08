module top(
    input  logic clk,
    input  logic rst,
    output logic [31:0] a0
);

    // PC
    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] pc_plus4_f;
    logic [31:0] branch_pc;
    logic [31:0] pred_pc_f;
    logic pred_taken_f;

    // Control unit
    logic [31:0] instr_f;
    logic [31:0] imm_ext_d;

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    logic take_branch;
    logic result_src;
    logic mem_write;
    logic [3:0] alu_control;
    logic alu_src;
    logic [1:0] imm_src;
    logic reg_write;
    logic mem_read;

    // Regfile 
    logic [31:0] rd1;
    logic [31:0] rd2;
    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    logic [31:0] wd3;

    // ALU/branch
    logic [31:0] alu_out;
    logic alu_zero;
    logic [1:0] branch_d;
    logic jump_d;
    logic [31:0] cache_read_data; 
    logic [31:0] backing_read_data;

    logic [31:0] instr_d;      
    logic [31:0] pc_d;        
    logic [31:0] pc_plus4_d;

    // Execute stage 1 (forwarding prep)
    logic        reg_write_e1;
    logic [1:0]  result_src_e1;
    logic        mem_read_e1;
    logic        mem_write_e1;
    logic        jump_e1;
    logic [1:0]  branch_e1;
    logic [3:0]  alu_control_e1;
    logic        alu_src_e1;
    logic [31:0] rd1_e1;
    logic [31:0] rd2_e1;
    logic [4:0]  rs1_e1;
    logic [4:0]  rs2_e1;
    logic [4:0]  rd_e1;
    logic [31:0] pc_e1;
    logic [31:0] pc_plus4_e1;
    logic [31:0] imm_ext_e1;
    logic        pred_taken_e1;
    logic [31:0] pred_pc_e1;

    // Execute stage 2 (ALU)
    logic        reg_write_e2;
    logic [1:0]  result_src_e2;
    logic        mem_write_e2;
    logic        jump_e2;
    logic [1:0]  branch_e2;
    logic [3:0]  alu_control_e2;
    logic        alu_src_e2;
    logic [31:0] rd1_e2;
    logic [31:0] rd2_e2;
    logic [4:0]  rd_e2;
    logic [31:0] pc_e2;
    logic [31:0] pc_plus4_e2;
    logic [31:0] imm_ext_e2;
    logic        pred_taken_e2;
    logic [31:0] pred_pc_e2;

    // Execute2->Mem 
    logic        reg_write_m1;
    logic [1:0]  result_src_m1;
    logic        mem_write_m1;
    logic [31:0] alu_result_m1;
    logic [31:0] write_data_m1;
    logic [4:0]  rd_m1;
    logic [31:0] pc_plus4_m1;

    // Mem->Write
    logic [31:0] read_data_w;
    logic [31:0] alu_result_w;
    logic [1:0]  result_src_w;
    logic        reg_write_w;
    logic [4:0]  rd_w;
    logic [31:0] pc_plus4_w;

    logic [1:0] result_src_d;

    // Hazard unit helpers
    logic flush;
    logic flush_pipe;
    logic [1:0] forward_a_e;
    logic [1:0] forward_b_e;    
    logic stall;
    logic [31:0] next_pc_gated;
    logic  mispredict_e;
    logic [31:0] correct_pc_e;
    logic upd_bt;
    logic pred_taken_d;
    logic [31:0] pred_pc_d;

    logic [31:0] alu_input_a_e1;
    logic [31:0] alu_input_b_e1;
    logic [31:0] alu_op2_e2;
    logic [31:0] forward_data_m;

    assign result_src_d = {1'b0, result_src}; 

    assign take_branch = (branch_e2[0] & alu_zero) | (branch_e2[1] & ~alu_zero) | jump_e2;
    assign correct_pc_e = take_branch ? branch_pc : pc_plus4_e2;
    assign mispredict_e = (pred_taken_e2 != take_branch) || (take_branch && pred_taken_e2 && (pred_pc_e2 != branch_pc));
    assign upd_bt = jump_e2 | (branch_e2 != 2'b00);

    branch_pc_adder branch_pc_adder_i(
        .pc(pc_e2),
        .imm_ext(imm_ext_e2),
        .branch_pc(branch_pc)
    );

    branch_predictor branch_predictor_i(
        .clk(clk),
        .rst(rst),
        .pc_fetch(pc),
        .pred_pc(pred_pc_f),
        .pred_taken(pred_taken_f),
        .upd_bt(upd_bt),
        .pc_e(pc_e2),
        .upd_taken(take_branch),
        .upd_target(branch_pc)
    );
     
    assign next_pc = mispredict_e ? correct_pc_e : pred_pc_f;
    assign next_pc_gated = stall ? pc : next_pc;

    pc_reg pc_reg_i(
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc_gated),
        .pc(pc)
    );

    // instruction decode
    assign pc_plus4_f = pc + 32'd4;
    assign opcode = instr_d[6:0];
    assign funct3 = instr_d[14:12];
    assign funct7 = instr_d[31:25];
    assign rs1_addr = instr_d[19:15];
    assign rs2_addr = instr_d[24:20];
    assign rd_addr = instr_d[11:7];

    control_unit control_unit_i(
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .branch(branch_d),
        .jump(jump_d),
        .result_src(result_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_control(alu_control),
        .alu_src(alu_src),
        .imm_src(imm_src),
        .reg_write(reg_write)
    );

    imm_gen imm_gen_i(
        .imm_src(imm_src),
        .instruction(instr_d),
        .imm_ext(imm_ext_d)
    );

    instr_mem instr_mem_i(
        .imem_addr(pc),
        .read_data(instr_f)
    );

    alu_hazard_mux alu_hazard_mux_i(
        .rd1_e(rd1_e1),
        .rd2_e(rd2_e1),
        .alu_result_e(alu_out),
        .alu_result_m(forward_data_m),
        .result_w(wd3),
        .forward_a_e(forward_a_e),
        .forward_b_e(forward_b_e),
        .alu_input_a_e(alu_input_a_e1),
        .alu_input_b_e(alu_input_b_e1)
    );

    pipe_execute1 pipe_execute1_i(
        .clk(clk),
        .rst(flush_pipe),
        
        .reg_write_e1(reg_write_e1),
        .result_src_e1(result_src_e1),
        .mem_write_e1(mem_write_e1),
        .jump_e1(jump_e1),
        .branch_e1(branch_e1),
        .alu_control_e1(alu_control_e1),
        .alu_src_e1(alu_src_e1),
        .rd1_e1(alu_input_a_e1),
        .rd2_e1(alu_input_b_e1),
        .rd_e1(rd_e1),
        .pc_e1(pc_e1),
        .pc_plus4_e1(pc_plus4_e1),
        .imm_ext_e1(imm_ext_e1),
        .pred_taken_e1(pred_taken_e1),
        .pred_pc_e1(pred_pc_e1),
        
        .reg_write_e2(reg_write_e2),
        .result_src_e2(result_src_e2),
        .mem_write_e2(mem_write_e2),
        .jump_e2(jump_e2),
        .branch_e2(branch_e2),
        .alu_control_e2(alu_control_e2),
        .alu_src_e2(alu_src_e2),
        .rd1_e2(rd1_e2),
        .rd2_e2(rd2_e2),
        .rd_e2(rd_e2),
        .pc_e2(pc_e2),
        .pc_plus4_e2(pc_plus4_e2),
        .imm_ext_e2(imm_ext_e2),
        .pred_taken_e2(pred_taken_e2),
        .pred_pc_e2(pred_pc_e2)
    );

    alu_src_mux alu_src_mux_i(
        .reg_op2(rd2_e2),
        .imm_ext(imm_ext_e2),
        .alu_src(alu_src_e2),
        .alu_op2(alu_op2_e2)
    );

    alu alu_i(
        .alu_op1(rd1_e2),
        .alu_op2(alu_op2_e2),
        .alu_ctrl(alu_control_e2),
        .alu_out(alu_out),
        .eq(alu_zero)
    );

    pipe_execute2 pipe_execute2_i(
        .clk(clk),
        .rst(rst),
        
        .reg_write_e2(reg_write_e2),
        .result_src_e2(result_src_e2),
        .mem_write_e2(mem_write_e2),
        .alu_result_e2(alu_out),
        .write_data_e2(rd2_e2),
        .rd_e2(rd_e2),
        .pc_plus4_e2(pc_plus4_e2),
        
        .reg_write_m1(reg_write_m1),
        .result_src_m1(result_src_m1),
        .mem_write_m1(mem_write_m1),
        .alu_result_m1(alu_result_m1),
        .write_data_m1(write_data_m1),
        .rd_m1(rd_m1),
        .pc_plus4_m1(pc_plus4_m1)
    );

    data_mem data_mem_i(
        .addr(alu_result_m1),
        .clk(clk),
        .write_data(write_data_m1),
        .write_enable(mem_write_m1),
        .read_data(backing_read_data)
    );

    cache data_cache_i(
        .clk(clk),
        .rst(rst),
        .addr(alu_result_m1[31:2]),
        .write_en(mem_write_m1),
        .write_data(write_data_m1),
        .backing_read_data(backing_read_data),
        .read_data(cache_read_data)
    );

    data_mux data_mux_i(
        .read_data_w(read_data_w),
        .alu_result_w(alu_result_w),
        .pc_plus4_w(pc_plus4_w),
        .result_src_w(result_src_w),
        .result_w(wd3)
    );

    reg_file reg_file_i(
        .clk (clk),
        .rst (rst),
        .we3 (reg_write_w),
        .rs1 (rs1_addr),
        .rs2 (rs2_addr),
        .rd  (rd_w),
        .wd3 (wd3),
        .rd1 (rd1),
        .rd2 (rd2),
        .a0(a0)
    );

    pipe_fetch pipe_fetch_i(
        .clk(clk),
        .rst(flush_pipe),
        .stall(stall),

        .instr_f(instr_f),
        .pc_f(pc),
        .pc_plus4_f(pc_plus4_f),
        .pred_taken_f(pred_taken_f),
        .pred_pc_f(pred_pc_f),

        .instr_d(instr_d),
        .pc_d(pc_d),
        .pc_plus4_d(pc_plus4_d),
        .pred_taken_d(pred_taken_d),
        .pred_pc_d(pred_pc_d)
    );

    pipe_decode pipe_decode_i(
        .clk(clk),
        .rst(flush_pipe | stall),
        
        .reg_write_d(reg_write),
        .result_src_d(result_src_d),
        .mem_read_d(mem_read),
        .mem_write_d(mem_write),
        .jump_d(jump_d),
        .branch_d(branch_d),
        .alu_control_d(alu_control),
        .alu_src_d(alu_src),
        .rd1_d(rd1),
        .rd2_d(rd2),
        .rs1_d(rs1_addr),
        .rs2_d(rs2_addr),
        .pc_d(pc_d),          
        .rd_d(rd_addr),
        .imm_ext_d(imm_ext_d),
        .pc_plus4_d(pc_plus4_d),
        .pred_taken_d(pred_taken_d),
        .pred_pc_d(pred_pc_d),

        .reg_write_e1(reg_write_e1),
        .result_src_e1(result_src_e1),
        .mem_read_e1(mem_read_e1),
        .mem_write_e1(mem_write_e1),
        .jump_e1(jump_e1),
        .branch_e1(branch_e1),
        .alu_control_e1(alu_control_e1),
        .alu_src_e1(alu_src_e1),
        .rd1_e1(rd1_e1),
        .rd2_e1(rd2_e1),
        .rs1_e1(rs1_e1),
        .rs2_e1(rs2_e1),
        .pc_e1(pc_e1),
        .rd_e1(rd_e1),
        .imm_ext_e1(imm_ext_e1),
        .pc_plus4_e1(pc_plus4_e1),
        .pred_taken_e1(pred_taken_e1),
        .pred_pc_e1(pred_pc_e1)
    );

    pipe_write pipe_write_i(
        .clk(clk),
        .rst(rst),

        .read_data_m2(cache_read_data),
        .alu_result_m2(alu_result_m1),
        .result_src_m2(result_src_m1),
        .reg_write_m2(reg_write_m1),
        .rd_m2(rd_m1),                
        .pc_plus4_m2(pc_plus4_m1),

        .read_data_w(read_data_w),
        .alu_result_w(alu_result_w),
        .result_src_w(result_src_w),
        .reg_write_w(reg_write_w),
        .rd_w(rd_w),
        .pc_plus4_w(pc_plus4_w)
    );

    assign flush_pipe = rst | flush;

    hazard_unit hazard_unit_i(
        .branch(mispredict_e),
        .flush(flush),

        .rs1_d(rs1_addr),
        .rs2_d(rs2_addr),
        .rs1_e(rs1_e1),
        .rs2_e(rs2_e1),
        .mem_read_e(mem_read_e1),
        .rd_e(rd_e1),
        .reg_write_e2(reg_write_e2),
        .result_src_e2(result_src_e2),
        .rd_e2(rd_e2),
        .rd_m(rd_m1),
        .reg_write_m(reg_write_m1),
        .rd_w(rd_w),
        .reg_write_w(reg_write_w),
        .forward_a_e(forward_a_e),
        .forward_b_e(forward_b_e),
        .stall(stall)
    );

    assign forward_data_m = (result_src_m1 == 2'b01) ? cache_read_data :
                            (result_src_m1 == 2'b10) ? pc_plus4_m1 :
                            alu_result_m1;

endmodule
