`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2026 10:31:55 AM
// Design Name: 
// Module Name: instrMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instrMem(
        input wire clk,           // Clock signal (unused)
        input wire rst,           // Reset signal (unused)
        input wire [31:0] addr,   // 32-bit address (2^32 possibilities)
        output reg [31:0] data    // 32-bit instruction output
);

//Declare instruction memory
// 40 locations for simulation
reg [31:0] mem [0:23];

// Initialize the first 10 instructions
initial begin
    $readmemb("instr.mem", mem);
end

// Read instruction using direct address
always @(*) begin
    if (addr[31:2] < 32'd24)
        data = mem[addr[31:2]];
    else
        data = 32'bx;
end
endmodule
