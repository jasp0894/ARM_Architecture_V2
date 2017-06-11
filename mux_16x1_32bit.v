module mux_16x1_32bit (Y, S, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P);

	//Inputs
	input wire [31:0] A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
	input wire [3:0] S;

	//Outputs
	output reg [31:0] Y;
	
	always @ (S,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P)

	case(S)

		4'b0000: Y=A;		//Output is A
		4'b0001: Y=B;		//Output is B
		4'b0010: Y=C;		//Output is C
		4'b0011: Y=D;		//Output is D
		4'b0100: Y=E;		//Output is E
		4'b0101: Y=F;		//Output is F
		4'b0110: Y=G;		//Output is G
		4'b0111: Y=H;		//Output is H
		4'b1000: Y=I;		//Output is I
		4'b1001: Y=J;		//Output is J
		4'b1010: Y=K;		//Output is K
		4'b1011: Y=L;		//Output is L
		4'b1100: Y=M;		//Output is M
		4'b1101: Y=N;		//Output is N
		4'b1110: Y=O;		//Output is O
		4'b1111: Y=P;		//Output is P
	endcase // S	
endmodule // mux_16x1_32bit