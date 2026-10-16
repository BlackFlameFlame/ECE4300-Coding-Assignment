`timescale 1ns / 1ps

module ifIdLatch_tb;

// Testbench inputs
reg clk;
reg rst;
reg [31:0] pc_in;
reg [31:0] instr_in;

// Testbench outputs
wire [31:0] pc_out;
wire [31:0] instr_out;

// Instantiate IF/ID Latch
ifIdLatch uut(
    .clk(clk),
    .rst(rst),
    .pc_in(pc_in),
    .instr_in(instr_in),
    .pc_out(pc_out),
    .instr_out(instr_out)
);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test IF/ID Latch operation
initial begin

    // Initialize inputs
    rst = 1;
    pc_in = 32'd0;
    instr_in = 32'd0;

    $monitor("Time=%0t rst=%b pc_in=%d instr_in=%h pc_out=%d instr_out=%h",
             $time, rst, pc_in, instr_in, pc_out, instr_out);

    // Release reset
    #12 rst = 0;

    // Test 1: First instruction
    #10;
    pc_in = 32'd4;
    instr_in = 32'hA00000AA;

    // Test 2: Second instruction
    #10;
    pc_in = 32'd8;
    instr_in = 32'h10000011;

    // Test 3: Third instruction
    #10;
    pc_in = 32'd12;
    instr_in = 32'h20000022;

    // Test 4: Fourth instruction
    #10;
    pc_in = 32'd16;
    instr_in = 32'h30000033;

    // Test 5: Asynchronous reset
    #10 rst = 1;

    // Release reset
    #10 rst = 0;

    // Test 6: Another instruction
    #10;
    pc_in = 32'd20;
    instr_in = 32'h40000044;

    // End simulation
    #10 $finish;

end

endmodule