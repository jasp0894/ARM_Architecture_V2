module D_Latch32bits(output reg[31:0] Q, input [31:0] D, input ENABLE,CLK,RESET);

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