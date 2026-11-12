`timescale 1ns / 1ps

module InstrMemWBMux_tb;

    // Inputs
    reg [31:0] alu_result;
    reg [31:0] read_data;
    reg memtoreg;

    // Output
    wire [31:0] write_data;

    // Instantiate the Unit Under Test (UUT)
    InstrMemWBMux uut(
        .alu_result(alu_result),
        .read_data(read_data),
        .memtoreg(memtoreg),
        .write_data(write_data)
    );

    initial begin

        // Test 1: Select ALU Result
        alu_result = 32'h00000014;
        read_data  = 32'h12345678;
        memtoreg   = 0;
        #10;

        // Test 2: Select Memory Data
        memtoreg = 1;
        #10;

        // Test 3: Change ALU Result
        alu_result = 32'h00000020;
        memtoreg = 0;
        #10;

        // Test 4: Change Memory Data
        read_data = 32'hABCDEF12;
        memtoreg = 1;
        #10;

        // Test 5: Select ALU Result Again
        memtoreg = 0;
        #10;

        $finish;
    end

endmodule
