//Single Load/Store Manager
//This module determines RAM setting for Addressing mode 2&3
//The Output Bus organization is as follows:
//OUT[3] -> SLS_R/W
//OUT[2] -> Sign Extension 
//OUT[1:0] -> Data Size
//See ROM Table for more info.

module SLSManager (output reg[3:0] OUT, input[31:0] IR, input SLS_EN);



	always @ (IR, SLS_EN)



	if(SLS_EN)

	begin

	// Addresing Mode 2
		// Immediate & Register

		if(IR[27:25] == 3'b010 || IR[27:25] == 3'b011)

		begin					


			if(IR[22] == 1'b1)	//post-indexed

				OUT= 4’b0000;					

			else 

				OUT = 4’b0010;  //unsigned word  (I don't know if  signed or unsigned. It's not clear from the documentation)

			end	


	//Addressing mode 3 



		//Immediate & Register



		if(IR[27:25] == 3'b000 && IR[4]==1'b1)

		begin					



			if(IR[20]==1'b1 && IR[5]==1'b0)	//LDRSB - Load Signed Byte 

				OUT= 4’b0100;					

			else if(IR[20]==1'b1 && IR[5]==1'b1)

				OUT = 4’b0101;  //LDRSH - Load Signed Halfword 

			else

				OUT = 4’b0011;  //LDRD - Load Doubleword (don't know if signed of unsigned)

				

				

			end	

if(IR[20] == 1’b1) //Load

			OUT[3] = 1’b1;  //Read
else
               OUT[3] = 1’b0; //Write



		end

	





endmodule //SLSManager