module Reg4bits(output reg[3:0] Q, input [3:0] D, input ENABLE,CLK);

reg reset=1'b1;

always @ (posedge CLK)
if(reset)
	begin
		Q<=4'd0;		//output initialization
		reset <= 1'b0; 	//turn off reset state
	end
else
 	begin

		if(ENABLE)
			Q <= D;
		else
			Q <= Q;

	end

endmodule // D_Latch4bits