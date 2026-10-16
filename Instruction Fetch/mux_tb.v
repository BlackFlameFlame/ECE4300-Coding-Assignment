`timescale 1ns / 1ps

// MUX Testbench
// Tests the 2-to-1 multiplexer

module mux_tb;

// Testbench inputs
reg [31:0] a;       // Branch address
reg [31:0] b;       // Sequential PC address
reg sel;            // Select signal

// Testbench output
wire [31:0] y;      // Selected address

// Instantiate MUX module
mux uut(
    .a_true(a),     // Connect a to a_true
    .b_false(b),    // Connect b to b_false
    .sel(sel),      // Select signal
    .y(y)           // MUX output
);

// Test MUX operation
initial begin

    // Initialize inputs
    a = 32'd16;
    b = 32'd4;
    sel = 0;

    // Display simulation results
    $monitor("Time=%0t | sel=%b | a=%d | b=%d | y=%d",
             $time, sel, a, b, y);

    // Test 1: Select b (PC + 4)
    #10 sel = 0;

    // Test 2: Select a (Branch address)
    #10 sel = 1;

    // Test 3: Change inputs and select b
    #10;
    a = 32'd32;
    b = 32'd8;
    sel = 0;

    // Test 4: Select a
    #10 sel = 1;

    // Test 5: Change inputs and select b
    #10;
    a = 32'd64;
    b = 32'd12;
    sel = 0;

    // Test 6: Select a
    #10 sel = 1;

    // End simulation
    #10 $finish;

end

endmodule