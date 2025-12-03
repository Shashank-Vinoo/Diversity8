module cache(
    input  logic clk,
    input  logic rst,

    //CPU side interface 
    input  logic [31:0] addr,       
    input  logic write_en,
    input  logic [31:0] write_data,

    output logic [31:0] read_data,
    output logic hit
);

    // Parameters
    localparam int NUM_SETS = 16;
    localparam int NUM_WAYS = 2;
    localparam int BLOCK_WORDS = 4;

    // work in word addresses dont care about byte offset
    localparam int BLOCK_OFFSET_BITS = 2; // 4 words per block, select which word inside the line
    localparam int SET_BITS = 4; // 16 sets, selects which set in the cache
    localparam int TAG_BITS = 24;  


    // address fields laid out for simpler access later on

    logic [29:0] word_addr;
    logic [TAG_BITS-1:0] addr_tag;
    logic [SET_BITS-1:0] addr_set;
    logic [BLOCK_OFFSET_BITS-1:0] addr_block_off;

    always_comb begin
        word_addr = addr[31:2]; // drop byte offset
        addr_block_off = word_addr[BLOCK_OFFSET_BITS-1:0]; //1:0
        addr_set = word_addr[BLOCK_OFFSET_BITS+SET_BITS-1:BLOCK_OFFSET_BITS]; //5:2
        addr_tag = word_addr[29:BLOCK_OFFSET_BITS+SET_BITS]; //29:6
    end


    // declaring the cache arrays for use heres the identity [set][way][word]

    logic [31:0] data_array [NUM_SETS-1:0][NUM_WAYS-1:0][BLOCK_WORDS-1:0];
    logic [TAG_BITS-1:0] tag_array [NUM_SETS-1:0][NUM_WAYS-1:0];
    logic valid_array [NUM_SETS-1:0][NUM_WAYS-1:0];



    // hit management and output data from the cache

    logic  hit_way [NUM_WAYS-1:0];//2:0
    logic [31:0] way_rdata [NUM_WAYS-1:0];//2:0

    always_comb begin
        // defaults
        hit       = 1'b0;
        read_data = 32'b0;

        for (int w = 0; w < NUM_WAYS; w++) begin
            hit_way[w]   = 1'b0;
            way_rdata[w] = 32'b0;
        end


        //prepopulating the hit way and read data from the data array
        for (int w = 0; w < NUM_WAYS; w++) begin
            //Set hit based on the valid bit of the sepcific way and then check the tag comparison aswell
            hit_way[w] = valid_array[addr_set][w] && (tag_array[addr_set][w] == addr_tag);
            //Data read form a specific way
            way_rdata[w] = data_array[addr_set][w][addr_block_off];
        end   


        //comfirming a hit occured in one of the ways
        for (int w = 0; w < NUM_WAYS; w++) begin
            hit |= hit_way[w];
        end


        // Outputing the read data based on which way had the hit

        if (hit) begin
            for (int w = 0; w < NUM_WAYS; w++) begin
                if (hit_way[w]) begin
                    read_data = way_rdata[w];
                end
            end
        end else begin
            read_data = 32'b0;
        end
    end



    // Reseting the cache if theres a reset signal by making all valid bits for bnoth ways 0

    //Updating the cache for sw instructions if im storing to a word in a memory location alread present in the cache

    //better words
    /* 
    Check if the address is already in the cache → if yes, output its data;
    and, if this is a store (write_en=1), update that cached word on the next clock edge.
    */ 

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            //clear valid_array initialising it all to 0
            for (int s = 0; s < NUM_SETS; s++) begin
               for (int w = 0; w < NUM_WAYS; w++) begin
                 valid_array[s][w] <= 1'b0;
               end
            end

        end else begin
            //replacing data for specific tag
            if (write_en) begin
                for (int w = 0; w < NUM_WAYS; w++) begin
                    if (hit_way[w]) begin
                        data_array[addr_set][w][addr_block_off] <= write_data;
                    end
                end
            end 
        end
    end



endmodule
