//%%%%%%%%%%%%%%%%%%%ARM ARITHMETIC LOGIC UNIT%%%%%%%%%%%%%%%%%%%%%%%%
//********************************************************************
//-------------------------------------------------------------------
/**
	Input A will take the place of the of shifter operand
	Input B will take the place of Rn
	Output R will take the place of Rd
**/
module ALU_V1 (output reg [31:0] R, output reg [3:0] FLAG, /*output reg CF, ZF, VF, NF*/ input [31:0]A,B, input CIN, input [4:0] OP);

//-----------------ARM Instruction set definition---------------------

	parameter  AND = 5'b00000;
	parameter  EOR = 5'b00001;
	parameter  SUB = 5'b00010;
	parameter  RSB = 5'b00011;
	parameter  ADD = 5'b00100;
	parameter  ADC = 5'b00101;
	parameter  SBC = 5'b00110;
	parameter  RSC = 5'b00111;
	parameter  TST = 5'b01000;
	parameter  CMP = 5'b01010;
	parameter  CMN = 5'b01011;
	parameter  ORR = 5'b01100;
	parameter  TEQ = 5'b01001;
	parameter  MOV = 5'b01101;
	parameter  BIC = 5'b01110;
	parameter  MVN = 5'b01111;

	parameter  OP1 = 5'b10000;
	parameter  OP2 = 5'b10001;
	parameter  OP3 = 5'b10010;
	parameter  OP4 = 5'b10011;
	parameter  OP5 = 5'b10100;
	parameter  OP6 = 5'b10101;
	parameter  OP7 = 5'b10110;
	parameter  OP8 = 5'b11001;
	parameter  OP9 = 5'b11010;



	//Flags initialization
	initial begin
		FLAG[3] = 1'b0;			//Carry Flag
		FLAG[2] = 1'b0;			//Zero Flag
		FLAG[1] = 1'b0;			//Overflow Flag
		FLAG[0] = 1'b0;			//Negative Flag
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
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit
			end
		EOR:
			begin
				R = A ^ B;		//Bitwise xor operation
				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit
			end
		ORR:
			begin
				R = A | B;		//Bitwise OR operation
				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit
			end
		BIC:
			begin
				R = ~A & B;		//A AND NOT_B
				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit
			end
	//--------------------------Arithmetic Instructions------------------------------
		SUB:
			begin
				{FLAG[3],R} = B - A;		//BorrowFlag = not(CarryFlag)
				FLAG[3] = ~FLAG[3];
				if(A[31] != B[31] && R[31] == A[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					FLAG[1] = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

		SBC:
			begin
				 {FLAG[3],R} = B - A - (1-CIN);		//BorrowFlag = not(CarryFlag). The operation includes the input carry
				 FLAG[3] = ~FLAG[3];
				if(A[31] != B[31] && R[31] == A[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					FLAG[1] = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

		RSB:
			begin
			
				 {FLAG[3],R} = A - B;		//BorrowFlag = not(CarryFlag)
				 FLAG[3] = ~FLAG[3];
				if(A[31] != B[31] && R[31] == B[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					FLAG[1] = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

		RSC:
			begin
				 {FLAG[3],R} = A - B - (1-CIN);		//BorrowFlag = not(CarryFlag). The operation includes the input carry
				 FLAG[3] = ~FLAG[3];
				if(A[31] != B[31] && R[31] == B[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					FLAG[1] = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

		ADD:
			begin
			
				 {FLAG[3],R} = A + B;		
				if(A[31] == B[31] && R[31] !== A[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when adding two equally signed numbers
									//and the result is of the opposite sign
				else
					FLAG[1] = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end	
		
		ADC:
			begin
				 {FLAG[3],R} = A + B + CIN;		//The addition operation includes the input carry
				if(A[31] == B[31] && R[31] !== A[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when adding two equally signed numbers
									//and the result is of the opposite sign
				else
					FLAG[1] = 1'b0;

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

	//--------------------------Data transfer Instructions------------------------------
		MOV:
			begin
				R = A;			//moves input A to the output

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

		MVN:
			begin
				R = ~A;			//moves NOT_A to the output

				if(R == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = R[31];		//FLAG[0] takes the value of R's MSbit	
			end

	//--------------------------Comparison Instructions------------------------------
		TST:
			begin
				tempResult = A & B;		//Dummy variable to test flags
				if(tempResult == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = tempResult[31];		//FLAG[0] takes the value of R's MSbit
			end

		TEQ:
			begin
				tempResult = A ^ B;		//Dummy variable to test flags
				if(tempResult == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = tempResult[31];		//FLAG[0] takes the value of R's MSbit
			end

		CMP:
			begin
				tempResult = 32'd0;		//Dummy variable to test flags
				{FLAG[3],tempResult} = B - A;		//BorrowFlag = not(CarryFlag)
				FLAG[3] = ~FLAG[3];

				if(A[31] != B[31] && tempResult[31] == A[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when subtracting two numbers of 
									//opposite sign and the result is the same sign of the 
									//subtrahend number 
				else
					FLAG[1] = 1'b0;

				if(tempResult == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = tempResult[31];		//FLAG[0] takes the value of R's MSbit	
			end

		CMP:
			begin
				tempResult = 32'd0;		//Dummy variable to test flags
				 {FLAG[3],tempResult} = B + A;		//BorrowFlag = not(CarryFlag)

				if(A[31] == B[31] && tempResult[31] !== A[31])
					FLAG[1] = 1'b1;		//Overflow only occurs when adding two equally signed numbers
									//and the result is of the opposite sign
				else
					FLAG[1] = 1'b0;

				if(tempResult == 32'd0)	//Negative Flag condition testing
					FLAG[2] = 1'b1;
				else 
					FLAG[2] = 1'b0;		//Result is not zero

				FLAG[0] = tempResult[31];		//FLAG[0] takes the value of R's MSbit	
				
			end

	//--------------------------OP Instructions------------------------------
	//---These instructions do not alter flags------------------------------
	OP1:  R = B;			//moves B to the output
	OP2:  R = B+4;			// B+4to the output
	OP3:  R = A+B+4;			//A+B+4to the output
	OP4:  R = B-4;
	OP5:  R = A-4;
	OP6:  R = A+B;
	OP7:  R = B-A;
	OP8:  R = A;
	OP9:  R = A+4;


	endcase // OP


endmodule // ALU_V1


