`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2026 10:19:41 AM
// Design Name: 
// Module Name: pc
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


module pc
    #(parameter WIDTH = 32)
    (
        input wire clk,
        input wire rst,
        input wire [WIDTH-1:0] pc_in,
        output reg [WIDTH-1:0] pc_out
    );
    
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                pc_out <= 32'b0;
            else
                pc_out <= pc_in;    
        end
    
endmodule
