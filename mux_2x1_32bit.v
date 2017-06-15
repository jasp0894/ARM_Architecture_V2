//---------------------Mux 8x1 32bit----------------------
module mux_2x1_32bit (Y, S, A, B);
	
	//Inputs
	input wire [31:0] A,B;
	input wire S;

	//Outputs
	output reg [31:0] Y;


	//Test for selection bit
	always @ (S,A,B)

	case(S)
		1'b0:	Y=A;
		1'b1:	Y=B;

	endcase // S

endmodule // mux_8x1_32bit