//---------------------Mux 2x1 8bits----------------------

//A -|0
//   |
//B- |1
// 

module mux_2x1_1bit (Y, S, A, B);
	
	//Inputs
	input wire A, B;
	input wire S;

	//Outputs
	output reg Y;

	//Test for selection bit
	always @ (S, A, B)

	case(S)
		1'b0:	Y=A;
		1'b1:	Y=B;
	endcase // S

endmodule // mux_2x1_3bit