module Encoder (output reg[7:0] OUT, input[31:0] IR);

	always @ (IR)

	if(IR[27:25] == 3'b010)begin					// Load/Store Immediate Offset

		if(IR[20] == 1'b1)	begin					// Load
			if(IR[23]== 1'b1)						// Suma
				OUT = 8'd16;						// GO to State 16
			else									//Resta
				OUT = 8'd20;
		end
		else begin									//Store	

			if(IR[23] == 1'b1)						//Suma
				OUT = 8'd35;
			else 									//Resta
				OUT = 8'd39;
		end	
	end	
	else if(IR[27:25] == 3'b000)begin				//DataProcessing immediate shift OR Addressing Mode3
			if(IR[4] == 0)							// DataProcesssing immediate shift
				begin
					if(IR[24]==1'b1 && IR[23]==1'b0)
						OUT = 8'd14;
					else 
						OUT = 8'd10;
				end		
		end				
	else if(IR[27:25] == 3'b001)begin				//DataProcessing immediate  
			if(IR[24]==1'b1 && IR[23]==1'b0)
						OUT = 8'd15;
					else 
						OUT = 8'd11;	
		end				

	endmodule // Encoder END***************************8