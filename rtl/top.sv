module top(
    input  logic clk,
    input  logic rst,
    output logic [31:0] a0
);

    //PC
    logic [31:0] pc;
    logic [31:0] next_pc;
    logic [31:0] pc_plus4_f;
    logic [31:0] branch_pc;

    //Control unit
    logic [31:0] instr_f;
    logic [31:0] imm_ext_d;

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    logic take_branch;
    logic result_src;
    logic mem_write;
    logic [2:0] alu_control;
    logic alu_src;
    logic [1:0] imm_src;
    logic reg_write;

    //Regfile 
    logic [31:0] rd1;
    logic [31:0] rd2;
    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    logic [31:0] wd3;

    //ALU
    logic [31:0] alu_out;
    logic alu_zero;
    logic [1:0] branch_d;
    logic [31:0] data_mem_read; 

    logic [31:0] instr_d;      
    logic [31:0] pc_d;        
    logic [31:0] pc_plus4_d;
    logic [31:0] alu_op2_e;

    logic [31:0] alu_input_a_e;
    logic [31:0] alu_input_b_e;

    // Decode->Execute 
    logic        reg_write_e;
    logic [1:0]  result_src_e;
    logic        mem_write_e;
    logic        jump_e = 1'b0;
    logic [1:0]      branch_e;
    logic [2:0]  alu_control_e;
    logic        alu_src_e;
    logic [1:0]  imm_src_e;
    logic [31:0] rd1_e;
    logic [31:0] rd2_e;
    logic [31:0] pc_e;
    logic [4:0]  rd_e;
    logic [31:0] imm_ext_e;
    logic [31:0] pc_plus4_e;

    // Execute->Mem 
    logic        reg_write_m;
    logic [1:0]  result_src_m;
    logic        mem_write_m;
    logic [31:0] alu_result_m;
    logic [31:0] write_data_m;
    logic [4:0]  rd_m;
    logic [31:0] pc_plus4_m;

    // Mem->Write
    logic [31:0] read_data_w;
    logic [31:0] alu_result_w;
    logic [1:0]  result_src_w;
    logic        reg_write_w;
    logic [4:0]  rd_w;
    logic [31:0] pc_plus4_w;

    logic [1:0] result_src_d;

    /* Hazard unit: */

    // flushing for pipes
    logic flush;
    logic flush_pipe;

    // Forwarding signals
    logic [1:0] forward_a_e;
    logic [1:0] forward_b_e;    
    logic [4:0] rs1_e;
    logic [4:0] rs2_e;


    assign result_src_d = {1'b0, result_src}; 


    assign take_branch = (branch_e[0] & alu_zero) | (branch_e[1] & ~alu_zero) | jump_e;

   


    branch_pc_adder branch_pc_adder_i(
        .pc(pc_e),
        .imm_ext(imm_ext_e),
        .branch_pc(branch_pc)
    );

    pc_reg pc_reg_i(
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
        .pc(pc)
    );

    pc_src_mux pc_src_mux_i(
        .pc_src(take_branch),
        .branch_pc(branch_pc),
        .pc_plus4(pc_plus4_f),
        .next_pc(next_pc)
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
        .result_src(result_src),
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
        .rd1_e(rd1_e),
        .rd2_e(rd2_e),
        .alu_result_m(alu_result_m),
        .result_w(wd3),                 //smth sus happening here
        .forward_a_e(forward_a_e),
        .forward_b_e(forward_b_e),
        .alu_input_a_e(alu_input_a_e),
        .alu_input_b_e(alu_input_b_e)
    );


    alu_src_mux alu_src_mux_i(
        .reg_op2(alu_input_b_e),
        .imm_ext(imm_ext_e),
        .alu_src(alu_src_e),
        .alu_op2(alu_op2_e)
    );

    alu alu_i(
        .alu_op1(alu_input_a_e),
        .alu_op2(alu_op2_e),
        .alu_ctrl(alu_control_e),
        .alu_out(alu_out),
        .eq(alu_zero)
    );

    data_mem data_mem_i(
        .addr(alu_result_m),
        .clk(clk),
        .write_data(write_data_m),
        .write_enable(mem_write_m),
        .read_data(data_mem_read)
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

        .instr_f(instr_f),
        .pc_f(pc),
        .pc_plus4_f(pc_plus4_f),

        .instr_d(instr_d),
        .pc_d(pc_d),
        .pc_plus4_d(pc_plus4_d)
    );

    
    pipe_decode pipe_decode_i(
        .clk(clk),
        .rst(flush_pipe),
        
        .reg_write_d(reg_write),
        .result_src_d(result_src_d),
        .mem_write_d(mem_write),
        .jump_d(1'b0),
        .branch_d(branch_d),
        .alu_control_d(alu_control),
        .alu_src_d(alu_src),
        .imm_src_d(imm_src),
        .rd1_d(rd1),
        .rd2_d(rd2),
        .pc_d(pc_d),          
        .rd_d(rd_addr),
        .imm_ext_d(imm_ext_d),
        .pc_plus4_d(pc_plus4_d),

        .reg_write_e(reg_write_e),
        .result_src_e(result_src_e),
        .mem_write_e(mem_write_e),
        //.jump_e(jump_e),
        .branch_e(branch_e),
        .alu_control_e(alu_control_e),
        .alu_src_e(alu_src_e),
        .imm_src_e(imm_src_e),
        .rd1_e(rd1_e),
        .rd2_e(rd2_e),
        .pc_e(pc_e),
        .rd_e(rd_e),
        .imm_ext_e(imm_ext_e),
        .pc_plus4_e(pc_plus4_e)
    );


    pipe_mem pipe_mem_i(
        .clk(clk),
        .rst(flush_pipe),            

        .reg_write_e(reg_write_e),
        .result_src_e(result_src_e),
        .mem_write_e(mem_write_e),
        .alu_result_e(alu_out), 
        .write_data_e(rd2_e),         
        .rd_e(rd_e),
        .pc_plus4_e(pc_plus4_e),

        .reg_write_m(reg_write_m),
        .result_src_m(result_src_m),
        .mem_write_m(mem_write_m),
        .alu_result_m(alu_result_m),
        .write_data_m(write_data_m),
        .rd_m(rd_m),
        .pc_plus4_m(pc_plus4_m)
    );

    pipe_write pipe_write_i(
        .clk(clk),
        .rst(flush_pipe),

        .read_data_m(data_mem_read),
        .alu_result_m(alu_result_m),
        .result_src_m(result_src_m),
        .reg_write_m(reg_write_m),
        .rd_m(rd_m),                
        .pc_plus4_m(pc_plus4_m),

        .read_data_w(read_data_w),
        .alu_result_w(alu_result_w),
        .result_src_w(result_src_w),
        .reg_write_w(reg_write_w),
        .rd_w(rd_w),
        .pc_plus4_w(pc_plus4_w)
    );

    assign flush_pipe = rst | flush;
    assign rs1_e = instr_d[19:15];
    assign rs2_e = instr_d[24:20];

    hazard_unit hazard_unit_i(
        .branch(take_branch),
        .flush(flush),

        .rs1_e(rs1_e),
        .rs2_e(rs2_e),
        .rd_m(rd_m),
        .reg_write_m(reg_write_m),
        .rd_w(rd_w),
        .reg_write_w(reg_write_w),
        .forward_a_e(forward_a_e),
        .forward_b_e(forward_b_e)
    );


endmodule
