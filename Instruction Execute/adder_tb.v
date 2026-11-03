`timescale 1ns / 1ps

// Adder Testbench
module adder_tb;

reg [31:0] add_in1;
reg [31:0] add_in2;

wire [31:0] add_out;

// Instantiate Adder
adder uut(
    .add_in1(add_in1),
    .add_in2(add_in2),
    .add_out(add_out)
);

initial begin

    // Display simulation results
    $monitor("Time=%0t A=%h B=%h Result=%h",
             $time, add_in1, add_in2, add_out);

    // Test 1: Normal addition
    add_in1 = 32'd100;
    add_in2 = 32'd12;
    #10;

    // Test 2: Another positive addition
    add_in1 = 32'd200;
    add_in2 = 32'd20;
    #10;

    // Test 3: Negative immediate
    add_in1 = 32'd100;
    add_in2 = 32'hFFFFFFFC;
    #10;

    // Test 4: Add zero
    add_in1 = 32'd100;
    add_in2 = 32'd0;
    #10;

    // Test 5: 32-bit overflow (wraparound)
    add_in1 = 32'hFFFFFFFF;
    add_in2 = 32'd1;
    #10;

    $finish;

end

endmodule