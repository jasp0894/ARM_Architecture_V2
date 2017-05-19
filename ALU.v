//%%%%%%%%%%%%%%%%%%%ARM ARITHMETIC LOGIC UNIT%%%%%%%%%%%%%%%%%%%%%%%%
//********************************************************************
//-------------------------------------------------------------------
/**
	Input A will take the place of the of shifter operand
	Input B will take the place of Rn
	Output R will take the place of Rd
**/
module ALU_V1 (output reg [31:0] R, output reg CF, ZF, VF, NF, input [31:0]A,B, input CIN, input [4:0] OP);

//-----------------ARM Instruction set definition---------------------

	parameter  AND = 4'b00000;
	parameter  EOR = 4'b00001;
	parameter  SUB = 4'b00010;
	parameter  RSB = 4'b00011;
	parameter  ADD = 4'b00100;
	parameter  ADC = 4'b00101;
	parameter  SBC = 4'b00110;
	parameter  RSC = 4'b00111;
	parameter  TST = 4'b01000;
	parameter  CMP = 4'b01010;
	parameter  CMN = 4'b01011;
	parameter  ORR = 4'b01100;
	parameter  TEQ = 4'b01001;
	parameter  MOV = 4'b01101;
	parameter  BIC = 4'b01110;
	parameter  MVN = 4'b01111;

	parameter  OP1 = 4'b10000;
	parameter  OP2 = 4'b10001;
	parameter  OP3 = 4'b10010;
	parameter  OP4 = 4'b10011;
	parameter  OP5 = 4'b10100;
	parameter  OP6 = 4'b10101;
	parameter  OP7 = 4'b10110;
	parameter  OP8 = 4'b11001;
	parameter  OP9 = 4'b11010;



	//Flags initialization
	initial begin
		CF = 0;			//Carry Flag
		ZF = 0;			//Zero Flag
		VF = 0;			//Overflow Flag
		NF = 0;			//Negative Flag
	end

//Temporal Variables
reg [31:0] tempResult;

	always@(A,B,OP)		
	//Input operation different cases evaluation
	case(OP)
		AND: 
			begin
				R = A & B;		//Bitwise and operation
				if(R == 32'd0)		//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit
			end
		EOR:
			begin
				R = A ^ B;		//Bitwise xor operation
				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit
			end
		ORR:
			begin
				R = A | B;		//Bitwise OR operation
				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit
			end
		BIC:
			begin
				R = ~A & B;		//A AND NOT_B
				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit
			end
	//--------------------------Arithmetic Instructions------------------------------
		SUB:
			begin
				{CF,R} = B - A;		//BorrowFlag = not(CarryFlag)
				CF = ~CF;
				if(A[31] != B[31] && R[31] == A[31])
					VF = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					VF = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

		SBC:
			begin
				 {CF,R} = B - A - (1-CIN);		//BorrowFlag = not(CarryFlag). The operation includes the input carry
				 CF = ~CF;
				if(A[31] != B[31] && R[31] == A[31])
					VF = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					VF = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

		RSB:
			begin
			
				 {CF,R} = A - B;		//BorrowFlag = not(CarryFlag)
				 CF = ~CF;
				if(A[31] != B[31] && R[31] == B[31])
					VF = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					VF = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

		RSC:
			begin
				 {CF,R} = A - B - (1-CIN);		//BorrowFlag = not(CarryFlag). The operation includes the input carry
				 CF = ~CF;
				if(A[31] != B[31] && R[31] == B[31])
					VF = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					VF = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

		ADD:
			begin
			
				 {CF,R} = A + B;		
				if(A[31] == B[31] && R[31] !== A[31])
					VF = 1'b1;		//Overflow only occurs when adding two equally signed numbers
									//and the result is of the opposite sign
				else
					VF = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end	
		
		ADC:
			begin
				 {CF,R} = A + B + CIN;		//The addition operation includes the input carry
				if(A[31] == B[31] && R[31] !== A[31])
					VF = 1'b1;		//Overflow only occurs when adding two equally signed numbers
									//and the result is of the opposite sign
				else
					VF = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

	//--------------------------Data transfer Instructions------------------------------
		MOV:
			begin
				R = A;			//moves input A to the output

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

		MVN:
			begin
				R = ~A;			//moves NOT_A to the output

				if(R == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = R[31];		//NF takes the value of R's MSbit	
			end

	//--------------------------Comparison Instructions------------------------------
		TST:
			begin
				tempResult = A & B;		//Dummy variable to test flags
				if(tempResult == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = tempResult[31];		//NF takes the value of R's MSbit
			end

		TEQ:
			begin
				tempResult = A ^ B;		//Dummy variable to test flags
				if(tempResult == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = tempResult[31];		//NF takes the value of R's MSbit
			end

		CMP:
			begin
				tempResult = 32'd0;		//Dummy variable to test flags
				{CF,tempResult} = B - A;		//BorrowFlag = not(CarryFlag)
				CF = ~CF;

				if(A[31] != B[31] && tempResult[31] == A[31])
					VF = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					VF = 1'b0;

				if(tempResult == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = tempResult[31];		//NF takes the value of R's MSbit	
			end

		CMP:
			begin
				tempResult = 32'd0;		//Dummy variable to test flags
				 {CF,tempResult} = B + A;		//BorrowFlag = not(CarryFlag)

				if(A[31] == B[31] && tempResult[31] !== A[31])
					VF = 1'b1;		//Overflow only occurs when adding two equally signed numbers
									//and the result is of the opposite sign
				else
					VF = 1'b0;

				if(tempResult == 32'd0)	//Negative Flag condition testing
					ZF = 1'b1;
				else 
					ZF = 1'b0;		//Result is not zero

				NF = tempResult[31];		//NF takes the value of R's MSbit	
				
			end

	//--------------------------OP Instructions------------------------------

	




	endcase // OP


endmodule // ALU_V1


