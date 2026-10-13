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


module instrMem
    #(parameter WIDTH = 32)
    (
        input wire clk,
        input wire rst,
        input wire [WIDTH-1:0] addr,
        output reg [WIDTH-1:0] data
    );
    
    always @(*)
        begin
            case(addr)
                0 : data = 32'hA00000AA;
                4 : data = 32'h10000011;
                8 : data = 32'h20000022;
                12 : data = 32'h30000033;
                16 : data = 32'h40000044;
                20 : data = 32'h50000055;
                24 : data = 32'h60000066;
                28 : data = 32'h70000077;
                32 : data = 32'h80000088;
                36 : data = 32'h90000099;
                default: data = 32'h00000000;
            endcase    
        end
    
endmodule
