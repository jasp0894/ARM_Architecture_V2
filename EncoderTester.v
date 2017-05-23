module EncoderTester;

	reg [31:0] InstStorage [19:0];	//Simulates the memory that is passing down instructions to the instruction register.		
	reg [31:0] EncoderIn;			//Simulates the output of the instruction register.
	wire [7:0] EncoderOut;			//Output of the encoder.
	reg clk;						//Clock to simulate instruction register transisiton
	reg ip;							//Instruction pointer. Signals which instruction will be passed from memory to the instruction register.

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
	#20; EncoderIn = 32'b00000001110000000000000011010000;

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