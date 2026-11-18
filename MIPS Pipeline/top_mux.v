`timescale 1ns / 1ps

module top_mux(
    input wire [31:0] a,   // Connects to s_extend 
    input wire [31:0] b,   // Connects to rdata2 
    input wire alusrc,     // Driven by the alusrc control line
    output wire [31:0] y   
);

    assign y = alusrc ? a : b; // If alusrc=1 pick immediate constant, if alusrc=0 pick register data

endmodule
