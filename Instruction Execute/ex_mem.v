`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2026 05:05:45 PM
// Design Name: 
// Module Name: ex_mem
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


module ex_mem(
    input wire clk,                     // Hardware stepping clock trigger pin
    input wire [1:0] ctlwb_out,         // Decoded write-back signals moving forward from the latch
    input wire [2:0] ctlm_out,          // Decoded memory path signal bundles moving forward
    input wire [31:0] adder_out,        // Computed branch destination space pointer value
    input wire aluzero,                 // Current zero evaluation comparison state flag
    input wire [31:0] aluout,           // Finalized execution arithmetic computational payload
    input wire [31:0] readdat2,         // Stable register file port 2 contents line data
    input wire [4:0] muxout,            // Chosen target writeback address register index
    
    output reg [1:0] wb_ctlout,         // Stable buffered writeback configuration lines out
    output reg [2:0] ctlm_ctlout,       // Stable buffered memory path handling signal bundles out
    output reg [31:0] alu_result,       // Stable buffered computational calculations result payload out
    output reg [31:0] rdata2out,        // Stable buffered storage tracking data lines out
    output reg [4:0] five_bit_muxout    // Stable buffered register target pointer index out
);

    // Initial power-on block to eliminate undefined 'x' simulation waveforms at startup
    initial begin
        wb_ctlout       = 2'b0;
        ctlm_ctlout     = 3'b0;
        alu_result      = 32'b0;
        rdata2out       = 32'b0;
        five_bit_muxout = 5'b0;
    end

    // Positive clock edge sampling block with the specified update delay
    always @(posedge clk) begin
        #1 // Mirroring the professor's requested update-delay interval layout
        wb_ctlout       <= ctlwb_out;
        ctlm_ctlout     <= ctlm_out;
        alu_result      <= aluout;
        rdata2out       <= readdat2;
        five_bit_muxout <= muxout;
    end

endmodule
