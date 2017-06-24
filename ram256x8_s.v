module ram256x8_s (CLK, MOCin, MOCoff);

	//This module is in charge of turning off the MOC signal after a 
	//cycle has passed since the MOC was turned on.
	
	//Inputs
	input wire CLK;
	input wire MOCin;

	//Outputs
	output reg MOCoff;

	//Internal
	reg MOCcounter;

	always@(posedge CLK)
		if(MOCin)
			if(MOCcounter == 1'b0)
					 MOCcounter <= ~MOCcounter;						// Gilissa #4
			else
				MOCoff <= 1'b1;
		else
			fork
			MOCcounter <= 1'b0;
			MOCoff <= 1'b0;
			join

endmodule // ram256x8_s
