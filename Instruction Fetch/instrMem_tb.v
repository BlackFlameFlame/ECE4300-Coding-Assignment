`timescale 1ns / 1ps

module instrMem_tb;

// Testbench inputs
reg clk;
reg rst;
reg [31:0] addr;

// Testbench output
wire [31:0] data;

// Instantiate Instruction Memory
instrMem uut(
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .data(data)
);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test instruction memory
initial begin

    // Initialize inputs
    rst = 1;
    addr = 32'd0;

    $monitor("Time=%0t addr=%d data=%h",
             $time, addr, data);

    // Release reset
    #12 rst = 0;

    // Read all 10 initialized instructions
    #10 addr = 32'd4;
    #10 addr = 32'd8;
    #10 addr = 32'd12;
    #10 addr = 32'd16;
    #10 addr = 32'd20;
    #10 addr = 32'd24;
    #10 addr = 32'd28;
    #10 addr = 32'd32;
    #10 addr = 32'd36;

    // Test uninitialized address
    #10 addr = 32'd40;

    // Return to valid address
    #10 addr = 32'd16;

    // End simulation
    #10 $finish;

end

endmodule