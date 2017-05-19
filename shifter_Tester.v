module shifter_Tester;

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
			  IR = 32'b01010000100100000001000110001000; // Shuft by immediate LSL with 3 rotations
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