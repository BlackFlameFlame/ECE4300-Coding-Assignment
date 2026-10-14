`timescale 1ns / 1ps

// Instruction Memory
// 32-bit wide with a 2^32 address space
// Uses direct addressing without an offset

module instrMem
    #(parameter WIDTH = 32)
    (
        input wire clk,           // Clock signal (unused)
        input wire rst,           // Reset signal (unused)
        input wire [WIDTH-1:0] addr,   // 32-bit address (2^32 possibilities)
        output reg [WIDTH-1:0] data    // 32-bit instruction output
    );

// Number of possible addresses
localparam [63:0] DEPTH = 64'd2**32;

// Store only the initialized instruction locations
// Avoid allocating all 2^32 words
    reg [WIDTH-1:0] mem [0:39];

// Read instruction using direct address
always @(*) begin
    if (addr < 32'd40)
        data = mem[addr];
    else
        data = 32'bx;
end

// Initialize the first 10 instructions
initial begin
    mem[0]  = 32'hA00000AA;
    mem[4]  = 32'h10000011;
    mem[8]  = 32'h20000022;
    mem[12] = 32'h30000033;
    mem[16] = 32'h40000044;
    mem[20] = 32'h50000055;
    mem[24] = 32'h60000066;
    mem[28] = 32'h70000077;
    mem[32] = 32'h80000088;
    mem[36] = 32'h90000099;
end

endmodule
