module SLSManager (output reg[2:0] OUT, input[31:0] IR, input SLS_EN);

	always @ (IR, SLS_EN)

	if(SLS_EN)
	begin
	// Addresing Mode 2

		// Immediate & Register

		if(IR[27:25] == 3'b010 || IR[27:25] == 3'b011)
		begin					

			if(IR[22] == 1'b1)	//post-indexed
				OUT= 3'b000;					
			else 
				OUT = 3'b010;  //unsigned word  (I don't know if  signed or unsigned. It's not clear from the documentation)
			
			
		end	

	//Addressing mode 3 

		//Immediate & Register

		if(IR[27:25] == 3'b000 && IR[4]==1'b1)
		begin					

			if(IR[20]==1'b1 && IR[5]==1'b0)	//LDRSB - Load Signed Byte 
				OUT= 3'b100;					
			else if(IR[20]==1'b1 && IR[5]==1'b1)
				OUT = 3'b101;  //LDRSH - Load Signed Halfword 
			else
				OUT = 3'b011;  //LDRD - Load Doubleword (don't know if signed of unsigned)
				
				
			end	


		end
	/*else 
		OUT = 3'd0;*/

endmodule // Encoder END