`timescale 1ns / 1ps

module incrementer_tb;

// Testbench inputs
reg clk;
reg rst;
reg [31:0] pcin;

// Testbench output
wire [31:0] pcout;

// Instantiate incrementer module
incrementer uut(
    .clk(clk),
    .rst(rst),
    .pcin(pcin),
    .pcout(pcout)
);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test incrementer operation
initial begin

    // Initialize inputs
    rst = 1;
    pcin = 32'd0;

    $monitor("Time=%0t pcin=%d pcout=%d",
             $time, pcin, pcout);

    // Release reset
    #12 rst = 0;

    // Test different PC addresses
    #10 pcin = 32'd4;
    #10 pcin = 32'd8;
    #10 pcin = 32'd12;
    #10 pcin = 32'd16;
    #10 pcin = 32'd20;
    #10 pcin = 32'd36;

    // End simulation
    #10 $finish;

end

endmodule