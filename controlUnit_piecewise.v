
//---------------------ROM 2^8 cells of 64 bits----------------------
module controlUnit_p(output reg [33:0] CU, input [31:0] IR, input MOC, COND, LSM_DETECT,LSM_END, CLK,RESET);
	
	
	//63 62 61 60 59 58  57-55  54 53 52-50   49-42    41-34  33    32   31   30     29  28  27  26  25  24  23  22  21  20  19  18  17 16  15  14  13  12  11      10  9  8    7     6      5       4       3     2   1  0
//                       N2-N0 INV MI S2-S0 CR15-CR8 CR7-CR0 FRLd RFLd IRLd MARLd MDRLd R/W MOV MA1 MA0 MB2 MB1 MB0 MC2 MC1 MC0 MD1 MD0 ME OP4 OP3 OP2 OP1 OP0 SLS_EN MS2 MS1 MS0 LSM_EN LSM_IN2 LSM_IN1 LSM_IN0 MH1 MH0 MF


	//wires
	wire[1:0] M1M0;
	wire MC_OUT, INV_OUT, ADDER_COUT ;

	wire[7:0] MD_OUT,ADD_OUT,INC_REG_OUT,ME, MA_OUT, ENC_OUT,MR_OUT;

	wire[63:0] CTL_REG_OUT,ROM_OUT;


	
		

			


		    Encoder encoder(ENC_OUT,IR);

		    mux_4x1_8bit muxA(MA_OUT,M1M0,ENC_OUT,8'd0,CTL_REG_OUT[41:34],ME);


			rom ROM(ROM_OUT,MR_OUT);

			ControlRegister ctl_register(CTL_REG_OUT, ROM_OUT,1'd1,CLK,RESET);


			AdderCU adder (ADD_OUT,ADDER_COUT,MA_OUT,8'd1,1'd0);

		    Reg8bits incrementerRegister(INC_REG_OUT,ADD_OUT,1'd1,CLK,RESET);


		    mux_2x1_8bit muxE(ME,CTL_REG_OUT[53],INC_REG_OUT,CTL_REG_OUT[49:42]);



	        mux_8x1_1bit muxC (MC_OUT,CTL_REG_OUT[52:50], MOC, COND, IR[20], LSM_DETECT, LSM_END,IR[21],1'd0,1'd0);

		    InverterCU inv(INV_OUT, MC_OUT,CTL_REG_OUT[54]);

			NextStateAdd nextState(M1M0, CTL_REG_OUT[57:55], INV_OUT);



			// Sugerencia del profesor
			// Reset es un bit controlado por uno
			mux_2x1_8bit muxR(MR_OUT,RESET,MA_OUT,8'd0); 

		always @ (CLK)

			CU <= CTL_REG_OUT[33:0];



	

			

			


endmodule // end controlunit_piecewise
