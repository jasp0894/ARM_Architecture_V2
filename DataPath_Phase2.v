//Datapath Phase 1 Tester: DOES NOT include memory interface 



module dp_phase1;



//input signals

	//reg[31:0] IR;

	reg COND, CLK;
	
	reg[31:0] DATA_IN;





//output signals

	wire[31:0]  PA, PB, ALU_OUT, IR_Q, MAR_Q, MDR_Q, SHIFTER_OUT, MB_OUT, ME_OUT;

	wire [33:0] CU_OUT;

	wire[3:0] FR_Q, MC_OUT, MA_OUT , FLAGS, LSM_COUNTER;
	
	wire[2:0] SLS_OUT, MF_OUT;

	wire[4:0] MI_OUT, MG_OUT,MD_OUT;
	
	wire CONDTESTER_OUT, Z, N, V, C, MH_OUT;
	wire LSM_DETECT, LSM_END,MOC;
	
	wire[31:0] DATA_OUT;

	


//63 62 61 60 59 58      57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0

//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 FRLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF



	parameter sim_time = 1000;



	//modules instantiation

	flagRegister FR(FR_Q,FLAGS,CU_OUT[33],CLK);

	controlUnit_p cu1(CU_OUT,IR_Q,MOC,CONDTESTER_OUT,LSM_DETECT,LSM_END,CLK);

	ALU_V1 alu(ALU_OUT,FLAGS,MB_OUT,PA,FR_Q[3], {1'b0,IR_Q[24:21]});

	

	CondTester conditionTester (CONDTESTER_OUT,IR_Q[31:28],FR_Q[3],FR_Q[2],FR_Q[1],FR_Q[0]);

	mux_4x1_4bit muxA (MA_OUT,CU_OUT[26:25],IR_Q[19:16], 4'b1111, 4'd0, IR_Q[15:12]);

	mux_8x1_4bit muxC (MC_OUT,CU_OUT[21:19],IR_Q[19:16], 4'b1111, 4'b1110, IR_Q[15:12], 4'd0, 4'd0, 4'd0, 4'd0);

	registerFile RF (PA,PB,ALU_OUT, CLK, CU_OUT[32],MA_OUT,IR_Q[3:0], MC_OUT);

	mux_8x1_32bit muxB (MB_OUT,CU_OUT[24:22],PB, SHIFTER_OUT, 32'd0, 32'd0, 32'd0, 32'd0, 32'd0, 32'd0);

	shifter SHIFTER (SHIFTER_OUT,FLAGS[3],PB,IR_Q,FR_Q[3],1'd1);
	//*******************************************************************************************************
	
	mux_4x1_1bit muxH(MH_OUT,CU_OUT[1:0],CU_OUT[28],1'b0,IR_Q[20],1'b0);	// falta B = SLS_R/W
	mux_2x1_3bit muxF(MF_OUT, CU_OUT[0], CU_OUT[9:7], SLS_OUT);
	SLSManager sls(SLS_OUT,IR_Q,CU_OUT[10]);
	mux_2x1_32bit muxE(ME_OUT, CU_OUT[16], ALU_OUT, DATA_OUT);


	lsm_manager lsm(CU_OUT[6], CU_OUT[5:3], DATA_OUT, CLK, LSM_DETECT, LSM_END, LSM_COUNTER);

	mux_4x1_5bit muxD(MD_OUT,CU_OUT[18:17],CU_OUT[15:11],{1'b0,IR_Q[24:21]}, MG_OUT,MI_OUT);
	mux_2x1_5bit muxI(MI_OUT, IR_Q[23], 5'b10001, 5'b10011);
	mux_2x1_5bit muxG(MG_OUT, IR_Q[23], 5'b10110, 5'b10101 );

	Reg32bits IR (IR_Q, DATA_OUT, CU_OUT[31], CLK);
	Reg32bits MDR(MDR_Q, ME_OUT, CU_OUT[29], CLK);
	Reg32bits MAR(MAR_Q, ALU_OUT, CU_OUT[30], CLK);

	//  MOV, ReadWrite, MS_2_0, DataIn, Address, CLK, MOC, DataOut
	ram256x8 ram(CU_OUT[27],MH_OUT,MF_OUT,MDR_Q,MAR_Q,CLK,MOC,DATA_OUT);






	initial

		begin

			//INPUTS initialization



			 COND=1'd0; CLK=1'd0; 		



		    	
		    //IR = 32'b11100001101110001000000000101100;	//MOV  Rd = R8 = 12


		   // #200;

		    //IR= 32'b11100000100111001000000000101100; //ADD Rd= R12; Rn=R8; shifterOp = 12
		   //  #200;

			//IR = 32'b11100000100110100001000000101100;		//State 10

			//#20;

			/*

			IR =  32'b11110010100110100001000000101100; 		//state 11

			#200;

			IR= 32'b11110001001110100001000000101100;		//state 14

			#200;

			IR=  32'b11110011000110100001000000101100;			//state 15

			#20;*/

		end



	initial

		begin

		

			$display("CU\t  Rn CondT Rd MA MC\t     PA\t\t PB\t   SHIFT MB_S      ALU  FR  CZVN MH MF ME      MD      MI     MG     MB      IR         MDR    MAR    R/W  DATAOUT             Time"); 

			$monitor("%h %d  %d   %d  %d  %d  %d  %d  %d  %d %d %b %b %b  %d %h %b  %b  %b %h %h %h %h %b %h%d",CU_OUT,IR_Q[19:16],CONDTESTER_OUT,IR_Q[15:12], MA_OUT,MC_OUT,PA,PB,SHIFTER_OUT,CU_OUT[24:22],ALU_OUT,FR_Q,FLAGS,MH_OUT,MF_OUT,ME_OUT,MD_OUT,MI_OUT,MG_OUT,MB_OUT,IR_Q,MDR_Q,MAR_Q,MH_OUT,DATA_OUT,$time); 

			//$monitor("%b   %d ",CU_OUT,/*MA_OUT,MC_OUT,PA,PB,SHIFTER_OUT,MB_OUT,ALU_OUT,Z,C,N,V,*/ $time); 

		//



		end





	always #20 CLK = ~CLK;

	initial #sim_time $finish;



endmodule // controlunit_piecewise Tester







