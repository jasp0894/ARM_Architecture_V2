//Datapath Phase 1 Tester: DOES NOT include memory interface 

module dp_phase1;

//input signals
	reg[31:0] IR;
	reg MOC,LSM_DETECT, LSM_END, CLK;


//output signals
	wire[31:0] CU_OUT, PA, PB, ALU_OUT, IR_Q, SHIFTER_OUT, MB_OUT;

	wire[3:0] FR_Q, MC_OUT, MA_OUT,;

	wire[4:0] MD_OUT;

	wire CONDTESTER_OUT, Z,N,V,C;

//63 62 61 60 59 58      57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0
//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 FRLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF

	parameter sim_time = 1000;

	//modules instantiation
	controlUnit_p cu (CU_OUT,IR,MOC,CONDTESTER_OUT,LSM_DETECT,LSM_END,CLK);
	ALU_V1 alu(ALU_OUT,C,Z,V,N,MB_OUT,PA,FR_Q[3],MD_OUT);
	FLagRegister FR(FR_Q,Z,C,N,V,CU_OUT[33],CLK);
	CondTester conditionTester (CONDTESTER_OUT,IR[31:28],FR_Q[3],FR_Q[2],FR_Q[1],FR_Q[0]);
	mux_4x1_4b (MA_OUT,CU_OUT[26],CU_OUT[25],IR[19:16], 4'b1111, 4'd0, IR[15:12]);
	mux_8x1_4b (MC_OUT,CU_OUT[21],CU_OUT[20],CU_OUT[19],IR[19:16], 4'b1111, 4'b1110, IR[15:12], 4'd0, 4'd0, 4'd0, 4'd0);
	registerFile RF (PA,PB,ALU_OUT, CLK, CU_OUT[32],MA_OUT,IR[3:0], MC_OUT);
	mux_8x1_4b (MB_OUT,CU_OUT[24],CU_OUT[23],CU_OUT[12],PB, SHIFTER_OUT, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0);
	
	initial
		begin
			//IRPUTS initialization

			MOC=1'd1; COND=1'd0; LSM_DETECT=1'd0; LSM_END=1'd0; CLK=1'd0; 			

			

			IR = 32'b11110001100111111111000111111111; //Signed  halfowrd (50)



			//IR = 32'b00001011000000000000000000000000; //44


			//IR = 32'b00001000000000000000000000000000; //30



			//IR = 32'b00000110010100000000000000000000; //22


			//IR = 32'b00000100010100000000000000000000; //17

			//IR = 32'b00000111101100000000000000000000; //23

			//IR = 32'b00000101111000000000000000000000; //19



			//IR= 32'b00000111110100000000000000000000;   //21




			//IR = 32'b00000100000101010100001001110101;			//State 19

			

			//IR =32'b00000101001011010101011010101101; //State17


			//  IR = 32'b00000101110100000000000000000000;    //state16 e0

			//IR = 32'b00000101010101011110010100101011;			//State 16
			// #40

			// IR = 32'b11100001110101000101000000000100;		//State 10
			
			// #500;


			/*M1M0 = 2'd2;#100;
			M1M0 = 2'd3;#100;*/
			// M1M0 = 2'd3;

			/*
			IR =  32'b11110010100110100001000000101100; 		//state 11
			#200;

			IR= 32'b11110001001110100001000000101100;		//state 14
			#200;

			IR=  32'b11110011000110100001000000101100;			//state 15
			#20;*/

			//there seems to be a synchronization issue 




		end

	initial
		begin
			
		
			$display("S2S0  INV   STS      N2N0    M1M0     ENC    mu0A    CR15_8          CR7_0   mu0E  IncReg  ADD_Out        ctlRregister ");
			$monitor("%b   %d    %d       %b      %b       %d     %d        %d        %d      %d    %d      %d       %b", cu.ctl_register.Q[52:50],cu.ctl_register.Q[54], cu.inv.OUT,cu.ctl_register.Q[57:55], cu.nextState.M1M0, cu.encoder.OUT, cu.muxA.Y,cu.ctl_register.Q[49:42],cu.ctl_register.Q[41:34],cu.muxE.Y, cu.incrementerRegister.Q,  cu.adder.S,  cu.ctl_register.Q);
		
		//

		end


	always #20 CLK = ~CLK;
	initial #sim_time $finish;

endmodule // controlunit_piecewise Tester



