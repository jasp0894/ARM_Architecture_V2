//---------------------Mux 2x1 8bits----------------------

//A -|0
//   |
//B- |1
// 

module mux_2x1_5bit (Y, S, A, B);
	
	//Inputs
	input wire [4:0] A, B;
	input wire S;

	//Outputs
	output reg [4:0] Y;

	//Test for selection bit
	always @ (S, A, B)

	case(S)
		1'b0:	Y=A;
		1'b1:	Y=B;
	endcase // S

endmodule // mux_2x1_5bit