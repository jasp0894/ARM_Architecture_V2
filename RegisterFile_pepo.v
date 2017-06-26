module RegisterFile_pepo (PA, PB, PC, CLK, RFLD, A, B, C, RESET);

	//Outputs
	output wire [31:0] PA;		//RF output port 
	output wire [31:0] PB;		//RF output port
	//Inputs
	input wire [31:0] PC;		//This is the input data to the register file that will be regirected.
	input wire CLK;
	input wire RFLD;			//Register File Load Enable.
	input wire [3:0] A, B; 		//Address of register when performing a load.
	input wire [3:0] C;			//Address of register when performing a store.
	input wire RESET;



	wire [15:0] BDE;			//Binary decoder enable.

	wire [31:0] QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15;

	//Binary decoder
	BinaryDecoder_pepo BinaryDecoder_pepo (BDE,C,RFLD);

	//RF Registers
	Register_32bits_pepo R0(QS0,PC,BDE[0],CLK,RESET); 
	Register_32bits_pepo R1(QS1,PC,BDE[1],CLK,RESET);
	Register_32bits_pepo R2(QS2,PC,BDE[2],CLK,RESET); 
	Register_32bits_pepo R3(QS3,PC,BDE[3],CLK,RESET); 
	Register_32bits_pepo R4(QS4,PC,BDE[4],CLK,RESET); 
	Register_32bits_pepo R5(QS5,PC,BDE[5],CLK,RESET); 
	Register_32bits_pepo R6(QS6,PC,BDE[6],CLK,RESET); 
	Register_32bits_pepo R7(QS7,PC,BDE[7],CLK,RESET); 
	Register_32bits_pepo R8(QS8,PC,BDE[8],CLK,RESET); 
	Register_32bits_pepo R9(QS9,PC,BDE[9],CLK,RESET); 
	Register_32bits_pepo R10(QS10,PC,BDE[10],CLK,RESET); 
	Register_32bits_pepo R11(QS11,PC,BDE[11],CLK,RESET); 
	Register_32bits_pepo R12(QS12,PC,BDE[12],CLK,RESET); 
	Register_32bits_pepo R13(QS13,PC,BDE[13],CLK,RESET); 
	Register_32bits_pepo R14(QS14,PC,BDE[14],CLK,RESET); 
	Register_32bits_pepo R15(QS15,PC,BDE[15],CLK,RESET); 

	//Register Output Selectors
	mux_16x1_32bit muxA(PA,A,QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15);

	mux_16x1_32bit muxB(PB,B,QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15);

endmodule // RegisterFile_pepo