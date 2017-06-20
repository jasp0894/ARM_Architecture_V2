module Reg8bits(output reg[7:0] Q, input [7:0] D, input ENABLE,CLK,RESET);

//reg reset=1'b1;

always @ (posedge CLK)

if(RESET)
	Q<= 8'd0;
else
 	begin

		if(ENABLE)
			Q <= D;
		else
			Q <= Q;

	end

endmodule // D_Latch8bits