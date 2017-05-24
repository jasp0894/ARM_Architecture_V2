module SLSManagerTester;

	reg [31:0] IN;	//Simulates the memory that is passing down instructions to the instruction register.		
	reg  ENABLE;			//Simulates the output of the instruction register.
	wire [2:0] OUT;			//Output of the encoder.

SLSManager sls (OUT, IN,ENABLE);

initial
	begin
	IN = 8'd0;

	ENABLE = 1'd0;
	//State 47
	
	#20; IN = 32'b00000001110000000000000011010000; //Load Doubleword

	#20; IN = 32'b11110001010111111111111111111111; //Signed Halfword


	ENABLE = 1'd1;
	
	#20; IN = 32'b00000001110000000000000011010000; //Load Doubleword

	#20; IN = 32'b11110001010111111111111111111111; //Signed Halfword
	#20; IN = 32'b00000001110100000000000011010000; //Signed byte


	//State 50

	#20; IN = 32'b11110001100111111111000111111111; //Signed  halfowrd


	end


initial
	begin
	$display("EN  Out    IN");
	$monitor("%b   %b   %b", ENABLE, OUT, IN);
	end

initial
	#2000 $finish;					//End of simulation

endmodule // EncoderTester