//---------------------Mux 4x1 4bits----------------------
module mux_4x1_5b (output reg[4:0] Y, input [1:0]S, input[4:0] A,B,C,D);
	
	//Test for selection bit
	always @ (S,A,B,C,D)

	case(S)
		2'b00:	Y=A;
		2'b01:	Y=B;
		2'b10:	Y=C;
		2'b11:	Y=D;
	endcase // S

endmodule // mux_4x