module BinaryDecoder_pepo (BDE, BDA, RFLD);

	//Outputs
	output reg [15:0] BDE; 	//Binary Decoder Enable --> Cintains the enable of the registers
												//		in the register file.
	//Inputs
	input wire [3:0] BDA;	//Binary Decoder Address --> Sets the enable of the DESIRED register
													//	 in the register file.
	input wire RFLD;

	always @ (BDA or RFLD)
		if(RFLD)		// if enable is high enter case
			case(BDA)
				4'b0000: BDE = 16'b0000000000000001;		//BDE0 high
				4'b0001: BDE = 16'b0000000000000010;		//BDE1 high
				4'b0010: BDE = 16'b0000000000000100;		//BDE2 high
				4'b0011: BDE = 16'b0000000000001000;		//BDE3 high
				4'b0100: BDE = 16'b0000000000010000;		//BDE4 high
				4'b0101: BDE = 16'b0000000000100000;		//BDE5 high
				4'b0110: BDE = 16'b0000000001000000;		//BDE6 high
				4'b0111: BDE = 16'b0000000010000000;		//BDE7 high
				4'b1000: BDE = 16'b0000000100000000;		//BDE8 high
				4'b1001: BDE = 16'b0000001000000000;		//BDE9 high
				4'b1010: BDE = 16'b0000010000000000;		//BDE10 high
				4'b1011: BDE = 16'b0000100000000000;		//BDE11 high
				4'b1100: BDE = 16'b0001000000000000;		//BDE12 high
				4'b1101: BDE = 16'b0010000000000000;		//BDE13 high
				4'b1110: BDE = 16'b0100000000000000;		//BDE14 high
				4'b1111: BDE = 16'b1000000000000000;		//BDE15 high
			endcase // BDA
		else
			BDE = 16'd0;		//Output is not enabled, thus place zeros.


endmodule // BinaryDecoder_pepo