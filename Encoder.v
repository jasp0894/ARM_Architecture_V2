module Encoder (output reg[7:0] OUT, input[31:0] IR);

	always @ (IR)



	if(IR[31:0] == 32'b0)
		OUT = 8'd0;			
	

	// Data Processing 

	else if(IR[27:25] == 3'b000 && IR[4]==0)			// Shift by Immediate					
	//begin
		//if(IR[24]==1'b1 && IR[23]==1'b0)
			//OUT = 8'd14;
		//else 
		OUT = 8'd10;
	//end					

	else if(IR[27:25] == 3'b001)//begin		// 32-bit Immediate Shifter		 
	//	if(IR[24]==1'b1 && IR[23]==1'b0)
		//	OUT = 8'd15;
		//else 
		OUT = 8'd11;	
	//end	

	// Addresing Mode 2 

		// Immediate

		else if(IR[27:25] == 3'b010 )
		begin					

			if(IR[24] == 1'b0)	//post-indexed
				OUT= 8'd17;					
			else if (IR[21] == 0)	// immediate offset
				OUT = 8'd16;

			else	//pre-indexed
				OUT = 8'd19;		
		end	

		// Register

		else if(IR[27:25] == 3'b011 )
		begin					

			if(IR[24] == 1'b0)	//post-indexed
				OUT= 8'd22;					
			else if (IR[21] == 0)	// register offset
				OUT = 8'd21;
			else	//pre-indexed
				OUT = 8'd23;		
		end	

	// Addresing Mode 3 (Cannot be inside Addr.Mode 2 due to IR22 having different meaning)

		// Immediate

		else if(IR[27:25] == 3'b000 && IR[22]==1 && IR[4]==1)
		begin					

			if(IR[24] == 1'b0)	//post-indexed
				OUT= 8'd46;					
			else if (IR[21] == 0)	// immediate offset
				OUT = 8'd47;
			else	//pre-indexed
				OUT = 8'd48;		
		end	

		// Register

		else if(IR[27:25] == 3'b000 && IR[22]==0 && IR[4]==1)
		begin					

			if(IR[24] == 1'b0)	//post-indexed
				OUT= 8'd49;					
			else if (IR[21] == 0)	// register offset
				OUT = 8'd50;
			else	//pre-indexed
				OUT = 8'd51;		
		end	

	// Load-Store Multiple

	else if(IR[27:25] == 3'b100)
	begin					

			if(IR[24] == 1'b0)	// First address is Rn contents
				OUT= 8'd30;					

			else	//First address is Rn +/- 4
				OUT = 8'd31;		
		end	

	// Branch & Link, Branch

	else 
	begin					

			if(IR[24] == 1'b0)	// Branch
				OUT= 8'd45;					

			else	//Branch & Link
				OUT = 8'd44;		
		end	

endmodule // Encoder END