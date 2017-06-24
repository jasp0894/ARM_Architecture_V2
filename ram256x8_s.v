module ram256x8_s (CLK, RESET, MOCin, MOCoff);

	//This module is in charge of turning off the MOC signal after a 
	//cycle has passed since the MOC was turned on.
	
	//Inputs
	input wire CLK;
	input wire MOCin;

	//Outputs
	output reg MOCoff;

	//Internal
	reg [1:0] MOCcounter;

	always@(posedge CLK)
		if(RESET)
			MOCcounter <= 2'd0;						//Initialize counter value
		else
			if(MOCin)
				if(MOCcounter < 2'd3)
						MOCcounter <= 1 + MOCcounter;
				else
					MOCoff <= 1'b1;
			else
				fork
				MOCcounter <= 1'b0;
				MOCoff <= 1'b0;
				join

endmodule // ram256x8_s
