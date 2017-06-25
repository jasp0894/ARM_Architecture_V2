module RegisterFile_pepo (PA, PB, PC, CLK, ENABLE, A, B, C, RESET);

	//Outputs
	output wire [31:0] PA;		//RF output port 
	output wire [31:0] PB;		//RF output port
	//Inputs
	input wire [31:0] PC;		//Doubpts! Why the PC is outside?
	input wire CLK, ENABLE;
	input wire [3:0] A, B, C;	
	input wire RESET;



	wire [0:15] E;

	wire [31:0] QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15;

	//Binary decoder
	BinaryDecoder_pepo BinaryDecoder_pepo (E,C,ENABLE);

	//RF Registers
	D_Latch32bits_pepo R0(QS0,PC,E[0],CLK,RESET); 

	D_Latch32bits_pepo R1(QS1,PC,E[1],CLK,RESET);

	D_Latch32bits_pepo R2(QS2,PC,E[2],CLK,RESET); 

	D_Latch32bits_pepo R3(QS3,PC,E[3],CLK,RESET); 

	D_Latch32bits_pepo R4(QS4,PC,E[4],CLK,RESET); 

	D_Latch32bits_pepo R5(QS5,PC,E[5],CLK,RESET); 

	D_Latch32bits_pepo R6(QS6,PC,E[6],CLK,RESET); 

	D_Latch32bits_pepo R7(QS7,PC,E[7],CLK,RESET); 

	D_Latch32bits_pepo R8(QS8,PC,E[8],CLK,RESET); 

	D_Latch32bits_pepo R9(QS9,PC,E[9],CLK,RESET); 

	D_Latch32bits_pepo R10(QS10,PC,E[10],CLK,RESET); 

	D_Latch32bits_pepo R11(QS11,PC,E[11],CLK,RESET); 

	D_Latch32bits_pepo R12(QS12,PC,E[12],CLK,RESET); 

	D_Latch32bits_pepo R13(QS13,PC,E[13],CLK,RESET); 

	D_Latch32bits_pepo R14(QS14,PC,E[14],CLK,RESET); 

	D_Latch32bits_pepo R15(QS15,PC,E[15],CLK,RESET); 



	mux_16x1_32bit muxA(PA,A,QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15);

	mux_16x1_32bit muxB(PB,B,QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15);



endmodule // registerFile