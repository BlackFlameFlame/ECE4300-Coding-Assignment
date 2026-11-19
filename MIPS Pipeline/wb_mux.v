`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 11:54:23 AM
// Design Name: 
// Module Name: wb_mux
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


module wb_mux(
    input wire [31:0] read_data,      // Input 1 (from Data Memory)
    input wire [31:0] mem_alu_result, // Input 0 (from ALU)
    input wire memtoreg,              // Select line
    output wire [31:0] write_data     // Output to Decode stage
);

    assign write_data = memtoreg ? read_data : mem_alu_result;

endmodule
