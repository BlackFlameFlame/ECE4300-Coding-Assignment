`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2026 10:09:16 AM
// Design Name: 
// Module Name: mux
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


module mux
    (
        input wire sel,         //Select Signal
        input [31:0] a_true,    //Branch Address From ExMem
        input [31:0] b_false,   //Next Sequential Address (PC + 4)
        output [31:0] y
    );
    
    assign y = sel ? a_true : b_false; //sel = 0: Normal, sel = 1: Branch
    
endmodule
