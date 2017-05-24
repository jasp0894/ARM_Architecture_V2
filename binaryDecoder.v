module binaryDecoder(output reg [15:0]E,input [3:0]D, input ENABLE);

	always @ (D,ENABLE)

	if(ENABLE)		// if enable is high enter case

		case(D)

			4'b0000: E = 16'h8000;		//E0 high
			4'b0001: E = 16'h4000;		//E1 high
			4'b0010: E = 16'h2000;		//E2 high
			4'b0011: E = 16'h1000;		//E3 high
			4'b0100: E = 16'h0800;		//E4 high
			4'b0101: E = 16'h0400;		//E5 high
			4'b0110: E = 16'h0200;		//E6 high
			4'b0111: E = 16'h0100;		//E7 high
			4'b1000: E = 16'h0080;		//E8 high
			4'b1001: E = 16'h0040;		//E9 high
			4'b1010: E = 16'h0020;		//E10 high
			4'b1011: E = 16'h0010;		//E11 high
			4'b1100: E = 16'h0008;		//E12 high
			4'b1101: E = 16'h0004;		//E13 high
			4'b1110: E = 16'h0002;		//E14 high
			4'b1111: E = 16'h0001;		//E15 high

		endcase // S	


endmodule // binaryDecoder