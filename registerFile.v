module registerFile(output [31:0] PA, PB, input [31:0] PC, input CLK,ENABLE, input [3:0]A,B,C, input RESET);

	wire[0:15] E;
	wire[31:0] QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15;
	wire PA,PB;

	always @ (CLK,C,PC,B,A);


	binaryDecoder binDecoder(E,C,ENABLE);

	D_Latch32bits R0(QS0,PC,E[0],CLK,RESET); 
	D_Latch32bits R1(QS1,PC,E[1],CLK,RESET); 
	D_Latch32bits R2(QS2,PC,E[2],CLK,RESET); 
	D_Latch32bits R3(QS3,PC,E[3],CLK,RESET); 
	D_Latch32bits R4(QS4,PC,E[4],CLK,RESET); 
	D_Latch32bits R5(QS5,PC,E[5],CLK,RESET); 
	D_Latch32bits R6(QS6,PC,E[6],CLK,RESET); 
	D_Latch32bits R7(QS7,PC,E[7],CLK,RESET); 
	D_Latch32bits R8(QS8,PC,E[8],CLK,RESET); 
	D_Latch32bits R9(QS9,PC,E[9],CLK,RESET); 
	D_Latch32bits R10(QS10,PC,E[10],CLK,RESET); 
	D_Latch32bits R11(QS11,PC,E[11],CLK,RESET); 
	D_Latch32bits R12(QS12,PC,E[12],CLK,RESET); 
	D_Latch32bits R13(QS13,PC,E[13],CLK,RESET); 
	D_Latch32bits R14(QS14,PC,E[14],CLK,RESET); 
	D_Latch32bits R15(QS15,PC,E[15],CLK,RESET); 

	mux_16x1_32bit muxA(PA,A,QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15);
	mux_16x1_32bit muxB(PB,B,QS0,QS1,QS2,QS3,QS4,QS5,QS6,QS7,QS8,QS9,QS10,QS11,QS12,QS13,QS14,QS15);

endmodule // registerFile