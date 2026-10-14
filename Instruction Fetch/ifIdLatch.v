`timescale 1ns / 1ps


module ifIdLatch
    #(parameter WIDTH = 32)
    (
        input wire clk,
        input wire rst,
        input wire [WIDTH-1:0] pc_in,
        input wire [WIDTH-1:0] instr_in,
        output reg [WIDTH-1:0] pc_out,
        output reg [WIDTH-1:0] instr_out
    );
    
    always @(posedge clk or posedge rst)
        begin
            if(rst)
                begin
                    pc_out <= 0;     //If reset button pressed clear out the contents of each register
                    instr_out <= 0;
                end
            else 
                begin
                    pc_out <= pc_in; //On every clock tick save pc_in and instr_in 
                    instr_out <= instr_in;
                end
        end
    
endmodule
