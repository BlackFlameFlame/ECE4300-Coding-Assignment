`timescale 1ns / 1ps

module InstrMemWBMux(
    input wire [31:0] alu_result,
    input wire [31:0] read_data,
    input wire memtoreg,
    output wire [31:0] write_data
);

    assign write_data = memtoreg ? read_data : alu_result;

endmodule