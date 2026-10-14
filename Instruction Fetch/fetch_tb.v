`timescale 1ns / 1ps

module fetch_tb;

// Testbench inputs
reg clk;
reg rst;
reg ex_mem_pc_src;
reg [31:0] ex_mem_npc;

// Testbench outputs
wire [31:0] if_id_instr;
wire [31:0] if_id_npc;

// Instantiate Instruction Fetch stage
fetch uut(
    .clk(clk),
    .rst(rst),
    .ex_mem_pc_src(ex_mem_pc_src),
    .ex_mem_npc(ex_mem_npc),
    .if_id_instr(if_id_instr),
    .if_id_npc(if_id_npc)
);

// Clock generation
// Clock period = 10 ns
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Display simulation results
initial begin
    $monitor(
        "Time=%0t rst=%b PC=%d Instr=%h NextPC=%d",
        $time, rst, uut.pc_out, if_id_instr, if_id_npc
    );
end

// Test Instruction Fetch stage
initial begin

    // Initialize inputs
    rst = 1;
    ex_mem_pc_src = 0;
    ex_mem_npc = 32'd0;

    // Release reset
    #12 rst = 0;

    // Test normal instruction fetching
    // Fetch instructions from addresses 0 through 36
    repeat (9) @(negedge clk);

    // Test branch operation
    // Redirect PC to address 16
    ex_mem_pc_src = 1;
    ex_mem_npc = 32'd16;

    // Wait for branch to update PC
    @(negedge clk);

    // Return to normal sequential execution
    ex_mem_pc_src = 0;

    // Continue fetching instructions
    repeat (5) @(negedge clk);

    // Finish simulation
    #10 $finish;

end

endmodule