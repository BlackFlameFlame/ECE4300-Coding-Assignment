`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2026 04:34:30 PM
// Design Name: 
// Module Name: top_mux
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


module top_mux(
    input wire [31:0] a,   // Connects to s_extend (Immediate constant value)
    input wire [31:0] b,   // Connects to rdata2 (Raw register contents data)
    input wire alusrc,     // Driven by the alusrc control line
    output wire [31:0] y   // Selected 32-bit ALU input operand
);

    assign y = alusrc ? a : b; // If alusrc=1 pick immediate constant, if alusrc=0 pick register data

endmodule
