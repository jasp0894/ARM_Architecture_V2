//---------------------Mux 2x1 8bits----------------------

//A -|0
//   |
//B- |1
// 

module mux_2x1 (output reg[7:0] Y, input S, input[7:0] A,B);
	
	//Test for selection bit
	always @ (S, A, B)

	case(S)
		1'b0:	Y=A;
		1'b1:	Y=B;
	endcase // S

endmodule // mux_2x1