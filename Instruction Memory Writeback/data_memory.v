`timescale 1ns / 1ps

module data_memory (
    input wire clk,                
    input wire [31:0] addr,        
    input wire [31:0] write_data,  
    input wire memread, memwrite,  
    output reg [31:0] read_data    
);

    reg [31:0] DMEM [0:255]; 
    integer i;

    initial 
        begin
            read_data = 0;
        
            $readmemb("data.txt", DMEM);
        
            for (i = 6; i < 256; i = i + 1) 
                begin
                    DMEM[i] = i;
                end
        
            $display("From Data Memory (data.txt):");
            for (i = 0; i < 6; i = i + 1) 
                begin
                    $display("\tDMEM[%0d] = %0h", i, DMEM[i]);
                end
        
            $display("From Data Memory (initial):");
            for (i = 6; i < 10; i = i + 1) 
                begin
                    $display("\tDMEM[%0d] = %0d", i, DMEM[i]);
                end
            $display("\t...");
            $display("\tDMEM[%0d] = %0d", 255, DMEM[255]);
        end

        always @(posedge clk) 
            begin
                if (memwrite) 
                    begin
                        DMEM[addr] <= write_data;
                    end
            end

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
