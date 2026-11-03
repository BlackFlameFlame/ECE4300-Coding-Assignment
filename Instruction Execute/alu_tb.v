`timescale 1ns / 1ps

// ALU Testbench
// Tests arithmetic, logical, and comparison operations

module alu_test;

// Inputs
reg [31:0] a;
reg [31:0] b;
reg [2:0] control;

// Outputs
wire [31:0] result;
wire zero;

// Instantiate the ALU
alu uut(
    .a(a),
    .b(b),
    .control(control),
    .result(result),
    .zero(zero)
);

// Apply test values
initial begin

    // Initialize inputs
    a = 32'd10;
    b = 32'd7;
    control = 3'b010;

    // Monitor changes
    $monitor("Time=%0t A=%d B=%d Control=%b Result=%h Zero=%b",
             $time, a, b, control, result, zero);

    // Test 1: ADD (10 + 7 = 17)
    #10 control = 3'b010;

    // Test 2: SUB (10 - 7 = 3)
    #10 control = 3'b110;

    // Test 3: AND (10 & 7 = 2)
    #10 control = 3'b000;

    // Test 4: OR (10 | 7 = 15)
    #10 control = 3'b001;

    // Test 5: SLT (10 < 7 is false)
    #10 control = 3'b111;

    // Test 6: SLT (7 < 10 is true)
    #10 a = 32'd7;
        b = 32'd10;
        control = 3'b111;

    // Test 7: Zero flag (10 - 10 = 0)
    #10 a = 32'd10;
        b = 32'd10;
        control = 3'b110;

    // Test 8: Signed SLT (-5 < 3 is true)
    #10 a = -32'sd5;
        b = 32'd3;
        control = 3'b111;

    // Test 9: Invalid ALU control
    #10 control = 3'b011;

    // End simulation
    #10 $finish;

end

endmodule