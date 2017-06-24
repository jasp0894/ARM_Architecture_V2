module Reg32bits (Q, D, ENABLE, CLK, RESET);

//Inputs
input wire [31:0] D;
input wire ENABLE;
input wire CLK;
input wire RESET;

//Outputs
output reg [31:0] Q;

always @ (posedge CLK)

if(RESET)
	Q<=32'd0;
else
 	begin
		if(ENABLE)
			Q <= D;
		else
			Q <= Q;
	end

endmodule // D_Latch32bits