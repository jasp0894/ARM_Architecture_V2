module EncoderTester;

	reg [31:0] InstStorage [19:0];	//Simulates the memory that is passing down instructions to the instruction register.		
	reg [31:0] EncoderIn;			//Simulates the output of the instruction register.
	wire [7:0] EncoderOut;			//Output of the encoder.
	reg clk;						//Clock to simulate instruction register transisiton
	reg ip;							//Instruction pointer. Signals which instruction will be passed from memory to the instruction register.

Encoder Encoder (EncoderOut, EncoderIn);

initial
	begin
	EncoderIn = 8'd0;
	clk = 1'd0;
	ip = 5'd0;

	InstStorage[0] = 32'b00000101010101011110010100101011;
	InstStorage[1] = 32'b00000110100111010101011011010101;

	$display("Encoder Output");
	$monitor("%d", EncoderOut);


	#20 $finish;					//End of simulation
	end

always
	begin
	#1 clk = !clk;
	end

always @(clk)
	begin
		EncoderIn = InstStorage[ip];
		ip = ip + 1;
	end

