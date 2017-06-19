//Datapath Phase 1 Tester: DOES NOT include memory interface 



module dp_phase1;



//input signals

	reg[31:0] IR;

	reg MOC,COND,LSM_DETECT, LSM_END, CLK;





//output signals

	wire[31:0]  PA, PB, ALU_OUT, IR_Q, SHIFTER_OUT, MB_OUT;

	wire [33:0] CU_OUT;

	wire[3:0] FR_Q, MC_OUT, MA_OUT , FLAGS;



	wire[4:0] MD_OUT;



	wire CONDTESTER_OUT, Z,N,V,C;



//63 62 61 60 59 58      57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0

//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 FRLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF



	parameter sim_time = 3000;


	//modules instantiation

	flagRegister FR(FR_Q,FLAGS,CU_OUT[33],CLK);

	controlUnit_p cu1(CU_OUT,IR,MOC,CONDTESTER_OUT,LSM_DETECT,LSM_END,CLK);


	ALU_V1 alu(ALU_OUT,FLAGS,MB_OUT,PA,FR_Q[3],{1'b0,IR[24:21]} );

	

	CondTester conditionTester (CONDTESTER_OUT,IR[31:28],FR_Q[3],FR_Q[2],FR_Q[1],FR_Q[0]);

	mux_4x1_4bit muxA (MA_OUT,CU_OUT[26:25],IR[19:16], 4'b1111, 4'd0, IR[15:12]);

	mux_8x1_4bit muxC (MC_OUT,CU_OUT[21:19],IR[19:16], 4'b1111, 4'b1110, IR[15:12], 4'd0, 4'd0, 4'd0, 4'd0);

	registerFile RF (PA,PB,ALU_OUT, CLK, CU_OUT[32],MA_OUT,IR[3:0], MC_OUT);

	mux_8x1_32bit muxB (MB_OUT,CU_OUT[24:22],PB, SHIFTER_OUT, 32'd0, 32'd0, 32'd0, 32'd0, 32'd0, 32'd0);

	shifter SHIFTER (SHIFTER_OUT,FLAGS[3],PB,IR,FR_Q[3],1'd1);





	initial

		begin

			//INPUTS initialization



			MOC=1'd1; COND=1'd0;LSM_DETECT=1'd0; LSM_END=1'd0; CLK=1'd0; 		



		    	
		     // IR = 32'b11100001101110001000000000101100;	//State10->MOV  Rd = R8 = 12

	

		     //  IR= 32'b11100000100110001100000000100001;	//State 10->Rd=12; Rn=R8; shifterOperand=1
		    	
		     IR = 32'b11100010100110100001000000000001; //State11 -> Rd=1; Rn=10; shifterOperand=1


		    


		end



	initial

		begin

		

			$display("CTLREG 	            					 	   Rn Rd  MA  MC         PA       PB        SHIFT   	  ALU  FR   CZVN    	      Time"); 

			$monitor("%b   %d %d  %d %d  %d %d %d  %d  %b %b %d",cu1.ctl_register.Q, IR[19:16],IR[15:12], MA_OUT,MC_OUT,PA,PB,SHIFTER_OUT,ALU_OUT,FR_Q,FLAGS, $time); 

			//$monitor("%b   %d ",CU_OUT,/*MA_OUT,MC_OUT,PA,PB,SHIFTER_OUT,MB_OUT,ALU_OUT,Z,C,N,V,*/ $time); 

		//



		end





	always #20 CLK = ~CLK;

	initial #sim_time $finish;



endmodule // controlunit_piecewise Tester







