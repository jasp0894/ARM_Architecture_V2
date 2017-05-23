module Encoder (output reg[7:0] OUT, input[31:0] IR, input SLS_EN);

	always @ (IR, SLS_EN)

if(SLS_EN)
begin
	// Addresing Mode 2 & 3

		// Immediate

	if(IR[27:25] == 3'b010)
	begin					

			if(IR[24] == 1'b0)	//post-indexed
				OUT= 8'd17;					
			else if (IR[21] == 0)	// immediate offset
				OUT = 8'd16;

			else	//pre-indexed
				OUT = 8'd19;		
	end	

		// Register

	else if(IR[27:25] == 3'b011)
	begin					

			if(IR[24] == 1'b0)	//post-indexed
				OUT= 8'd22;					
			else if (IR[21] == 0)	// register offset
				OUT = 8'd21;
			else	//pre-indexed
				OUT = 8'd23;		
	end	

	// Load-Store Multiple

	else if(IR[27:25] == 3'b100)
	begin					

			if(IR[24] == 1'b0)	// First address is Rn contents
				OUT= 8'd30;					

			else	//First address is Rn +/- 4
				OUT = 8'd31;		
	end	

end

endmodule // Encoder END