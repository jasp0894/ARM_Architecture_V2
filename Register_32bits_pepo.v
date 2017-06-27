module Register_32bits_pepo (Q, D, ENABLE, CLK, RESET);

	//Outputs
	output reg [31:0] Q;	//Output bus of the register.

	//Inputs
	input wire [31:0] D;	//Input bus to the register.
	input wire ENABLE;		//Allows the operation of the system.
	input wire CLK;
	input wire RESET;		//Signal used to initialize the register. (This is not a d_latch since its edge trigered!)



	always @ (posedge CLK)
		if(RESET)
			Q <= 32'd0;
		else
			if(ENABLE)
				Q <= D;
			else
				Q <= Q;	

endmodule // Register_32_bits_pepo