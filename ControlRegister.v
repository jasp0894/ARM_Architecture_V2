module ControlRegister(output reg[63:0] Q, input [63:0] D, input ENABLE,CLK,RESET);

//Output initialization

//reg reset=1'b1;

always @ (posedge CLK)

	if(RESET)
		Q <= 64'd0;
	else
		begin

			if(ENABLE)
				Q <= D;
			else
				Q <= Q;
		end






/*
	if(reset)
		begin
			Q<=64'd0;		//output initialization
			reset <= 1'b0; 	//turn off reset state
		end
	else
	 	begin

			if(ENABLE)
				Q <= D;
			else
				Q <= Q;
		end
 */

endmodule // D_Latch64bits