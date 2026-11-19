`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 11:48:06 AM
// Design Name: 
// Module Name: mem_stage
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


module mem_stage(
    input wire clk,
    input wire [31:0] ALUResult,
    input wire [31:0] WriteData,
    input wire [4:0] WriteReg,
    input wire [1:0] WBControl,
    input wire MemWrite,
    input wire MemRead,
    input wire Branch,
    input wire Zero,
    
    output wire [31:0] ReadData,
    output wire [31:0] ALUResult_out,
    output wire [4:0] WriteReg_out,
    output wire [1:0] WBControl_out,
    output wire PCSrc,
    output wire [31:0] WB_WriteData // Output from the Writeback Mux in Fig. 2
);

    wire [31:0] read_data_internal;
    wire regwrite_internal;
    wire memtoreg_internal;

    // Bundle the split WB wires back together so they match memoryTB's WBControl_out port
    assign WBControl_out = {regwrite_internal, memtoreg_internal};

    // 1. Branch AND Gate
    AND AND_4(
        .membranch(Branch),
        .zero(Zero),
        .PCSrc(PCSrc)
    );

    // 2. Data Memory
    data_memory data_memory4(
        .clk(clk),
        .addr(ALUResult),
        .write_data(WriteData),
        .memwrite(MemWrite),
        .memread(MemRead),
        .read_data(read_data_internal)
    );

    // 3. MEM/WB Pipeline Latch
    mem_wb mem_wb4(
        .clk(clk),
        .control_wb_in(WBControl),
        .read_data_in(read_data_internal),
        .alu_result_in(ALUResult),
        .write_reg_in(WriteReg),
        
        .regwrite(regwrite_internal),
        .memtoreg(memtoreg_internal),
        .read_data(ReadData),
        .mem_alu_result(ALUResult_out),
        .mem_write_reg(WriteReg_out)
    );

    // 4. Writeback Stage Multiplexer (Fig. 2 right side)
    wb_mux wb_mux5(
        .read_data(ReadData),
        .mem_alu_result(ALUResult_out),
        .memtoreg(memtoreg_internal),
        .write_data(WB_WriteData)
    );

endmodule
