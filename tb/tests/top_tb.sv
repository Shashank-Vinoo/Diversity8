module top_tb;

    logic clk;
    logic rst;
    logic [31:0] a0;

    top dut (
        .clk(clk),
        .rst(rst),
        .a0(a0)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
        $dumpvars(0, top_tb.dut);
    end

    initial begin
        rst = 1;
        #2;
        rst = 0;

        repeat (10) begin
            @(posedge clk);
            display_registers();
        end

        $finish;
    end

    task display_registers;
        integer i;
        begin
            $display("\n=== Register File State at time %0t ===", $time);
            for (i = 0; i < 32; i = i + 4) begin
                $display("x%02d: %h  x%02d: %h  x%02d: %h  x%02d: %h",
                    i,   dut.reg_file_i.registers[i],
                    i+1, dut.reg_file_i.registers[i+1],
                    i+2, dut.reg_file_i.registers[i+2],
                    i+3, dut.reg_file_i.registers[i+3]);
            end
            $display("PC: %h  Instr: %h  a0: %h\n",
                dut.PC,
                dut.instruction,
                dut.a0);
        end
    endtask

endmodule
