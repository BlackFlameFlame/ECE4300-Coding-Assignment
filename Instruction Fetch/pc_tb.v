`timescale 1ns / 1ps

module PC_tb;

// Testbench inputs
reg clk;               // Clock signal
reg rst;               // Reset signal
reg [31:0] pc_in;      // Next PC address

// Testbench output
wire [31:0] pc_out;    // Current PC address

// Instantiate PC module
PC uut(
    .clk(clk),
    .rst(rst),
    .pc_in(pc_in),
    .pc_out(pc_out)
);

// Clock generation
// Clock period = 10 ns
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test PC operation
initial begin

    // Initialize inputs
    rst = 1;
    pc_in = 32'd0;

    // Display simulation results
    $monitor("Time=%0t | rst=%b | pc_in=%d | pc_out=%d",
             $time, rst, pc_in, pc_out);

    // Release reset
    #12 rst = 0;

    // Test 1: PC = 4
    #10 pc_in = 32'd4;

    // Test 2: PC = 8
    #10 pc_in = 32'd8;

    // Test 3: PC = 12
    #10 pc_in = 32'd12;

    // Test 4: PC = 16
    #10 pc_in = 32'd16;

    // Test 5: Reset PC
    #10 rst = 1;

    // Release reset
    #10 rst = 0;

    // Test 6: PC = 20
    #10 pc_in = 32'd20;

    // End simulation
    #10 $finish;

end

endmodule