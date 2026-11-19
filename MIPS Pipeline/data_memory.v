`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 11:07:26 AM
// Design Name: 
// Module Name: data_memory
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


module data_memory (
    input wire clk,                // Added clock for synchronous writes
    input wire [31:0] addr,        // Memory Address
    input wire [31:0] write_data,  // Memory Address Contents
    input wire memread, memwrite,  // Read and Write control signals
    output reg [31:0] read_data    // Output of Memory Address Contents
);

    reg [31:0] DMEM [0:255]; // 256 words of 32-bit memory
    integer i;

    initial 
        begin
            read_data = 0;
        
            // 1. Initialize DMEM[0-5] from data.txt
            $readmemb("data.txt", DMEM);
        
            // 2. Initialize DMEM[6-255] to 6-255
            for (i = 6; i < 256; i = i + 1) 
                begin
                    DMEM[i] = i;
                end
        
            // Display DMEM[0-5] in Tcl Console to verify data.txt loaded properly
            $display("From Data Memory (data.txt):");
            for (i = 0; i < 6; i = i + 1) 
                begin
                    $display("\tDMEM[%0d] = %0h", i, DMEM[i]);
                end
        
            // Display DMEM[6-9] and DMEM[255]
            $display("From Data Memory (initial):");
            for (i = 6; i < 10; i = i + 1) 
                begin
                    $display("\tDMEM[%0d] = %0d", i, DMEM[i]);
                end
            $display("\t...");
            $display("\tDMEM[%0d] = %0d", 255, DMEM[255]);
        end

        // Synchronous write on positive clock edge
        always @(posedge clk) 
            begin
                if (memwrite) 
                    begin
                        DMEM[addr] <= write_data;
                    end
            end

        // Combinational read whenever addr or memread changes
        always @(*) 
            begin
                if (memread) 
                    begin
                        read_data = DMEM[addr];
                    end 
                else 
                    begin
                        read_data = 32'b0;
                    end
            end

endmodule
