`timescale 1ns / 1ps

module mux
    #(parameter WIDTH = 32)
    (
        input wire sel, 
        input [31:0] a_true, //Branch Address From ExMem
        input [31:0] b_false, //Next Sequential Address (PC + 4)
        output [31:0] y
    );
    
    assign y = sel ? a_true : b_false; //sel = 0: Normal, sel = 1: Branch
endmodule
