`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 11:07:26 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input wire clk,
    input wire [31:0] addr,
    input wire [31:0] write_data,
    input wire memwrite,
    input wire memread,
    output reg [31:0] read_data
);

    reg [31:0] DMEM [0:255];
    integer i;

    initial 
        begin
            read_data = 32'b0;
            for (i = 0; i < 256; i = i + 1) 
                begin
                    DMEM[i] = i;
                end
        end

    always @(posedge clk) 
        begin
            if (memwrite) 
                begin
                    DMEM[addr] <= write_data;
                end
        end

    always @(*) 
        begin
            if (memread) 
                begin
                    read_data = DMEM[addr];
                end 
            else 
                begin
                    read_data = 32'b0;
                end
        end

endmodule
