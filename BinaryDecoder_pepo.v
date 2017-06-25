module BinaryDecoder_pepo (output reg [15:0]E,input wire[3:0]D, input ENABLE);

	always @ (D,ENABLE)

	if(ENABLE)		// if enable is high enter case

		case(D)

			4'b0000: E = 16'b0000000000000001;		//E0 high
			4'b0001: E = 16'b0000000000000010;		//E1 high
			4'b0010: E = 16'b0000000000000100;		//E2 high
			4'b0011: E = 16'b0000000000001000;		//E3 high
			4'b0100: E = 16'b0000000000010000;		//E4 high
			4'b0101: E = 16'b0000000000100000;		//E5 high
			4'b0110: E = 16'b0000000001000000;		//E6 high
			4'b0111: E = 16'b0000000010000000;		//E7 high
			4'b1000: E = 16'b0000000100000000;		//E8 high
			4'b1001: E = 16'b0000001000000000;		//E9 high
			4'b1010: E = 16'b0000010000000000;		//E10 high
			4'b1011: E = 16'b0000100000000000;		//E11 high
			4'b1100: E = 16'b0001000000000000;		//E12 high
			4'b1101: E = 16'b0010000000000000;		//E13 high
			4'b1110: E = 16'b0100000000000000;		//E14 high
			4'b1111: E = 16'b1000000000000000;		//E15 high

		endcase // S	


endmodule // binaryDecoder