`timescale 1ns / 1ps

// Arithmetic Logic Unit (ALU)
// Performs arithmetic and logical operations
// based on the 3-bit control signal.

module alu(
    input wire [31:0] a,        // Register File
    input wire [31:0] b,        // Output of the upper MUX
    input wire [2:0] control,   // ALU Control selector
    output reg [31:0] result,   // ALU result
    output wire zero            // Indicates result is zero
);

// ALU operation parameters
parameter ALUadd = 3'b010;
parameter ALUsub = 3'b110;
parameter ALUand = 3'b000;
parameter ALUor  = 3'b001;
parameter ALUslt = 3'b111;

// Select ALU operation
always @(*) begin
    case (control)

        ALUadd:
            result = a + b;

        ALUsub:
            result = a - b;

        ALUand:
            result = a & b;

        ALUor:
            result = a | b;

        ALUslt:
            result = ($signed(a) < $signed(b))
                     ? 32'd1 : 32'd0;

        default:
            result = 32'bx;

    endcase
end

// Zero flag
// 1 when ALU result equals zero
// 0 otherwise
assign zero = (result == 32'd0);

endmodule