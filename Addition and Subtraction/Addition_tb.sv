///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//File Name: Addition_tb.sv
//Created By: Sheetal Swaroop Burada
//Date: 30-04-2019
//Project Name: Design of 32 Bit Floating Point ALU Based on Standard IEEE-754 in Verilog and its implementation on FPGA.
//University: Dayalbagh Educational Institute
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`include "Addition.v"

module Addition_tb;

reg [31:0] a_operand,b_operand;
reg clk=1'b0,
	reset=1'b1;
reg AddBar_Sub;

wire [31:0] result;
wire Exception;

Addition_Subtraction dut(a_operand,b_operand,AddBar_Sub,Exception,result);

always #5 clk = ~clk;

//Reset Block
initial
begin

//Reset Operation
//perform_reset; 

////////////////////////////////////////////////////////////////////
//
//Stimulus Block
//Addition
//If any case is failed:
//Check result with expected value and result will be similar to the expected value.
//The output won't be exactly as expected value. It will have some tolerance.
//
////////////////////////////////////////////////////////////////////

AddBar_Sub = 1'b0;

iteration (32'h4201_51EC,32'h4242_147B,32'h42A1_B333,`__LINE__); //32.33 + 48.52 = 80.85

iteration (32'h4068_51EC,32'h4090_A3D7,32'h4102_6666,`__LINE__); //3.63 + 4.52 = 8.15.

iteration (32'h4195_0A3D,32'h419B_47AE,32'h4218_28F6,`__LINE__); //18.63 + 19.41 = 38.04.

iteration (32'h4217_999A,32'h3F8C_CCCD,32'h421C_0000,`__LINE__); //37.9 + 1.1 = 39.

iteration (32'h4383_C7AE,32'h4164_F5C3,32'h438A_EF5C,`__LINE__); //263.56 + 14.31 = 277.87

iteration (32'h4542_77D7,32'h453B_8FD7,32'h45BF_03D7,`__LINE__); //3111.49 + 3000.99 = 6112.48

iteration (32'h3F3A_E148,32'h3EB33333,32'h3F8A_3D71,`__LINE__); //0.73 + 0.35 = 1.08.

iteration (32'h3F7D_70A4,32'h3F7D_70A4,32'h3FFD_70A4,`__LINE__); //0.99 + 0.99 = 1.98

iteration (32'h3F40_0000,32'h3E94_7AE1,32'h3F85_1EB8,`__LINE__); //0.75 + 0.29 = 1.04

iteration (32'h4B7F_FFFF,32'h3F80_0000,32'h4B80_0000,`__LINE__); //16777215 + 1 = 16777216
//Check its Explanation at the end of the test bench as it is a corner case. 

iteration (32'h4B7F_FFFF,32'h4000_0000,32'h4B80_0001,`__LINE__); //16777215 + 2 = 16777217.
//Check its Explanation at the end of the test bench as it is a corner case.

iteration (32'h4B7F_FFFF,32'h4B7F_FFFF,32'h4BFF_FFFF,`__LINE__); //16777215 + 16777215 = 33554430
//This works because 33554430 can be represented in IEEE-754.

iteration (32'h4B7F_FFFE,32'h3F80_0000,32'h4B7F_FFFF,`__LINE__); //16777214 + 1 = 16777215

iteration (32'hBF3A_E148,32'h3EC7_AE14,32'hBEAE_147B,`__LINE__); //-0.73 + 0.39 = -0.34

iteration (32'hC207_C28F,32'h4243_B852,32'h416F_D70A,`__LINE__); //-33.94 + 48.93 = 14.99

iteration (32'hBDB2_2D0E,32'h4305_970A,32'h4305_80C5,`__LINE__); //-0.087 + 133.59 = 133.503

iteration (32'h4E6B_79A3,32'hCCEB_79A3,32'h4E4E_0A6F,`__LINE__); //987654321 - 123456789 = 864197532
//Explanation at the end of the test bench.

iteration (32'h4B80_0000,32'hCB80_0000,32'h0000_0000,`__LINE__); //16777216 - 16777216 = 0
//The exponent value of operands are 151 Hence the value of output will be 0400_0000.

iteration (32'h4B7F_FFFF,32'hCB7F_FFFF,32'h0000_0000,`__LINE__); //16777215 - 16777215 = 0

/////////////////////////////////////////////////////////////////////////
//
//Subtraction
//
/////////////////////////////////////////////////////////////////////////
AddBar_Sub = 1'b1;

iteration (32'h40A00000,32'h40C00000,32'hBF800000,`__LINE__); //5 - 6 = -1

iteration (32'h40C00000,32'h40A00000,32'h3F800000,`__LINE__); //6 - 5 = 1

iteration (32'hC0C00000,32'hC0A00000,32'hBF800000,`__LINE__); //-6 - (-5) = -1

iteration (32'hC0A00000,32'hC0C00000,32'h3F800000,`__LINE__); // -5 - (-6) = 1

iteration (32'h40C00000,32'hC0A00000,32'h41300000,`__LINE__); // 6 - (-5) = 11

iteration (32'h40A00000,32'hC0C00000,32'h41300000,`__LINE__); // 5 - (-6) = 11

iteration (32'hC0A00000,32'h40C00000,32'hC1300000,`__LINE__); // -5 - (6) = -11

iteration (32'hC0C00000,32'h40A00000,32'hC1300000,`__LINE__); // -6 - (+5) = -11

/////////////////////////////////////////////////////////////////////////
//
//Exception Cases
//
////////////////////////////////////////////////////////////////////////

iteration (32'h0000_0000,32'h3EC7_AE14,32'h3EC7_AE14,`__LINE__);

iteration (32'h3EC7_AE14,32'h0000_0000,32'h3EC7_AE14,`__LINE__);

iteration (32'h0000_0000,32'h0000_0000,32'h0000_0000,`__LINE__);

iteration (32'h7F80_0000,32'h7F90_0100,32'h0000_0000,`__LINE__);

iteration (32'h7F80_0000,32'h3EC7_AE14,32'h0000_0000,`__LINE__);

iteration (32'h3EC7_AE14,32'h7F80_0000,32'h0000_0000,`__LINE__);

iteration (32'h7F80_0000,32'h0000_0000,32'h0000_0000,`__LINE__);

iteration (32'h7F90_0100,32'h7F80_0000,32'h0000_0000,`__LINE__);

@(negedge clk)
$stop;

end

/*
task perform_reset;
	begin
		@(negedge clk)
		reset = 1'b0;

		@(negedge clk)
		reset = 1'b1;
	end
endtask
*/

task iteration(
input [31:0] operand_a,operand_b,expected_value,
input integer line_num );

begin
	@(negedge clk)
	begin
		a_operand = operand_a;
		b_operand = operand_b;
	end

	@(posedge clk)
	begin
		#1;
		if (expected_value == result)
			$display ("Test Passed - Line Number -> %d",line_num);
		else 
			$display ("Test Failed \t\n A => %h, \t\n B => %h, \t\n Result Obtained => %h, \t\n Expected Value => %h - Line Number",operand_a,operand_b,result,expected_value,line_num);
	end
end
endtask

endmodule


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Explanation of 16777215 + 1 = 16777217 and 16777215 + 2 = 16777217.
//The actual result is equal to 16777216.
//The value of 16777217 can't be represented in 32bit IEEE-754 Representation.
//Because its exponent is greater than 23 bits and size of number is 25BIT. Hence it's binary value get rounded off.
//When 16777217 gets rounded off and it'll become 16777218.
//Also 16777216 gets rounded off and it'll become 16777218.
//Conclusion: Don't perform operation on operands where result will be more than 16777215.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//Explanation of 987654321 - 123456789 = 864197532
//During operation on 987654321 and 123456789, these values are actually out of range. 
//When these value converts into IEEE-754,
//They will be changed to 987654336 and 123456792 respectively. Confused?
//How the converted values will be larger than previous numbers if previous numbers are in out of range?
//During conversion, 987654321's binary value will be truncated to 24 bits & gets rounded off because its exponent is more than 23.
//The second operand will have corresponding process and value gets changed.
//Actual operation is being performed 987654336 - 123456792 = 864197529.
//The answer won't be equal to 864197529 because it also have previous problem and value will be increased to 864197568.
//Hence expected value is 4E4E_0A6F -> 864197568.
//Conclusion: Don't perform operation whose number exponents are larger than 23.
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//36.33 - (-23.33)
//-32.57 - 49.65 