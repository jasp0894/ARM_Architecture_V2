module Shifter_Tester;

	reg[31:0] IR,RM;
	reg CIN,ENABLE;
	wire[31:0] OPERAND;
	wire COUT;

	parameter sim_time = 1000;

	shifter shifterData (OPERAND,COUT,RM,IR,CIN,ENABLE);

	initial #sim_time $finish;

	initial
		begin
			
			//IR = 32'b01010010100100000001000100100000; // 32-bit immediate
			//IR = 32'b01010000100100000001000110001000; // Shift by immediate LSL with 3 rotations
			//IR = 32'b11100101010101100101000000010100; // Addresing Mode 2 (zero extention)
			//IR = 32'b11100001111001100101101111011110;	//Addresing mode 3 (one extention)
			//IR = 32'b11101000101100110001011110000010;	//Load/Store Multiple
			IR = 32'b11100000100110100001000000101100;		//State 10
			
			RM = 32'd35;
			CIN = 1'b0;
			ENABLE = 1'b1;

		end


	initial
		begin
			$display("COUT\tOPERAND");
			$display("========================================================");
			$monitor("%b\t%b ",COUT,OPERAND);
		end	
endmodule // EncoderTester