module buffer_test;

	reg [3:0] IN;
	wire [4:0] OUT;		
						
buffer_4to5bits(OUT,IN)

initial
	begin

	IN = 4'b0;


	repeat(15) #5
	IN = IN +1;
	//clk = 1'd0;



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
	$display("IN  Out");
	$monitor("%b  %b", IN, OUT);
	end

initial
	#2000 $finish;					//End of simulation

endmodule // EncoderTester