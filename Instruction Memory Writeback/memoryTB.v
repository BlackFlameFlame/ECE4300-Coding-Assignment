`timescale 1ns / 1ps

// Memory Stage Testbench
module memoryTB;

// Testbench inputs
reg clk;
reg [1:0] wb_ctlout;
reg branch;
reg memread;
reg memwrite;
reg zero;
reg [31:0] alu_result;
reg [31:0] rdata2out;
reg [4:0] five_bit_muxout;

// Testbench outputs
wire MEM_PCSrc;
wire MEM_WB_regwrite;
wire MEM_WB_memtoreg;
wire [31:0] read_data;
wire [31:0] mem_alu_result;
wire [4:0] mem_write_reg;

// Instantiate Memory Stage
MEMORY uut(
    .clk(clk),
    .wb_ctlout(wb_ctlout),
    .branch(branch),
    .memread(memread),
    .memwrite(memwrite),
    .zero(zero),
    .alu_result(alu_result),
    .rdata2out(rdata2out),
    .five_bit_muxout(five_bit_muxout),

    .MEM_PCSrc(MEM_PCSrc),
    .MEM_WB_regwrite(MEM_WB_regwrite),
    .MEM_WB_memtoreg(MEM_WB_memtoreg),
    .read_data(read_data),
    .mem_alu_result(mem_alu_result),
    .mem_write_reg(mem_write_reg)
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
        "Time=%0t Addr=%h ReadData=%h ALU=%h WriteReg=%d RegWrite=%b MemToReg=%b PCSrc=%b",
        $time,
        alu_result,
        read_data,
        mem_alu_result,
        mem_write_reg,
        MEM_WB_regwrite,
        MEM_WB_memtoreg,
        MEM_PCSrc
    );
end

// Test sequence
initial begin

    // Initialize inputs
    wb_ctlout = 2'b00;
    branch = 0;
    memread = 0;
    memwrite = 0;
    zero = 0;
    alu_result = 32'd0;
    rdata2out = 32'd0;
    five_bit_muxout = 5'd0;

    // ----------------------------------------
    // Test 1: Read Memory
    // Read initialized address 4
    // ----------------------------------------
    @(negedge clk);
    alu_result = 32'd4;
    memread = 1;
    memwrite = 0;
    wb_ctlout = 2'b11;
    five_bit_muxout = 5'd2;

    @(posedge clk);
    #1;

    $display("Test 1: ReadData=%h", read_data);

    // ----------------------------------------
    // Test 2: Write Memory
    // Write 12345678 to address 4
    // ----------------------------------------
    @(negedge clk);
    alu_result = 32'd4;
    rdata2out = 32'h12345678;
    memread = 0;
    memwrite = 1;
    wb_ctlout = 2'b00;

    @(posedge clk);
    #1;

    $display("Test 2: Memory write completed");

    // ----------------------------------------
    // Test 3: Read Back Written Data
    // ----------------------------------------
    @(negedge clk);
    memwrite = 0;
    memread = 1;
    wb_ctlout = 2'b11;

    @(posedge clk);
    #1;

    $display("Test 3: ReadData=%h", read_data);

    // ----------------------------------------
    // Test 4: Branch Taken
    // Branch = 1, Zero = 1
    // ----------------------------------------
    @(negedge clk);
    branch = 1;
    zero = 1;

    #1;

    $display("Test 4: PCSrc=%b", MEM_PCSrc);

    // ----------------------------------------
    // Test 5: Branch Not Taken
    // Branch = 1, Zero = 0
    // ----------------------------------------
    @(negedge clk);
    zero = 0;

    #1;

    $display("Test 5: PCSrc=%b", MEM_PCSrc);

    // ----------------------------------------
    // Test 6: Verify ALU and Register Outputs
    // ----------------------------------------
    @(negedge clk);
    branch = 0;
    memread = 0;
    wb_ctlout = 2'b10;
    alu_result = 32'd20;
    five_bit_muxout = 5'd8;

    @(posedge clk);
    #1;

    $display(
        "Test 6: ALU=%h WriteReg=%d RegWrite=%b",
        mem_alu_result,
        mem_write_reg,
        MEM_WB_regwrite
    );

    #10;
    $finish;

end

endmodule