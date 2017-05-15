module ControlRegister(output reg[63:0] Q, input [63:0] D, input ENABLE,CLK);

//Output initialization

reg reset=1'b1;

always @ (posedge CLK)
if(reset)
	begin
		Q<=64'd0;		//output initialization
		reset <= 1'b0; 	//turn off reset state
	end
else
 	begin

		if(ENABLE)
			Q = D;
		else
			Q = 64'b0;
	end

endmodule // D_Latch64bits