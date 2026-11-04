`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2026 04:37:40 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input wire [5:0] funct,     // Lower 6 bits of the instruction (from s_extend[5:0])
    input wire [1:0] aluop,     // 2-bit main opcode configuration tracking bundle
    output reg [2:0] select     // 3-bit operational control output sent to drive the ALU core
);

    // Main Type Parameters
    parameter Rtype = 2'b10;
    parameter lwsw  = 2'b00;
    parameter Itype = 2'b01;
    parameter unknown = 2'b11;

    // ALU Action Codes 
    parameter ALUadd = 3'b010;
    parameter ALUsub = 3'b110;
    parameter ALUand = 3'b000;
    parameter ALUor  = 3'b001;
    parameter ALUslt = 3'b111;
    parameter ALUx   = 3'b011; // Catch-all undefined operation parameter

    // R-Type Function Field Constants
    parameter FUNCTadd = 6'b100000;
    parameter FUNCTsub = 6'b100010;
    parameter FUNCTand = 6'b100100;
    parameter FUNCTor  = 6'b100101;
    parameter FUNCTslt = 6'b101010;

    always @(*) begin
        case (aluop)
            lwsw: begin
                select = ALUadd; // Loads and stores always evaluate via arithmetic addition
            end
            Itype: begin
                select = ALUsub; // Branches (BEQ) use subtraction for evaluation comparisons
            end
            Rtype: begin
                case (funct) // Sub-decode R-type math operations using the funct field bits
                    FUNCTadd: select = ALUadd;
                    FUNCTsub: select = ALUsub;
                    FUNCTand: select = ALUand;
                    FUNCTor:  select = ALUor;
                    FUNCTslt: select = ALUslt;
                    default:  select = ALUx;
                endcase
            end
            default: begin
                select = ALUx; // Safe default assignment block for unmapped instructions
            end
        endcase
    end

endmodule
