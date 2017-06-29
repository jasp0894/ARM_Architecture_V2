module shifter (output reg[31:0] SHIFTER_OPERAND, /*output reg COUT*/ input [31:0] RM,IR, /*input CIN*/input ENABLE);

	reg[32:0] RegTemp;	// Registro Temporero para "32-bit immediate shifter operand"
	reg[15:0] MultipleReg;	// Registro temporero para Load/Store Multiple
	reg[63:0] regtemp2;
	
	// Tipos de "SHIFTS" en "Shift by immediate shifter operand"

	parameter LSL = 2'b00;	// Logical Shift Left
	parameter LSR = 2'b01;	// Logical Shift Right
	parameter ASR = 2'b10;	// Arithmetic Shift Right
	parameter ROR = 2'b11;	// Rotate Right
	
	always @ (RM,IR)
	begin

		if(ENABLE)
		begin

			if(IR[27:25] == 3'b001)		//32-bit immediate shifter operand
			begin
				RegTemp = {24'd0,IR[7:0]} >> 2*IR[11:8];
				SHIFTER_OPERAND = RegTemp;
				
			//	regtemp2 = {RM, RM} >> 2*IR[11:8];	//rotate right
			//	SHIFTER_OPERAND[31:0] = regtemp2[31:0];

			end

			else if(IR[27:25] == 3'b000)	
			begin

				if(IR[4] == 1'b0)	//Shift by immediate shifter operand
				begin
				

				case(IR[6:5])

					LSL: 
						begin
							RegTemp = RM; 
							SHIFTER_OPERAND = RegTemp << IR[11:7];
						
						end

					LSR: 
						begin
							RegTemp = RM;
							SHIFTER_OPERAND = RegTemp >> IR[11:7];
							
						end	

					ASR: 
						begin
							RegTemp = RM;
							SHIFTER_OPERAND = RegTemp >>> IR[11:7];
							
						end


					ROR: 
						begin
							regtemp2 = {RM,RM} >> IR[11:7];
							SHIFTER_OPERAND[31:0] = regtemp2[31:0];
						end				

				endcase // shift
				end

				else	// Addresing Mode 3 (Immediate) Use a 8-bit offset
				begin

						
						if(IR[11] == 1'b1)
							SHIFTER_OPERAND = {24'hFFFFFF,{IR[11:8],IR[3:0]}};

						else
							SHIFTER_OPERAND = {24'h000000,{IR[11:8],IR[3:0]}};
				end

			end

			else if(IR[27:25] == 3'b010)	// Addresing Mode 2 (Immediate) Use a 12-bit offset
			begin

				//COUT = CIN;
				if(IR[11] == 1'b1)
					SHIFTER_OPERAND = {20'hFFFFF,IR[11:0]};
				else
					SHIFTER_OPERAND = {20'h00000,IR[11:0]};
			end	


			else if(IR[27:25] == 3'b100)	// Load/Store Multiple (Immediate) Use a 12-bit offset
			begin
				
				MultipleReg = 3'b100*(IR[15]+IR[14]+IR[13]+IR[12]+IR[11]+IR[10]+IR[9]+IR[8]+IR[7]+IR[6]+IR[5]+IR[4]+IR[3]+IR[2]+IR[1]+IR[0]);
				SHIFTER_OPERAND = {26'd0,MultipleReg};
				
			end	

			else if(IR[27:25] == 3'b101)	// B and B&L Use a 32-bit offset
			begin

				
				
				if(IR[23] == 1'b1)
					RegTemp = {8'hFF,IR[23:0]};
				else
					RegTemp = {8'h00,IR[23:0]};

				SHIFTER_OPERAND = 32'd4*RegTemp;	
			end	

		end

		else		// Enable = 0
		begin 

			SHIFTER_OPERAND = RM;

		end

	end

endmodule // Shifter