`timescale 1ns / 1ps


module bottom_mux(
    input wire [4:0] a,    // Connects to instr_15_11 
    input wire [4:0] b,    // Connects to instr_20_16  
    input wire sel,        // Driven by the regdst control line
    output wire [4:0] y    
);

    assign y = sel ? a : b; // If regdst=1 pick a, if regdst=0 pick b

endmodule
