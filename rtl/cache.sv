module cache(
    input  logic clk,
    input  logic rst,

    // CPU side interface 
    input  logic [31:2] addr,       
    input  logic read_en,
    input  logic write_en,
    input  logic [31:0] write_data,
    input  logic [31:0] backing_read_data,

    output logic [31:0] read_data
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
    localparam BLOCK_WORDS = 1;

    logic hit;

    logic [31:0] data_array [NUM_SETS-1:0][NUM_WAYS-1:0][BLOCK_WORDS-1:0];
    logic [25:0] tag_array [NUM_SETS-1:0][NUM_WAYS-1:0];
    logic valid_array [NUM_SETS-1:0][NUM_WAYS-1:0];
    logic lru_array [NUM_SETS-1:0];

    logic [25:0] addr_tag;
    logic [3:0] addr_set;
    logic access_en;
    
    assign addr_set = addr[5:2]; // which set, set to 4 bits as log2
    assign addr_tag = addr[31:6]; //tag
    assign access_en = read_en | write_en;
    
    //Cache hit logic, checks if the data is valid and the tag is present
    always_comb begin
        hit = 1'b0;
        read_data = 32'b0;

        if(access_en) begin
            if(valid_array[addr_set][0] && tag_array[addr_set][0] == addr_tag) begin
                hit = 1'b1;
                read_data = data_array[addr_set][0][0];
            end
            else if (valid_array[addr_set][1] && tag_array[addr_set][1] == addr_tag) begin 
                hit = 1'b1;
                read_data = data_array[addr_set][1][0];
            end
            else if (read_en) begin
                read_data = backing_read_data;
            end
        end
    end

    logic replace_way;

    always_comb begin
        replace_way = lru_array[addr_set];
        if(~valid_array[addr_set][0])
            replace_way = 1'b0;
        else if (~valid_array[addr_set][1])
            replace_way = 1'b1;
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            //Reset absolutely everything
            for(int set = 0; set < NUM_SETS; set++) begin
                for(int way = 0; way < NUM_WAYS; way++) begin
                    valid_array[set][way] <= 1'b0;
                    tag_array[set][way] <= 26'b0;
                    for (int block = 0; block < BLOCK_WORDS; block++)
                        data_array[set][way][block] <= 32'b0;
                end
                lru_array[set] <= 1'b0;
            end
        end
        else if (access_en) begin
            if(hit) begin
                if(valid_array[addr_set][0] && tag_array[addr_set][0]==addr_tag) begin
                    if(write_en)
                        data_array[addr_set][0][0] <= write_data;
                    lru_array[addr_set] <= 1'b1;
                end
                else if(valid_array[addr_set][1] && tag_array[addr_set][1]==addr_tag) begin
                    if(write_en)
                        data_array[addr_set][1][0] <= write_data;
                    lru_array[addr_set] <= 1'b0;
                end 
            end
            else begin
                data_array[addr_set][replace_way][0] <= write_en ? write_data : backing_read_data;
                tag_array[addr_set][replace_way] <= addr_tag;
                valid_array[addr_set][replace_way] <= 1'b1;
                lru_array[addr_set] <= ~replace_way;
            end
        end
    end
endmodule
