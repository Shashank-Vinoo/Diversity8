#include "../base_testbench.h"

unsigned int ticks = 0;


class Cache_tb : public BaseTestbench
{
protected:

    void initializeInputs() override
    {
        top->clk = 0;
        top->rst = 0;
        top->addr = 0;
        top->read_en = 0;
        top->write_en = 0;
        top->write_data = 0;
        top->backing_read_data = 0;
    }

    void tick()
    {
        // Falling edge
        top->clk = 0;
        top->eval();

        // Rising edge (this triggers the always_ff block)
        top->clk = 1;
        top->eval();
    }
};



TEST_F(Cache_tb, Reset_Clears_All)
{
    initializeInputs();


    top->addr = 0x00000000;
    top->read_en = 1;
    top->backing_read_data = 0xAAAAAAAA;
    tick(); // miss -> fill
    EXPECT_EQ(top->read_data, 0xAAAAAAAA);

    top->rst = 1;
    tick();

    top->addr = 0x00000000;
    top->read_en = 1;
    top->backing_read_data = 0xBBBBBBBB;
    tick(); // miss -> fill
    // Should not get previous data
    EXPECT_EQ(top->read_data, 0xBBBBBBBB);
    


}


TEST_F(Cache_tb, Write_Hit_Updates_Cache)
{
    initializeInputs();
    top->rst = 1;
    tick();
    top->rst = 0;
    tick();


    top->addr = 0x00000020;
    top->read_en = 1;
    top->backing_read_data = 0x11111111;
    tick();

    EXPECT_EQ(top->read_data, 0x11111111);


    top->read_en = 0;
    top->write_en = 1;
    top->write_data = 0x22222222;
    tick();

    top->write_en = 0;
    top->read_en = 1;
    tick();

    EXPECT_EQ(top->read_data, 0x22222222);
}


TEST_F(Cache_tb, Two_Way_Miss_Fill)
{
    initializeInputs();

    
    top->rst = 1; 
    tick();
    top->rst = 0; 
    tick();

    
    uint32_t addr1 = 0;    // tag=0, set=0
    uint32_t addr2 = 64;   // tag=1, set=0

    
    top->addr = addr1;
    top->read_en = 1;
    top->write_en = 0;
    top->backing_read_data = 0xAAAAAAAA;
    tick();
    EXPECT_EQ(top->read_data, 0xAAAAAAAA);

    
    top->addr = addr2;
    top->backing_read_data = 0xBBBBBBBB;
    tick();
    EXPECT_EQ(top->read_data, 0xBBBBBBBB);
}


TEST_F(Cache_tb, Two_Way_Read_Hit)
{
    initializeInputs();

    top->rst = 1; 
    tick();
    top->rst = 0; 
    tick();

    uint32_t addr1 = 0;    // tag=0, set=0
    uint32_t addr2 = 64;   // tag=1, set=0

    // filling both
    top->addr = addr1;
    top->read_en = 1;
    top->backing_read_data = 0xAAAAAAAA;
    tick();

    top->addr = addr2;
    top->backing_read_data = 0xBBBBBBBB;
    tick();

    
    top->addr = addr1;
    top->backing_read_data = 0xDDDDDDDD; // ignored
    tick();
    EXPECT_EQ(top->read_data, 0xAAAAAAAA);

    
    top->addr = addr2;
    top->backing_read_data = 0xDDDDDDDD; // ignored
    tick();
    EXPECT_EQ(top->read_data, 0xBBBBBBBB);
}


TEST_F(Cache_tb, Two_Way_LRU)
{
    initializeInputs();
    top->rst = 1;
    tick();
    top->rst = 0;
    tick();

    
    uint32_t addr1 = 0;    // way 0
    uint32_t addr2 = 64;   // way 1
    uint32_t addr3 = 128;  // will kick out one of the 2

    // Fill both
    top->addr = addr1;
    top->read_en = 1;
    top->backing_read_data = 0x00000001;
    tick();
    EXPECT_EQ(top->read_data, 0x00000001);

    top->addr = addr2;
    top->backing_read_data = 0x00000002;
    tick();
    EXPECT_EQ(top->read_data, 0x000000002);

    // Access addr1 again to make it most recently used
    top->addr = addr1;
    top->backing_read_data = 0x00000004; // should be ignored
    tick();
    EXPECT_EQ(top->read_data, 0x00000001);

    // Access addr3 → should get rid of addr2
    top->addr = addr3;
    top->backing_read_data = 0x00000003;
    tick();
    EXPECT_EQ(top->read_data, 0x00000003);

    // Check addr 1 still there
    top->addr = addr1;
    top->backing_read_data = 0x00000004; // ignored
    tick();
    EXPECT_EQ(top->read_data, 0x00000001);

    // addr2 should have been kicked out and changed
    top->addr = addr2;
    top->backing_read_data = 0x0000000A; // new value
    tick();

    // value at addr2 should be updated
    EXPECT_EQ(top->read_data, 0x0000000A);
}

TEST_F(Cache_tb, Write_Miss_LRU) {

    initializeInputs();
    top->rst = 1; tick();
    top->rst = 0; tick();

    uint32_t addr1 = 0x00;   // way 0
    uint32_t addr2 = 0x40;   // way 1, same set as addr1
    uint32_t addr3 = 0x80;   // will evict least recently used

    // Fill both ways
    top->addr = addr1; 
    top->read_en = 1; 
    top->backing_read_data = 0x11111111; 

    tick();

    top->addr = addr2; 
    top->read_en = 1; 
    top->backing_read_data = 0x22222222; 
    tick();

    // addr1 is used recently
    top->addr = addr1; 
    top->backing_read_data = 0x44444444; // should be ignored
    tick();


    EXPECT_EQ(top->read_data, 0x11111111);

    // addr3 should remove addr2
    top->addr = addr3; 
    top->write_en = 1; 
    top->write_data = 0x33333333; 
    top->backing_read_data = 0; 
    tick();

    // addr1 should still be intact
    top->write_en = 0; 
    top->read_en = 1; 
    top->addr = addr1;
    top->backing_read_data = 0x44444444;  
    tick();

    EXPECT_EQ(top->read_data, 0x11111111);

    //addr2 should have a new value as it was evicted
    top->addr = addr2; 
    top->backing_read_data = 0x44444444; 
    tick();

    EXPECT_EQ(top->read_data, 0x44444444);

    // addr3 value should be present
    top->addr = addr3; 
    tick();

    EXPECT_EQ(top->read_data, 0x33333333);


}



int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
