////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: ALU_TB.v
//Created By: Sheetal Swaroop Burada
//Date: 30-04-2019
//Project Name: Design of 32 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


`include "ALU.v"
module ALU_Tb;

reg [31:0] a_operand,b_operand;
reg [3:0] Operation;
wire [31:0] ALU_Output;
wire Exception;
wire Underflow;
wire Overflow;

reg clk = 1'b0;

ALU dut(a_operand,b_operand,Operation,ALU_Output,Exception,Overflow,Underflow);

always #5 clk = ~clk;

initial
begin
iteration (32'h4201_51EC,32'h4242_147B,32'h42A1_B333,4'b1010,`__LINE__,1'b0);

end

task iteration(
input [31:0] operand_a,operand_b,expected_value,
input [3:0] operation,
input integer line_num,
input expected_exception
);

	@(negedge clk)
	begin
		a_operand = operand_a;
		b_operand = operand_b;
		Operation = operation;
	end

	
	@(posedge clk)
	begin
		if ((expected_value == ALU_Output) & (expected_exception == Exception))
			$display ("Test Passed - Line Number -> %d", line_num);

		else 
			$display ("Test Failed Expected Result -> %h and Expected_Exception -> %b and Obtained Result -> %h and Obtained Exception -> %b of corresponding Operation -> %d and %d",expected_value,expected_exception,ALU_Output,Exception,operation,line_num);
	end

endtask

endmodule