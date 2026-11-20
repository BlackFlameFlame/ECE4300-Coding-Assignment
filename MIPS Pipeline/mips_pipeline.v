`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2026 09:45:31 PM
// Design Name: 
// Module Name: mips_pipeline
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


module mips_pipeline(
    input wire clk,
    input wire rst
);

    // Fetch -> Decode wires
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;

    // Decode -> Execute wires
    wire [1:0]  id_ex_wb;
    wire [2:0]  id_ex_mem;
    wire [3:0]  id_ex_execute; // {RegDst, ALUOp[1:0], ALUSrc}
    wire [31:0] id_ex_npc;
    wire [31:0] id_ex_readdat1;
    wire [31:0] id_ex_readdat2;
    wire [31:0] id_ex_sign_ext;
    wire [4:0]  id_ex_instr_20_16;
    wire [4:0]  id_ex_instr_15_11;

    // Execute -> Memory wires
    wire [1:0]  ex_mem_wb;
    wire [2:0]  ex_mem_mem;     // {Branch, MemRead, MemWrite}
    wire [31:0] ex_mem_adder_out;
    wire        ex_mem_zero;
    wire [31:0] ex_mem_alu_result;
    wire [31:0] ex_mem_rdata2;
    wire [4:0]  ex_mem_muxout;

    // Memory / Writeback -> Fetch & Decode feedback wires
    wire        mem_pcsrc;
    wire [1:0]  mem_wb_control; // {RegWrite, MemtoReg}
    wire [31:0] mem_wb_read_data;
    wire [31:0] mem_wb_alu_result;
    wire [4:0]  mem_wb_write_reg;
    wire [31:0] wb_write_data;

    // Stage 1: Instruction Fetch
    fetch stage1_fetch (
        .clk(clk),
        .rst(rst),
        .ex_mem_pc_src(mem_pcsrc),
        .ex_mem_npc(ex_mem_adder_out),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc)
    );

    // Stage 2: Instruction Decode
    decode stage2_decode (
        .clk(clk),
        .rst(rst),
        .wb_reg_write(mem_wb_control[1]),
        .wb_write_reg_location(mem_wb_write_reg),
        .mem_wb_write_data(wb_write_data),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        
        .id_ex_wb(id_ex_wb),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc),
        .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_15_11)
    );

    // Stage 3: Execute
    execute stage3_execute (
        .clk(clk),
        .ctlwb_in(id_ex_wb),
        .ctlm_in(id_ex_mem),
        .npc(id_ex_npc),
        .rdata1(id_ex_readdat1),
        .rdata2(id_ex_readdat2),
        .s_extend(id_ex_sign_ext),
        .instr_20_16(id_ex_instr_20_16),
        .instr_15_11(id_ex_instr_15_11),
        .alu_op(id_ex_execute[2:1]),
        .funct(id_ex_sign_ext[5:0]),
        .alusrc(id_ex_execute[0]),
        .regdst(id_ex_execute[3]),
        
        .ctlwb_out(ex_mem_wb),
        .ctlm_out(ex_mem_mem),
        .adder_out(ex_mem_adder_out),
        .zero_out(ex_mem_zero),
        .alu_result_out(ex_mem_alu_result),
        .rdata2_out(ex_mem_rdata2),
        .muxout_out(ex_mem_muxout)
    );

    // Stage 4 & 5: Memory & Writeback
    mem_stage stage4_mem_wb (
        .clk(clk),
        .ALUResult(ex_mem_alu_result),
        .WriteData(ex_mem_rdata2),
        .WriteReg(ex_mem_muxout),
        .WBControl(ex_mem_wb),
        .MemWrite(ex_mem_mem[0]),
        .MemRead(ex_mem_mem[1]),
        .Branch(ex_mem_mem[2]),
        .Zero(ex_mem_zero),
        
        .ReadData(mem_wb_read_data),
        .ALUResult_out(mem_wb_alu_result),
        .WriteReg_out(mem_wb_write_reg),
        .WBControl_out(mem_wb_control),
        .PCSrc(mem_pcsrc),
        .WB_WriteData(wb_write_data)
    );

endmodule