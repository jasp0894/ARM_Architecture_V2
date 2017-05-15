module EncoderTester;
	reg[31:0] IN;
	wire[7:0] OUT;
	parameter sim_time = 1000;
	Encoder encoder(OUT,IN);
	initial #sim_time $finish;

	initial
		begin
			IN = 32'b11100101110101000101000000000100;		//State 16
			#30;
			IN = 32'b11100001110101000101000000000100;		//State 10
			#30;
			IN =  32'b11110010100110100001000000101100; 		//state 11
			#30;

			IN= 32'b11110001001110100001000000101100;		//state 14
			#30;

			IN=  32'b11110011000110100001000000101100;			//state 15
			#30;


		end


	initial
		begin
			$display("IN                                      ST");
			$monitor(" %b      %d", IN, OUT);
		end	
endmodule // EncoderTester