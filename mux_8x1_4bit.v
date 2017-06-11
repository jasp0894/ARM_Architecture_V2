
//---------------------Mux 8x1 1bit----------------------
module mux_8x1 (Y, S, A, B, C, D, E, F, G, H);
	
	//Inputs
	input wire [3:0] A,B,C,D,E,F,G,H;
	input wire [2:0] S;

	//Outputs
	output wire [3:0] Y;

	//Test for selection bit
	always @ (S,A,B,C,D,E,F,G,H)

		case(S)
			3'b000:	Y=A;
			3'b001:	Y=B;
			3'b010:	Y=C;
			3'b011:	Y=D;
			3'b100:	Y=E;
			3'b101:	Y=F;
			3'b110:	Y=G;
			3'b111:	Y=H;

		endcase // S
endmodule // mux_8x1