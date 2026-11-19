`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2026 09:48:54 AM
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] add_in1, //NPC from the the ID/EX Latch
    input [31:0] add_in2, //SignExtend Immediate
    output [31:0] add_out //Calculate the Branch Adrress
    );
    
    assign add_out = add_in1 + add_in2;
endmodule
