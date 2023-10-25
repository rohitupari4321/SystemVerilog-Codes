module floating_point_unit (
input wire clk, // Clock input
input wire rst, // Reset input
input wire [31:0] instruction, // FPU instruction input
output reg [31:0] result, // FPU result output
output reg exception_flag // Exception flag output
);
reg [1:0] op_type;
reg [31:0] operand_a;
reg [31:0] operand_b;
always @(posedge clk or posedge rst) begin
if (rst) begin
op_type <= 2'b00; // Reset to addition operation
operand_a <= 0;
operand_b <= 0;
end else begin
op_type <= instruction[7:6]; // Extract operation type from instruction
operand_a <= instruction[15:0]; // Extract operand A from instruction
operand_b <= instruction[31:16]; // Extract operand B from instruction
end
end
always @(*) begin
case (op_type)
2'b00: result = operand_a + operand_b; // Addition
2'b01: result = operand_a - operand_b; // Subtraction
2'b10: result = operand_a * operand_b; // Multiplication
2'b11: begin // Division
if (operand_b == 0) begin
result = 32'h80000000; // Set result to a special value indicating division by zero
exception_flag = 1; // Set exception flag
end else begin
result = operand_a / operand_b;
exception_flag = 0; // Clear exception flag
end
end
default: begin
result = 0; // Default to zero for unknown operation
exception_flag = 0; // Clear exception flag
end
endcase
end
endmodule