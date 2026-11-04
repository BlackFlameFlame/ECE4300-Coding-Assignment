`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 12:15:11 PM
// Design Name: 
// Module Name: alu_control_tb
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


module alu_control_tb;

    //Wire Ports
    wire [2:0] select;
    //Register Declarations
    reg [1:0] alu_op;
    reg [5:0] funct;
    
    alu_control alucontrol(
                            .select(select), 
                            .aluop(alu_op), 
                            .funct(funct) 
                          );
    
    initial 
        begin
            alu_op = 2'b00; // lwsw
            funct = 6'b100000; // select = 010
            $monitor("Time=%0t | ALUOp = %b\tfunct = %b\tselect = %b", $time, alu_op, funct, select);
            #10;
            
            alu_op = 2'b01; // I-type
            funct = 6'b100000; // select = 110
            #10;
            
            alu_op = 2'b10; // R-type, and so are all subsequent opcodes
            funct = 6'b100000; // add, therefore select = 010
            #10;
            
            funct = 6'b100010; // select = 110
            #10;
            
            funct = 6'b100100; // select = 000
            #10;
            
            funct = 6'b100101; // select = 001
            #10;
            
            funct = 6'b101010; // select = 111
            #10;
            
            $finish;
        end
endmodule //alu_control_testbench
