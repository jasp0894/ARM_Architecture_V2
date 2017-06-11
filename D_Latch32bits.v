module D_Latch32bits(output reg[31:0] Q, input [31:0] D, input ENABLE,CLK);

always @ (posedge CLK)

if(ENABLE)
	Q <= D;
else
	Q <= 32'b0;

endmodule // D_Latch32bits