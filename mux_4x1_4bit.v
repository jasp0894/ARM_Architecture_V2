//---------------------Mux 4x1 4bits----------------------
module mux_4x1_4bit (Y, S, A, B, C, D);
	
	//Inputs
	input wire [3:0] A,B,C,D;
	input wire [1:0] S;

	//Outputs
	output reg [3:0] Y;
	
	//Test for selection bit
	always @ (S,A,B,C,D)

	case(S)
		2'b00:	Y=A;
		2'b01:	Y=B;
		2'b10:	Y=C;
		2'b11:	Y=D;
	endcase // S

endmodule // mux_4x1