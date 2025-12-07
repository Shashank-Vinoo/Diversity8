module cache(
    input  logic clk,
    input  logic rst,

    // CPU side interface 
    input  logic [31:2] addr,       
    input  logic write_en,
    input  logic [31:0] write_data,
    input  logic [31:0] backing_read_data,

    output logic [31:0] read_data,
    output logic hit
);

    /*
    This cache has the following layout:
        16 sets
        2 ways
        4 words per block designed for spatial locality
    This leaves us with
    */

    localparam NUM_SETS = 16;
    localparam NUM_WAYS = 2;
    localparam BLOCK_WORDS = 4;

    logic [31:0] data_array [NUM_SETS-1:0][NUM_WAYS-1:0][BLOCK_WORDS-1:0];
    logic [23:0] tag_array [NUM_SETS-1:0][NUM_WAYS-1:0];
    logic valid_array [NUM_SETS-1:0][NUM_WAYS-1:0];
    logic lru_array [NUM_SETS-1:0];

    logic [29:0] word_addr;
    logic [23:0] addr_tag;
    logic [3:0] addr_set;
    logic [1:0] addr_block_offset;
    
    assign word_addr = addr[31:2]; // Words increase by 4 so get rid of the last two bits
    assign addr_block_offset = word_addr[1:0]; //Selects which word in the block of 4
    assign addr_set = word_addr[5:2]; // which set, set to 4 bits as log2
    assign addr_tag = word_addr[29:6]; //tag
    
    //Cache hit logic, checks if the data is valid and the tag is present
    always_comb begin
        if(valid_array[addr_set][0] && tag_array[addr_set][0] == addr_tag) begin
            hit = 1'b1;
            read_data = data_array[addr_set][0][addr_block_offset];
        end
        else if (valid_array[addr_set][1] && tag_array[addr_set][1] == addr_tag) begin 
            hit = 1'b1;
            read_data = data_array[addr_set][1][addr_block_offset];
        end
        else begin
            hit = 1'b0;
            read_data = write_en ? 32'b0 : backing_read_data;
        end
    end

    logic replace_way;

    always_comb begin
        if(~valid_array[addr_set][0])
            replace_way = 1'b0;
        else if (~valid_array[addr_set][1])
            replace_way = 1'b1;
        else 
            replace_way = lru_array[addr_set];
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            //Reset absolutely everything
            for(int set = 0; set < NUM_SETS; set++) begin
                for(int way = 0; way < NUM_WAYS; way++) begin
                    valid_array[set][way] <= 1'b0;
                    tag_array[set][way] <= 24'b0;
                    for (int block = 0; block < BLOCK_WORDS; block++)
                        data_array[set][way][block] <= 32'b0;
                end
                lru_array[set] <= 1'b0;
            end
        end
        else begin
            if(hit) begin
                if(valid_array[addr_set][0] && tag_array[addr_set][0]==addr_tag) begin
                    if(write_en)
                        data_array[addr_set][0][addr_block_offset] <= write_data;
                    lru_array[addr_set] <= 1'b1;
                end
                else if(valid_array[addr_set][1] && tag_array[addr_set][1]==addr_tag) begin
                    if(write_en)
                        data_array[addr_set][1][addr_block_offset] <= write_data;
                    lru_array[addr_set] <= 1'b0;
                end 
            end
            else begin
                data_array[addr_set][replace_way][addr_block_offset] <= write_en ? write_data : backing_read_data;
                tag_array[addr_set][replace_way] <= addr_tag;
                valid_array[addr_set][replace_way] <= 1'b1;
                lru_array[addr_set] <= ~replace_way;
            end
        end
    end
endmodule
