module shifter (output reg[31:0] SHIFTER_OPERAND, output reg COUT, input [31:0] RM,IR, input CIN,ENABLE);

	reg[31:0] RegTemp;	// Registro Temporero para "32-bit immediate shifter operand"
	reg[15:0] MultipleReg;	// Registro temporero para Load/Store Multiple
	
	// Tipos de "SHIFTS" en "Shift by immediate shifter operand"

	parameter LSL = 2'b00;	// Logical Shift Left
	parameter LSR = 2'b01;	// Logical Shift Right
	parameter ASR = 2'b10;	// Arithmetic Shift Right
	parameter ROR = 2'b11;	// Rotate Right
	
	always @ (RM,IR,CIN)
	begin

		if(ENABLE)
		begin

			if(IR[27:25] == 3'b001)		//32-bit immediate shifter operand
			begin
				RegTemp = {24'd0,IR[7:0]} >> 2*IR[11:8];
				SHIFTER_OPERAND = RegTemp;
				if(IR[11:8] > 0)
					COUT = SHIFTER_OPERAND[31];
				else
					COUT = CIN;
			end

			else if(IR[27:25] == 3'b000)	
			begin

				if(IR[4] == 1'b0)	//Shift by immediate shifter operand
				begin
				

				case(IR[6:5])

					LSL: 
						begin
							RegTemp = {28'd0,IR[3:0]}; 
							SHIFTER_OPERAND = RegTemp << IR[11:7];
							if(IR[11:7] == 5'd0)
								COUT = CIN;
							else
								COUT = RegTemp[8'b00100000 - IR[11:7]];
						end

					LSR: 
						begin
							RegTemp = {28'd0,IR[3:0]};
							SHIFTER_OPERAND = RegTemp >> IR[11:7];
							if(IR[11:7] == 5'd0)
								COUT = CIN;
							else
								COUT = RegTemp[IR[11:7] - 1];
						end	

					ASR: 
						begin
							RegTemp = {28'd0,IR[3:0]};
							SHIFTER_OPERAND = RegTemp >>> IR[11:7];
							if(IR[11:7] == 5'd0)
								COUT = CIN;
							else
								COUT = RegTemp[IR[11:7] - 1];
						end


					ROR: 
						begin
							RegTemp = {28'd0,IR[3:0]};
							SHIFTER_OPERAND = RegTemp >> IR[11:7];
							if(IR[11:7] == 5'd0)
								COUT = CIN;
							else
								COUT = RegTemp[IR[11:7] - 1];
						end				

				endcase // shift
				end

				else	// Addresing Mode 3 (Immediate) Use a 8-bit offset
				begin

						COUT = CIN;
						if(IR[11] == 1'b1)
							SHIFTER_OPERAND = {24'hFFFFFF,{IR[11:8],IR[3:0]}};

						else
							SHIFTER_OPERAND = {24'h000000,{IR[11:8],IR[3:0]}};
				end

			end

			else if(IR[27:25] == 3'b010)	// Addresing Mode 2 (Immediate) Use a 12-bit offset
			begin

				COUT = CIN;
				if(IR[11] == 1'b1)
					SHIFTER_OPERAND = {20'hFFFFF,IR[11:0]};
				else
					SHIFTER_OPERAND = {20'h00000,IR[11:0]};
			end	


			else if(IR[27:25] == 3'b100)	// Load/Store Multiple (Immediate) Use a 12-bit offset
			begin
				COUT = CIN;
				MultipleReg = 3'b100*(IR[15]+IR[14]+IR[13]+IR[12]+IR[11]+IR[10]+IR[9]+IR[8]+IR[7]+IR[6]+IR[5]+IR[4]+IR[3]+IR[2]+IR[1]+IR[0]);
				SHIFTER_OPERAND = {26'd0,MultipleReg};
				
			end	

			else if(IR[27:25] == 3'b101)	// B and B&L Use a 32-bit offset
			begin

				COUT = CIN;
				
				if(IR[23] == 1'b1)
					RegTemp = {8'hFF,IR[23:0]};
				else
					RegTemp = {8'h00,IR[23:0]};

				SHIFTER_OPERAND = 32'd8 + 32'd4*RegTemp;	
			end	

		end

		else		// Enable = 0
		begin 

			COUT = CIN;
			SHIFTER_OPERAND = RM;

		end

	end

endmodule // Shifter