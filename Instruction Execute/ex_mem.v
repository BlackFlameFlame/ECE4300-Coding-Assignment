`timescale 1ns / 1ps


module ex_mem(
    input wire clk,                     
    input wire [1:0] ctlwb_out,         
    input wire [2:0] ctlm_out,          
    input wire [31:0] adder_out,        
    input wire aluzero,                 
    input wire [31:0] aluout,           
    input wire [31:0] readdat2,         
    input wire [4:0] muxout,            
    
    output reg [1:0] wb_ctlout,         
    output reg [2:0] ctlm_ctlout,       
    output reg [31:0] alu_result,       
    output reg [31:0] rdata2out,        
    output reg [4:0] five_bit_muxout    
);

    
    initial 
        begin
            wb_ctlout       = 2'b0;
            ctlm_ctlout     = 3'b0;
            alu_result      = 32'b0;
            rdata2out       = 32'b0;
            five_bit_muxout = 5'b0;
        end
    
    always @(posedge clk) 
        begin
            #1 
            wb_ctlout       <= ctlwb_out;
            ctlm_ctlout     <= ctlm_out;
            alu_result      <= aluout;
            rdata2out       <= readdat2;
            five_bit_muxout <= muxout;
        end

endmodule
