`timescale 1ns / 1ps


module execute(
    input wire clk,
    input wire [1:0] ctlwb_in,
    input wire [2:0] ctlm_in,
    input wire [31:0] npc,
    input wire [31:0] rdata1,
    input wire [31:0] rdata2,
    input wire [31:0] s_extend,
    input wire [4:0] instr_20_16,
    input wire [4:0] instr_15_11,
    input wire [1:0] alu_op,
    input wire [5:0] funct,
    input wire alusrc,
    input wire regdst,
    
    output wire [1:0] ctlwb_out,
    output wire [2:0] ctlm_out,
    output wire [31:0] adder_out,
    output wire [31:0] alu_result_out,
    output wire [31:0] rdata2_out,
    output wire [4:0] muxout_out
    );

    
    wire [31:0] b_operand;
    wire [31:0] aluout;
    wire [4:0] muxout;
    wire [2:0] alu_control_wire;
    wire aluzero;
    
    adder adder3(
        .add_in1(npc),
        .add_in2(s_extend),
        .add_out(adder_out)
    );

    bottom_mux bottom_mux3(
        .a(instr_15_11),
        .b(instr_20_16),
        .sel(regdst),
        .y(muxout)
    );
    
    alu_control alu_control3(
        .funct(funct),
        .aluop(alu_op),
        .select(alu_control_wire)
    );

    top_mux top_mux3(
        .a(s_extend),
        .b(rdata2),
        .alusrc(alusrc),
        .y(b_operand)
    );

    alu alu3(
        .a(rdata1),
        .b(b_operand),
        .control(alu_control_wire),
        .result(aluout),
        .zero(aluzero)
    );

    ex_mem ex_mem3(
        .clk(clk),
        .ctlwb_out(ctlwb_in),
        .ctlm_out(ctlm_in),
        .adder_out(adder_out),
        .aluzero(aluzero),
        .aluout(aluout),
        .readdat2(rdata2),
        .muxout(muxout),
        
        .wb_ctlout(ctlwb_out),
        .ctlm_ctlout(ctlm_out),
        .alu_result(alu_result_out),
        .rdata2out(rdata2_out),
        .five_bit_muxout(muxout_out)
    );

endmodule
