//---------------------Mux 4x1 8bits----------------------
module mux_4x1 (output reg[7:0] Y, input [1:0]S, input[7:0] A,B,C,D);
	
	//Test for selection bit
	always @ (S)

	case(S)
		2'b00:	Y=A;
		2'b01:	Y=B;
		2'b10:	Y=C;
		2'b11:	Y=D;
	endcase // S

endmodule // mux_4x1