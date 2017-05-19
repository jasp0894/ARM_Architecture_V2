module condtester_test;

	reg [3:0] cond, flags;			//Simulates the condition and flags
	wire Out;			        //Output of the condition tester module 
	reg clk;						//Clock to simulate instruction register transisiton

Encoder encoder (EncoderOut, EncoderIn);

initial
	begin
	EncoderIn = 8'd0;
	//clk = 1'd0;
	ip = 5'd0;
	// InstStorage[0] = 32'b00000101010101011110010100101011;			//State 16
	// InstStorage[1] = 32'b00000101001011010101011010101101;			//State 19
	// InstStorage[2] = 32'b00000100000101010100001001110101;			//State 17
	// InstStorage[3] = 32'b11100001110101000101000000000100;			//State 10

	#20; EncoderIn = 32'b00000101010101011110010100101011;
	#20; EncoderIn = 32'b00000101001011010101011010101101;
	#20; EncoderIn = 32'b00000100000101010100001001110101;
	#20; EncoderIn = 32'b11100001110101000101000000000100;

	end

// always
// 	begin
// 	#1 clk = !clk;
// 	end

// always @(clk)
// 	begin
// 		#5 EncoderIn = InstStorage[ip];
// 		ip = ip + 1;
// 	end

initial
	begin
	$display("Output   IN");
	$monitor("%d  %b", EncoderOut, EncoderIn);
	end

initial
	#2000 $finish;					//End of simulation

endmodule // EncoderTester