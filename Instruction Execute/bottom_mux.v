`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2026 04:33:10 PM
// Design Name: 
// Module Name: bottom_mux
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


module bottom_mux(
    input wire [4:0] a,    // Connects to instr_15_11 (rd field for R-type)
    input wire [4:0] b,    // Connects to instr_20_16 (rt field for I-type)
    input wire sel,        // Driven by the regdst control line
    output wire [4:0] y    // Selected 5-bit register file destination index
);

    assign y = sel ? a : b; // If regdst=1 pick rd, if regdst=0 pick rt

endmodule
