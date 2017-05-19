module shifter (output reg[31:0] SHIFTER_OPERAND, output reg COUT, input [31:0] RM,IR, input CIN,ENABLE);

	reg[31:0] RegTemp;	// Registro Temporero para "32-bit immediate shifter operand"

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

			else						//Shift by immediate shifter operand
			begin

				case(IR[6:5])

					LSL: 
						begin
							SHIFTER_OPERAND = RM << IR[11:7];
							COUT = RM[8'b00100000 - IR[11:7]];
						end

					LSR: 
						begin
							SHIFTER_OPERAND = RM >> IR[11:7];
							COUT = RM[IR[11:7] - 1];
						end	

					ASR: 
						begin
							SHIFTER_OPERAND = RM >>> IR[11:7];
							COUT = RM[IR[11:7] - 1];
						end


					ROR: 
						begin
							SHIFTER_OPERAND = RM >> IR[11:7];
							COUT = RM[IR[11:7] - 1];
						end				

				endcase // shift

			end

		end

		else		// Enable = 0
		begin 

			COUT = CIN;
			SHIFTER_OPERAND = RM;

		end

	end

endmodule // Shifter