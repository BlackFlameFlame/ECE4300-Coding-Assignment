`timescale 1ns / 1ps

// Memory Stage
// Connects the AND gate, Data Memory, and MEM/WB Latch

module MEMORY(
    input wire clk,                   // Clock signal
    input wire [1:0] wb_ctlout,       // Write Back control signals
    input wire branch,               // Branch control signal
    input wire memread,              // Memory read enable
    input wire memwrite,             // Memory write enable
    input wire zero,                 // Zero flag from ALU
    input wire [31:0] alu_result,    // ALU result / memory address
    input wire [31:0] rdata2out,     // Data to write into memory
    input wire [4:0] five_bit_muxout,// Destination register

    output wire MEM_PCSrc,           // Branch decision
    output wire MEM_WB_regwrite,     // Register write enable
    output wire MEM_WB_memtoreg,     // Memory-to-register selection
    output wire [31:0] read_data,    // Memory data from MEM/WB latch
    output wire [31:0] mem_alu_result,// ALU result from MEM/WB latch
    output wire [4:0] mem_write_reg  // Destination register
);

    // Internal signal
    wire [31:0] read_data_in;

    // ----------------------------------------
    // AND Gate
    // Determines whether branch is taken
    // ----------------------------------------
    AND AND_4(
        .membranch(branch),
        .zero(zero),
        .PCSrc(MEM_PCSrc)
    );

    // ----------------------------------------
    // Data Memory
    // Reads and writes memory locations
    // ----------------------------------------
    data_memory data_memory4(
        .clk(clk),
        .addr(alu_result),
        .write_data(rdata2out),
        .memwrite(memwrite),
        .memread(memread),
        .read_data(read_data_in)
    );

    // ----------------------------------------
    // MEM/WB Pipeline Latch
    // Stores outputs on rising clock edge
    // ----------------------------------------
    mem_wb mem_wb4(
        .clk(clk),
        .control_wb_in(wb_ctlout),
        .read_data_in(read_data_in),
        .alu_result_in(alu_result),
        .write_reg_in(five_bit_muxout),

        .regwrite(MEM_WB_regwrite),
        .memtoreg(MEM_WB_memtoreg),
        .read_data(read_data),
        .mem_alu_result(mem_alu_result),
        .mem_write_reg(mem_write_reg)
    );

endmodule