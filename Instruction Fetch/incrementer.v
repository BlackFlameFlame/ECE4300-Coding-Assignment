`timescale 1ns / 1ps

module incrementer
    #(parameter WIDTH = 32)
    (
        input wire clk,
        input wire rst,
        input wire [WIDTH-1:0] pcin,
        output wire [WIDTH-1:0] pcout
    );
    
    assign pcout= pcin + 4;
    
endmodule
