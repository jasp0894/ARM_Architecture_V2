//%%%%%%%%%%%%%%%%%%%%%%%%%%%%ALU Test Module%%%%%%%%%%%%%%%%%%%%%%%%
//********************************************************************
//-------------------------------------------------------------------


module ALU_Test_V1;

//local variables
//--------------input
reg [31:0] A,B; 		//32 bit input operands
reg [4:0] OP; 			//Input operation 
reg	CIN; 				//input carry
//--------------output
wire[31:0] R; 			//32-bit ALU result
wire  C,V,N,Z;			//condition codes
wire[3:0] FLAG;


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

	parameter  OP1 = {1'b1,4'b0000};
	parameter  OP2 = 5'b10001;
	parameter  OP3 = 5'b10010;
	parameter  OP4 = 5'b10011;
	parameter  OP5 = 5'b10100;
	parameter  OP6 = 5'b10101;
	parameter  OP7 = 5'b10110;
	parameter  OP8 = 5'b11001;
	parameter  OP9 = 5'b11010;



//simulation parameters
parameter sim_time = 100000;	//simulation time

ALU_V1 ALU(R,FLAG,A,B,CIN,OP);		//ALU module instantiation
initial #sim_time $finish;		//simulation termination time

initial	begin
	//initializing inputs
	
	CIN = 0;		//Input Carry equals 0
	A = 0; B = 0;

	//--------------------------------AND	
	OP = AND;			
	#10; A = 32'h12344567; B = 32'h0000FE18;
	#10; A = 32'h005AC023; B = 32'h0DAE2310;
	#10;
	$display("**********************************************************************");
	//--------------------------------EOR
	OP = EOR; 
	#10; A = 32'h000F000F; B = 32'hFFFFAAFA;
	#10; A = 32'h12344567; B = 32'h0000FE18;

	#10;
	$display("**********************************************************************");
	//--------------------------------SUB
	OP = SUB; 
	#10; A = 32'h005AC023; B = 32'h0DAE2310;
	#10; A = 32'h50000000; B = 32'hB0000000;
	#10;
	$display("**********************************************************************");
	//--------------------------------RSB
	OP = RSB; 
	#10; A = 32'h12344567; B = 32'hF000FE18;
	#10; A = 32'h005AC023; B = 32'h0DAE2310;

	#10;
	$display("**********************************************************************");
	//--------------------------------ADD
	OP = ADD; 
	#10; A = 32'h12344567; B = 32'hF000FE18;
	#10; A = 32'h7F000000; B = 32'h0F001000;  //testing V
	#10;
	$display("**********************************************************************");
	//--------------------------------TST
	OP = TST; 
	#10; A = 32'h12344567; B = 32'h0000FE18;
	#10; A = 32'h005AC023; B = 32'h0DAE2310;

	#10;
	$display("**********************************************************************");
	//--------------------------------TEQ
	OP = TEQ; 
	#10; A = 32'h12344567; B = 32'h0000FE18;
	
	#10;
	$display("**********************************************************************");
	//--------------------------------CMP
	OP = CMP; 
	#10; A = 32'h50000000; B = 32'hB0000000;
	#10;
	$display("**********************************************************************");
	//--------------------------------CMN
	OP = CMN; 
	#10; A = 32'h12344567; B = 32'h0000FE18;
	#10; A = 32'h005AC023; B = 32'h0DAE2310;

	#10;
	$display("**********************************************************************");
	//--------------------------------ORR
	OP = ORR; 
	#10; A = 32'h12344567; B = 32'h0000FE18;

	#10;
	$display("**********************************************************************");
	//--------------------------------MOV
	OP = MOV; 
	#10; A = 32'h005AC023; B = 32'h0DAE2310;

	#10;
	$display("**********************************************************************");
	//--------------------------------BIC
	OP = BIC; 
	#10; A = 32'h12344567; B = 32'h0000FE18;

	#10;
	$display("**********************************************************************");
	//--------------------------------MVN
	OP = MVN; 
	#10; A = 32'h005AC023; B = 32'h0DAE2310;
	#10;

	//-----------------------------------Operation involving Carry bit
	CIN=0;
		$display("**********************************************************************");
		//--------------------------------ADC
		OP = ADC; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10;

		$display("**********************************************************************");
		//--------------------------------SBC
		OP = SBC; 
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10;

		$display("**********************************************************************");
		//--------------------------------RSC
		OP = RSC; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10;

	CIN = 1;
		$display("**********************************************************************");
		//--------------------------------ADC
		OP = ADC; 
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;

		$display("**********************************************************************");
		//--------------------------------SBC
		OP = SBC; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10;

		$display("**********************************************************************");
		//--------------------------------RSC
		OP = RSC; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;	





		$display("**********************************************************************");
		//--------------------------------Rd = B
		OP = OP1; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10;

		$display("**********************************************************************");
		//--------------------------------Rd = B +4
		OP = OP2; 
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;

		$display("**********************************************************************");
		//--------------------------------Rd = R=B + A +4
		OP = OP3; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10;

		$display("**********************************************************************");
		//--------------------------------Rd=B-4
		OP = OP4; 
		#10; A = 32'h12344567; B = 32'd10;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;	

		$display("**********************************************************************");
		//--------------------------------Rd =A-4
		OP = OP5; 
		#10; A = 32'd10; B = 32'hF000FE18;
		#10;

		$display("**********************************************************************");
		//--------------------------------Rd = A +B
		OP = OP6; 
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;

		$display("**********************************************************************");
		//--------------------------------Rd= B-A
		OP = OP7; 
		#10; A = 32'd1; B = 32'd5;
		#10; A = 32'h50000000; B = 32'hB0000000;
		#10;

		$display("**********************************************************************");
		//--------------------------------Rd= A
		OP = OP8; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;	

		$display("**********************************************************************");
		//--------------------------------Rd= A +4
		OP = OP9; 
		#10; A = 32'h12344567; B = 32'hF000FE18;
		#10; A = 32'h005AC023; B = 32'h0DAE2310;
		#10;	


end

initial begin 
	$display(" OP   A        B        CIN Result   Z N V C 	   	      Time");		//prints header
	$display("**********************************************************************");
	$monitor(" %b %h %h %b   %h %b  %d", OP, A, B, CIN, R, FLAG, $time);		//print signals
end

endmodule

