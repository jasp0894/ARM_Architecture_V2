module condtester_test;

	reg [3:0] cond, flags;			//Simulates the condition and flags
	wire Out;			        //Output of the condition tester module 
	reg clk;						//Clock to simulate instruction register transisiton

CondTester ct (Out, cond, flags[3], flags[2], flags[1], flags[0]);

initial
	begin
	cond = 4'd0;

	flags = 4'b0000;


	repeat(15) #5
	cond = cond +1;
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
	$display("Cond  ZCNV     Out");
	$monitor("%b  %b   %b", cond, flags, Out);
	end

initial
	#2000 $finish;					//End of simulation

endmodule // EncoderTester