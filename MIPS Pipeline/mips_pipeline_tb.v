`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2026 09:55:32 PM
// Design Name: 
// Module Name: mips_pipeline_tb
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


module mips_pipeline_tb;

        reg clk;
        reg rst;
        
        mips_pipeline uut (
            .clk(clk),
            .rst(rst)
        );
            
            initial
                begin
                    clk = 0;
                    forever #5 clk = ~clk;
                end
                
                initial
                    begin
                        rst = 1;
                        #10 rst = 0;
                        
                        #1000 $finish;
                    end

endmodule
