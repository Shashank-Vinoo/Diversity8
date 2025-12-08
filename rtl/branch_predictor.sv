module branch_predictor #(
    parameter ROWS      = 32,
    parameter ROW_INDEX = 5,
    parameter TAG_BITS  = 25
)(
    input logic clk,
    input logic rst,

    //fetch 
    input  logic [31:0] pc_fetch,
    output logic [31:0] pred_pc,
    output logic pred_taken,

    //execute
    input  logic upd_bt,
    input  logic [31:0] pc_e,
    input  logic upd_taken,
    input  logic [31:0] upd_target
);

    // branch table
    logic valid[ROWS];
    logic [TAG_BITS-1:0] tag [ROWS];
    logic [31:0] target [ROWS];
    logic [1:0] branch_pred_state[ROWS]; 

    //fetch computation
    logic [ROW_INDEX-1:0] index_fetch;
    logic [TAG_BITS-1:0] tag_fetch;

    always_comb begin
        index_fetch = pc_fetch[ROW_INDEX+1:2]; //getting the index for BT from the PC in fetch 
        tag_fetch = pc_fetch[31:32-TAG_BITS]; //getting the tag bits for comparison
    end

    //checking if a branch should be taken or not based on the branch_pred_state
    always_comb begin
        pred_taken = 0;
        pred_pc = pc_fetch + 4;
        //check if the BT hit is valid and the tag matches for the specific index
        if(valid[index_fetch] &&  (tag[index_fetch] == tag_fetch))begin
            //extracting the msb of the fsm state
            pred_taken = branch_pred_state[index_fetch][1]; 
            pred_pc = pred_taken ? target[index_fetch]:pc_fetch+4;
        end
    end

    //updating the branch table by looking at the execute stage

    logic [ROW_INDEX-1:0] u_index;
    logic [TAG_BITS-1:0] u_tag;
    logic                 unused_pc_e_bits;

    always_comb begin
        u_index = pc_e[ROW_INDEX+1:2];
        u_tag = pc_e[31:32-TAG_BITS];
        unused_pc_e_bits = |pc_e[1:0]; // consume low bits (word-aligned PCs)
    end


    always_ff @(posedge clk)begin
        //resetting the Branch table
        if (rst) begin
            integer i;
            for(i=0; i < ROWS; i++) begin
                valid[i]<=1'b0;
                branch_pred_state[i] <= 2'b00;
            end
        end else if(upd_bt) begin
             // allocate or update btb entry for this branch
            valid[u_index]  <= 1'b1;
            tag[u_index]    <= u_tag;
            target[u_index] <= upd_target;

            // updating the state of the current branch within the table
            case ({branch_pred_state[u_index], upd_taken})
                3'b00_1: branch_pred_state[u_index] <= branch_pred_state[u_index] + 1; // toward taken
                3'b01_1: branch_pred_state[u_index] <= branch_pred_state[u_index] + 1; // toward taken
                3'b10_1: branch_pred_state[u_index] <= 2'b11;
                3'b11_0: branch_pred_state[u_index] <= branch_pred_state[u_index] - 1; // toward not taken
                3'b10_0: branch_pred_state[u_index] <= branch_pred_state[u_index] - 1; // toward not taken
                3'b01_0: branch_pred_state[u_index] <= 2'b00;
                default: branch_pred_state[u_index] <= 2'b01;
            endcase
        end
    end


endmodule
