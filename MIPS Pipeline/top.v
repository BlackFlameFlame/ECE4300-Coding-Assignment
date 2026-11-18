module top (
    input  wire clk,
    input  wire reset,
    output wire [7:0] led
);

    // Internal pipeline signals
    wire [31:0] npc;
    wire [31:0] rdata1;
    wire [31:0] rdata2;
    wire [31:0] s_extend;

    execute execute_unit (
        .clk(clk),
        .ctlwb_in(ctlwb_in),
        .ctlm_in(ctlm_in),
        .npc(npc),
        .rdata1(rdata1),
        .rdata2(rdata2),
        .s_extend(s_extend),
        .instr_20_16(instr_20_16),
        .instr_15_11(instr_15_11),
        .alu_op(alu_op),
        .funct(funct),
        .alusrc(alusrc),
        .regdst(regdst),
        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .adder_out(adder_out),
        .alu_result_out(alu_result_out),
        .rdata2_out(rdata2_out),
        .muxout_out(muxout_out)
    );

endmodule