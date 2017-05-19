module Reg8bits(output reg[7:0] Q, input [7:0] D, input ENABLE,CLK);

reg reset=1'b1;

always @ (posedge CLK)
if(reset)
	begin
		Q<=8'd0;		//output initialization
		reset <= 1'b0; 	//turn off reset state
	end
else
 	begin

		if(ENABLE)
			Q <= D;
		else
			Q <= Q;

	end

endmodule // D_Latch8bits